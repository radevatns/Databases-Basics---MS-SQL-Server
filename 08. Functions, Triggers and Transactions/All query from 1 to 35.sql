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
GO
ALTER PROCEDURE usp_AssignProject(@emloyeeId INT, @projectID INT)
AS  
BEGIN
	BEGIN TRANSACTION
		INSERT INTO EmployeesProjects (EmployeeID,ProjectID) VALUES 
				(@emloyeeId, @projectID)
		IF((SELECT COUNT(ProjectID)FROM EmployeesProjects
			GROUP BY EmployeeID
			HAVING EmployeeID =@emloyeeId)>3)
			BEGIN
				RAISERROR('The employee has too many projects!',16,1)
				ROLLBACK
				RETURN --TO DO TRY WITHOUT RETURN
			END
	 COMMIT
END

 EXEC usp_AssignProject 6,12



DELETE FROM EmployeesProjects
WHERE EmployeeID IN(2,6) 
SELECT * FROM Employees
SELECT * FROM EmployeesProjects
SELECT * FROM Projects
SELECT EmployeeID,COUNT(ProjectID)AS cntProjects FROM EmployeesProjects
GROUP BY EmployeeID
GO

--  10. Find Full Name
GO
USE Bank


CREATE PROCEDURE usp_GetHoldersFullName
AS
	BEGIN
	SELECT FirstName + ' ' + LastName as 'Full Name' FROM AccountHolders
	END
EXEC usp_GetHoldersFullName

   
SELECT * FROM AccountHolders
SELECT * FROM Accounts
GO	   

--  11. People with Balance Higher Than
CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan (@inputMoney MONEY)
AS
	BEGIN
		SELECT FirstName AS 'First Name' ,LastName AS 'Last Name' 
		FROM (SELECT FirstName,LastName, SUM(Balance) AS totalBalance FROM Accounts AS a
				JOIN AccountHolders	   AS ah
				ON a.AccountHolderId = ah.Id
				GROUP BY ah.FirstName, ah.LastName) AS balanceWithName
				WHERE @inputMoney < totalBalance 
	END

EXEC usp_GetHoldersWithBalanceHigherThan 654640


SELECT AccountHolderId, SUM(Balance) FROM Accounts AS a
JOIN AccountHolders	   AS ah
ON a.AccountHolderId = ah.Id
GROUP BY AccountHolderId
ORDER BY AccountHolderId
  
SELECT * FROM AccountHolders
SELECT * FROM Accounts
ORDER BY AccountHolderId

--  12. Future Value Function

USE Bank

CREATE FUNCTION ufn_CalculateFutureValue(@sum MONEY, @yearlyRate FLOAT, @numYears INT) 
RETURNS MONEY
AS
BEGIN
	DECLARE @result MONEY;
			SET @result = @sum * (POWER((1+@yearlyRate),@numYears))
			
			RETURN @result; 
--FV=I×(〖(1+R)〗^T) 
END

EXEC ufn_CalculateFutureValue 1000.0, 0.1, 5 

-- not mine
Option 2
CREATE FUNCTION ufn_CalculateFutureValue(@sum MONEY, @yir FLOAT, @ny INT)
RETURNS MONEY
AS
BEGIN
	DECLARE @i INT = 1 
	WHILE (@i <= @ny)
	BEGIN
		SET @sum = @sum + @sum*@yir
		SET @i += 1
	END
	RETURN @sum
END

--  13. Calculating Interest

CREATE PROCEDURE usp_CalculateFutureValueForAccount(@AccountId INT, @interestRate FLOAT)
AS
BEGIN
	SELECT accHold.Id AS [Account Id], 
		accHold.FirstName AS [First Name],
		accHold.LastName AS [LastName],
		a.Balance AS [Current Balanse], 
		dbo.ufn_CalculateFutureValue(a.Balance, @interestRate, 5)
	FROM AccountHolders accHold
	RIGHT JOIN Accounts a
	ON accHold.Id = a.AccountHolderId
	WHERE a.Id = @AccountId 
END

