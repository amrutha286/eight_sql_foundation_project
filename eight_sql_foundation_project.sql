create database EIGHT_SQL;
USE EIGHT_SQL;

CREATE table employee (
emp_id int primary key,
first_name varchar(50),
last_name varchar(50),
birth_day date,
sex VARCHAR(1),
salary INT,
super_id INT,
branch_id INT);

describe employee;
Alter table employee
ADD foreign key (super_id)
references employee(emp_id)
on delete set null;

describe employee;

create table branch(
branch_id int primary key,
branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) 
  ON DELETE SET NULL
);

describe branch;

Alter table employee
ADD foreign key (branch_id)
references branch(branch_id)
on delete set null;
 describe employee;
 
 
 CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

show tables;
describe employee ;
describe branch ;
describe branch_supplier ;
describe works_with ;
describe client ;
show tables ;
insert into employee values(100,'david','wallace','1967-11-17','m', 250000 , null ,null );
select  * from employee;

use eight_sql;
insert into branch values (1,'corporate',100 ,'2006-02-09');
select * from branch;

update employee
set branch_id=1
where emp_id = 100;

select * from employee;
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15','M', 75000,100,NULL);
select * from employee;

insert into branch values(2,'scranton',102,'1992-04-06');
select * from branch;
update employee
set branch_id = 2
where emp_id = 102;

select * from employee;
select * from branch;


INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);
INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M',69000, 102, 2);
 
 insert into employee values(106,'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3,'Stamford', 106,'1998-02-13');

update employee
set branch_id = 3
where emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000,106,3);
 select * from employee;
-- branch
INSERT INTO branach_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);
select * from employee;
select * from branch;
select * from client;
select * from works_with;
select * from branch_supplier;

select * from EMPLOYEE
order by sex ASC;
SELECT * FROM EMPLOYEE
ORDER BY SALARY ASC;
SELECT * FROM WORKS_WITH
ORDER BY TOTAL_SALES DESC; 

select distinct branch_id from employee;
select first_name as fore_name, last_name employee;  
select salary from employee where salary >= 25000;
select * from works_with where total_sales >= 25000;
select * from works_with where total_sales > 25000 order by total_sales desc limit 3;
select * from employee where sex in ('f') and branch_id = 2;
select * from employee where first_name in('jim','michael',' josh', 'david');
select * from employee where birth_date between 1967-11-07 and  1980-02-05;
select sum(salary) from employee;
select count(*) from employee;



use eight_sql;
select count(distinct super_id) as managers from employee;
select avg(salary) from employee;
select sum(salary) from employee;
select min(salary) from employee;
select max(salary) from employee;
select sex, count(sex) from employee
group by sex 
order by sex desc;
select emp_id,sum(total_sales) from works_with
 group by emp_id;
 select client_id,
 sum(total_sales) from works_with
 group by client_id;
 
 
 #####clint#####
  select * from client
  where client_name like'%llc';
    select * from client
  where client_name like'times%';
    select * from client
where client_name like'%law%';
###union
select client_id from client
union
select branch_id from branch;

 ####nested queries#########
 
 select emp_id,first_name,salary from employee where(select emp_id from works_with where total_sales>30000);
  select emp_id,first_name,salary from employee where emp_id in 
  (select emp_id from works_with where client_id in
  (select client_id from client where client_name like'%llc'));
  select emp_id,sum(total_sales) from works_with where emp_id in(select emp_id from employee where super_id in 
  (106)) group by emp_id
  order by emp_id;
  
 select client_id,client_name from client where branch_id in
 (select branch_id from employee where emp_id= 102);
 use eight_sql;
 select emp_id,first_name,salary from employee where 
 emp_id in(select emp_id from works_with where total_sales>1000) 
 and branch_id in
 (select branch_id from branch where branch_id = 2);
 
 ####join function ###
 
 use eight_sql;
 select a.emp_id, a.first_name , a.last_name,a.sex, a.salary, sum(b.total_sales) as total_sales_1 from employee a 
 join works_with b on a.emp_id = b.emp_id where a.salary>70000
 group by emp_id;
 
grant select on employee and works_with to 'priya_1';


 revoke select, update,delete,drop on employee from 'priya_1';
 
 ####concat####
 
use eight_sql;
create table emp_2 as
select
concat(concat((emp_id),(first_name)), (last_name)) as fullname from employee;

select * from emp_2;
DROP TABLE EMP_2;

###### TRIM #######
select * from employee;
create table emp_8 as
select
concat(concat(concat(
trim((emp_id)),
trim((first_name))),
trim((last_name))),
trim((birth_day)))from employee;
######################################
create table emp_6 as
select concat(concat(trim((emp_id)),trim((first_name))),trim((salary))) sum(salary) total_slary from employee;
drop table emp_6;
select * from emp_6;
######################################
create table emp_5 as
select
concat(concat(concat(
trim((emp_id)),
trim((first_name))),
trim((last_name))),
trim((birth_day))) from employee;

#####case when#####

select emp_id, first_name, salary,
case when(salary>=700000) then 'high paied' else 'under paid' end from employee;


##### with clause######

with
salary_1 as 
(select emp_id,super_id, salary, sum(salary) total_salary_1 from employee group by emp_id),
sales_1 as 
(select emp_id, sum(total_sales) total_sales_1 from works_with group by emp_id)
select a.emp_id,a.total_salary_1,b.total_sales_1 ,a.super_id  from salary_1 a join sales_1 b on a.emp_id= b.emp_id;
##here created tables to take info only , not realy


##### having ######

select emp_id, sum(total_sales) total_sales_1 
from works_with 
group by emp_id having  total_sales_1 > 70000;


###having, group by,where clause, order by, join, nested,concat : this one was rare
##insted of where in group by we use having in group by topic using time


###Exercise : Fetch total_emp_CNT, Total_client_CNT, Total_Supplier_CNT, Total_Sales, Total_Salary, total_Branch-CNT for with clause


with
salary_1 as
(select emp_id);


#### triger ####


###first create the table
create table trigger_test (
message varchar(100)
);
### and then creating the table , to create tyable the varchar was must. 



#####sub queries
select emp_id,first_name,last_name from employee where (select total_sales from works_with where sum(total_sales))
group by emp_id
order by emp_id;











 
 
 