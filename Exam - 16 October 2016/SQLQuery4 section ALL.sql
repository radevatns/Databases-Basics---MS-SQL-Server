--CREATE PROCEDURE usp_SubmitReview (@CustomerID INT
--									,@ReviewContent varchar(255)
--									,@ReviewGrade INT
--									,@AirlineName VARCHAR(30))
	
--AS
--	BEGIN
--		BEGIN TRANSACTION
--			IF(EXISTS(SELECT AirlineName FROM Airlines
--					WHERE AirlineName = @AirlineName))
--				BEGIN
--					RAISERROR('Airline does not exist.',16,1)
--					ROLLBACK
--				END
--			ELSE
--				BEGIN
--				INSERT INTO [dbo].[CustomerReviews](CustomerID
--									,ReviewContent
--									,ReviewGrade
--									,AirlineID)
--		VALUES
--		(@CustomerID,@ReviewContent,@ReviewGrade,@AirlineID)
--		COMMIT
--				END
		
		
--	END
CREATE PROCEDURE usp_SubmitReview(@CustomerID INT, @ReviewContent VARCHAR(255),
	@ReviewGrade INT, @AirlineName VARCHAR(30))
AS
BEGIN
	BEGIN TRAN

	DECLARE @Index INT 
		IF((SELECT COUNT(*) FROM CustomerReviews) = 0)
			SET @Index = 1
		ELSE 
		SET @Index = (SELECT MAX(ReviewID) FROM CustomerReviews) + 1
		
		DECLARE @AirlineId INT  = (SELECT AirlineID FROM Airlines WHERE AirlineName = @AirlineName)
		
		INSERT INTO CustomerReviews
					(ReviewID, ReviewContent, ReviewGrade, 
						 CustomerID, AirlineID)
				VALUES (@Index, @ReviewContent, @ReviewGrade,
						@CustomerID, @AirlineID)

		IF NOT EXISTS(SELECT AirlineName FROM Airlines
					WHERE AirlineName = @AirlineName)
			BEGIN
				RAISERROR('Airline does not exist.', 16, 1)
				ROLLBACK
			END
		ELSE
			BEGIN 
				COMMIT
			END
END 

EXEC usp_SubmitReview 'custom review fform happy person',1, 20, 'Royal Airline'

EXEC usp_SubmitReview ()	


SELECT * FROM Tickets
SELECT * FROM Flights
SELECT * FROM Airports
SELECT * FROM Customers
SELECT * FROM Towns
SELECT * FROM CustomerReviews
SELECT * FROM Airlines  