EXEC usp_CalculateFutureValueForAccount 1, 0.1

--  14. Deposit Money Procedure

CREATE PROCEDURE usp_DepositMoney (@AccountId INT, @moneyAmount MONEY)
AS
	BEGIN
	BEGIN TRANSACTION
	UPDATE Accounts
	SET Balance = Balance + @moneyAmount
	WHERE Id = @AccountId
	COMMIT 
	
	END
 
--  15. Withdraw Money Procedure

CREATE PROCEDURE usp_WithdrawMoney (@accountId INT, @moneyAmount MONEY)
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Accounts
	SET Balance = Balance - @moneyAmount
	WHERE Accounts.Id = @AccountId
	COMMIT 
END 

EXEC usp_WithdrawMoney 1, 10000

--  16. Money Transfer
CREATE PROCEDURE usp_TransferMoney(@senderId INT, @receiverId INT, @amount MONEY)
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Accounts
	SET Balance = Balance - @amount
	WHERE Accounts.Id = @senderId
	UPDATE Accounts
	SET Balance = Balance + @amount
	WHERE Accounts.Id = @receiverId
	IF (SELECT Balance FROM Accounts WHERE Accounts.Id = @senderId) < 0
		ROLLBACK
	ELSE COMMIT 
END

EXEC usp_TransferMoney 1, 2, 10000


--  17. Create Table Logs

CREATE TABLE Logs(
LogId INT IDENTITY PRIMARY KEY,
AccountId INT,
OldSum MONEY,
NewSum Money)

CREATE TRIGGER tr_SumChanges ON Accounts AFTER UPDATE
AS
BEGIN
	INSERT INTO Logs (AccountId, OldSum, NewSum)
	SELECT i.Id, d.Balance, i.Balance 
	FROM inserted AS i
	INNER JOIN deleted AS d
	ON i.AccountHolderId = d.AccountHolderId
END

UPDATE Accounts
SET Balance += 10
WHERE Id = 1
--  18. Create Table Emails

CREATE TABLE NotificationEmails(
Id INT IDENTITY PRIMARY KEY,
Recipient NVARCHAR(50),
Subject NVARCHAR(256),
Body NVARCHAR(MAX)
)

CREATE TRIGGER tr_LogToEmail ON Logs AFTER INSERT
AS
BEGIN
	INSERT INTO NotificationEmails
		(Recipient, Subject, Body)
	SELECT AccountId,
		'Balance change for account: ' 
		+ CONVERT(varchar(10), AccountId),
		'On ' + CONVERT(varchar(30), GETDATE()) + ' your balance was changed from '
		+ CONVERT(varchar(30), OldSum) + ' to ' 
		+ CONVERT(varchar(30), NewSum) 
	  FROM Logs
END

UPDATE Accounts
SET Balance += 10
WHERE Id = 1


--  19. *Cash in User Games Odd Rows
USE Diablo
GO
				CREATE FUNCTION ufn_CashInUsersGames (@gameName NVARCHAR(50))
RETURNS @Result TABLE(SumCash MONEY)
AS
BEGIN
	INSERT INTO @Result
	SELECT SUM(sc.Cash) as SumCash
	FROM
		(SELECT Cash,
		ROW_NUMBER() OVER(ORDER BY Cash DESC) AS RowNumber
		FROM UsersGames userg
		RIGHT JOIN Games g
		ON userg.GameId = g.Id
		WHERE g.Name = @gameName) sc
	WHERE RowNumber % 2 != 0
	RETURN
END

GO
--  21. *Massive Shopping

GO
BEGIN TRANSACTION
DECLARE @sum1 MONEY = (SELECT SUM(i.Price)
						FROM Items i
						WHERE MinLevel BETWEEN 11 AND 12)

IF (SELECT Cash FROM UsersGames WHERE Id = 110) < @sum1
ROLLBACK
ELSE BEGIN
		UPDATE UsersGames
		SET Cash = Cash - @sum1
		WHERE Id = 110

		INSERT INTO UserGameItems (UserGameId, ItemId)
		SELECT 110, Id 
		FROM Items 
		WHERE MinLevel BETWEEN 11 AND 12
		COMMIT
	END

