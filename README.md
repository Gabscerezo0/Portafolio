# Consulta SQL para el estado del inventario de productos
Este script SQL permite obtener información sobre el estado del inventario en AdventureWorks2017, identificando productos con bajo stock, entradas y salidas de productos.

## Descripción del código
- Se utilizó LEFT JOIN para unir las tablas Product y ProductInventory, obteniendo el stock actual de cada producto.
- Se implementó COALESCE para reemplazar valores NULL por 0, asegurando operaciones numéricas correctas.
- Se empleó un CASE para clasificar el stock:
  - "Bajo en Stock" si la cantidad es menor a 100.
  - "Ok" si la cantidad es suficiente.
- Este código también analiza entradas y salidas de productos con subconsultas sobre la tabla TransactionHistory.
