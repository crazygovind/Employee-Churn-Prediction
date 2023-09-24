use train1;
select * from train1;
SELECT COUNT(*) FROM train1;



SELECT Attrition, COUNT(*) AS Count_Attrition
FROM train1
GROUP BY Attrition;



select
(select
    count(Attrition)
from
	train1
where
	Attrition = '1') /
(select
	count(Age)
from
	train1)*100 as attrition_rate;



create or replace view employee_profile as
	select 
			Age,
			Gender,
			Attrition,
			DistanceFromHome,
			JobRole,
			MaritalStatus
	from
			train1;




select
	(select
			count(Gender)
		from
			employee_profile
		where 
			Attrition = '1' and Gender='Female')/
		(select 
			count(Attrition)
		from
			employee_profile
		where
			Attrition= '1')*100 as females_attrition;




select 
	(select
			count(Gender)
		from 
			employee_profile
		where
			Attrition='0' and Gender ='Female')/
		(select
			count(Attrition)
		from 
			employee_profile
		where
			Attrition='0')*100 as female_stayed;





select
	(select
			count(Gender)
		from
			employee_profile
		where
			Attrition='1' and Gender='Male')/
		(select
			count(Gender)
		from 
			employee_profile
		where
			Attrition='1')*100 as males_attrition;



select
	(select
			count(Gender)
		from 
			employee_profile
		where
			Attrition='0' and Gender='Male')/
		(select
			count(Gender)
		from
			employee_profile
		where
			Attrition='0')*100 as males_stayed;




Select 
	max(Age)
from
	employee_profile
where
	Attrition='1';




select
	max(age)
from
	employee_profile
where
	Attrition='0';



drop table department;
create table departments(dept_no varchar(12),department varchar(25));
insert into departments values('d001','Human Resources'),('d002','Research & Development'),('d003','Sales');
select *from departments;



drop table dep_emp;
create table dep_emp as
select EmployeeNumber,department
from train1 ;




select * from dep_emp;



create or replace view emp_dept as
select
	 d.dept_no,de.EmployeeNumber, d.department 
from
	dep_emp de
		inner join
	departments d 
on
	de.department=d.department
order by 
	de.EmployeeNumber;




create or replace view dept as
select
	d.dept_no ,de.employeenumber, d.department
from
	dep_emp de
inner join
	departments d
On 
	de.department=d.department
order by de.employeenumber;




select distinct
		department
from 
		dept;




select distinct
	jobrole
from 
	train1;




select jobrole, count(jobrole) as count
from employee_profile
where Attrition='1'
group by jobrole;





select attrition,avg(jobsatisfaction)
from train1
group by attrition;




select std(jobsatisfaction) as std_jobsatisfaction
from train1;





select count(*), attrition
from train1
group by attrition;





select
	@firstvalue:=avg(yearsatcompany) as avg_years_at_company,
	@secondvalue:=avg(yearsincurrentrole) as avg_years_on_job,
	@division:=(stddev_samp(yearsatcompany)* stddev(yearsincurrentrole)) as std
from train1;





select
	sum((yearsatcompany -@firstvalue) *(yearsincurrentrole - @secondvalue))/
((count(yearsatcompany) - 1)*@division) as correlation
from train1;
