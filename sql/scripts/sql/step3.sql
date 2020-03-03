USE [TestData]
GO

CREATE INDEX ix_Buy_ProductId ON Buy(ProductId)
CREATE INDEX ix_Client_Rank ON Client(Rank)
CREATE INDEX ix_Buy_ClientId_ProductId ON Buy(ClientId, ProductId)
CREATE UNIQUE INDEX ix_UserRole_UserId_RoleId ON UserRole(UserId, RoleId)
GO