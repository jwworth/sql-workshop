-- Create a database.
-- $ createdb weather
--
-- Import the sample data. Thanks to NOAA for original data: https://www.ncdc.noaa.gov/cdo-web/
-- $ psql -f data/weather.sql weather
--
-- Start the psql PostgreSQL client
-- $ psql weather

-- Explore the database and familiarize yourself with the data schema. (e.g. use \d)

-- Exercise 1:
--   1.1 Find which weather station has the highest temperature record.
--   1.2 Find which weather station has the coldest temperature record.
--   1.3 Find the hottest and coldest record for each station in a single query.

-- Can we find the average wind speed for each day at each station?

select stations.name, reports.time::date, avg(wind_speed)
from reports
  join stations on reports.station_id=stations.id
group by 1, 2
order by 1, 2;

-- Is this correct (enough)? Why or why not?

select stations.name, reports.time::date, avg(wind_speed), count(*) samples
from reports
  join stations on reports.station_id=stations.id
group by 1, 2
order by 1, 2;

-- Perhaps a slightly different question would be easier to answer?

select stations.name, reports.time::date, min(wind_speed), max(wind_speed)
from reports
  join stations on reports.station_id=stations.id
group by 1, 2
order by 1, 2;

-- Exercise 2:
--   2.1 Find the high and low temperature, humidity, and wind speed for each day at each station.

-- Now that we can find daily statistics, let's find the monthly average high and low temperatures at each station. A
-- sub-query that returns a result set and can be used in a FROM clause.

select name,
  left(date::text, 7),
  avg(min_tempf) as avg_min_tempf,
  avg(max_tempf) as avg_max_tempf
from (
  select stations.name,
    time::date as date,
    min(tempf) min_tempf,
    max(tempf) max_tempf,
    min(humidity) min_humidity,
    max(humidity) max_humidity,
    min(wind_speed) min_wind_speed,
    max(wind_speed) max_wind_speed
  from reports
    join stations on reports.station_id=stations.id
  group by 1, 2
) t
group by 1, 2
order by 1, 2;

-- That's starting to get messy. Let's extract the daily summarization into a view.

create view daily_summaries as
select stations.id as station_id,
  stations.name as station_name,
  time::date as date,
  min(tempf) min_tempf,
  max(tempf) max_tempf,
  min(humidity) min_humidity,
  max(humidity) max_humidity,
  min(wind_speed) min_wind_speed,
  max(wind_speed) max_wind_speed
from reports
  join stations on reports.station_id=stations.id
group by 1, 3;

-- Note that we didn't need to group by stations.name since we were already grouping by stations.id.

-- Now let's rewrite the previous query to use the view.

select station_name,
  left(date::text, 7),
  avg(min_tempf) as avg_min_tempf,
  avg(max_tempf) as avg_max_tempf
from daily_summaries
group by 1, 2
order by 1, 2;

-- Perhaps we could make this faster with a materialized view.

create materialized view daily_summaries_mat as
select stations.id as station_id,
  stations.name as station_name,
  time::date as date,
  min(tempf) min_tempf,
  max(tempf) max_tempf,
  min(humidity) min_humidity,
  max(humidity) max_humidity,
  min(wind_speed) min_wind_speed,
  max(wind_speed) max_wind_speed
from reports
  join stations on reports.station_id=stations.id
group by 1, 3;

select station_name,
  left(date::text, 7),
  avg(min_tempf) as avg_min_tempf,
  avg(max_tempf) as avg_max_tempf
from daily_summaries_mat
group by 1, 2
order by 1, 2;

-- Why is it faster? What are the downsides?

-- Exercise 3 (advanced):
--   3.1 We discussed sampling issues with averaging hourly data. But are there any entirely missing days? Hint: You can
--       do this with generate_series, cross join, and left join.
--   3.2 What days had the most similar temperatures between O'Hare and Jacksonville? Hint: The same table can be
--       selected from multiple times in a single query by renaming the table.
