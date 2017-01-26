CREATE DATABASE Movies -- whitout this row for judge

CREATE TABLE Directors 
(
Id int NOT NULL primary key,
DirectorName NVARCHAR(50) NOT NULL,
Notes NVARCHAR(max),
)

INSERT INTO Directors (Id, DirectorName) Values
(1,'directorName1'),
(2,'directorName2'),
(3,'directorName3'),
(4,'directorName4'),
(5,'directorName5')

CREATE TABLE Genres  
(
Id int NOT NULL primary key,
GenreName NVARCHAR(50) NOT NULL,
Notes NVARCHAR(max),
)
INSERT INTO Genres (Id, GenreName) Values
(1,'directorName1'),
(2,'directorName2'),
(3,'directorName3'),
(4,'directorName4'),
(5,'directorName5')

CREATE TABLE Categories   
(
Id int NOT NULL primary key,
CategoryName NVARCHAR(50) NOT NULL,
Notes NVARCHAR(max),
)

INSERT INTO Categories (Id, CategoryName ) Values
(1,'CategoryName1'),
(2,'CategoryName2'),
(3,'CategoryName3'),
(4,'CategoryName4'),
(5,'CategoryName5')

CREATE TABLE Movies    
(
Id int NOT NULL primary key,
Title NVARCHAR(50) NOT NULL,
DirectorId int NOT NULL,
CopyrightYear date,
Length float,
GenreId int NOT NULL,
CategoryId int NOT NULL,
Rating int,
Notes NVARCHAR(max)
)

INSERT INTO Movies (Id,Title,DirectorId,GenreId,CategoryId) VALUES
(1,'Title1',1,3,1),
(2,'Title2',1,4,2),
(3,'Title3',2,4,3),
(4,'Title4',2,5,2),
(5,'Title5',3,5,1)

ALTER TABLE Movies -- may be work
ADD FOREIGN KEY (DirectorId)
REFERENCES Directors