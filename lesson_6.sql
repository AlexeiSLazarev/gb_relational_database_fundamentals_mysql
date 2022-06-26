/*
1. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
который больше всех общался с выбранным пользователем (написал ему сообщений).
*/
USE vk;

INSERT INTO messages(from_user_id, to_user_id) VALUES
(72,63),
(72,63);

SELECT 
	COUNT(*) as num, 
	@x_user := from_user_id
FROM messages
WHERE to_user_id = 63
GROUP BY from_user_id
ORDER BY num DESC
LIMIT 1
;

SELECT *
FROM users
WHERE id = @x_user;


/*
2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
(представим что в таблице likes БД vk столбец media_id = liked_by)
*/

SELECT GROUP_CONCAT(id)
INTO @userIDs
FROM users
WHERE age <10

SELECT COUNT(user_id)
FROM likes
WHERE FIND_IN_SET(user_id, @userIDs);
;


/*
3. Определить кто больше поставил лайков (всего): мужчины или женщины.
(представим что в таблице likes БД vk столбец media_id = liked_by)
sex(пол): 1- мужчины, 0 - женщины 
*/
SELECT GROUP_CONCAT(media_id)
INTO @userIDs
FROM likes;
SELECT @userIDs;

SELECT 
	COUNT(*) as cnt, 
	@x_sex := sex as male_female
FROM users
WHERE FIND_IN_SET(id, @userIDs)
GROUP BY sex
ORDER BY cnt DESC
LIMIT 1;

SELECT @x_sex as sex,
CASE
	WHEN @x_sex = 0 THEN "Женщины больше лайкают"
	WHEN @x_sex = 1 THEN "Мужчины больше лайкают"
END as result;
