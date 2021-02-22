-- Create a database.
-- $ createdb covid_19

-- Import the data.
-- $ psql -f data/covid_19.sql covid_19

-- Original data provided by "The Atlantic" under the Creative Commons CC BY 4.0 license
-- (https://creativecommons.org/licenses/by/4.0/).

-- Data URL:
-- https://covidtracking.com/data/download/all-states-history.csv

-- Import Date:
-- 02/22/2021

-- Data definitions:
-- https://covidtracking.com/about-data/data-definitions

-- Notes regarding source and confidence of each state's data:
-- https://covidtracking.com/data

-- Start the psql PostgreSQL client
-- $ psql covid_19

-- Explore the database and familiarize yourself with the data schema. (e.g. use \d). Use
-- the data definitions URL above to clarify the meaning of fields.

-- How many total cases have there been in the US?

select sum(positive)
from all_states_history
where date = '2021-02-21';

-- Exercise 1:
--   1.1 How many total deaths have there been?
--   1.2 How many total tests have been performed?

-- What is the overall case fatality rate? (i.e. total deaths divided by total cases)

select sum(death)::numeric / sum(positive)::numeric
from all_states_history
where date = '2021-02-21';

-- Q: Why is this number so high relative current CDC fatality rate estimates?
-- A: Incomplete data / asymptomatic cases (https://www.nbc26.com/news/coronavirus/cdc-estimates-covid-19-fatality-rate-including-asymptomatic-cases)

-- When was the peak ventilator usage and how many were in use?

select date, sum(onventilatorcurrently)
from all_states_history
group by 1
order by 2 desc nulls last
limit 1;

-- Why is "nulls last" necessary?

-- Exercise 2:
--   2.1 When was the peak ICU usage and how many were in use?
--   2.2 How many patients are in the ICO now?
--   2.3 How many total patients have been in the ICU?
--   2.4 How many total patients have been hospitalized?

-- Could we have answered these questions without the "cumulative" fields?
-- How or why not?

-- Does the number of cases in a state ever go down? Tables can be included
-- in the from clause multiple times. This can be used to compare rows.

select
  curr_day.state,
  curr_day.date,
  curr_day.positive,
  prev_day.date,
  prev_day.positive,
  curr_day.positive - prev_day.positive as diff
from all_states_history curr_day
  join all_states_history prev_day on curr_day.state = prev_day.state
    and curr_day.date - 1 = prev_day.date
where curr_day.positive < prev_day.positive
order by diff asc;

-- Optional discussion and advanced topics:
--   Data integrity and garbage in / garbage out (GIGO)
--   Real world data is very messy
--   When preparing reports the majority of time is often spent cleaning the data
--   When designing a data model consider the questions that will need to be answered.
--   WINDOW functions
--   LATERAL JOINs
