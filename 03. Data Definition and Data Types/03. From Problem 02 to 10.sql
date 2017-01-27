USE SoftUni
SELECT * FROM Departments -- 02. Find All Information About Departments

SELECT [Name] FROM Departments--03. Find all Department 

SELECT	[FirstName]
		,[LastName]
		,[Salary] 
	FROM Employees--04. Find Salary of Each Employee

SELECT [FirstName]
		,[MiddleName]
		,[LastName]
	FROM Employees --05. Find Full Name of Each Employee

SELECT [FirstName]+'.'+[LastName]+'@softuni.bg' AS "FULL Email Address"
FROM Employees	--06. Find Email Address of Each Employee

SELECT DISTINCT [salary]
FROM Employees --07. Find All Different Employee’s Salaries

SELECT * 
FROM Employees
WHERE JobTitle = 'Sales Representative' --08. Find all Information About Employees

SELECT [FirstName] --1st type
		,[LastName]
		,[JobTitle]
	FROM Employees 
	WHERE [Salary] BETWEEN 20000 AND 30000	--09. Find Names of All Employees by Salary in Range
SELECT [FirstName] -- 2nd type
		,[LastName]
		,[JobTitle]
	FROM Employees 
	WHERE Salary >= 20000 AND Salary <= 30000	--09. Find Names of All Employees by Salary in Range

SELECT [FirstName] +' '+ [MiddleName] +' '+ [LastName] AS "Full Name"
FROM Employees
WHERE Salary = 25000 OR Salary = 14000 OR Salary = 12500 OR Salary = 23600 --10. Find Names of All Employees
