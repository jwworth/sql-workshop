-- 1.1 How many total deaths have there been?
select sum(death)
from all_states_history
where date = '2020-10-26';

-- 1.2 How many total tests have been performed?
select sum(totaltestresults)
from all_states_history
where date = '2020-10-26';

-- 2.1 When was the peak ICU usage and how many were in use?
select date, sum(inicucurrently)
from all_states_history
group by 1
order by 2 desc nulls last
limit 1;

-- 2.2 How many patients are in the ICO now?
select sum(inicucurrently)
from all_states_history
where date = '2020-10-26';

-- 2.3 How many total patients have been in the ICU?
select sum(inicucumulative)
from all_states_history
where date = '2020-10-26';
