  --2.4
  USE AMS
  GO
   begin tran



   CREATE TABLE CustomerReviews
   (
	ReviewID INT PRIMARY KEY NOT NULL,
	ReviewContent VARCHAR(255) NOT NULL,
	ReviewGrade INT CHECK (ReviewGrade BETWEEN 0 AND 10),
	AirlineID INT FOREIGN KEY REFERENCES Airlines(AirlineID),
	CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
   )
	   begin tran
   CREATE TABLE CustomerBankAccounts
   (
	AccountID INT PRIMARY KEY,
	AccountNumber VARCHAR(10)NOT NULL UNIQUE,
	Balance DECIMAL(10,2) NOT NULL,
	CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
   )


     rollback

	 --2.5-----
begin tran


INSERT INTO CustomerReviews (ReviewID,ReviewContent,ReviewGrade,AirlineID,CustomerID)
VALUES
(1,'Me is very happy. Me likey this airline. Me good.',			10	,1,	1),
(2,'Ja, Ja, Ja... Ja, Gut, Gut, Ja Gut! Sehr Gut!',				10	,1,	4),
(3,'Meh...',													5	,4,	3),
(4,'Well Ive seen better, but Ive certainly seen a lot worse...',7	,3,	5)
																		
  INSERT INTO CustomerBankAccounts (AccountID,	AccountNumber,	Balance,	CustomerID)
VALUES
(1,'123456790',2569.23		,1),
(2,'18ABC23672',14004568.23	,2),
(3,'F0RG0100N3',19345.20	,5)

 ROLLBACK



	
 
	SELECT CustomerID FROM Customers
   SELECT * FROM Airlines
   GO