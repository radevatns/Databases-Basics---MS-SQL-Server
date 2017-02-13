--01. Employee Address
  SELECT EmployeeID,JobTitle,AddressID FROM Employees
  SELECT AddressID,AddressText FROM Addresses

  SELECT TOP 5 e.EmployeeID,e.JobTitle,e.AddressID,a.AddressText FROM Employees AS e
  JOIN Addresses AS a
  ON e.AddressID = a.AddressID
  ORDER BY AddressID

--02. Addresses with Towns

SELECT TOP 50 e.FirstName, e.LastName,t.Name AS Town,a.AddressText 
FROM Employees AS e
JOIN Addresses AS a
ON e.AddressID = a.AddressID
JOIN Towns AS t
ON a.TownID = t.TownID					  
ORDER BY FirstName, LastName

--03. Sales Employees
SELECT * FROM Employees
SELECT * FROM Departments

SELECT e.EmployeeID, e.FirstName, e.LastName, d.Name AS DepartmentName
FROM Employees AS e
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'
ORDER BY e.EmployeeID

--04. Employee Departments
SELECT * FROM Employees
SELECT * FROM Departments

SELECT TOP (5) e.EmployeeID, e.FirstName, e.Salary, d.Name AS DepartmentName
FROM Employees AS e
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 15000
ORDER BY e.DepartmentID

--05. Employees Without Projects

SELECT * FROM Employees
SELECT * FROM EmployeesProjects
SELECT * FROM Projects

SELECT TOP (3)
	e.EmployeeID, e.FirstName FROM Employees AS e
WHERE e.EmployeeID NOT IN 
	(SELECT EmployeeID 
	FROM EmployeesProjects AS ep)

--06. Employees Hired After
SELECT FirstName,LastName, HireDate,DepartmentID FROM Employees
SELECT DepartmentID,Name FROM Departments

SELECT e.FirstName,e.LastName, e.HireDate, d.Name AS DeptName 
FROM Employees AS e
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE HireDate > '1/1/1999' 
AND Name IN ('Sales', 'Finance')

--07. Employees With Project
  SELECT * FROM Employees
  SELECT * FROM Projects
  SELECT * FROM EmployeesProjects

  SELECT TOP (5) e.EmployeeID, e.FirstName, p.Name AS ProjectName
  FROM Employees AS e
  JOIN EmployeesProjects AS ep
  ON e.EmployeeID = ep.EmployeeID
  JOIN Projects AS p
  ON ep.ProjectID = p.ProjectID
  WHERE p.StartDate > '2002/08/12' AND p.EndDate IS NULL
  ORDER BY e.EmployeeID 

--08. Employee 24
USE SoftUni
SELECT EmployeeID, FirstName FROM Employees
SELECT ProjectID,Name,StartDate FROM Projects
SELECT EmployeeID,ProjectID FROM EmployeesProjects

SELECT e.EmployeeID, e.FirstName,
	CASE
		WHEN p.StartDate > '2005/01/01' THEN NULL
		ELSE p.Name
	END AS ProjectName 
 FROM Employees AS e
  JOIN EmployeesProjects AS ep
   ON e.EmployeeID = ep.EmployeeID
  JOIN Projects AS p
   ON p.ProjectID=ep.ProjectID
WHERE e.EmployeeID = 24

--09. Employee Manager
 SELECT e1.EmployeeID, e1.FirstName, e1.ManagerID, e2.FirstName AS ManagerName 
 FROM Employees AS e1
 JOIN Employees AS e2
 ON e1.ManagerID = e2.EmployeeID
 WHERE	e1.ManagerID = 3 OR e1.ManagerID = 7
 ORDER BY e1.EmployeeID  

--10. Employees Summary

SELECT TOP(50) e1.EmployeeID, e1.FirstName +' '+ e1.LastName AS EmployeeName, 
		 e2.FirstName +' '+ e2.LastName AS ManagerName,
		 d.Name AS DepartmentName
FROM Employees AS e1
JOIN Employees AS e2
ON e1.ManagerID = e2.EmployeeID
JOIN Departments AS d
ON e1.DepartmentID = d.DepartmentID 
ORDER BY e1.EmployeeID

--11. Min Average Salary

SELECT TOP (1) AVG(Salary) AS SumSalary FROM Employees
GROUP BY DepartmentID
ORDER by SumSalary

