CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');


  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

	   CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);

CREATE TABLE JOB
(JOB_ID INT PRIMARY KEY,
DESIGNATION VARCHAR(20))

INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')


CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)





--Simple Queries:
--1. List all the employee details.
select * from EMPLOYEE

--2. List all the department details.
select * from DEPARTMENT

--3. List all job details.
select * from JOB

--4. List all the locations
select * from LOCATION

--5. List out the First Name, Last Name, Salary, Commission for all Employees.
select first_name,last_name,salary,comm from EMPLOYEE

--6. List out the Employee ID, Last Name, Department ID for all employeesandalias Employee ID as "ID of the Employee", Last Name as "Name of theEmployee", Department ID as "Dep_id".
SELECT 
    EMPLOYEE_ID AS "ID of the Employee",
    LAST_NAME AS "Name of the Employee",
    DEPARTMENT_ID AS "Dep_id"
FROM EMPLOYEE;


--7. List out the annual salary of the employees with their names only.
SELECT 
    CONCAT(FIRST_NAME, ' ', LAST_NAME) AS "Employee Name",
    SALARY * 12 AS "Annual Salary"
FROM EMPLOYEE;

--WHERE Condition:
--1. List the details about "Smith".
SELECT * FROM EMPLOYEE
WHERE LAST_NAME = 'SMITH';

--2. List out the employees who are working in department 20. 
SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID = 20;

--3. List out the employees who are earning salaries between 3000and4500. 
SELECT * FROM EMPLOYEE
WHERE SALARY BETWEEN 3000 AND 4500;

--4. List out the employees who are working in department 10 or 20. 
SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (10, 20);

--5. Find out the employees who are not working in department 10 or 30.
SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID NOT IN (10, 30);

--6. List out the employees whose name starts with 'S'.
SELECT * FROM EMPLOYEE
WHERE FIRST_NAME LIKE 'S%';

--7. List out the employees whose name starts with 'S' and ends with'H'.
SELECT * FROM EMPLOYEE
WHERE FIRST_NAME LIKE 'S%' AND LAST_NAME LIKE '%H';


--8. List out the employees whose name length is 4 and start with 'S'. 
SELECT * FROM EMPLOYEE
WHERE LEN(FIRST_NAME) = 4 AND FIRST_NAME LIKE 'S%';


--9. List out employees who are working in department 10 and drawsalariesmorethan 3500. 
SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID = 10 AND SALARY > 3500;


--10. List out the employees who are not receiving commission.
SELECT * FROM EMPLOYEE
WHERE COMM IS NULL;

--ORDER BY Clause:
--1. List out the Employee ID and Last Name in ascending order basedontheEmployee ID. 
SELECT EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEE
ORDER BY EMPLOYEE_ID ASC;


--2. List out the Employee ID and Name in descending order based onsalary. 
SELECT EMPLOYEE_ID, CONCAT(FIRST_NAME, ' ', LAST_NAME) AS Employee_Name
FROM EMPLOYEE
ORDER BY SALARY DESC;


--3. List out the employee details according to their Last Name in ascending-order.
SELECT *
FROM EMPLOYEE
ORDER BY LAST_NAME ASC;


--4. List out the employee details according to their Last Name in ascendingorder and then Department ID in descending order.
SELECT *
FROM EMPLOYEE
ORDER BY LAST_NAME ASC, DEPARTMENT_ID DESC;

--GROUP BY and HAVING Clause:
--1. How many employees are in different departments in the organization?
SELECT DEPARTMENT_ID, COUNT(*) AS Total_Employees
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID;

--2. List out the department wise maximum salary, minimumsalary andaverage salary of the employees. 
SELECT DEPARTMENT_ID, MAX(SALARY) AS Max_Salary, MIN(SALARY) AS Min_Salary, AVG(SALARY) AS Avg_Salary
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID;

--3. List out the job wise maximum salary, minimum salary and averagesalary of the employees.
SELECT JOB_ID, MAX(SALARY) AS Max_Salary, MIN(SALARY) AS Min_Salary, AVG(SALARY) AS Avg_Salary
FROM EMPLOYEE
GROUP BY JOB_ID;

