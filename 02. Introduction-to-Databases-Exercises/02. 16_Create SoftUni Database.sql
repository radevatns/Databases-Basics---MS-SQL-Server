CREATE DATABASE SoftUni

CREATE TABLE Towns 
(
Id INT NOT NULL PRIMARY KEY IDENTITY,
Name NVARCHAR(50)
)

INSERT Towns (Name) VALUES
('Sofia'),
('Plovidiv'),
('Varna'),
('Burgas')

CREATE TABLE Addresses 
(Id INT NOT NULL PRIMARY KEY IDENTITY, 
AddressText NVARCHAR(255), 
TownId INT FOREIGN KEY REFERENCES Towns(Id)
)

CREATE TABLE Departments 
(
Id INT NOT NULL PRIMARY KEY IDENTITY, 
Name NVARCHAR(50)
)


INSERT Departments (Name) VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance')

CREATE TABLE Employees 
(
Id INT NOT NULL PRIMARY KEY IDENTITY, 
FirstName NVARCHAR(50), 
MiddleName NVARCHAR(50), 
LastName NVARCHAR(50) NOT NULL, 
JobTitle NVARCHAR(50), 
DepartmentId INT FOREIGN KEY REFERENCES Departments(Id), 
HireDate DATE, 
Salary MONEY NOT NULL, 
AddressId INT FOREIGN KEY REFERENCES Addresses(Id)
)

INSERT Employees (FirstName,MiddleName,LastName,JobTitle,DepartmentId,HireDate,Salary ) VALUES
('Ivan' , 'Ivanov' ,'Ivanov', '.NET Developer',	4,'2013-02-01',3500.00),
('Petar', 'Petrov' ,'Petrov', 'Senior Engineer',1,'2004-03-02',4000.00),
('Maria', 'Petrova','Ivanova','Intern',			5,'2016-08-28',525.25),
('Georgi','Teziev','Ivanov', 'CEO',				2,'2007-12-09',3000.00),
('Peter' ,'Pan'    ,'Pan',	  'Intern',			3,'2016-08-28',599.88)

SELECT * FROM Towns
SELECT * FROM Addresses
SELECT * FROM Departments
SELECT * FROM Employees

DROP DATABASE SoftUni



