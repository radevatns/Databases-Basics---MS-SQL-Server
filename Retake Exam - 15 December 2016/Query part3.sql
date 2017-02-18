--Section 3: Querying - 5. Age Range

  SELECT Nickname,Gender,Age FROM Users
  WHERE Age BETWEEN 22 AND 37
  
  SELECT * FROM Users 

--Section 3: Querying - 6. Messages

 SELECT Content,SentOn FROM Messages
 WHERE Content LIKE '%just%' AND SentOn > '2014-05-12'
 ORDER BY Id DESC

SELECT * FROM Messages

--Section 3: Querying - 7. Chats

SELECT Title,IsActive FROM Chats
WHERE (IsActive = 0 AND LEN(Title) < 5) 
		OR (Title LIKE '__tl%')
	ORDER BY Title DESC


SELECT * FROM Chats

--Section 3: Querying - 8. Chat Messages

SELECT c.Id,c.Title,m.Id FROM Chats AS c
JOIN Messages AS m
ON m.ChatId = c.Id
WHERE m.SentOn <'2012-03-26' AND Title LIKE '%x'
ORDER BY c.Id	, m.Id		

SELECT * FROM Chats
SELECT * FROM Messages

--Section 3: Querying - 9.	Message Count

SELECT TOP 5 C.Id,COUNT(m.Id)as TotalMessages FROM Chats AS c
FULL JOIN Messages AS m
	ON m.ChatId = c.Id
WHERE m.Id < 90
GROUP BY c.Id
ORDER BY TotalMessages DESC,c.Id

  -- option 2

SELECT TOP (5) CH.Id, COUNT(T1.Id)
FROM Chats AS CH
FULL JOIN (SELECT Id, SentOn, ChatId FROM Messages WHERE Id < 90) AS T1 
	ON T1.ChatId = CH.Id
GROUP BY CH.Id
ORDER BY COUNT(T1.Id) DESC, CH.Id

  SELECT * FROM Chats
SELECT * FROM Messages

--Section 3: Querying - 10. Credentials

SELECT u.Nickname,c.Email,c.Password FROM Users AS u
JOIN Credentials AS c
ON c.Id = u.CredentialId 
WHERE Email LIKE '%co.uk'
ORDER BY Email

SELECT * FROM Users
SELECT * FROM Credentials

--Section 3: Querying - 11. Locations


SELECT Id, Nickname, Age FROM Users
WHERE LocationId IS NULL


--Section 3: Querying - 12. Left Users
SELECT m.Id, m.ChatId, m.UserId FROM Messages AS m
WHERE m.ChatId = 17 AND (m.UserId NOT IN (SELECT UserId FROM UsersChats WHERE ChatId = 17) OR m.UserId IS NULL)
ORDER BY m.Id DESC


SELECT * FROM Messages
SELECT * FROM Users
SELECT * FROM UsersChats
SELECT * FROM Chats

--Section 3: Querying - 13. Users in Bulgaria

SELECT u.Nickname, c.Title, l.Latitude, l.Longitude FROM Users AS u
INNER JOIN Locations AS l ON l.Id = u.LocationId
INNER JOIN UsersChats AS uc ON uc.UserId = u.Id
INNER JOIN Chats AS c ON c.Id = uc.ChatId
WHERE (l.Latitude BETWEEN 41.13999 AND 44.12999) AND (l.Longitude BETWEEN 22.209999 AND 28.35999)
ORDER BY c.Title 


--Section 3: Querying - 14. Last Chat

SELECT 
TOP 1 WITH TIES c.Title
 FROM Chats AS c
LEFT JOIN Messages AS m ON m.ChatId = c.Id
ORDER BY StartDate DESC, m.SentOn ASC

-- 14. Last Chat (1)
SELECT TOP 1 WITH TIES c.Title, m.Content FROM (
				SELECT 
				 TOP 1 WITH TIES c.Id
				FROM Chats AS c
				ORDER BY StartDate DESC
				) AS LastChat
INNER JOIN Chats AS c ON c.Id = LastChat.Id
LEFT JOIN Messages AS m ON m.ChatId = LastChat.Id
ORDER BY m.SentOn