BEGIN TRANSACTION
DECLARE @sum2 MONEY = (SELECT SUM(i.Price)
						FROM Items i
						WHERE MinLevel BETWEEN 19 AND 21)

IF (SELECT Cash FROM UsersGames WHERE Id = 110) < @sum2
ROLLBACK
ELSE BEGIN
		UPDATE UsersGames
		SET Cash = Cash - @sum2
		WHERE Id = 110

		INSERT INTO UserGameItems (UserGameId, ItemId)
			SELECT 110, Id 
			FROM Items 
			WHERE MinLevel BETWEEN 19 AND 21
		COMMIT
	END

SELECT i.Name AS 'Item Name' 
FROM UserGameItems AS ugi
JOIN Items i
ON ugi.ItemId = i.Id
WHERE ugi.UserGameId = 110
GO


--  22. Number of Users for Email Provider

SELECT SUBSTRING(Email, CHARINDEX('@', Email)+1, len(Email))  AS [Email Provider], 
	COUNT(Email) AS [Number Of Users]
FROM Users
GROUP BY SUBSTRING(Email, CHARINDEX('@', Email)+1, len(Email))
ORDER BY COUNT(Email) DESC, SUBSTRING(Email, CHARINDEX('@', Email)+1, len(Email)) 

--  23. All Users in Games
GO
SELECT g.Name, gt.Name, 
	u.Username, userg.Level, userg.Cash, c.Name
FROM Games g
JOIN GameTypes gt
ON gt.Id = g.GameTypeId
JOIN UsersGames userg
ON userg.GameId = g.Id
JOIN Users u
ON u.Id = userg.UserId
JOIN Characters c
ON userg.CharacterId = c.Id
ORDER BY userg.Level DESC, u.Username, g.Name

GO

--  24. Users in Games with Their Items
   SELECT u.Username, g.Name, COUNT(i.Name), SUM(i.Price)
FROM Users u
JOIN UsersGames userg
ON u.Id = userg.UserId
JOIN Games g
ON userg.GameId = g.Id
JOIN UserGameItems usergi
ON usergi.UserGameId = userg.Id
JOIN Items i
ON i.Id = usergi.ItemId
GROUP BY u.Username, g.Name
HAVING COUNT(i.Name) >= 10
ORDER BY COUNT(i.Name) DESC,
	SUM(i.Price) DESC,
	u.Username

--  25. * User in Games with Their Statistics
SELECT u.Username, g.Name AS Game, MAX(c.Name) AS Character,
SUM(its.Strength) + MAX(gts.Strength) + MAX(cs.Strength) AS Strength,
SUM(its.Defence) + MAX(gts.Defence) + MAX(cs.Defence) AS Defence,
SUM(its.Speed) + MAX(gts.Speed) + MAX(cs.Speed) as Speed,
SUM(its.Mind) + MAX(gts.Mind) + MAX(cs.Mind) AS Mind,
SUM(its.Luck) + MAX(gts.Luck) + MAX(cs.Luck) AS Luck
FROM Users u
JOIN UsersGames ug
ON u.Id = ug.UserId
JOIN Games g
ON ug.GameId = g.Id
JOIN GameTypes gt
ON gt.Id = g.GameTypeId
JOIN [dbo].[Statistics] gts
ON gts.Id = gt.BonusStatsId
JOIN Characters c
ON ug.CharacterId = c.Id
JOIN [dbo].[Statistics] cs
ON cs.Id = c.StatisticId
JOIN UserGameItems ugi
ON ugi.UserGameId = ug.Id
JOIN Items i
ON i.Id = ugi.ItemId
JOIN [dbo].[Statistics] its
ON its.Id = i.StatisticId
GROUP BY u.Username, g.Name
ORDER BY Strength DESC, Defence DESC, Speed DESC, Mind DESC, Luck DESC


