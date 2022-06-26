/* 1.Установите СУБД MySQL. Создайте в домашней директории 
файл .my.cnf, задав в нем логин и пароль, 
который указывался при установке.
[client]
user=mysqluser
password=mysqlpass*/

/*
 * 2.Создайте базу данных example, разместите в ней 
 * таблицу users, состоящую из двух столбцов, 
 * числового id и строкового name.
 */
CREATE DATABASE example;
USE example;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  	id INT,
	name CHAR(255)
);

INSERT INTO users(id, name) VALUES (1, 'Пользователь 1');
INSERT INTO users(id, name) VALUES (2, 'Пользователь 2');

SELECT * FROM users;

/* 3.Создайте дамп базы данных example из предыдущего задания, 
 разверните содержимое дампа в новую базу данных sample.*/

# Дамп БД
# В командной строке
# mysqldump --user=username --p example > example.sql

# Развернуть содержимое БД из дампа
CREATE DATABASE example2;
# В командной строке 
# mysql -u username -p example2 < example.sql


# 4. Ознакомьтесь более подробно с документацией утилиты 
# mysqldump. Создайте дамп единственной таблицы help_keyword
# базы данных mysql. Причем добейтесь того, чтобы дамп 
# содержал только первые 100 строк таблицы. 
#mysqldump --opt --user=user --password=pswd mysql help_keyword  --where="1 limit 100" > test.sql

