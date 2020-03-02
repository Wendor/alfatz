-- Скрипт содержит таблицы и функции, необходимые для задания 2.
USE [TestData]
GO

-- Таблица с возможными вариантами отчета из первого задания
CREATE TABLE [Report]
(
  [Id] int IDENTITY(1,1) NOT NULL,
  [Name] nvarchar(max) NOT NULL,
  [LinkName] nvarchar(max) NOT NULL,
  PRIMARY KEY ([Id])
)

SET IDENTITY_INSERT [Report] ON
INSERT INTO [Report] ([Id], [Name], [LinkName]) VALUES (1, N'Популярные', N'popular')
INSERT INTO [Report] ([Id], [Name], [LinkName]) VALUES (2, N'Актуальные', N'actual')
INSERT INTO [Report] ([Id], [Name], [LinkName]) VALUES (3, N'ТОП-5', N'top')
SET IDENTITY_INSERT [Report] OFF
GO

-- Процедура для получения возможных вариантов отчета из первого задания
CREATE PROCEDURE [GetReport]
AS
SELECT *
FROM [Report]
GO

-- Таблица с пользователями
CREATE TABLE [User]
(
  [Id] int IDENTITY(1,1) NOT NULL,
  [Name] nvarchar(max) NOT NULL,
  PRIMARY KEY ([Id])
)

SET IDENTITY_INSERT [User] ON
INSERT INTO [User] ([Id], [Name]) VALUES (1, N'User')
SET IDENTITY_INSERT [User] OFF
GO

-- Таблица с возможными вариантами ролей пользователя
CREATE TABLE [Role]
(
  [Id] int IDENTITY(1,1) NOT NULL,
  [Name] nvarchar(max) NOT NULL,
  PRIMARY KEY ([Id])
)
GO

SET IDENTITY_INSERT [Role] ON
INSERT INTO [Role] ([Id], [Name]) VALUES (1, N'Аналитик')
INSERT INTO [Role] ([Id], [Name]) VALUES (2, N'Менеджер')
INSERT INTO [Role] ([Id], [Name]) VALUES (3, N'Руководитель')
SET IDENTITY_INSERT [Role] OFF
GO

-- Таблица с ролями пользователя
CREATE TABLE [UserRole]
(
  [Id] int IDENTITY(1,1) NOT NULL,
  [UserId] [int] NOT NULL,
  [RoleId] [int] NOT NULL,
  PRIMARY KEY ([Id])
)

SET IDENTITY_INSERT [UserRole] ON
INSERT INTO [UserRole] ([Id], [UserId], [RoleId]) VALUES (1, 1, 1)
INSERT INTO [UserRole] ([Id], [UserId], [RoleId]) VALUES (2, 1, 2)
SET IDENTITY_INSERT [UserRole] OFF
GO

-- Процедура для получения возможных вариантов ролей пользователя
CREATE PROCEDURE GetRole
AS
SELECT *
FROM [Role]
GO

-- Процедура для получения установленных ролей у пользователя
CREATE PROCEDURE GetUserRole
  (@user INT)
AS
SELECT [RoleId] AS Id
FROM [UserRole]
WHERE [UserId] = @user
GO

-- Тип списка ID
CREATE TYPE [IdListType] AS Table (
  [Id] int
)
GO

-- Процедура для установки ролей пользователю
CREATE PROCEDURE [SetUserRole] (
  @user int,
  @roles AS [IdListType] READONLY
) AS
BEGIN
  DELETE FROM [UserRole] WHERE [UserId] = @user
  
  INSERT INTO [UserRole]
  SELECT @user, Id FROM @roles;
END
GO


DECLARE @RoleList as [IdListType]
INSERT INTO @RoleList VALUES (1), (2)
EXEC [SetUserRole] @USER = 1, @roles = @RoleList
GO
