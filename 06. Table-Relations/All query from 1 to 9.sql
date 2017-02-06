--01. One-To-One Relationship
CREATE DATABASE TableRelationship
USE TableRelationship 
CREATE TABLE Persons(
  PersonID int IDENTITY(1,1),
  FirstName NVARCHAR (50) NOT NULL,
  Salary decimal(16,2),
  PassportID int
)
CREATE TABLE Passports (
  PassportID int NOT NULL,
  PassportNumber NVARCHAR(50)
)
INSERT Persons (FirstName,Salary,PassportID) VALUES
('Roberto',43300,102),
('Tom',56100,103),
('Yana',60200,101)

INSERT Passports (PassportID, PassportNumber) VALUES
(101, 'N34FG21B'),
(102, 'K65LO4R7'),
(103, 'ZE657QP2')
							   
ALTER TABLE	Persons	
	 ADD CONSTRAINT	PK_PersonId
	 PRIMARY KEY (PersonID)
ALTER TABLE Passports
	ADD CONSTRAINT PK_PassportsId
	PRIMARY KEY (PassportID)

ALTER TABLE	Persons
	 ADD CONSTRAINT FK_PassportID
	 FOREIGN KEY (PassportID)
	 REFERENCES Passports(PassportID)

--02. One-To-Many Relationship

CREATE TABLE Models(
  ModelID int NOT NULL,
  Name NVARCHAR (50) NOT NULL,
  ManufacturerID int
)
CREATE TABLE Manufacturers (
  ManufacturerID int NOT NULL,
  Name NVARCHAR (50) NOT NULL,
  EstablishedOn DATE
)

INSERT Models (ModelID,Name,ManufacturerID) VALUES
(101,'X1',1),
(102,'i6',1),
(103,'Model S',2),
(104,'Model X',2),
(105,'Model 3',2)

INSERT Manufacturers (ManufacturerID, Name, EstablishedOn) VALUES
(1, 'BMW', '1916/03/07'),
(2, 'Tesla','2003/01/01'),
(3, 'Lada','1966/05/01')

ALTER TABLE Models
ADD CONSTRAINT PK_ModelsID
PRIMARY KEY (ModelID)

ALTER TABLE Manufacturers
ADD CONSTRAINT PK_ManufacturerID
PRIMARY KEY (ManufacturerID)

ALTER TABLE Models
ADD CONSTRAINT FK_ManufacturerID
FOREIGN KEY (ManufacturerID) 
REFERENCES Manufacturers(ManufacturerID)

--03. Many-To-Many Relationship
GO
USE TableRelationship
CREATE TABLE Students
(
	StudentID INT NOT NULL,
	Name NVARCHAR(50) NOT NULL
)
CREATE TABLE Exams
(
	 ExamID INT NOT NULL,
	 Name NVARCHAR(50) NOT NULL
)
CREATE TABLE StudentsExams	  -- this is map table
(
	StudentID INT NOT NULL,
	ExamID INT NOT NULL
)
INSERT Students (StudentID,Name) VALUES 
(1,'Mila'),
(2,'Toni'),
(3,'Ron')
INSERT Exams (ExamID,Name) VALUES 
(101,'SpringMVC'),
(102,'Neo4j'),
(103,'Oracle 11g')
INSERT StudentsExams VALUES	  -- this is map table
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103)


ALTER TABLE Students
 ADD CONSTRAINT PK_StudentID
 PRIMARY KEY (StudentID)

ALTER TABLE Exams
 ADD CONSTRAINT PK_ExamsID
 PRIMARY KEY (ExamID)

ALTER TABLE StudentsExams -- this is map table
 ADD CONSTRAINT PK_StudentID_ExamID
 PRIMARY KEY (StudentID,ExamID)

ALTER TABLE StudentsExams
 ADD CONSTRAINT FK_StudentsExams_StudentID
 FOREIGN KEY (StudentID)
 REFERENCES  Students(StudentID)

ALTER TABLE StudentsExams
 ADD CONSTRAINT FK_StudentsExams_ExamID
 FOREIGN KEY (ExamID)
 REFERENCES  Exams(ExamID) 
GO

--04. Self-Referencing

CREATE TABLE Teachers (

   	TeacherID INT NOT NULL, 
	Name NVARCHAR (50) NOT NULL,
	ManagerID INT
)
INSERT Teachers VALUES
(101,'John',NULL), 
(102,'Maya',106),
(103,'Silvia',106),
(104,'Ted',105),
(105,'Mark',101),
(106,'Greta',101)

ALTER TABLE	Teachers
ADD CONSTRAINT PK_TeacherID
PRIMARY KEY (TeacherID)

ALTER TABLE Teachers
ADD CONSTRAINT FK_ManagerID_TeacherID
FOREIGN KEY (ManagerID)
REFERENCES Teachers(TeacherID)

--05. Online Store Database
GO
CREATE DATABASE OnlineStore
USE OnlineStore
CREATE TABLE Cities(
   CityID INT PRIMARY KEY NOT NULL,
   Name VARCHAR(50)
)
CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY NOT NULL,
  Name VARCHAR(50),
  Birthday DATE,
  CityID INT
)
CREATE TABLE Orders (
   OrderID INT PRIMARY KEY NOT NULL,
   CustomerID INT
)
CREATE TABLE OrderItems(
	OrderID INT NOT NULL,
	ItemID INT NOT NULL,
	CONSTRAINT PK_OrdersItems 
	PRIMARY KEY (OrderID,ItemID)
)
CREATE TABLE Items (
   ItemID INT PRIMARY KEY NOT NULL,
   Name VARCHAR(50),
   ItemTypeID INT
)
CREATE TABLE ItemTypes(
   ItemTypeID INT PRIMARY KEY NOT NULL,
   Name VARCHAR(50)
)
ALTER TABLE Customers
ADD CONSTRAINT FK_Customers_CityID
FOREIGN KEY (CityID)
REFERENCES Cities(CityID)

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_CustomerID
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID)

ALTER TABLE OrderItems
ADD CONSTRAINT FK_OrderItems_OrderID
FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID)

ALTER TABLE OrderItems
ADD CONSTRAINT FK_OrderItems_ItemID
FOREIGN KEY (ItemID)
REFERENCES Items(ItemID)

ALTER TABLE Items
ADD CONSTRAINT FK_Items_ItemTypeID
FOREIGN KEY (ItemTypeID)
REFERENCES ItemTypes(ItemTypeID)

 
GO

--06. University Database
--09. *Peaks in Rila