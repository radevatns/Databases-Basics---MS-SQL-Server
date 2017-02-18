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

--11. Mix of Peak and River Names	-- !!! bottom !!
		 
SELECT p.PeakName, r.RiverName, lower(p.PeakName + SUBSTRING(r.RiverName, 2, len(r.RiverName)-1)) AS Mix
	FROM Peaks p
	JOIN Rivers r
	ON RIGHT(p.PeakName, 1) = LEFT(r.RiverName, 1)
	ORDER BY Mix

-- to do
--12. Games From 2011 and 2012 Year

SELECT TOP 50 Name, CONVERT(char(10), Start, 126) FROM Games
	WHERE YEAR(Start) = '2011' OR YEAR(Start) = '2012'
	ORDER BY Start, Name



--13. User Email Providers

SELECT TOP 50 Name, CONVERT(char(10), Start, 126) FROM Games
	WHERE YEAR(Start) = '2011' OR YEAR(Start) = '2012'
	ORDER BY Start, Name


 SELECT Username, SUBSTRING(Email, CHARINDEX('@', Email)+1, len(Email)) AS 'Email Provider' FROM Users
	ORDER BY 'Email Provider', Username


--14. Get Users with IPAddress Like Pattern

SELECT Username, IpAddress AS 'IP Address' FROM Users
WHERE IpAddress LIKE '___.1_%._%.___'
ORDER BY Username


--15. Show All Games with Duration
	   SELECT Name AS Game, 'Part Of The Day' =
	CASE 
		WHEN (DATEPART(HOUR, Start)) BETWEEN 0 AND 11 THEN 'Morning'
		WHEN (DATEPART(HOUR, Start)) BETWEEN 12 AND 17  THEN 'Afternoon'
		WHEN (DATEPART(HOUR, Start)) BETWEEN 18 AND 23  THEN 'Evening'
	END,
	Duration = 
	CASE 
		WHEN Duration <= 3 THEN 'Extra Short'
		WHEN Duration >= 4 AND Duration <=6 THEN 'Short'
		WHEN Duration > 6 THEN 'Long'
		WHEN Duration IS NULL THEN 'Extra Long'
	END
FROM Games
ORDER BY Game, Duration, 'Part Of The Day'

--16. Orders Table
SELECT ProductName
,OrderDate
,DATEADD(Day, 3, OrderDate) AS 'Pay Due',
DATEADD(Month, 1, OrderDate) AS 'Deliver Due'
FROM Orders

