CREATE DATABASE Hotel

CREATE TABLE Employees  
(Id INT NOT NULL primary key,
 FirstName NVARCHAR(50) NOT NULL,
 LastName NVARCHAR(50) NOT NULL,
 Title NVARCHAR(50),
 Notes NVARCHAR(MAX),
 )
 INSERT INTO Employees  (Id, FirstName, LastName) Values
 (1,'FirstNameBX','LastNAME1'), 
 (2,'FirstNameVY','LastNAME2'),
 (3,'FirstNameZQ','LastNAME3')

 CREATE TABLE Customers 
 (AccountNumber INT NOT NULL primary key,
  FirstName NVARCHAR(50) NOT NULL,
  LastName NVARCHAR(50) NOT NULL,
  PhoneNumber VARCHAR(50),
  EmergencyName NVARCHAR(50),
  EmergencyNumber INT,
  Notes INT,
 )
 INSERT INTO Customers (AccountNumber,FirstName,LastName) VALUES
 (0001,'FirstNameBX','LastNAME1'), 
 (0002,'FirstNameVY','LastNAME2'),
 (0003,'FirstNameZQ','LastNAME3')

 CREATE TABLE RoomStatus   
 (RoomStatus NVARCHAR(50) NOT NULL PRIMARY KEY,
  Notes NVARCHAR(MAX)
  )
 INSERT INTO RoomStatus  (RoomStatus,Notes) VALUES
 ('empty','used from two pig'), 
 ('Not empty','one chick use this room'),
 ('cleaning','shit on the carpet')

 CREATE TABLE RoomTypes    
 (RoomType NVARCHAR(50) NOT NULL PRIMARY KEY,
  Notes NVARCHAR(MAX)
  )
 INSERT INTO RoomTypes   (RoomType,Notes) VALUES
 ('for 4 people','notes from room type'), 
 ('kink size room','notes from room type2'),
 ('no bathroom','notes for  roomtype')

  CREATE TABLE BedTypes     
 (BedTypes NVARCHAR(50) NOT NULL PRIMARY KEY,
  Notes NVARCHAR(MAX)
  )
 INSERT INTO BedTypes (BedTypes) VALUES
 ('Double'), 
 ('SIngle'),
 ('Double twin tip')


 CREATE TABLE Rooms   
 (RoomNumber INT NOT NULL PRIMARY KEY,
  RoomType INT, 
  BedType INT, 
  Rate MONEY NOT NULL, 
  RoomStatus NVARCHAR(50), 
  Notes NVARCHAR(MAX)
  )
  INSERT INTO Rooms(RoomNumber,Rate) VALUES
  (1,131.14),
  (2,200.00),
  (3,399.45)

  CREATE TABLE Payments
  (Id INT NOT NULL PRIMARY KEY,
   EmployeeId INT, 
   PaymentDate DATE, 
   AccountNumber INT, 
   FirstDateOccupied DATE, 
   LastDateOccupied DATE, 
   TotalDays INT NOT NULL, 
   AmountCharged MONEY, 
   TaxRate MONEY, 
   TaxAmount MONEY, 
   PaymentTotal MONEY NOT NULL, 
   Notes NVARCHAR(MAX)
  )
  INSERT Payments (Id, TotalDays, PaymentTotal) VALUES
  (1,3,12.23),
  (2,4,111.2),
  (3,5,54.37)

  CREATE TABLE Occupancies 
  (
  Id INT NOT NULL PRIMARY KEY, 
  EmployeeId INT, 
  DateOccupied DATE, 
  AccountNumber INT, 
  RoomNumber INT, 
  RateApplied BIT, 
  PhoneCharge BIT, 
  Notes NVARCHAR(MAX)
  )

  INSERT Occupancies (Id, EmployeeId) VALUES
   (1,3),
   (2,2),
   (3,2)



  SELECT * FROM [Employees]
  SELECT * FROM [Customers]
  SELECT * FROM RoomStatus 
  SELECT * FROM RoomTypes
  SELECT * FROM BedTypes
  SELECT * FROM Rooms
  SELECT * FROM Payments
  SELECT * FROM Occupancies 

  --DROP TABLE Employees 
  