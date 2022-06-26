# Практическое задание по теме “Транзакции, переменные, представления”

# 1.В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
# Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
create DATABASE sample;
use sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users VALUES
  (DEFAULT, 'sample user', '1990-01-01', DEFAULT, DEFAULT);

SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO sample.users (name, birthday_at) 
SELECT shop.users.name, shop.users.birthday_at 
FROM shop.users 
WHERE (id = 1);
COMMIT;

# 2.Создайте представление, которое выводит название name товарной позиции из таблицы products и 
# соответствующее название каталога name из таблицы catalogs.
use shop;
CREATE VIEW items_with_category(item, catalogs) AS 
SELECT p.name, c.name 
FROM 
catalogs AS c 
JOIN 
products AS p 
ON p.catalog_id=c.id;

# Хранимые процедуры и функции, триггеры
/*1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
с 18:00 до 00:00 — "Добрый вечер", 
с 00:00 до 6:00 — "Доброй ночи".*/
DROP PROCEDURE IF EXISTS hello;

delimiter //

CREATE PROCEDURE hello ()
BEGIN
	SET @time = HOUR(NOW());
	CASE
		WHEN (@time > 6 AND @time < 12) THEN SELECT 'Доброе утро';
		WHEN (@time > 12 AND @time < 18) THEN SELECT 'Добрый день';
		WHEN (@time > 18 AND @time < 24) THEN SELECT 'Добрый вечер';
		WHEN (@time > 0 AND @time < 6) THEN SELECT 'Доброй ночи'; 
	END CASE;
END
//

delimiter ;
CALL hello ();

/* 2. В таблице products есть два текстовых поля: name с названием товара и description 
с его описанием. Допустимо присутствие обоих полей или одно из них. 
Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
При попытке присвоить полям NULL-значение необходимо отменить операцию.*/

DROP TRIGGER IF EXISTS check_description_name;
DELIMITER //

CREATE TRIGGER check_description_name BEFORE UPDATE ON products
FOR EACH ROW BEGIN
IF NEW.name is NULL OR NEW.description is NULL THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='UPDATE canceled';
END IF;
END
//

DELIMITER ;


UPDATE products SET description = NULL WHERE id = 8;
