-- EXEC GetProductTop @variant = 1;

DROP PROCEDURE IF EXISTS GetPproductTop;
GO

CREATE PROCEDURE GetProductTop (
  @variant SMALLINT
) AS
BEGIN
  declare @list table (id int);

  -- Популярные – отобразить товары, которые покупались
  -- больше 3 раз клиентами с рангом больше 5.
  -- Как понимаю, разы не штуки
  IF @variant = 1
  BEGIN
    INSERT INTO @list
      SELECT b.ProductId
      FROM Buy b
      INNER JOIN Client c ON b.ClientId = c.Id
      WHERE
        c.Rank > 5
      GROUP BY b.ProductId
      HAVING COUNT(*) >= 3;
  END;

  -- Актуальные – отобразить товары, которые покупались
  -- одним и тем же клиентом больше двух раз.
  IF @variant = 2
  BEGIN
    INSERT INTO @list
      SELECT b2.ProductId
      FROM Buy b2
      GROUP BY b2.ClientId, b2.ProductId
      HAVING COUNT(*) >= 2
  END;

  -- Топ 5 – отобразить топ 5 товаров, в порядке
  -- убывания общей суммы покупок за всё время
  IF @variant = 3
  BEGIN
    INSERT INTO @list
      SELECT TOP 5 p.id
      FROM Product p
      ORDER BY (
        SELECT SUM(b2.[Count]*p2.Cost)
        FROM Product p2
        INNER JOIN Buy b2 ON b2.ProductId = p2.Id
        WHERE p2.Id = p.Id
      ) DESC
  END;

  -- Вывод товаров
  SELECT
    p.*,
    (
      SELECT COUNT(*)
      FROM Buy b
      LEFT JOIN Client c ON b.ClientId = c.Id
      WHERE b.ProductId = p.Id
    ) as buys
  FROM @list l
  INNER JOIN Product p ON l.id = p.id

END;