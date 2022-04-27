use sandip
/*create table class*/
create table class(
class_id int not null ,
);
select*from  class


/*create table foreign key on class(class_id) */
create table student
(
student_id INT  NOT NULL CONSTRAINT pk_student PRIMARY KEY IDENTITY(1,1 ) ,
name varchar(50) not null constraint uk_name unique,
s_address varchar(50) not null constraint df_address default 'birtamod',
age int not null default 16 check(age>=16),
section varchar(50) not null,
class_id INT NOT NULL CONSTRAINT fk_class FOREIGN KEY(class_id) REFERENCES class(class_id),
);
 
 
/*2. drop primary key*/
ALTER TABLE  student
DROP CONSTRAINT pk_student;

/*3 drop foreign key*/
alter table student
drop constraint fk_class;

/*4 add constraint pk*/
alter table student
add constraint pk_student primary key (student_id);

/*5 add consraint fk*/
alter table student
add constraint fk_class foreign key(class_id) references class(class_id);

/*6. remove unique constraint */
alter table student
drop constraint uk_name,

/*7 remove deafult */
alter table student
drop constraint df_address;

 /* 8 add constraint unique */
alter table student
add constraint uk_student unique(section);

/*9 change defult value */
alter table student
add constraint df_age default '18' for age;
 
/*10 change name */
exec sp_rename 'student.address' , 'location','Column';

/* 11 add new not null column  */
alter table student
add email varchar(50) not null;

/* 12 remove column section */
alter table student
drop column section;


/* 13 add new column integer contact*/
alter table student
add contact int;

/* 14 change data type */
alter table student
alter column contact varchar(50);

/*15 change defult value */
alter table student
add constraint df_address  default 'kathmandu' for location;

/* 16 insert data */
insert into class(class_id) values('1'),('2'),('3');

set identity_insert student on
insert into student(student_id,name,location,age,email,contact,class_id)
values('1','kapil','jutpani','23','kapil@gmail.com','9876545609','1'),
('2','sudip','bharatpur','22','sudip@gmail.com','98564738284','3'),
('3','raju','tandi','23','raju@gmail.com','9879238473','1'),
('4','sila','pokhara','22','silu@gmail.com','988787676','2'),
('5','krishna','damauli','21','krishna@gmail.com','988787849','2')
('6','ram','bdm','21','ram@gmail.com','988787849','3'),
('9','dhol','birtamode','23','dhol@gmail.com','987656363','1'),
('8','zyan','ktm','24','zya@gmail.com','9873456363','1');

/*17 update name and address of student whose student id is 5*/

/*18  DELETE the records of student having age greater than 20 */
delete from student where age>20;

/*19. to update age of student having address btm.*/
update student set age='19' where location='btm';

/*20.  to delete all records of student having student id 1.*/

delete student where student_id='1';

/*21  select all records of student */
select*from student;

/* 22 select all student where student id = 3 */
select*from student where student_id='3';

/* 23 select name and address of students whose age is greater than 21 */
select name, location from student where age>21;

/*24 select student id and name of students whose address in 
Birtamode.*/
select student_id, name from student where location='birtamod';

/* 25 select records of students whose class id is 5 and address is 
Kathmandu */
select * from student where location='kathmandu' and class_id='5';

/*26 select maximum age from above table */
select MAX(age) from student;

/* 27 select minimum age of students whose address is Birtamode */
select MIN(age) from student where location='birtamode';

/*28 find total number of students having class id 5 and age greater 
than 19 */
select count(name) from student where class_id='5' and age>19;

/*29  find average age of students whose class id is 4 and section is B */
alter table student
add section varchar(20);
select*from student;
select section from student;
update student set location='birtamode' where class_id='7';
update student set section='b' where class_id='3';
update student set section='a' where class_id='2';

update student set section='c' where class_id='1';

select AVG(age) from student where class_id='4' and section='b';

/*30 select students whose address starts with letter ‘B’ */
select * from student where location like 'b%';
/*31  count those students whose name ends with letter ‘R’ */
select count(student_id) from student where name like '%R';

/*32 select name and age of students whose having address btm or 
ktm. */
select name, age from student where location = 'btm' or location='ktm' ;

/* 33 select sum of age of students having id 1,2 and 3 */
select sum(age) from student where student_id in (1,2,3);

/*34  students whose age is between 18 and 22.*/
select name 
from student
 where age between 18 and 22;

/*35  select total students of each age group. */
SELECT COUNT(age) as no_of_student, age
FROM student
GROUP BY age;

/* 36 select class id, name and maximum age of students studying in 
each class. */
SELECT class_id, name, MAX(age) as age
FROM student 
GROUP BY name,class_id;


/* 37 select student’s records by arranging in descending order on the 
basis of student id */
select * from student
order by student_id desc;

/*38 select student id and name by of students whose age is greater 
than 20 after arranging records in alphabetical order on the basis of name */
select student_id, name from student where age>20 order by name asc;

/*39 select records of student whose age is maximum among all the 
students */
select max(age) from student

/*40 select student id and name of student whose student id is 
maximum among all the students */

SELECT  name, student_id from student where student_id=(select MAX(student_id) from student);


/* 41 select name and age of student whose age is minimum than the 
average age of all students */
select name, age from student where age=(select min(age) from student);

