--16. Customers With Countries
GO
CREATE VIEW	v_UserWithCountries AS
	SELECT CONCAT(cu.FirstName, ' ',cu.LastName ) AS CustomerName,
			cu.Age,
			cu.Gender,
			co.Name AS CountryName
 FROM Customers AS cu	  
JOIN Countries AS co
ON cu.CountryId=co.Id  

--17. Feedback by Product Name
	 CREATE FUNCTION udf_GetRating(@Name VARCHAR(max))
	  RETURNS NVARCHAR(15)
	  BEGIN
		IF ((
			SELECT AVG(F.Rate) FROM Feedbacks AS F
			JOIN Products AS p
			ON p.Id = F.ProductId
			GROUP BY p.Name
			having @Name = p.NAME)<5)
				BEGIN
					RETURN 'Bad'; 
				END
		ELSE IF ((
			SELECT AVG(F.Rate) FROM Feedbacks AS F
			JOIN Products AS p
			ON p.Id = F.ProductId
			GROUP BY p.Name
			having  @Name= p.NAME) BETWEEN 5 AND 8)
			BEGIN
				RETURN 'Average'; 
			END
		ELSE IF ((
			SELECT AVG(F.Rate) FROM Feedbacks AS F
			JOIN Products AS p
			ON p.Id = F.ProductId
			GROUP BY p.Name
			having @Name = p.NAME) >8)
			BEGIN
				RETURN 'Good'; 
			END
				RETURN 'No rating'
END



--18. Send Feedback
--19. Delete Products
--20. Products by One Distributor