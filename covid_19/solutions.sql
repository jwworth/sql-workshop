-- 1.1 How many total deaths have there been?
select sum(death)
from all_states_history
where date = '2021-02-21';

-- 1.2 How many total tests have been performed?
select sum(totaltestresults)
from all_states_history
where date = '2021-02-21';

-- 2.1 When was the peak ICU usage and how many were in use?
select date, sum(inicucurrently)
from all_states_history
group by 1
order by 2 desc nulls last
limit 1;

-- 2.2 How many patients are in the ICO now?
select sum(inicucurrently)
from all_states_history
where date = '2021-02-21';

-- 2.3 How many total patients have been in the ICU? (This number seems suspiciously low.)
select sum(inicucumulative)
from all_states_history
where date = '2021-02-21';

--   2.4 How many total patients have been hospitalized?
select sum(hospitalizedcumulative)
from all_states_history
where date = '2021-02-21';
