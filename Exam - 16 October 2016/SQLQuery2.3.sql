
UPDATE Tickets
SET Price = Price + Price * 0.5
WHERE FlightID IN (
					SELECT FlightID FROM Flights
					WHERE AirlineID = (
						SELECT a.AirlineID FROM Airlines AS a
						WHERE Rating = (
						SELECT MAX(Rating) FROM Airlines
										)
									)
					)





SELECT t.Price, f.AirlineID FROM Tickets AS t
FULL JOIN Flights AS f
ON  t.FlightID = f.FlightID



SELECT * FROM Flights
SELECT * FROM Tickets

SELECT TOP (1) AirlineID FROM Airlines
ORDER BY Rating	DESC

SELECT * FROM Airlines
ORDER BY Rating	DESC