--  26. All Items with Greater than Average Statistics
SELECT i.Name, i.Price, i.MinLevel, 
	s.Strength, s.Defence, s.Speed, s.Luck, s.Mind
FROM Items i
JOIN [Statistics] s
ON i.StatisticId = s.Id
WHERE s.Speed > (SELECT AVG(s.Speed)
					FROM Items i
					JOIN [Statistics] s
					ON i.StatisticId = s.Id
					)
AND s.Luck > (SELECT AVG(s.Luck)
					FROM Items i
					JOIN [Statistics] s
					ON i.StatisticId = s.Id
					)
AND s.Mind > (SELECT AVG(s.Mind)
					FROM Items i
					JOIN [Statistics] s
					ON i.StatisticId = s.Id
					)
ORDER BY i.Name
--  27. Display All Items about Forbidden Game Type
SELECT i.Name AS Item, i.Price, i.MinLevel,
gt.Name AS [Forbidden Game Type]
FROM Items i
LEFT JOIN GameTypeForbiddenItems gtfi
ON gtfi.ItemId = i.Id
LEFT JOIN GameTypes gt
ON gt.Id = gtfi.GameTypeId
ORDER BY [Forbidden Game Type] DESC,
i.Name
--  28. Buy Items for User in Game
USE Diablo
 DECLARE @sumCash MONEY = (SELECT SUM(Price)
					FROM Items
					WHERE Name IN ('Blackguard', 'Bottomless Potion of Amplification',
					'Eye of Etlich (Diablo III)', 'Gem of Efficacious Toxin', 
					'Golden Gorget of Leoric', 'Hellfire Amulet'))

BEGIN TRAN
IF (SELECT SUM(Cash) FROM UsersGames 
	WHERE UserId = (SELECT Id FROM Users
					WHERE Username = 'Alex')) < @sumCash	
ROLLBACK
ELSE
	UPDATE UsersGames
	SET Cash = Cash - @sumCash
	WHERE UserId = (SELECT Id FROM Users
					WHERE Username = 'Alex')

	INSERT INTO UserGameItems (ItemId, UserGameId)
	(SELECT i.Id, 235
	FROM Items i
	WHERE Name IN ('Blackguard', 'Bottomless Potion of Amplification',
	'Eye of Etlich (Diablo III)', 'Gem of Efficacious Toxin', 
	'Golden Gorget of Leoric', 'Hellfire Amulet'))
COMMIT

SELECT u.Username, g.Name, ug.Cash, i.Name AS [Item Name]
FROM UserGameItems ugi
JOIN Items i
ON ugi.ItemId = i.Id
JOIN UsersGames ug
ON ug.Id = ugi.UserGameId
JOIN Users u
ON ug.UserId = u.Id
JOIN  Games g
ON ug.GameId = g.Id
WHERE g.Name = 'Edinburgh'
ORDER BY i.Name

-- 29. Peaks and Mountains
USE Geography

SELECT p.PeakName, m.MountainRange AS Mountain, p.Elevation
FROM Peaks p
JOIN Mountains m
ON p.MountainId = m.Id 
ORDER BY p.Elevation DESC, p.PeakName

-- 30. Peaks with Mountain, Country and Continent
SELECT p.PeakName, m.MountainRange, c.CountryName, con.ContinentName
FROM Peaks p
JOIN Mountains m
ON p.MountainId = m.Id 
JOIN MountainsCountries mc
ON mc.MountainId = m.Id
JOIN Countries c
ON mc.CountryCode = c.CountryCode
JOIN Continents con
ON con.ContinentCode = c.ContinentCode
ORDER BY p.PeakName, c.CountryName

-- 31. Rivers by Country
SELECT c.CountryName, con.ContinentName, 
ISNULL(COUNT(r.Id), 0) AS RiversCount,
ISNULL(SUM(r.Length), 0)  AS TotalLength
FROM Countries c
JOIN Continents con
ON con.ContinentCode = c.ContinentCode
LEFT JOIN CountriesRivers cr
ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers r
ON cr.RiverId = r.Id
GROUP BY c.CountryName, con.ContinentName
ORDER BY RiversCount DESC, TotalLength DESC, c.CountryName

