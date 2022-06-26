/*
1. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
который больше всех общался с выбранным пользователем (написал ему сообщений).
*/
USE vk;

INSERT INTO messages(from_user_id, to_user_id) VALUES
(72,63),
(72,63);

SELECT 
* 
FROM
(SELECT 
	COUNT(*) as num, 
	from_user_id
FROM messages
WHERE to_user_id = 63
GROUP BY from_user_id
ORDER BY num DESC
LIMIT 1) t1
JOIN
(SELECT * 
FROM users
WHERE id = @x_user) t2
ON (t1.from_user_id = t2.id);



/*
2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
(представим что в таблице likes БД vk столбец media_id = liked_by)
*/

SELECT 
COUNT(media_id)
FROM
(SELECT id
-- INTO @userIDs
FROM users
WHERE age <10) t1
LEFT JOIN 
(SELECT 
	user_id,
	media_id
FROM likes) t2
ON
t1.id = t2.user_id;


/*
3. Определить кто больше поставил лайков (всего): мужчины или женщины.
(представим что в таблице likes БД vk столбец media_id = liked_by)
sex(пол): 1- мужчины, 0 - женщины 
*/

SELECT
 @x_sex := sex
FROM
(SELECT media_id
FROM likes) t1
JOIN
(SELECT 
	id,
	sex 
FROM users) t2
ON t1.media_id = t2.id
GROUP BY sex
ORDER BY COUNT(sex) DESC
LIMIT 1;


SELECT @x_sex as sex,
CASE
	WHEN @x_sex = 0 THEN "Женщины больше лайкают"
	WHEN @x_sex = 1 THEN "Мужчины больше лайкают"
END as result;