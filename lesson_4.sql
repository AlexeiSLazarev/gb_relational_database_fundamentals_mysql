# i. Заполнить все таблицы БД vk данными (по 10-20 записей в каждой таблице)
use vk;


# comminities
DROP PROCEDURE IF EXISTS fill_comminites;
CREATE PROCEDURE fill_comminites()
BEGIN
	DECLARE i INT DEFAULT 0; 
	WHILE i <= 10 DO
		INSERT INTO communities (id, name, admin_user_id)
		VALUES (i+102, concat('community', i+101), 10);
	    SET i = i+1;
	END WHILE;
END;
CALL fill_comminites();

# friend_requests
DROP PROCEDURE IF EXISTS fill_friend_requests;
CREATE PROCEDURE fill_friend_requests()
BEGIN
	DECLARE i INT DEFAULT 0; 
	WHILE i <= 10 DO
	    INSERT IGNORE INTO `friend_requests` (initiator_user_id, target_user_id, status) 
	   	values (95, i, 'requested');
	    SET i = i+1;
	END WHILE;
END;
CALL fill_friend_requests(); 


# likes
DROP PROCEDURE IF EXISTS fill_likes;
CREATE PROCEDURE fill_likes()
BEGIN
	DECLARE a INT;
	DECLARE b INT;
	DECLARE i INT DEFAULT 0; 
	WHILE i <= 10 DO
		SELECT FLOOR(1 + RAND() * (100 - 1 + 1))
	   	into a;
	   	SELECT FLOOR(1 + RAND() * (100 - 1 + 1))
	   	into b;
	    INSERT IGNORE INTO likes (user_id, media_id)
	   	VALUES (a,b);
	    SET i = i+1;
	END WHILE;
END;
CALL fill_likes(); 

# media_type
DROP PROCEDURE IF EXISTS fill_media_types;
CREATE PROCEDURE fill_media_types()
BEGIN
	DECLARE i INT DEFAULT 0; 
	WHILE i <= 10 DO
		INSERT INTO media_types (id, name)
		VALUES (i+5, concat('media', i+5));
	    SET i = i+1;
	END WHILE;
END;
CALL fill_media_types();

# messages
DROP PROCEDURE IF EXISTS fill_messages;
CREATE PROCEDURE fill_messages()
BEGIN
	DECLARE a INT;
	DECLARE b INT;
	DECLARE m VARCHAR(30);
	DECLARE i INT DEFAULT 0; 
	WHILE i <= 10 DO
		SELECT FLOOR(1 + RAND() * (100 - 1 + 1)) INTO a;
	   	SELECT FLOOR(1 + RAND() * (100 - 1 + 1)) into b;
	   	SELECT SUBSTRING(MD5(RAND()) FROM 1 FOR 30) INTO m;
	    INSERT IGNORE INTO messages (from_user_id, to_user_id, body, created_at)
	   	VALUES (a,b,m,now());
	    SET i = i+1;
	END WHILE;
END;
CALL fill_messages(); 


# ii. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке
SELECT DISTINCT firstname from users;

# iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). 
#Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)
ALTER TABLE users ADD COLUMN age TINYINT UNSIGNED;
ALTER TABLE users ADD COLUMN is_active BOOLEAN DEFAULT True;

# заполним столбец возрастов
SELECT GROUP_CONCAT(id)
INTO @userIDs
FROM  users;
-- SELECT @userIDs;

UPDATE users
SET age = FLOOR(10 + RAND() * (50 - 1 + 1))
WHERE FIND_IN_SET(id, @userIDs);

# отмечаем неактивных пользоателей
UPDATE users
set is_active=FALSE 
WHERE age<18;

# iv. Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)
DELETE FROM messages 
WHERE created_at > NOW();

# v. Написать название темы курсового проекта (в комментарии)
Разработать базу данных активности сотрудников отдела на основании данных из 
Jira, Confluence, Git, ClearML и логгера совещаний.