/* 42 list all the students except ‘btm & ‘ktm in asc order of age */
select name from student except select location=('btm''ktm') from student order by name ;


/*	43	students who does not belong to address ‘btm */
select name from student except select location='btm';

/* 44   display the location of ‘Ram’’  */
select student_id, name from student where name='ram';

/* 45   display the total information of student table along with name and 
location of all the students having address ‘Birtamode’  */
select name, location from student where location='tandi';

/*********************************************************************************************/
/*********************************************************************************************/

/* 46  table below with appropriate data type and constraints.  */
create table Department (
Dep_id int not null primary key,
Dep_Name varchar(50),
floor varchar(10),
);

create table Employee(
Empl_id int not null primary key,
Name varchar(50) not null,
Address varchar(50) not null,
Salary money not null,
Dep_id int not null foreign key(Dep_id) references Department(Dep_id)
);

insert into Department(Dep_id, Dep_Name, floor)values('1','administrator','1st'),
('2','Engineer','2nd'), ('3','Developer','3rd'), ('4','Project Manager','4th');

insert into Employee(Empl_id, Name, Address, Salary, Dep_id)
values('1','Sandip Bhatrai','Saradpur','93750','1'),
('2','Ambika Paudel','Tandi','70000','1'),
('3','Binod Chaudhari','Pokhara','78000','1'),


('5','Dheraj karki', 'Kathmandu','60000','2'),
('6','Ganu Magar','Gorkha','67800','2'),


('8','Kamal khatri','Chetrapur','110140','3'),
('7','Sudip shrestha','Bharatpur','125000','3'),
('4','Saroj Tamang','Kalika','100000','3'),


('9','Suman Khatri','Rampur','126000','4');


select*FROM Department;
select*from Employee
use sandip;
delete from Department;
/* 47  Use all types of joins to select employee id, name and department name of employees */
 /* inner join */
 select Employee.Empl_id,Employee.Name,Department.Dep_Name
 from Employee
 inner join Department on Employee.Dep_id = Department.Dep_id;
 /* left(outer) join */
  select Employee.Empl_id,Employee.Name,Department.Dep_Name
 from Employee
LEFT JOIN Department ON Employee.Dep_id = Department.Dep_id
 /*right join*/
 
  select Employee.Empl_id,Employee.Name,Department.Dep_Name
 from Employee
right JOIN Department
ON Employee.Dep_id = Department.Dep_id
 /*full join */
 select Employee.Empl_id,Employee.Name,Department.Dep_Name
 from Employee
full outer JOIN Department
ON Employee.Dep_id = Department.Dep_id


/* 48  Select name and address of employees whose salary is between 100000 and 200000 */
select name, address from Employee where Salary between 100000 and 200000;
/* 49  Select employee id, employee name and department name of employees working in 
first floor*/
select Employee.Empl_id, Employee.Name, Department.Dep_Name
from Employee
inner join Department on Employee.Dep_id=Department.Dep_id;

/* 50  Select all records of department which are in second floor. */
select*from Department where floor='2nd';

/* 51  Select name, address and department name of employees which are from Birtamode*/

select Employee.Empl_id, Employee.Name, Department.Dep_Name
from Employee
inner join Department on Employee.Dep_id=Department.Dep_id
where Address='Birtamode';
/* 52  Select employee id and name of employees having salary more than 10000 and from 
Kathmandu*/
select Empl_id, Name from Employee where Salary>100000 and address='kathmanud';
/* 53 select name, department name and floor of employee whose name start with letter 
‘R’ and age is greater than 30  */
select Employee.Name, Department.Dep_Name, Department.Floor
from Employee
left join Department on Employee.Dep_id= Department.Dep_id
where Name like 'a%'


/* 54 Select employee id and department name of employees whose floor is ‘first’ by 
arranging in ascending order on the basis of salary  */
select Employee.Empl_id, Department.Dep_Name
from Employee
right join Department on Employee.Dep_id = Department.Dep_id
where Floor='1st' order by Salary asc;

/* 55  Select total number of employee working in each departmen*/
SELECT
Dep_id,
count(*)
FROM
	Employee
	group by Dep_id
/*56  Select maximum salary of employee working in each floor and whose department is 
‘Developer’  */
select Department.Floor,
 max(Employee.Salary)
 from Employee
inner join Department on Employee.Dep_id = Department.Dep_id 
 where Dep_Name='Developer'
 group by Floor;

/*  57  Select name and department name of employees whose salary is greater than average 
salary of all employees.*/
select Employee.Name, Department.Dep_Name
from Employee
inner join Department on Employee.Dep_id=Department.Dep_id
where salary>(select avg(salary) from Employee)
/*58 Select name and address of employee whore salary is between 20000 and 30000 and 
floor is ‘second’*/
select Name, Address
from Employee
where Salary between 200000 and 300000;
/*59  . Select name and department name employee whose age is minimum */
select Employee.Name, Employee.Salary, Department.Dep_Name
from Employee
join Department on Employee.Dep_id = Department.Dep_id
where Salary=(select min(Salary) from Employee);

/*  60 select sum of salary of all employees whose name ends with letter ‘s’ and department 
is ‘Account  */
select sum(salary)
from Employee
where Name like '$p'



use sandip
select*from Employee;
select*from class
drop table class;
