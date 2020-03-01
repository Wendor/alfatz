USE TestData
GO

CREATE TABLE ProductTopVariant (
  [Id] int IDENTITY(1,1) NOT NULL,
  [Name] nvarchar(max) NOT NULL,
  [LinkName] nvarchar(max) NOT NULL,
  PRIMARY KEY ([Id])
)

SET IDENTITY_INSERT ProductTopVariant ON
INSERT INTO ProductTopVariant ([Id], [Name], LinkName) VALUES (1, N'Популярные', N'popular')
INSERT INTO ProductTopVariant ([Id], [Name], LinkName) VALUES (2, N'Актуальные', N'actual')
INSERT INTO ProductTopVariant ([Id], [Name], LinkName) VALUES (3, N'ТОП-5', N'top')
SET IDENTITY_INSERT ProductTopVariant OFF
GO

CREATE PROCEDURE GetProductTopVariant
AS
SELECT * FROM ProductTopVariant
GO

CREATE TABLE RoleVariant (
	[Id] int IDENTITY(1,1) NOT NULL,
	[Name] nvarchar(max) NOT NULL,
    PRIMARY KEY ([Id])
)
GO

SET IDENTITY_INSERT RoleVariant ON
INSERT INTO RoleVariant ([Id], [Name]) VALUES (1, N'Аналитик')
INSERT INTO RoleVariant ([Id], [Name]) VALUES (2, N'Менеджер')
INSERT INTO RoleVariant ([Id], [Name]) VALUES (3, N'Руководитель')
SET IDENTITY_INSERT RoleVariant OFF
GO


CREATE PROCEDURE GetRoleVariant
AS
  SELECT * FROM RoleVariant
GO

CREATE TABLE [Role] (
	[Id] int NOT NULL
)
GO


CREATE TYPE RoleType AS Table (
  Id INT
)
GO

CREATE PROCEDURE GetRole
AS
SELECT * FROM [Role]
GO

CREATE PROCEDURE SetRole (@roles AS RoleType READONLY)
AS
BEGIN
DELETE FROM [Role];
INSERT INTO [Role] SELECT * FROM @roles;
END
GO

DECLARE @RoleList as RoleType
INSERT INTO @RoleList VALUES (1)
INSERT INTO @RoleList VALUES (2)
EXEC SetRole @roles = @RoleList
GO
