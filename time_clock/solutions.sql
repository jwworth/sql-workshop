-- 1.1 Write a query to find the newest employee.
select * from employees order by hire_date desc limit 1;

-- 1.2 Write a query to find the oldest employee.
select * from employees order by hire_date asc limit 1;

-- 1.3 Bonus: Write a query to find how long each person has been employed.
select *, current_date - hire_date as days_employed
from employees;

-- 1.4 Bonus 2: Write a query to find the average tenure of employee.
select avg(current_date - hire_date) as avg_days_employed
from employees;

-- 2.1 Write a query to clock an employee in (hint: you need to insert a record).
insert into worked_shifts (employee_id, time_range) values (1, tstzrange(now(), null));

-- 2.2 Write a query to clock an employee out (hint: you need to update the previously inserted record).
update worked_shifts
set time_range=tstzrange(lower(time_range), now())
where employee_id=1
  and upper_inf(time_range);

-- 3.1 Write a query to compute how much each employee has worked. Include the employee's name.
select last_name, first_name, sum(upper(time_range) - lower(time_range))
from worked_shifts
  join employees on employees.id=worked_shifts.employee_id
group by last_name, first_name;

-- 3.2 Bonus: Write a query to compute how much each employee has worked in the last week. Include the employee's name.
select last_name, first_name, sum(upper(time_range) - lower(time_range))
from worked_shifts
  join employees on employees.id=worked_shifts.employee_id
where now() - make_interval(days => 7) < lower(time_range)
group by last_name, first_name;

-- 3.3 Bonus 2 (very hard): Would an employee who had not worked in the last week appear in the results of exercise 3.2?
--     Insert a new employee who has not worked any hours. Then make the query used in 3.2 show the new employee
--     with 0 time worked.
insert into employees(first_name, last_name, hire_date) values('William', 'Lancaster', '2018-09-15');

select last_name, first_name,
  coalesce(sum(upper(time_range) - lower(time_range)), '00:00:00')
from employees
  left join worked_shifts on employees.id=worked_shifts.employee_id
    and now() - make_interval(days => 7) < lower(time_range)
group by last_name, first_name;
