ALTER TABLE Users
DROP CONSTRAINT [PK_userssKey]

ALTER TABLE Users
ADD CONSTRAINT PK_UsersId
PRIMARY KEY (Id)

ALTER TABLE Users
ADD CONSTRAINT uq_UserName
UNIQUE (UserName)

ALTER TABLE Users
ADD CONSTRAINT chkUserNameLenght CHECK(LEN(UserName)>=3)