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




--Section 3: Querying - 9.	Message Count
--Section 3: Querying - 10. Credentials
--Section 3: Querying - 11. Locations
--Section 3: Querying - 12. Left Users
--Section 3: Querying - 13. Users in Bulgaria
--Section 3: Querying - 14. Last Chat