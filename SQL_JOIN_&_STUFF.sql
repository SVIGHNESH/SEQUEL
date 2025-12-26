create database company;
use company;

show tables;

CREATE TABLE Employee (
    id INT PRIMARY KEY,
    fname VARCHAR(50),
    lname VARCHAR(50),
    age INT,
    emailID VARCHAR(100),
    phoneNo VARCHAR(20),
    city VARCHAR(50)
);

INSERT INTO Employee (id, fname, lname, age, emailID, phoneNo, city) VALUES
(1, 'Aman',  'Proto',  32, 'aman@gmail.com',  '898', 'Delhi'),
(2, 'Yagya', 'Narayan',44, 'yagya@gmail.com', '222', 'Palam'),
(3, 'Rahul', 'BD',     22, 'rahul@gmail.com', '444', 'Kolkata'),
(4, 'Jatin', 'Hermit', 31, 'jatin@gmail.com', '666', 'Raipur'),
(5, 'PK',    'Pandey', 21, 'pk@gmail.com',    '555', 'Jaipur');

CREATE TABLE Client (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    emailID VARCHAR(100),
    phoneNo VARCHAR(20),
    city VARCHAR(50),
    empID INT,
    FOREIGN KEY (empID) REFERENCES Employee(id)
);

INSERT INTO Client (id, first_name, last_name, age, emailID, phoneNo, city, empID) VALUES
(1, 'Mac',     'Rogers',   47, 'mac@hotmail.com',   '333',   'Kolkata',   3),
(2, 'Max',     'Poirier',  27, 'max@gmail.com',     '222',   'Kolkata',   3),
(3, 'Peter',   'Jain',     24, 'peter@abc.com',     '111',   'Delhi',     1),
(4, 'Sushant', 'Aggarwal', 23, 'sushant@yahoo.com', '45454', 'Hyderabad', 5),
(5, 'Pratap',  'Singh',    36, 'p@xyz.com',         '77767', 'Mumbai',    2);


CREATE TABLE Project (
    id INT PRIMARY KEY,
    empID INT,
    name VARCHAR(50),
    startdate DATE,
    clientID INT,
    FOREIGN KEY (empID) REFERENCES Employee(id),
    FOREIGN KEY (clientID) REFERENCES Client(id)
);


INSERT INTO Project (id, empID, name, startdate, clientID) VALUES
(1, 1, 'A', '2021-04-21', 3),
(2, 2, 'B', '2021-03-12', 1),
(3, 3, 'C', '2021-01-16', 5),
(4, 3, 'D', '2021-04-27', 2),
(5, 5, 'E', '2021-05-01', 4);


INSERT INTO Project (id, empID, name, startdate, clientID) VALUES
(1, 1, 'A', '2021-04-21', 3),
(2, 2, 'B', '2021-03-12', 1),
(3, 3, 'C', '2021-01-16', 5),
(4, 3, 'D', '2021-04-27', 2),
(5, 5, 'E', '2021-05-01', 4);

select * from Employee;
select * from Project;
select * from Client;



select c.*,e.* from Employee as e INNER JOIN  Client  as c on e.id=c.empID;
select c.first_name,e.fname from Employee as e LEFT JOIN  Client as c on e.id=c.empID;


-- Enlist All Employee id,name,project name on which they are working 

select e.id,e.fname,e.lname,p.id as project_id ,p.name as project_name 
from Employee as e
INNER JOIN Project as p 
on p.empID=e.id;

-- Fetch out all the employeess ID's and their contact details who have been working from 
-- Jaipur with the Clients name working in the Hyderabad;

select e.id,e.fname,e.emailID,e.phoneNo,c.first_name as client_name 
from Employee as e 
INNER JOIN Client as c 
on e.id=c.empID 
where e.city='Jaipur' and c.city='Hyderabad';

-- Left Joinn
-- Fetch out each project allocated to each employee

select p.name as PROJECT_NAME,e.fname as EMPLOYEE_NAME 
from  Employee as e 
LEFT JOIN Project as p
on e.id=p.empID;

-- List out the all the project name along with the employee name and their respective allocated email id 
select p.name as PROJECT_NAME,e.fname as EMPLOYEE_NAME , e.emailID as EMPLOYEE_EMAIL
from   Project as p 
LEFT JOIN Employee as e
on e.id=p.empID ;
 
-- List Out the All the possible combinations of the  Employee'name and the project there can  exist

SELECT e.fname,p.name FROM Employee as e CROSS JOIN Project as p;

-- Subqueries 
-- Employees with more age than the 30

select * from Employee where age in (select age from Employee where age>30);

-- Employee details who is working in the more than 1 project 
SELECT * from Employee where id in (
Select empID from Project group by (empID) having count(empID) > 1);

-- Single Value SubQuery

select * from Employee where age >(Select avg(age) from Employee);
select * from Employee where age > avg(age);

-- From Clause SubQuery -- Derived Table 
-- Maximum age of the employees whose name has 'a'
select max(age),fname from (Select * from Employee where fname like '%a%') as temp;


-- Corelated Subquery 
-- find third oldest employee 
Select fname,age from Employee as e1
WHERE 3 = (
	Select COUNT(e2.age) from Employee as e2
    where e2.age >= e1.age);


-- SQL VIEW 

SELECT * FROM Employee;

-- Creating a VIEW 
CREATE VIEW customView as SELECT fname,lname,age,city from Employee;

-- VIEWING THE VALUES FROM THE VIEW 
select * from customView;
