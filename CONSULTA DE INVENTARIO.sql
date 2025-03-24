SELECT 
	pi.ProductID,
	COALESCE(pi.Quantity,0) AS stock_actual,
	COALESCE(en.cantidad,0) AS Total_entradas,
	COALESCE(sal.cantidad,0) AS total_salidas,
	pi.LocationID AS almacen,
	p.Name AS producto,
	CASE 
		WHEN COALESCE(pi.Quantity,0)<10 THEN 'Bajo en Stock'
		ELSE 'Ok'
	END AS status
FROM AdventureWorks2017.Production.Product p
LEFT JOIN AdventureWorks2017.Production.ProductInventory pi 
ON p.ProductID=pi.ProductID
---hasta aqui vemos como se encuentra el status de nuestro stock actual
---analizando entradas
LEFT JOIN(
	SELECT 
	th.ProductID,
	SUM(th.Quantity) AS cantidad --suma todas las entradas del producto
	FROM AdventureWorks2017.Production.TransactionHistory th
		WHERE th.TransactionType='P' --P=Purchase
		GROUP BY th.ProductID
)en ON p.ProductID=en.ProductID
--analizamos salidas
LEFT JOIN(
	SELECT 
	th.ProductID,
	SUM(th.Quantity) AS cantidad
	FROM AdventureWorks2017.Production.TransactionHistory th
		WHERE th.TransactionType='S' --S=SALE
		GROUP BY th.ProductID
)sal ON p.ProductID=sal.ProductID
--WHERE COALESCE(pi.Quantity, 0) <10 AND COALESCE(sal.cantidad,0)>500
--WHERE COALESCE(pi.Quantity, 0) >10 AND COALESCE(en.cantidad,0)>5000 AND COALESCE(sal.cantidad,0)=0
ORDER BY stock_actual 


