/*
1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
*/

ALTER table users 
ADD column created_at DATETIME,
ADD column updated_at DATETIME;

UPDATE users SET 
created_at = NOW(),
updated_at = NOW();

/*
2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". 
Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
*/

ALTER table users 
DROP column created_at_str,
DROP column updated_at_str;

SELECT CHAR_LENGTH(DATE_FORMAT(NOW(), '%d/%m/%y %T'));

ALTER table users 
ADD column created_at_str VARCHAR(17),
ADD column updated_at_str VARCHAR(17);

UPDATE users SET 
created_at_str = DATE_FORMAT(NOW(), '%d/%m/%y %T'),
updated_at_str = DATE_FORMAT(NOW(), '%d/%m/%y %T');

UPDATE users
SET created_at = STR_TO_DATE(created_at_str, '%d/%m/%y %T'),
    updated_at = STR_TO_DATE(updated_at_str, '%d/%m/%y %T');
   
ALTER TABLE users 
DROP created_at_str, 
DROP updated_at_str;


/*
3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
0, если товар закончился и выше нуля, если на складе имеются запасы. 
Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
Однако, нулевые запасы должны выводиться в конце, после всех записей.
*/

SELECT * 
FROM storehouses_products
ORDER BY CASE WHEN value = 0 THEN 1000 ELSE value END;


/*
4. Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
Месяцы заданы в виде списка английских названий ('may', 'august')
*/

SELECT *
FROM users
HAVING MONTH(birthday_at)=5 OR MONTH(birthday_at)=8;


/*
5. Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
Отсортируйте записи в порядке, заданном в списке IN.
*/

SELECT * 
FROM catalogs 
ORDER BY FIND_IN_SET(id,'2,1,5') 
DESC 
LIMIT 3;

/*
6. Подсчитайте средний возраст пользователей в таблице users 
*/

SELECT AVG((YEAR(NOW()) - YEAR(birthday_at))) as age
FROM users;


/*
7.Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
Следует учесть, что необходимы дни недели текущего года, а не года рождения.
*/

SELECT
    WEEKDAY(DATE_FORMAT(birthday_at, '2021-%m-%d')) AS 'day_num',
    COUNT(*) AS 'birthdays_cnt'
FROM users
GROUP BY weekday(date_format(birthday_at, '2021-%m-%d'))
ORDER BY day_num;

/*
Подсчитайте произведение чисел в столбце таблицы
1,2,3,4,5 -> 120
*/

SELECT EXP(SUM(LN(id))) AS 'Multiplication'
FROM users
WHERE id < 6;

