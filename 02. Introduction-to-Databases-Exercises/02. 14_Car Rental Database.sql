CREATE DATABASE CarRental

CREATE TABLE Categories 
(Id INT NOT NULL primary key,
 Category NVARCHAR(max),
 DailyRate MONEY NOT NULL,
 WeeklyRate MONEY NOT NULL,
 MonthlyRate MONEY NOT NULL,
 WeekendRate MONEY NOT NULL
 )
 INSERT INTO Categories (Id, Category,DailyRate, WeeklyRate, MonthlyRate, WeekendRate) Values
(1,'category1',123,213,312,413),
(2,'category2',124,214,313,414),
(3,'category3',125,215,314,415)

 CREATE TABLE Cars
 (Id INT NOT NULL primary key,
  PlateNumber NVARCHAR(50) NOT NULL,
  Make NVARCHAR(50),
  Model NVARCHAR(50),
  CarYear DATETIME,
  CategoryId INT,
  Doors INT,
  Picture VARBINARY(MAX),
  Condition NVARCHAR(50),   
  Available BIT NOT NULL
 )
 INSERT INTO Cars (Id,PlateNumber,Available) VALUES
 (1,'CA0001BX',1), 
 (2,'CA0002VY',0),
 (3,'CA0003ZQ',1)

 CREATE TABLE Employees  
 (Id INT NOT NULL PRIMARY KEY,
  FirstName NVARCHAR(50),
  LastName NVARCHAR(50),
  Title NVARCHAR(50),
  Notes NVARCHAR(MAX)
  )
 INSERT INTO Employees (Id,FirstName,LastName) VALUES
 (1,'FirstNameBX','LastNAME1'), 
 (2,'FirstNameVY','LastNAME2'),
 (3,'FirstNameZQ','LastNAME3')

 CREATE TABLE Customers  
 (
  Id INT NOT NULL PRIMARY KEY,
  DriverLicenceNumber INT,
  FullName NVARCHAR(50),
  Address NVARCHAR(50),
  City NVARCHAR(50),
  ZIPCode INT,
  Notes NVARCHAR(MAX)
  )
  INSERT INTO Customers (Id,DriverLicenceNumber,FullName) VALUES
 (1,523,'FirstNameBX LastNAME1'), 
 (2,624,'FirstNameVY LastNAME2'),
 (3,725,'FirstNameZQ LastNAME3')

 CREATE TABLE RentalOrders  
 (Id INT NOT NULL PRIMARY KEY,
  EmployeeId INT, 
  CustomerId INT, 
  CarId INT, 
  CarCondition NVARCHAR(50), 
  TankLevel FLOAT, 
  KilometrageStart DECIMAL(10,2), 
  KilometrageEnd DECIMAL(10,2), 
  TotalKilometrage DECIMAL(10,2), 
  StartDate DATE, 
  EndDate DATE, 
  TotalDays INT, 
  RateApplied BIT, 
  TaxRate MONEY, 
  OrderStatus NVARCHAR(50), 
  Notes NVARCHAR(MAX)
  )
  INSERT INTO RentalOrders(Id,TotalKilometrage,TotalDays,TaxRate) VALUES
  (1,131.14,5,1),
  (2,200.00,1,13),
  (3,399.45,5,123)


  --SELECT * FROM [Categories]
  --SELECT * FROM [Cars]
  --SELECT * FROM [Employees]
  --SELECT * FROM [Customers]
  --SELECT * FROM RentalOrders

  --DROP TABLE Categories
  