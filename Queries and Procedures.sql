select count(emp_id) employees, attrition from join_hr group by Attrition;
select concat(round(employees /(select count(emp_id) from join_hr) *100,2), '%') Attrition_rate 
from (select count(emp_id) employees, attrition from join_hr group by Attrition) T1 where attrition = 'yes';

-- ATTRITION RATE
select concat(round(count(emp_id)/(select count(emp_id) from join_hr)*100,2), '%') Attrition_rate from join_hr where Attrition = 'yes' ;

-- 1ST KPI (DEPARTMENT-WISE ATTRITION RATE)
with departwise_detail as (select department,attrition, count(attrition) emp_leave, 
(select count(emp_id) from join_hr j1 where j1.department = j2.department) Depwise_Tot_Emp
from join_hr j2 where attrition = 'yes' group by department,attrition)
select department, concat(round(emp_leave/depwise_tot_emp *100,2), '%') Dep_wise_Attrition_Rate from departwise_detail; 


-- 2ND KPI (AVERAGE HOURLY RATE OF MALE RESEARCH SCIENTIST)
select round(avg(hourly_rate),2) `Hourly Rates for Male Scientist` from join_hr where gender = 'male' and job_role = 'Research Scientist';


-- 3RD KPI PART-1 (ATTRITION RATE VS MONTHLY INCOME STATS)
select * from join_hr;
select concat(round(sum(monthly_income)/(select sum(monthly_income) from join_hr)*100,2), '%') `Tota salary`, attrition
 from join_hr group by Attrition;
 
select * from (select `Total Income`, `salary rate`, case
      when Attrition = 'yes' then 'Employees are leaving the Company'
      else 'Employees are still Working'
end  `Employee status`
from (select concat(left(sum(monthly_income),4)/100, ' CR') `Total Income`, 
concat(round(sum(monthly_income)/(select sum(monthly_income) from join_hr)*100,2), '%') `salary rate`,
Attrition from join_hr group by Attrition) T1) T2 order by `salary rate` desc;

-- PART-2 (SALARY RANGE WISE ATTRITION RATE)
with Income_with_range as (select attrition, emp_id, monthly_income,
case
    when monthly_income<=20000 then 'Less than 20K'
    when monthly_income<=40000 then 'Between 20K and 40K'
    else 'More than 40K'
end as Income_range
from join_hr)
select income_range, 
concat(round(count(emp_id)/(select count(emp_id) from Income_with_range T2 where T1.Income_range = T2.Income_range)*100,2), '%') as Bucket_wise_Attrition_Rate
from Income_with_range T1 where attrition = 'yes'  group by income_range;

-- WITH MORE BUCKETS
with Bucket as (select emp_id, attrition,
case
     when monthly_income<=5000 then 'less than 5k'
     when monthly_income<=10000 then 'less than 10k'
     when monthly_income<=15000 then 'less than 15k'
     when monthly_income<=20000 then 'less than 20k'
     when monthly_income<=25000 then 'less than 25k'
     when monthly_income<=30000 then 'less than 30k'
     when monthly_income<=35000 then 'less than 35k'
     when monthly_income<=40000 then 'less than 40k'
     when monthly_income<=45000 then 'less than 45k'
     else 'more than 45k'
end  Income_Buckets
from join_hr)
select count(emp_id)/(select count(emp_id) from bucket t1 where t1.income_buckets = t2.income_buckets)*100 Attrition_Rate, 
attrition, income_buckets 
from bucket t2 where attrition = 'yes'group by attrition, income_buckets;


select avg(monthly_income) `Avg salary`, attrition from join_hr group by Attrition;
select max(monthly_income) `Highest salary`, attrition from join_hr group by Attrition;
select min(monthly_income) `Lowest salary`, attrition from join_hr group by Attrition;


-- 4TH KPI (AVERAGE WORKING YEAR FOR EACH DEPARTMENT)
select department, avg(Working_years_At_company) from join_hr group by department;


-- 5TH KPI (JOB ROLE VS WORK LIFE BALANCE)
select job_role, truncate(avg(work_life_balance),2) Avg_work_life_balance from join_hr group by job_role order by Avg_work_life_balance desc;


-- 6TH KPI (ATTRITION RATE VS YEAR SINCE LAST PROMOTION RELATION)
select  case
    when Attrition = 'yes' then 'Employees who left'
    else 'Employees who Stayed'
end as 'Employees',  `Avg year since last promotion`
from (select attrition, truncate(avg(years_since_last_promotion),2) `Avg year since last promotion` from join_hr group by attrition) T1;

