ALTER TABLE Userss
DROP CONSTRAINT PK__Userss__3214EC07D7C6B802

ALTER TABLE Userss
ADD CONSTRAINT PK_userssKey
PRIMARY KEY(Id, Username)