---- INNER JOIN -----
--- change database connection. use the sample database you created for TechPrac01 
use CarsonEmerySample

select * from Employee
--1  JOIN TWO TABLES 
--- 1.1  Get full details of employee and department name and location of all the employees 

---- ISO sql syntax
select * from employee e
inner join department d
on e.dept_no = d.dept_no

select * from employee e
inner join department d
on e.dept_no = d.dept_no

---- ANSI syntx
select *
from employee e, department d
where e.dept_no = d.dept_no


--- 1.2 Get names of the employees in accounting department  
select emp_fname, emp_lname
from employee e
inner join department d
on e.dept_no = d.dept_no
where dept_name = 'accounting'

---- we can do filtering on the ON clause
select emp_fname, emp_lname
from employee e
inner join department d
on e.dept_no = d.dept_no and
dept_name = 'accounting'



---1.3  Get the first and last name of employee whose department is located in Seattle
select emp_fname, emp_lname
from employee e
inner join department d
on e.dept_no = d.dept_no
where location = 'seattle'


----1.4 List the number of employees in each location
select location, count(*) as number_of_employees
from employee e
inner join department d
on e.dept_no = d.dept_no
group by location 


---- 1.5 Identify the employee numbers for those who work on the project Gemini
select emp_no
from works_on wo
inner join project p
on wo.project_no = p.project_no
where project_name = 'Gemini'



---1.6 Get the department number for all employees who entered their projects on Oct 15th, 2007.
select dept_no
from works_on wo
inner join employee e
on wo.emp_no = e.emp_no
where enter_date = '20071015' 



---1.7 how many employees work on the project Gemini?
select count(*) as num_of_emps
from project p
inner join works_on wo
on p.project_no = wo.project_no
where project_name = 'Gemini'


---2. JOIN MORE THAN TWO TABLES

----2.1 Identify the employee names for those who work on the project Gemini
select emp_fname, emp_lname
from employee e
inner join works_on wo
on e.emp_no = wo.emp_no
inner join project p
on wo.project_no = p.project_no
where project_name = 'Gemini'

select distinct emp_fname, emp_lname
from project p inner join works_on wo
on p.project_no = wo.project_no
inner join employee e
on wo.emp_no = e.emp_no
where project_name = 'Gemini'

----2.2 Get the department name for all employees who entered their projects on Oct 15th, 2017.
select dept_name, emp_fname, emp_lname
from employee e
inner join works_on wo
on e.emp_no = wo.emp_no
inner join department d
on e.dept_no = d.dept_no
where enter_date = '20071015'





----2.3 Get the first and last name of analyst whose department is located in Seattle


----2.4 Get the names of projects (remove redundant duplicates) being worked on by
--- employees from the accounting departments


---- 2.5 Show the number of projects that is worked on by each deparment. Show the department name and the number of project.



---2.6 get the names of the employees who are managers and work on project Mercury. 





----Exercise using the Northwind database

--- change database connection


-----1. For each product, we would like to know its assocated supplier. show the productID, productName
---- and the CompanyName of the supplier.


---2. Show a list of orders that were made, including the shhipper that was used
 ---Show the orderID, OrderDate and the companyName of the shhipper. Sort by OrderID and only show rows
---- with orderID less than 10270. 


----3. We would like to see the total number of products in each category (show catgory name). Sort the results
---- by the total number of products descendingly



--- 4. We are doing an inventory and would like to show Employee and Order Detail information.
--- Results should include EmployeeID, LastName, OrderID, ProductName and Quantity
 


---- 5: For each customer, return the total number of orders and total quantity ordered.
--- You results should include customerid, total number of orders and total quantity

--- 6.  For each US customer, return the total number of orders and total quantity
--- You results should include customerid, total number of orders and total quantity. Only return US customers.

--- 7.  For each US customer, return the total number of orders, total order amount and average order amount per order.
--- You results should include customerid, total number of orders, total order amount and average order amount per order
----Only return US customers. You do not need to consider discount for this problem 

--- 8. Some salesperson have more orders arriving late than others. Which salesperson have the most orders arrving late?
--- show employeeid, lastName and total number of late orders. 





   

