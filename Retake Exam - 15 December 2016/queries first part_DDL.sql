CREATE DATABASE TheNerdHerd
USE TheNerdHerd

--DROP DATABASE TheNerdHerd
 
--DROP TABLE Credentials
--DROP TABLE Users

CREATE TABLE Credentials
(
Id INT PRIMARY KEY IDENTITY,
Email VARCHAR(30),
Password VARCHAR(20)
)
CREATE TABLE Locations 
(
Id INT PRIMARY KEY IDENTITY,
Latitude FLOAT,
Longitude FLOAT
)
CREATE TABLE Users (
Id INT PRIMARY KEY IDENTITY,
Nickname VARCHAR(25), --WITH N
Gender CHAR(1),
Age	INT,		
LocationId	INT FOREIGN KEY REFERENCES Locations(Id),
CredentialId INT UNIQUE FOREIGN KEY REFERENCES Credentials(Id)
)

CREATE TABLE Chats 
(
Id INT PRIMARY KEY IDENTITY,
Title VARCHAR(32),
StartDate DATE,
IsActive BIT
)

CREATE TABLE Messages 
(
Id INT PRIMARY KEY IDENTITY,
Content VARCHAR(200),
SentOn DATE,
ChatId INT FOREIGN KEY REFERENCES Chats(Id),
UserId INT FOREIGN KEY REFERENCES Users(Id)
)

CREATE TABLE UsersChats
(
UserId INT,
ChatId INT,
CONSTRAINT PK_UsersChats PRIMARY KEY(ChatId, UserId),
CONSTRAINT FK_UsersChats_Users FOREIGN KEY (UserId) REFERENCES Users(Id),
CONSTRAINT FK_UsersChats_Chats FOREIGN KEY (ChatId) REFERENCES Chats(Id)
)


--Section 2. DML 2. Insert
  INSERT INTO Messages (Content,ChatId,UserId,SentOn) 
  SELECT 
  CONCAT(u.Age,'-',u.Gender,'-',l.latitude ,'-',l.longitude) AS Content,
	CASE
		WHEN u.Gender = 'F' THEN CEILING(SQRT(u.Age * 2))
		WHEN u.Gender = 'M' THEN CEILING(POWER((u.Age /18),3))
	END AS ChatId,
	u.Id AS UserId,
  '2016-12-15' AS SentOn

  FROM Users AS u
  INNER JOIN Locations AS l
  ON l.Id = u.LocationId
  WHERE u.Id BEtWEEN 10 and 20
  
  SELECT * FROM Messages 
  
--Section 2. DML 3. Update
				UPDATE Chats
SET StartDate = (
				SELECT MIN(m.SentOn) FROM Chats AS C
				INNER JOIN Messages AS m ON m.ChatId = c.Id
				WHERE c.Id = Chats.Id
				)
WHERE Chats.Id IN (
					SELECT c.Id FROM Chats AS c
					INNER JOIN Messages AS m ON m.ChatId = c.Id
					GROUP BY c.Id, c.StartDate
					HAVING c.StartDate > MIN(m.SentOn)
				)

--Section 2. DML 4. Delete
  DELETE FROM Locations 
WHERE Id NOT IN (SELECT DISTINCT LocationId FROM Users 
				WHERE LocationId IS NOT NULL)