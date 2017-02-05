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
--04. Self-Referencing
--05. Online Store Database
--06. University Database
--09. *Peaks in Rila