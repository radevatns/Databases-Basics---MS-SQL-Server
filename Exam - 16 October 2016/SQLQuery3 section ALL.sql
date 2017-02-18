--Section 3:
--Querying - 01. Extract All TicketsSection

SELECT TicketID,Price,Class,Seat FROM Tickets
ORDER BY TicketID
 
--Querying - 02. Extract All CustomersSection

SELECT CustomerID, CONCAT(FirstName, ' ',LastName)AS FullName, Gender FROM Customers
ORDER BY FullName, CustomerID
 
SELECT * FROM Customers

--Querying - 03. Extract Delayed FlightsSection

SELECT FlightID,DepartureTime,ArrivalTime FROM Flights
WHERE Status = 'Delayed'
ORDER BY FlightID 

SELECT * FROM Flights

--Querying - 04. Top 5 AirlinesSection 

SELECT TOP(5) AirlineID,AirlineName, Nationality,Rating FROM Airlines
WHERE AirlineID IN (SELECT AirlineID FROM Flights)
ORDER BY Rating DESC, AirlineID

SELECT * FROM Flights
SELECT * FROM Airlines

--Querying - 05. All Tickets Below 5000Section
SELECT t.TicketID,a.AirportName, CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName  
FROM Tickets AS t
 JOIN Customers AS c
	ON t.CustomerID = c.CustomerID
 JOIN Flights AS f
	ON t.FlightID = f.FlightID
 JOIN Airports AS a
	ON a.AirportID = f.DestinationAirportID
WHERE t.Price < 5000 AND t.Class = 'First'
  

SELECT * FROM Tickets
SELECT  * FROM Customers
SELECT * FROM Flights
SELECT * FROM Airports
 
--Querying - 06. Customers From HomeSection
--SELECT c.CustomerID, c.FirstName, c.LastName, t.TownName,t.TownID, f.OriginAirportID FROM Customers	AS c
--SELECT * FROM Customers	AS c

SELECT	c.CustomerID
		,CONCAT(c.FirstName, ' ', c.LastName) AS FullName
		,t.TownName AS HomeTown
		,t.TownID,t.TownName, c.CustomerID
		,tic.CustomerID,tic.FlightID,f.FlightID,f.OriginAirportID,f.DestinationAirportID,
		f.OriginAirportID, a.AirportID, a.AirportName,a.AirportID , t.TownID,AirPortT.TownName  
		FROM Customers AS c
JOIN Towns AS t
	ON c.HomeTownID = t.TownID
JOIN Tickets AS tic
	ON c.CustomerID = tic.CustomerID
JOIN Flights AS f
	ON tic.FlightID = f.FlightID
JOIN Airports AS a
	ON f.OriginAirportID = a.AirportID ---?? c.HomeTownID
JOIN Towns AS AirPortT
ON a.TownID = AirPortT.TownID
WHERE a.TownID = c.HomeTownID AND f.Status = 'Departing'
Order BY c.CustomerID  
 

SELECT * FROM Customers
SELECT * FROM Towns
SELECT * FROM Tickets
SELECT * FROM Flights
SELECT * FROM Airports
SELECT * FROM Towns

--Querying - 07. Customers who will flySection
--SELECT * FROM Tickets AS t
SELECT DISTINCT c.CustomerID,CONCAT(c.FirstName, ' ', c.LastName)AS FullName,( 2016 - (DATEPART(YEAR, c.DateOfBirth))) AS Age FROM Tickets AS t
JOIN Flights AS f
ON t.FlightID = f.FlightID
JOIN Customers AS c
ON t.CustomerID = c.CustomerID
WHERE Status = 'Departing'
ORDER BY age,CustomerID


 
 SELECT * FROM Tickets
SELECT * FROM Flights
SELECT * FROM Customers
--Querying - 08. Top 3 Customers DelayedSection