-- 32. Count of Countries by Currency
SELECT c.CurrencyCode, c.Description AS Currency, 
COUNT(ctr.CountryCode) AS NumberOfCountries
FROM Currencies c
LEFT JOIN Countries ctr
ON c.CurrencyCode = ctr.CurrencyCode
GROUP BY c.CurrencyCode, c.Description
ORDER BY NumberOfCountries DESC, c.Description

-- 33. Population and Area by Continent
SELECT cnt.ContinentName, 
SUM(cntr.AreaInSqKm) AS CountriesArea,
SUM(CAST (cntr.Population AS BIGINT)) AS CountriesPopulation 
FROM Countries cntr
JOIN Continents cnt
ON cntr.ContinentCode = cnt.ContinentCode
GROUP BY cnt.ContinentName
ORDER BY CountriesPopulation DESC

-- 34. Monasteries by Country
CREATE TABLE Monasteries(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(50),
CountryCode CHAR(2) 
FOREIGN KEY (CountryCode) REFERENCES Countries(CountryCode)
)

INSERT INTO Monasteries(Name, CountryCode) VALUES
('Rila Monastery “St. Ivan of Rila”', 'BG'), 
('Bachkovo Monastery “Virgin Mary”', 'BG'),
('Troyan Monastery “Holy Mother''s Assumption”', 'BG'),
('Kopan Monastery', 'NP'),
('Thrangu Tashi Yangtse Monastery', 'NP'),
('Shechen Tennyi Dargyeling Monastery', 'NP'),
('Benchen Monastery', 'NP'),
('Southern Shaolin Monastery', 'CN'),
('Dabei Monastery', 'CN'),
('Wa Sau Toi', 'CN'),
('Lhunshigyia Monastery', 'CN'),
('Rakya Monastery', 'CN'),
('Monasteries of Meteora', 'GR'),
('The Holy Monastery of Stavronikita', 'GR'),
('Taung Kalat Monastery', 'MM'),
('Pa-Auk Forest Monastery', 'MM'),
('Taktsang Palphug Monastery', 'BT'),
('Sümela Monastery', 'TR')

ALTER TABLE Countries 
ADD IsDeleted BIT DEFAULT 0


UPDATE Countries
SET IsDeleted = 1
WHERE CountryCode IN (SELECT r.CountryCode 
						FROM (SELECT c.CountryCode, COUNT(cr.RiverId) AS CountR
								FROM Countries c
								JOIN CountriesRivers cr
								ON c.CountryCode = cr.CountryCode
								GROUP BY c.CountryCode
								HAVING COUNT(cr.RiverId) > 3) r
					)

SELECT m.Name AS Monastery, c.CountryName AS Country
FROM Monasteries m
JOIN Countries c
ON m.CountryCode = c.CountryCode
WHERE c.IsDeleted != 1 OR c.IsDeleted IS NULL
ORDER BY Monastery

-- 35. Monasteries by Continents and Countries
UPDATE Countries
SET CountryName = 'Burma'
WHERE CountryName = 'Myanmar'

INSERT INTO Monasteries(Name, CountryCode)
SELECT 'Hanga Abbey', CountryCode 
	FROM Countries
	WHERE CountryName = 'Tanzania'


INSERT INTO Monasteries(Name, CountryCode)
SELECT 'Myin-Tin-Daik', CountryCode 
	FROM Countries
	WHERE CountryName = 'Myanmar'

SELECT cnt.ContinentName, cntr.CountryName, 
COUNT(m.Id) AS MonasteriesCount
FROM Countries cntr
LEFT JOIN Continents cnt
ON cnt.ContinentCode = cntr.ContinentCode
LEFT JOIN Monasteries m
ON cntr.CountryCode = m.CountryCode
WHERE cntr.IsDeleted != 1 OR cntr.IsDeleted IS NULL
GROUP BY cnt.ContinentName, cntr.CountryName
ORDER BY MonasteriesCount DESC, cntr.CountryName