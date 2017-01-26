CREATE TABLE Userss
(
Id BIGINT NOT NULL primary key identity,
UserName VARCHAR(30) NOT NULL,
Password VARCHAR(26),
ProfilePicture VARBINARY(MAX) ,
LastLoginTime DATE,
IsDelete bit,
)

INSERT INTO Userss (UserName, Password, LastLoginTime) VALUES 
									('Ogi',   'pass1', '1987-05-22'),
									('Ivo',   'pass2', '1923-04-13'),
									('Boris', 'pass3', '1934-01-16'),
									('Albena','pass4', '1976-12-18'),
									('Do4ka', 'pass5', '1999-12-19')
--ALTER TABLE Userss
--ADD CONSTRAINT CH_PictureSize CHECK (DATALENGHT(ProfilePicture)<900*1024)

SELECT * FROM Userss