--4. List out the number of employees who joined each month in ascendingorder.
SELECT DATEPART(MONTH, HIRE_DATE) AS JoinMonth, COUNT(*) AS TotalEmployees
FROM EMPLOYEE
GROUP BY DATEPART(MONTH, HIRE_DATE)
ORDER BY JoinMonth;


--5. List out the number of employees for each month and year in ascending order based on the year and month. 
SELECT DATEPART(YEAR, HIRE_DATE) AS JoinYear, DATEPART(MONTH, HIRE_DATE) AS JoinMonth, COUNT(*) AS TotalEmployees
FROM EMPLOYEE
GROUP BY DATEPART(YEAR, HIRE_DATE), DATEPART(MONTH, HIRE_DATE)
ORDER BY JoinYear, JoinMonth;


--6. List out the Department ID having at least four employees. 
SELECT DEPARTMENT_ID, COUNT(*) AS TotalEmployees
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 4;


--7. How many employees joined in the month of January?
SELECT COUNT(*) AS sepjoinCount
FROM EMPLOYEE
WHERE DATEPART(MONTH, HIRE_DATE) = 9;


--8. How many employees joined in the month of January orSeptember?
SELECT COUNT(*) AS JanOrSeptJoinCount
FROM EMPLOYEE
WHERE DATEPART(MONTH, HIRE_DATE) IN (1, 9);


--9. How many employees joined in 1985?
SELECT COUNT(*) AS JoinCountIn1985
FROM EMPLOYEE
WHERE DATEPART(YEAR, HIRE_DATE) = 1985;

--10. How many employees joined each month in 1985?
SELECT DATEPART(MONTH, HIRE_DATE) AS JoinMonth, COUNT(*) AS JoinCount
FROM EMPLOYEE
WHERE DATEPART(YEAR, HIRE_DATE) = 1985
GROUP BY DATEPART(MONTH, HIRE_DATE);


--11. How many employees joined in March 1985?
SELECT COUNT(*) AS March1985JoinCount
FROM EMPLOYEE
WHERE DATEPART(YEAR, HIRE_DATE) = 1985 AND DATEPART(MONTH, HIRE_DATE) = 3;


--12. Which is the Department ID having greater than or equal to 3 employeesjoining in April 1985?
SELECT DEPARTMENT_ID, COUNT(*) AS April1985JoinCount
FROM EMPLOYEE
WHERE DATEPART(YEAR, HIRE_DATE) = 1985 AND DATEPART(MONTH, HIRE_DATE) = 4
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 3;

--Joins:
--1. List out employees with their department names.
SELECT E.*, D.Name AS DepartmentName
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id;


--2. Display employees with their designations. 
SELECT E.*, J.Designation
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_ID = J.Job_ID;


--3. Display the employees with their department names and regional groups. 
SELECT E.*, D.Name AS DepartmentName, L.City AS RegionalGroup
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
JOIN LOCATION L ON D.Location_Id = L.Location_ID;


--4. How many employees are working in different departments? Displaywithdepartment names.
SELECT D.Name AS DepartmentName, COUNT(*) AS EmployeeCount
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.Name;


--5. How many employees are working in the sales department?
SELECT COUNT(*) AS SalesEmployeeCount
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name = 'Sales';


--6. Which is the department having greater than or equal to 5 employees? Display the department names in ascending order.
SELECT D.Name AS DepartmentName, COUNT(*) AS EmployeeCount
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.Name
HAVING COUNT(*) >= 5
ORDER BY DepartmentName ASC;


--7. How many jobs are there in the organization? Display with designations. 
SELECT COUNT(*) AS JobCount, Designation
FROM JOB
GROUP BY Designation;


--8. How many employees are working in "New York"?
SELECT COUNT(*) AS NewYorkEmployeeCount
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
JOIN LOCATION L ON D.Location_Id = L.Location_ID
WHERE L.City = 'New York';


--9. Display the employee details with salary grades. Use conditional statementtocreate a grade column. 
SELECT E.*, 
    CASE 
        WHEN SALARY >= 5000 THEN 'Grade A'
        WHEN SALARY >= 3000 AND SALARY < 5000 THEN 'Grade B'
        ELSE 'Grade C'
    END AS SalaryGrade
FROM EMPLOYEE E;


