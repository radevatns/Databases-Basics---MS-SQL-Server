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
SELECT DepartmentID, SUM(Salary) AS SumSalary FROM Employees
GROUP BY DepartmentID
ORDER by SumSalary
							   --TO DO

--12. Highest Peaks in Bulgaria
--13. Count Mountain Ranges
--14. Countries With or Without Rivers
--15. *Continents and Currencies
--16. Countries Without any Mountains
--17. Highest Peak and Longest River by Country
--18. *Highest Peak Name and Elevation by Country