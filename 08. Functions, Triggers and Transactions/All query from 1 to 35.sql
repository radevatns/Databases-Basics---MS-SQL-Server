--  01. Employees with Salary Above 35000
usp_GetEmployeesSalaryAbove35000

CREATE PROC usp_GetEmployeesSalaryAbove35000 
AS
SELECT FirstName,LastName FROM Employees
WHERE Salary > 35000

--  02. Employees with Salary Above Number

CREATE PROC usp_GetEmployeesSalaryAboveNumber (@aboveMoney Money = 48100) 
AS
SELECT FirstName, LastName FROM Employees
WHERE Salary >= @aboveMoney

usp_GetEmployeesSalaryAboveNumber 

--  03. Town Names Starting With

  CREATE PROCEDURE usp_GetTownsStartingWith(@customString NVARCHAR(50)) 
  AS
	BEGIN 
		SELECT Name FROM Towns
		WHERE Name Like @customString + '%' 
	END						
								 
  usp_GetTownsStartingWith b  -- send 'b' to procedure !!!

--  04. Employees from Town

CREATE PROCEDURE usp_GetEmployeesFromTown(@TownName NVARCHAR(50))
  AS
  BEGIN
  SELECT e.FirstName, e.LastName FROM Employees AS e
  JOIN Addresses AS a
  ON e.AddressID = a.AddressID
  FULL JOIN Towns AS t
  ON t.TownID  = a.TownID
  WHERE t.Name = @TownName 
  END

  usp_GetEmployeesFromTown sofia
 
--  05. Salary Level Function

CREATE FUNCTION ufn_GetSalaryLevel(@salary MONEY)
	RETURNS NVARCHAR(7)
		BEGIN
			IF (@salary < 30000)
				BEGIN
				RETURN 'Low'; 
				END
			ELSE IF (@salary >= 30000 AND @salary<= 50000)
				BEGIN
				RETURN 'Average';
				END
				RETURN 'High';
		END

--OPTION 2
	 CREATE FUNCTION ufn_GetSalaryLevel(@salary MONEY)
	RETURNS NVARCHAR(7)
		BEGIN
		DECLARE @Level NVARCHAR(7)
		IF (@salary < 30000)
			BEGIN
			SET @Level = 'Low' 
			END
		ELSE IF (@salary >= 30000 AND @salary<= 50000)
			BEGIN
			SET @Level = 'Average'
			END
		ELSE
			BEGIN
			SET @Level = 'High'
			END
		RETURN @Level 
		END
--  'High' not 'HIGH'

--OPTION 3
CREATE FUNCTION ufn_GetSalaryLevel(@salary MONEY)
RETURNS NVARCHAR(10)
AS
BEGIN
	RETURN
		CASE 
			WHEN @salary < 30000 THEN 'Low'
			WHEN @salary BETWEEN 30000 AND 50000 THEN 'Average'
			WHEN @salary > 50000 THEN 'High'
		END
END

		SELECT Salary, dbo.ufn_GetSalaryLevel(Salary) 
		AS [Salary Level] FROM [dbo].[Employees]
		ORDER BY Salary

--  06. Employees by Salary Level

CREATE PROCEDURE usp_EmployeesBySalaryLevel(@CustomName NVARCHAR(7))
AS
	BEGIN
	SELECT FirstName,LastName FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @CustomName
	END

usp_EmployeesBySalaryLevel Low

--  07. Define Function
	GO			
CREATE FUNCTION ufn_IsWordComprised (@setOfLetters NVARCHAR(50), @word NVARCHAR(50))
RETURNS BIT
AS
BEGIN
	DECLARE @lengh INT = LEN(@word)
	DECLARE @index INT = 1
 	WHILE (@index <= @lengh)
		BEGIN
			DECLARE @char CHAR(1)= SUBSTRING(@word,@index,1)
			IF(CHARINDEX(@char,@setOfLetters)<=0)
				BEGIN
					RETURN 0
				END
			SET @index = @index + 1
		END
	RETURN 1 
END

SELECT dbo.ufn_IsWordComprised ('oistmiahf','halves') 
   GO
--  08. Delete Employees and Departments
GO

ALTER TABLE Departments
ALTER COLUMN ManagerID INT NULL

SELECT e.EmployeeID,e.FirstName,e.DepartmentID,d.Name, d.ManagerID FROM Employees AS e
	JOIN Departments as d
	ON e.DepartmentID = d.DepartmentID
	WHERE d.Name IN ('Production','Production Control')

DELETE FROM EmployeesProjects
WHERE EmployeeID IN (
					 SELECT e.EmployeeID FROM Employees AS e
					JOIN Departments as d
					ON e.DepartmentID = d.DepartmentID
					WHERE d.Name IN ('Production','Production Control')
					)
UPDATE Employees
SET ManagerID = NULL
WHERE ManagerID IN (
					 SELECT e.EmployeeID FROM Employees AS e
					JOIN Departments as d
					ON e.DepartmentID = d.DepartmentID
					WHERE d.Name IN ('Production','Production Control')
					)


UPDATE Departments
SET ManagerID = NULL
WHERE ManagerID IN (
					SELECT e.EmployeeID FROM Employees AS e
					JOIN Departments as d
					ON e.DepartmentID = d.DepartmentID
					WHERE d.Name IN ('Production','Production Control')
					)

DELETE FROM Employees
WHERE EmployeeID IN (
					 SELECT e.EmployeeID FROM Employees AS e
					JOIN Departments as d
					ON e.DepartmentID = d.DepartmentID
					WHERE d.Name IN ('Production','Production Control')
					)
DELETE FROM Departments
WHERE Name IN ('Production','Production Control')

SELECT * FROM Employees
SELECT * FROM Projects
SELECT * FROM EmployeesProjects
SELECT * FROM Departments

 -- option 2
 BEGIN TRANSACTION 
ALTER TABLE EmployeesProjects
DROP CONSTRAINT FK_EmployeesProjects_Employees
ALTER TABLE Departments
DROP CONSTRAINT FK_Departments_Employees
ALTER TABLE Employees
DROP CONSTRAINT FK_Employees_Employees
DELETE FROM Employees
WHERE DepartmentID IN (7,8)
DELETE FROM Departments
WHERE DepartmentID IN (7,8)

ROLLBACK

GO
--  09. Employees with Three Projects
--  10. Find Full Name
--  11. People with Balance Higher Than
--  12. Future Value Function
--  13. Calculating Interest
--  14. Deposit Money Procedure
--  15. Withdraw Money Procedure
--  16. Money Transfer
--  17. Create Table Logs
--  18. Create Table Emails
--  19. *Cash in User Games Odd Rows
--  21. *Massive Shopping
--  22. Number of Users for Email Provider
--  23. All Users in Games
--  24. Users in Games with Their Items
--  25. * User in Games with Their Statistics
--  26. All Items with Greater than Average Statistics
--  27. Display All Items about Forbidden Game Type
--  28. Buy Items for User in Game
--  29. Peaks and Mountains
--  30. Peaks with Mountain, Country and Continent
--  31. Rivers by Country32. Count of Countries by Currency
--  33. Population and Area by Continent
--  34. Monasteries by Country
--  35. Monasteries by Continents and Countries