--10. List out the number of employees grade wise. Use conditional statementtocreate a grade column. 
SELECT SalaryGrade, COUNT(*) AS EmployeeCount
FROM (
    SELECT E.*, 
        CASE 
            WHEN SALARY >= 5000 THEN 'Grade A'
            WHEN SALARY >= 3000 AND SALARY < 5000 THEN 'Grade B'
            ELSE 'Grade C'
        END AS SalaryGrade
    FROM EMPLOYEE E
) AS GradeTable
GROUP BY SalaryGrade;


--11.Display the employee salary grades and the number of employees between 2000 to 5000 range of salary. 
SELECT SalaryGrade, COUNT(*) AS EmployeeCount
FROM (
    SELECT E.*, 
        CASE 
            WHEN SALARY >= 5000 THEN 'Grade A'
            WHEN SALARY >= 3000 AND SALARY < 5000 THEN 'Grade B'
            ELSE 'Grade C'
        END AS SalaryGrade
    FROM EMPLOYEE E
) AS GradeTable
WHERE Salary BETWEEN 2000 AND 5000
GROUP BY SalaryGrade;


--12. Display all employees in sales or operation departments.
SELECT E.*
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name IN ('Sales', 'Operations');

--SET Operators:
--1. List out the distinct jobs in sales and accounting departments. 
SELECT DISTINCT J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.JOB_ID = E.JOB_ID
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name IN ('Sales', 'Accounting');


--2. List out all the jobs in sales and accounting departments. 
SELECT J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.JOB_ID = E.JOB_ID
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name IN ('Sales', 'Accounting');
 

--3. List out the common jobs in research and accounting departments in ascending order.
SELECT J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.JOB_ID = E.JOB_ID
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name = 'Research'
INTERSECT
SELECT J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.JOB_ID = E.JOB_ID
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name = 'Accounting'
ORDER BY Designation ASC;

--Subqueries:
--1. Display the employees list who got the maximum salary.
SELECT * FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE);

--2. Display the employees who are working in the sales department. 
SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE Name = 'Sales');


--3. Display the employees who are working as 'Clerk'. 
SELECT * FROM EMPLOYEE
WHERE JOB_ID = (SELECT JOB_ID FROM JOB WHERE Designation = 'CLERK');


--4. Display the list of employees who are living in "New York". 
SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE Location_Id = (SELECT Location_ID FROM LOCATION WHERE City = 'New York'));


--5. Find out the number of employees working in the sales department.
SELECT COUNT(*) AS SalesEmployeeCount FROM EMPLOYEE
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE Name = 'Sales');


--6. Update the salaries of employees who are working as clerks on thebasisof 10%. 
UPDATE EMPLOYEE
SET SALARY = SALARY * 1.1
WHERE JOB_ID = (SELECT JOB_ID FROM JOB WHERE Designation = 'CLERK');


--7. Delete the employees who are working in the accounting department. 
DELETE FROM EMPLOYEE
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE Name = 'Accounting');


--8. Display the second highest salary drawing employee details. 

SELECT * FROM EMPLOYEE
WHERE SALARY = (
    SELECT MAX(SALARY)
    FROM EMPLOYEE
    WHERE SALARY < (SELECT MAX(SALARY) FROM EMPLOYEE)
);

--9. Display the nth highest salary drawing employee details. 

SELECT * FROM EMPLOYEE
WHERE SALARY = (
    SELECT DISTINCT TOP 1 SALARY
    FROM (
        SELECT DISTINCT TOP 3 SALARY
        FROM EMPLOYEE
        ORDER BY SALARY DESC
    ) AS NthHighestSalaries
    ORDER BY SALARY ASC
);

--10. List out the employees who earn more than every employee in department 30.
SELECT * FROM EMPLOYEE
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEE WHERE DEPARTMENT_ID = 30);


--11. List out the employees who earn more than the lowest salary in department.Find out whose department has no employees. 
SELECT * FROM EMPLOYEE
WHERE SALARY > ALL (SELECT MIN(SALARY) FROM EMPLOYEE WHERE DEPARTMENT_ID = EMPLOYEE.DEPARTMENT_ID);

--12. Find out which department has no employees. 
SELECT Name AS DepartmentName
FROM DEPARTMENT
WHERE Department_Id NOT IN (SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEE);


--13. Find out the employees who earn greater than the average salary for their department.
SELECT * FROM EMPLOYEE E
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPARTMENT_ID = E.DEPARTMENT_ID);



