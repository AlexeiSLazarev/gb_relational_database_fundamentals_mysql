use shop;
/*
1. Практическое задание по теме “Оптимизация запросов”
Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, 
идентификатор первичного ключа и содержимое поля name.*/

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(45) NOT NULL,
	str_id BIGINT(20) NOT NULL,
	name_value VARCHAR(45) NOT NULL
) ENGINE = ARCHIVE;

DROP TRIGGER IF EXISTS watchlog_users;
delimiter //
CREATE TRIGGER watchlog_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //
delimiter ;

DROP TRIGGER IF EXISTS watchlog_catalogs;
delimiter //
CREATE TRIGGER watchlog_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //
delimiter ;


INSERT INTO users (name, birthday_at)
VALUES ('user1', NOW());
SELECT * FROM logs;

/*
2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
*/

-- DROP PROCEDURE IF EXISTS LoadCalendars;

DELIMITER $$

CREATE PROCEDURE LoadCalendars()
BEGIN
 
    DECLARE counter INT DEFAULT 1;
    WHILE counter <= 1000 DO
    	INSERT INTO users (name, birthday_at) VALUES (CONCAT('user_',counter), NOW());
        SET counter = counter + 1;
    END WHILE;

END$$

DELIMITER ;

-- CALL LoadCalendars(); 

-- SELECT * FROM users;



Практическое задание по теме “NoSQL”
1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
alex@alex-T590:~$ redis-cli
127.0.0.1:6379> incr 192.168.0.1
(integer) 1
127.0.0.1:6379> incr 192.168.0.1
(integer) 2
127.0.0.1:6379> incr 192.168.0.2
(integer) 1
127.0.0.1:6379> incr 192.168.0.1
(integer) 3
127.0.0.1:6379> incr 192.168.0.2
(integer) 2


2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.
127.0.0.1:6379> HSET users user1 usr1@mail.com

127.0.0.1:6379> HGET users user1
"usr1@mail.com"
127.0.0.1:6379> HSET emails  usr1@mail.com user1
(integer) 1
127.0.0.1:6379> HGET emails usr1@mail.com
"user1"
127.0.0.1:6379> 