--12. Highest Peaks in Bulgaria
 USE Geography
 SELECT c.CountryCode, m.MountainRange, p.PeakName, p.Elevation 
 FROM Countries AS c
 JOIN MountainsCountries AS mc
 ON	c.CountryCode = mc.CountryCode
 JOIN Mountains AS m
 ON mc.MountainId = m.Id
 JOIN Peaks AS p
 ON m.Id = p.MountainId
 WHERE p.Elevation > 2835 AND c.CountryCode = 'BG'
 ORDER BY p.Elevation DESC
 
--13. Count Mountain Ranges
SELECT * FROM Countries
SELECT * FROM MountainsCountries
SELECT * FROM Mountains

SELECT c.CountryCode, COUNT(mc.MountainId) FROM Countries AS c
JOIN MountainsCountries AS mc
ON c.CountryCode = mc.CountryCode
GROUP BY c.CountryCode
HAVING c.CountryCode IN ('BG','US','RU')
ORDER BY c.CountryCode

--14. Countries With or Without Rivers
SELECT * FROM Countries
SELECT * FROM CountriesRivers
SELECT * FROM Rivers

SELECT TOP(5) c.CountryName,r.RiverName FROM Countries AS c
LEFT JOIN CountriesRivers AS cr
ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers AS r
ON cr.RiverId = r.Id 
WHERE c.ContinentCode = 'AF'
ORDER BY c.CountryName
 
--15. *Continents and Currencies
--copy paste from another
	SELECT c.ContinentCode, cc.CurrencyCode, 
	   COUNT(cc.CountryCode) AS CurrencyUsage
FROM Continents c
JOIN Countries cc 
ON c.ContinentCode = cc.ContinentCode 
GROUP BY c.ContinentCode , cc.CurrencyCode
HAVING COUNT(cc.CountryCode) = 
	(SELECT MAX(xxx.CurrencyXX) 
    FROM (SELECT cx.ContinentCode, ccx.CurrencyCode, 
				COUNT(ccx.COUNTryCode) AS CurrencyXX
			FROM Continents cx
			JOIN Countries ccx 
			ON cx.ContinentCode = ccx.ContinentCode 
			WHERE c.ContinentCode = cx.ContinentCode 
			GROUP BY cx.ContinentCode , ccx.CurrencyCode) AS xxx)
AND COUNT(cc.CountryCode) > 1
ORDER BY c.ContinentCode

--16. Countries Without any Mountains
USE Geography

SELECT(SELECT COUNT(CountryName)FROM Countries)-(SELECT COUNT(cc.CountryCode) FROM
	(SELECT CountryCode FROM MountainsCountries
		GROUP BY CountryCode) AS cc) AS CountryCode

--17. Highest Peak and Longest River by Country
SELECT * FROM Countries
SELECT * FROM CountriesRivers
SELECT * FROM Rivers
SELECT * FROM MountainsCountries
SELECT * FROM Peaks

SELECT CountryCode, CountryName FROM Countries
SELECT * FROM CountriesRivers
SELECT RiverName, Length FROM Rivers
SELECT * FROM MountainsCountries
SELECT Elevation, MountainId FROM Peaks

SELECT TOP (5) c.CountryName, 
MAX(p.Elevation)AS HighestPeakElevation, 
 MAX(r.Length) as LongestRiverLength FROM Countries as c
	LEFT JOIN MountainsCountries as mc
	ON c.CountryCode = mc.CountryCode
	LEFT JOIN Peaks AS p
	ON mc.MountainId = p.MountainId
		LEFT JOIN CountriesRivers AS cr
		ON c.CountryCode = cr.CountryCode
		LEFT JOIN Rivers AS r
		ON cr.RiverId = r.Id
GROUP BY c.CountryName
ORDER BY HighestPeakElevation DESC, LongestRiverLength DESC

--18. *Highest Peak Name and Elevation by Country
--copy paste from another
	SELECT TOP 5
	c.CountryName AS Country,
	ISNULL(p.PeakName, '(no highest peak)') AS HighestPeakName,
	ISNULL(MAX(p.Elevation), 0) AS HighestPeakElevation,
	ISNULL(m.MountainRange, '(no mountain)') AS Mountain
FROM Countries c
LEFT JOIN MountainsCountries mc
ON c.CountryCode = mc.CountryCode
LEFT JOIN Peaks p
ON mc.MountainId = p.MountainId
LEFT JOIN Mountains m
ON mc.MountainId = m.Id
GROUP BY c.CountryName, p.Elevation, p.PeakName, m.MountainRange
ORDER BY c.CountryName, p.PeakName
