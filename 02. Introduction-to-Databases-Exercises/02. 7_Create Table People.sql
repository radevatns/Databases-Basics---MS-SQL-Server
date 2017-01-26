CREATE TABLE Users
(
Id int NOT NULL primary key identity,
Name nvarchar(255) NOT NULL,
Picture varbinary(max),
Height float (2),
Weight float (2),
Gender char(1) NOT NULL,
Birthdate date NOT NULL,
Biography nvarchar(max)
)

INSERT INTO Users (Name, Height, Weight, Gender, Birthdate, Biography ) VALUES 
									('Ogi',   1.45, 48.96, 'F', '1987-05-22', 'Artist from tv show' ),
									('Ivo',   1.65, 46.87, 'F', '1923-04-13', 'FREELANCE' ),
									('Boris', 1.75, 46.73, 'F', '1934-01-16', 'Инженер' ),
									('Albena',1.85, 65.40, 'F', '1976-12-18', 'Безработен и тъпа' ),
									('Do4ka', 1.95, 65.21, 'F', '1999-12-19', 'Няма си биография' )