SELECT TOP 3 c.CustomerID
			,CONCAT(c.FirstName, ' ', c.LastName)AS FullName
			,t.Price AS TicketPrice
			,a.AirportName AS Destination 
			FROM Customers AS c
 JOIN Tickets AS t
  ON c.CustomerID = t.CustomerID
 JOIN Flights AS f
  ON t.FlightID = f.FlightID
 JOIN Airports AS a
  ON f.DestinationAirportID = a.AirportID
WHERE f.Status = 'Delayed'
ORDER BY t.Price DESC, CustomerID 


SELECT * FROM Customers
SELECT * FROM Tickets
SELECT * FROM Flights
SELECT * FROM Airports

--Querying - 09. Last 5 Departing FlightsSection

-- taboti samo na nulevi testove
SELECT TOP (5) f.FlightID
				,f.DepartureTime
				,f.ArrivalTime
				,aOri.AirportName AS Origin
				,aDes.AirportName AS DestinationAS 
	FROM Flights AS f
	JOIN Airports AS aOri
		ON f.OriginAirportID = aOri.AirportID
	JOIN Airports AS aDes
	ON	f.DestinationAirportID = aDes.AirportID  
WHERE f.Status = 'Departing'
ORDER BY f.DepartureTime, f.FlightID



 	--raboti korektno
  SELECT OrderedTable.FlightID
		,OrderedTable.DepartureTime
		,OrderedTable.ArrivalTime
		,aOri.AirportName AS Origin
		,aDes.AirportName AS Destination
 FROM (SELECT TOP 5 * FROM Flights
				WHERE Status = 'Departing'
				ORDER BY DepartureTime DESC) AS OrderedTable
JOIN Airports aOri
ON aOri.AirportID = OrderedTable.OriginAirportID
JOIN Airports aDes
ON aDes.AirportID = OrderedTable.DestinationAirportID
ORDER BY OrderedTable.DepartureTime, FlightID
 
SELECT * FROM Flights
SELECT * FROM Tickets
SELECT * FROM Airports

--Querying - 10. Customers Below 21Section

SELECT DISTINCT c.CustomerID
		,CONCAT(c.FirstName, ' ', c.LastName)AS FullName
		,(2016 - (DATEPART(YEAR, c.DateOfBirth))) AS Age --or 2016 - YEAR(c.DateOfBirth) AS Age	
FROM Customers AS c
JOIN Tickets AS t
ON c.CustomerID = t.CustomerID
JOIN Flights  AS f
ON t.FlightID = f.FlightID
WHERE f.Status = 'Arrived' AND (2016 - (DATEPART(YEAR,c.DateOfBirth)) < 21)
ORDER BY Age DESC, c.CustomerID

--OPtion two ot me 

SELECT DISTINCT selectedTable.CustomerID
		,CONCAT(selectedTable.FirstName, ' ', selectedTable.LastName)AS FullName
		,(2016 - (DATEPART(YEAR, selectedTable.DateOfBirth))) AS Age   -- --or 2016 - YEAR(c.DateOfBirth) AS Age	
 FROM (SELECT * FROM Customers AS c 
WHERE CustomerID IN (SELECT CustomerID FROM Tickets)) AS selectedTable
JOIN Tickets AS t
ON selectedTable.CustomerID = t.CustomerID
JOIN Flights  AS f
ON t.FlightID = f.FlightID
WHERE f.Status = 'Arrived' AND (2016 - (DATEPART(YEAR,selectedTable.DateOfBirth)) < 21)
ORDER BY Age DESC, selectedTable.CustomerID


SELECT * FROM Customers
SELECT * FROM Tickets
SELECT * FROM Flights



--Querying - 11. AIrports and Passengers
 --SELECT * FROM Tickets AS t

SELECT   a.AirportID
		,a.AirportName
		,COUNT(t.CustomerID) AS Passengers
	FROM Tickets AS t
JOIN Flights AS f
ON t.FlightID = f.FlightID AND f.Status = 'Departing'
JOIN Airports AS a
ON f.OriginAirportID=a.AirportID
GROUP BY a.AirportID,a.AirportName




  


SELECT * FROM Airports
SELECT * FROM Flights
SELECT * FROM Tickets

SELECT * FROM Customers
SELECT * FROM Towns  