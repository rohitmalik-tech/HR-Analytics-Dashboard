create database hr_data;
use hr_data;

create table temp_hr1(
age int,
Attrition varchar(50),
Bussiness_Travel varchar(100),
DailyRate int,
department varchar(100),
Distance_from_home int,
education int,
education_field varchar(100),
emp_count int,
emp_id int primary key,
environment_satisfaction int,
Gender varchar(50),
Hourly_rate int,
job_involvement int,
job_level int,
job_role varchar(250),
job_satisfaction int,
marital_status varchar(100));

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/HR_1.CSV'
into table temp_hr1
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows;

create table hr1(
age int,
Attrition varchar(50),
Bussiness_Travel varchar(100),
DailyRate int,
department varchar(100),
Distance_from_home int,
education int,
education_field varchar(100),
emp_id int primary key,
environment_satisfaction int,
Gender varchar(50),
Hourly_rate int,
job_involvement int,
job_level int,
job_role varchar(250),
job_satisfaction int,
marital_status varchar(100));

insert into hr1(
age ,
Attrition,
Bussiness_Travel ,
DailyRate,
department,
Distance_from_home ,
education,
education_field,
emp_id ,
environment_satisfaction,
Gender,
Hourly_rate,
job_involvement,
job_level,
job_role ,
job_satisfaction,
marital_status 
) 
(select 
age ,
Attrition,
Bussiness_Travel ,
DailyRate,
department,
Distance_from_home ,
education,
education_field,
emp_id ,
environment_satisfaction,
Gender,
Hourly_rate,
job_involvement,
job_level,
job_role ,
job_satisfaction,
marital_status
from temp_hr1
);

create table temp_hr2(
employee_id int primary key,
monthly_income int,
monthly_rate int,
work_in_companies int,
over_18 varchar(50),
overtime varchar(100),
percentage_salary_hike int,
performance_ratings int,
relationship_satisfaction int,
standard_hours int,
stock_option_level int,
Total_working_years int,
Training_time_lastyear int,
work_life_balance int,
Working_years_At_company int,
years_in_current_role int,
years_since_last_promotion int,
years_with_current_manager int);

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/HR_2.csv'
into table temp_hr2
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows;

create table hr2(
employee_id int primary key,
monthly_income int,
monthly_rate int,
work_in_companies int,
overtime varchar(100),
percentage_salary_hike int,
performance_ratings int,
relationship_satisfaction int,
stock_option_level int,
Total_working_years int,
Training_time_lastyear int,
work_life_balance int,
Working_years_At_company int,
years_in_current_role int,
years_since_last_promotion int,
years_with_current_manager int
);

insert into hr2(
employee_id ,
monthly_income ,
monthly_rate ,
work_in_companies,
overtime,
percentage_salary_hike ,
performance_ratings ,
relationship_satisfaction ,
stock_option_level ,
Total_working_years ,
Training_time_lastyear ,
work_life_balance ,
Working_years_At_company,
years_in_current_role ,
years_since_last_promotion ,
years_with_current_manager 
)
(select 
employee_id ,
monthly_income ,
monthly_rate ,
work_in_companies,
overtime,
percentage_salary_hike ,
performance_ratings ,
relationship_satisfaction ,
stock_option_level ,
Total_working_years ,
Training_time_lastyear ,
work_life_balance ,
Working_years_At_company,
years_in_current_role ,
years_since_last_promotion ,
years_with_current_manager
from temp_hr2
);


select * from hr1;
select * from hr2;

create table join_HR as (select h.*, hr.* from hr1 h join hr2 hr 
on h.emp_id = hr.employee_id);

select * from join_hr;



























