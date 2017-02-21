--section 3
--
--05. Products By Price
   SELECT Name,Price,Description FROM Products
   ORDER BY Price DESC, Name
   
   SELECT * FROM Products

--06. Ingredients

 select Name,Description,OriginCountryId FROM Ingredients
 WHERE OriginCountryId IN(1,10,20)
 ORDER BY Id

 select * FROM Ingredients
 WHERE OriginCountryId IN(1,10,20)
 ORDER BY Id

--07. Ingredients from Bulgaria and Greece
 
 select TOP(15) i.Name,i.Description,c.Name AS CountryName FROM Ingredients AS i
 JOIN Countries AS c
 ON c.Id = i.OriginCountryId
 WHERE c.Name IN ('Bulgaria','Greece')
 ORDER BY i.Name,c.Name
 

 select * FROM Ingredients
 SELECT * FROM Countries

--08. Best Rated Products
SELECT TOP (10) p.Name,p.Description, AVG(f.Rate) AS AverageRate, COUNT(p.Name) AS FeedbacksAmount FROM Products AS p
JOIN Feedbacks AS f
ON f.ProductId = p.Id
GROUP BY p.Name,p.Description
ORDER BY AverageRate DESC, FeedbacksAmount DESC


SELECT * FROM Products
SELECT * FROM Feedbacks

--09. Negative Feedback

SELECT f.ProductId,f.Rate,f.Description,f.CustomerId,c.Age,c.Gender FROM Feedbacks AS f
JOIN Customers AS c
ON 	c.Id = f.CustomerId
WHERE f.Rate < 5.0
ORDER BY f.ProductId DESC,f.Rate 

SELECT * FROM Products
SELECT * FROM Feedbacks
SELECT * FROM Customers


--10.	Customers without Feedback

SELECT CONCAT(c.FirstName, ' ',c.LastName ) AS CustomerName
	,c.PhoneNumber
	,c.Gender  FROM Customers	AS c
WHERE c.Id NOT IN(SELECT CustomerId FROM Feedbacks AS f)
ORDER BY c.Id



SELECT * FROM Customers	AS c
WHERE c.Id NOT IN(SELECT CustomerId FROM Feedbacks)

SELECT * FROM Feedbacks
SELECT * FROM Customers


--11. Honorable Mentions

SELECT f.ProductId
	,CONCAT(c.FirstName, ' ',c.LastName ) AS CustomerName
	,f.Description AS FeedbackDescription 
		FROM Feedbacks AS f
JOIN Customers AS c
ON c.Id = f.CustomerId
WHERE CustomerId IN (SELECT fe.CustomerId  
	FROM Feedbacks AS fe
		GROUP BY fe.CustomerId
		HAVING COUNT(fe.Id)>=3)
ORDER BY f.ProductId,CustomerName,f.Id


SELECT * FROM Feedbacks
order by ProductId
SELECT * FROM Customers
--12. Customers by Criteria


SELECT FirstName,Age,PhoneNumber FROM Customers
WHERE (Age > 21 AND FirstName Like '%an%') OR (PhoneNumber Like '%38' AND CountryId <>31)
ORDER BY FirstName, Age DESC 

SELECT * FROM Customers
select * from Countries

--13. Middle Range Distributors
SELECT * FROM Distributors AS d
JOIN Ingredients AS i
ON i.DistributorId = d.Id

SELECT d.Name AS DistributorName
		,i.Name AS IngredientName
		,p.Name AS ProductName
		,AVG(f.Rate) AS AverageRate
		 FROM Ingredients as i
JOIN ProductsIngredients as pi
ON pi.IngredientId  = i.Id 
JOIN Products AS p
ON p.Id = pi.ProductId
JOIN Feedbacks AS f
ON f.ProductId = p.Id
JOIN Distributors as d
ON d.Id	=i.DistributorId
GROUP BY d.Name, i.Name,p.Name
HAVING (AVG(f.Rate)>=5 and AVG(f.Rate)<=8)
ORDER BY DistributorName, IngredientName, ProductName

SELECT * FROM Distributors
SELECT * FROM Feedbacks
SELECT * FROM Products
select * from ingredients
SELECT * FROM ProductsIngredients 

--14. The Most Positive Country

SELECT TOP(1) WITH TIES cun.Name AS CountryName, avg(F.Rate) AS FeedbackRate FROM Feedbacks	 AS F
JOIN Customers AS C
ON C.Id = F.CustomerId
JOIN Countries AS cun
ON cun.Id = C.CountryId
GROUP BY cun.Name
ORDER BY FeedbackRate DESC					


SELECT * FROM Countries
SELECT * FROM Feedbacks


--15. Country Representative


SELECT * FROM Countries
SELECT * FROM IG
SELECT * FROM Feedbacks