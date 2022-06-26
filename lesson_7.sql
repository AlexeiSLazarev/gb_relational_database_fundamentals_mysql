/*Задание 1. Составьте список пользователей users, 
которые осуществили хотя бы один заказ orders в интернет магазине.*/

SELECT name 
FROM users
WHERE users.id in (SELECT DISTINCT user_id
FROM orders);

/* Задание 2. Выведите список товаров products и разделов catalogs, 
который соответствует товару.*/

SELECT 
	p.name,
	c.name AS catalog
FROM products AS p
JOIN catalogs AS c
ON p.catalog_id = c.id; 