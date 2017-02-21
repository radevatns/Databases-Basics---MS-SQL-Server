--create database
CREATE DATABASE	Bakery
USE Bakery

--DROP DATABASE Bakery


CREATE TABLE Countries
(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50) UNIQUE
)

CREATE TABLE Customers
(	
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(25),
LastName  NVARCHAR(25),
Gender CHAR(1) CHECK (Gender='M' OR Gender='F'),
Age INT,
PhoneNumber VARCHAR(10) CHECK (LEN(PhoneNumber) = 10),
CountryId INT FOREIGN KEY REFERENCES Countries(Id) --?
)

CREATE TABLE Products 
(
Id INT PRIMARY KEY IDENTITY, 
Name NVARCHAR(25) UNIQUE,
Description NVARCHAR(250),
Recipe NVARCHAR(MAX),
Price DECIMAL(16,2) CHECK(Price>=0)--OR MONEY or = or not
)

CREATE TABLE Feedbacks 
(
Id INT PRIMARY KEY IDENTITY,
Description	NVARCHAR(255),
Rate DECIMAL(10,2) CHECK (Rate BETWEEN 0 AND 10),
ProductId INT FOREIGN KEY REFERENCES Products(Id), --??
CustomerId INT FOREIGN KEY REFERENCES Customers(Id)
)

CREATE TABLE Distributors 
(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(25) UNIQUE,
AddressText NVARCHAR(30),
Summary NVARCHAR(200),
CountryId INT FOREIGN KEY REFERENCES Countries(Id)
)

CREATE TABLE Ingredients
(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(30),
Description	NVARCHAR(200),
OriginCountryId INT FOREIGN KEY REFERENCES Countries(Id), 
DistributorId INT FOREIGN KEY REFERENCES Distributors(Id)
)

CREATE TABLE ProductsIngredients 
(
ProductId INT,
IngredientId INT,
CONSTRAINT PK_ProductsIngredients PRIMARY KEY(ProductId, IngredientId),
CONSTRAINT FK_ProductsIngredients_ProductId FOREIGN KEY (ProductId) REFERENCES Products(Id),
CONSTRAINT FK_ProductsIngredients_IngredientId FOREIGN KEY (IngredientId) REFERENCES Ingredients(Id)
)

