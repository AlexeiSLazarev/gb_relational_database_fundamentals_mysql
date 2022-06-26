USE vk;

/*
Задание:
Написать крипт, добавляющий в БД vk, которую создали на занятии, 
3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей)
*/

# таблица gifts отоображает набор подарков
# содержит в себе название подарка, стоимость, дату создания, имя автора
CREATE TABLE gift_list(
	id INT UNIQUE NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100),
	price INT,
	date_of_creation DATETIME DEFAULT NOW(),
	gift_authors_name VARCHAR(255)
);

# связыавющая таблица gifts показывает что
# подарено от кого, кому, когда
CREATE TABLE gifts(
	id BIGINT UNIQUE NOT NULL AUTO_INCREMENT PRIMARY KEY,
	gift_id INT NOT NULL,
	gifted_by BIGINT UNSIGNED NOT NULL,
	gifted_to BIGINT UNSIGNED NOT NULL,
	gifted_when DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (gift_id) REFERENCES gift_list(id),
	FOREIGN KEY (gifted_by) REFERENCES users(id),
    FOREIGN KEY (gifted_to) REFERENCES users(id)
);


# таблица Post отображает сообщения на странице пользователя
# содержит в себе id пользователя, body, дату создания, и id пользователей 
# просмотревишх и поставивших лайки

CREATE TABLE post(
	id SERIAL PRIMARY KEY,
	created_by BIGINT UNSIGNED NOT NULL,
	created_date DATETIME DEFAULT NOW(),
	edited_date DATETIME DEFAULT NOW(),
	metadata JSON,
	photo_id BIGINT UNSIGNED,
	media_id BIGINT UNSIGNED,
	viewed_by BIGINT UNSIGNED,
	liked_by BIGINT UNSIGNED,
	FOREIGN KEY (photo_id) REFERENCES photos(id),
    FOREIGN KEY (media_id) REFERENCES media(id),
	FOREIGN KEY (liked_by) REFERENCES users(id),
    FOREIGN KEY (viewed_by) REFERENCES users(id)
);