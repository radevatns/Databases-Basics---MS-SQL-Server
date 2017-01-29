--01. Find Names of All Employees by First Name
USE SoftUni
SELECT FirstName, LastName 
FROM Employees
WHERE FirstName LIKE 'Sa%'

--02. Find Names of All Employees by Last Name
SELECT FirstName, LastName 
FROM Employees
WHERE LastName LIKE '%ei%'

--03. Find First Names of All Employess
SELECT FirstName
--,LastName
--,DepartmentID
--,HireDate 
FROM Employees
Where HireDate BETWEEN  '1995-01-01' AND '2005-12-31'
AND DepartmentID IN (3,10) 

--04. Find All Employees Except Engineers
SELECT FirstName
,LastName
,JobTitle
FROM Employees
WHERE JobTitle NOT LIKE '%Engineer%'

--05. Find Towns with Name Length
--06. Find Towns Starting With
--07. Find Towns Not Starting With
--08. Create View Employees Hired After
--09. Length of Last Name
--10. Countries Holding 'A'
--11. Mix of Peak and River Names
--12. Games From 2011 and 2012 Year
--13. User Email Providers
--14. Get Users with IPAddress Like Pattern
--15. Show All Games with Duration
--16. Orders Table