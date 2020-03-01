SELECT
    p.*,
    (
        SELECT SUM(b.[Count])
        FROM Buy b
        WHERE b.ProductId = p.Id
        GROUP BY b.ProductId
    ) AS buys,
    (
        SELECT SUM(b.[Count])
        FROM Buy b
        WHERE b.ProductId = p.Id
        GROUP BY b.ProductId
    )*p.Cost AS buysSum,
    (
        SELECT SUM(b.[Count])
        FROM Buy b
        INNER JOIN Client c ON b.ClientId = c.Id
        WHERE b.ProductId = p.Id AND c.Rank >= 5
        GROUP BY b.ProductId
    ) AS buysBy5
FROM Product p
ORDER BY buysSum DESC;


SELECT p.*, b.[Count], c.Id, c.Rank
FROM Product p
INNER JOIN Buy b ON b.ProductId = p.Id
INNER JOIN Client c ON c.Id = b.ClientId
WHERE p.Id = 10
ORDER BY p.Cost * b.[Count];

SELECT TOP 5 p.id
      FROM Product p
      ORDER BY (
        SELECT SUM(b2.[Count]*p2.Cost)
        FROM Product p2
        INNER JOIN Buy b2 ON b2.ProductId = p2.Id
        WHERE p2.Id = p.Id
      ) DESC;