with year_range as (select attrition, years_since_last_promotion,
case
     when years_since_last_promotion <=5 then 'Less than 5yrs'
     when years_since_last_promotion <=10 then 'Between 5yrs and 10yrs'
     else 'More than 10yrs'
end as Year_wise_promotion from join_hr)
select Year_wise_promotion,
 concat(round(count(attrition)/(select count(attrition) from year_range t1 where t1.year_wise_promotion = t2.year_wise_promotion)*100,2), '%') as Attrition_Rate
from year_range t2
where attrition = 'yes' group by Year_wise_promotion order by attrition_rate desc;

-- ATTRITION_RATE OF BUSSINESS TRAVEL
select bussiness_travel, 
concat(round(count(emp_id)/(select count(emp_id) from join_hr H1 where h1.Bussiness_Travel = h2.Bussiness_Travel)*100,2), '%') Attrition_Rate
from join_hr H2 where attrition = 'yes' group by bussiness_travel;

-- AGE GROUP-WISE ATTRITION RATE
with age_ranges as (select emp_id, attrition,
case
    when age <=30 then '18 to 30 age'
    when age <=45 then '30 to 45 age'
    else 'Above 45'
end age_Range
from join_hr)
select age_range, concat(round(count(emp_id)/(select count(emp_id) from age_ranges t1 where t1.age_range = t2.age_range)*100,2), '%') Attrition_rate 
from age_ranges t2 where attrition = 'yes' group by age_range;

-- DISTANCE RANGE WISE ATTRITION RATE
with Distance_ranges as (select emp_id, attrition,Distance_from_home,
case
    when Distance_from_home<=15 then 'Less than 15'
    when Distance_from_home<=30 then 'Less than 30'
    else 'more than 30'
end Distance_Range
from join_hr)
select Distance_range ,
concat(round(count(emp_id)/(select count(emp_id) from distance_ranges t1 where t1.distance_range = t2.distance_range)*100,2), '%') Attrition_Rate
from Distance_ranges t2 where attrition = 'yes' group by distance_range;


-- AVG WORKING YEAR/EXPERIENCE AND ROLE DEPARTMENTWISE
select department, avg(years_in_current_role) workin_in_current_role, avg(Working_years_At_company) working_at_company, 
avg(Total_working_years) Tot_Experience from join_hr group by department;

select * from join_hr;
with highest_attrition as (select attrition, emp_id, years_since_last_promotion, gender, department from join_hr h1
where years_since_last_promotion between 5 and 10 and gender='male' and department = 'software')
select count(emp_id)/(select count(emp_id) from highest_attrition )*100 Highest_attrition_rate from highest_attrition where attrition = 'yes';

select * from join_hr;
select sum(emp_count) from (select count(emp_id) emp_count, years_since_last_promotion from join_hr
 where years_since_last_promotion>=8 group by years_since_last_promotion) T1;

select department, count(emp_id) from join_hr group by department;
select department, count(emp_id)/(select count(emp_id) from join_hr t1 where t1.department = t2.department)*100 attrition_rate 
from join_hr t2 where attrition = 'yes' group by department;

select count(emp_id) into @soft_count  from join_hr where department = 'software' group by department; 
select count(emp_id) into @soft_att_count  from join_hr where department = 'software' and Attrition = 'yes' group by department; 

select  (@soft_att_count/@soft_count)*100 software_attrition_count;
delimiter //
create procedure dep_wise_Attrition(in dep_name varchar(50))
begin
    with departwise_detail as (select department,attrition, count(attrition) emp_leave, 
(select count(emp_id) from join_hr j1 where j1.department = j2.department) Depwise_Tot_Emp
from join_hr j2 where attrition = 'yes' group by department,attrition)
select department, concat(round(emp_leave/depwise_tot_emp *100,2), '%') Dep_wise_Attrition_Rate from departwise_detail
where department = dep_name;
end//
delimiter ;

select distinct department from join_hr;
call dep_wise_Attrition('Human Resources');

delimiter $$
create procedure Avg_hr_ms()
begin
     select round(avg(hourly_rate),2) `Hourly Rates for Male Scientist` from join_hr where gender = 'male' and job_role = 'Research Scientist';
end $$
delimiter ;

delimiter ##
create procedure avg_workingyear_dep(in dep_name varchar(50))
begin
      select department, avg(Working_years_At_company) avg_workingyear_at_company from join_hr where department = dep_name group by department;
      
end ##
delimiter ;




























