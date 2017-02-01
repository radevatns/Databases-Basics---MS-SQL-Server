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

SELECT FirstName FROM Employees
WHERE DepartmentID IN (3, 10)  AND YEAR([HireDate]) BETWEEN 1995 AND 2005

--04. Find All Employees Except Engineers
SELECT FirstName
,LastName
,JobTitle
FROM Employees
WHERE JobTitle NOT LIKE '%Engineer%'

--05. Find Towns with Name Length
SELECT Name FROM Towns
WHERE (LEN(Name) IN(5,6))
ORDER BY Name

--06. Find Towns Starting With
SELECT TownID, Name  FROM Towns
WHERE LEFT(Name,1) IN ('M', 'K', 'B', 'E')
ORDER BY Name

--07. Find Towns Not Starting With
SELECT TownID,Name FROM Towns
WHERE LEFT(Name,1) NOT IN ('R', 'B', 'D')
ORDER BY Name

--08. Create View Employees Hired After
GO
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName,
 LastName FROM Employees
WHERE HireDate > '2001'
GO
GO
CREATE VIEW V_EmployeesHiredAfter2000_3ndOption AS
SELECT FirstName,
 LastName F, HireDate FROM Employees
WHERE YEAR(HireDate) > 2000
GO

SELECT * FROM V_EmployeesHiredAfter2000
SELECT * FROM V_EmployeesHiredAfter2000_3ndOption
GO
--09. Length of Last Name

SELECT FirstName, LastName
FROM Employees
WHERE LEN(LastName) = 5

--10. Countries Holding 'A'
USE Geography
SELECT CountryName, ISOCode FROM Countries
WHERE CountryName LIKE '%a%a%a%'
ORDER BY IsoCode

SELECT CountryName, ISOCode FROM Countries
WHERE CountryName LIKE '%a%'
ORDER BY IsoCode

--11. Mix of Peak and River Names

SELECT p.PeakName, r.RiverName 
FROM Peaks p
JOIN Rivers r
-- to do
--12. Games From 2011 and 2012 Year
--13. User Email Providers
--14. Get Users with IPAddress Like Pattern
--15. Show All Games with Duration
--16. Orders Table