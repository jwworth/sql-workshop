-- 1.1 Find which weather station has the highest temperature record.
select stations.name, tempf
from reports
  join stations on reports.station_id=stations.id
order by tempf desc
limit 1;

-- 1.2 Find which weather station has the coldest temperature record.
select stations.name, tempf
from reports
  join stations on reports.station_id=stations.id
order by tempf asc
limit 1;

-- 1.3 Find the hottest and coldest record for each station in a single query.
select stations.name, min(tempf), max(tempf)
from reports
  join stations on reports.station_id=stations.id
group by 1;


-- 2.1 Find the high and low temperature, humidity, and wind speed for each day at each station.
select stations.name,
  time::date,
  min(tempf) min_tempf,
  max(tempf) max_tempf,
  min(humidity) min_humidity,
  max(humidity) max_humidity,
  min(wind_speed) min_wind_speed,
  max(wind_speed) max_wind_speed
from reports
  join stations on reports.station_id=stations.id
group by 1, 2
order by 1, 2;


-- 3.1 We discussed sampling issues with averaging hourly data. But are there any entirely missing days?
select d, stations.name
from generate_series('2010-01-01'::date, '2019-02-01'::date, '1 day') d
  cross join stations
  left join daily_summaries on d::date=daily_summaries.date and stations.id=daily_summaries.station_id
where daily_summaries.date is null;

-- 3.2 What days had the most similar temperatures between O'Hare and Jacksonville?
select date,
  ord.min_tempf as ord_min_tempf,
  jax.min_tempf as jax_min_tempf,
  ord.max_tempf as ord_max_tempf,
  jax.max_tempf as jax_max_tempf,
  abs(ord.min_tempf - jax.min_tempf) + abs(ord.max_tempf - jax.max_tempf) diff
from daily_summaries ord
  join daily_summaries jax using(date)
where ord.station_id=94846
  and jax.station_id=13889
order by 6 asc, 1 asc
limit 10;
