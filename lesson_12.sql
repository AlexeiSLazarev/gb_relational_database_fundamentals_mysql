DROP DATABASE IF EXISTS department;
CREATE DATABASE department;

USE department;
/*
 Краткое описание: БД разрабатывается как основа для программного
 инструмента  управления проектами в рамках отдела.
 Включается в себя информация по сотрудникам(фио, должности и т.д.),
 а так же их активности.
 
 Схема не законечена, отсутствуют существенные разделы по 
 активности в рамках различных инструметов (conficon, git, conficon)
 
 БД будет заполнена после завершении схемы.
 * */


/*
Таблица Должности
Поля:
UID
Наименование должности
Минимальная ставка
Макисмальная ставка
*/
DROP TABLE IF EXISTS positions;
CREATE TABLE positions(
	id 				INT UNSIGNED UNIQUE NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name 			VARCHAR(100),
	min_salary 		INT UNSIGNED NOT NULL,
	max_salary 		INT UNSIGNED NOT NULL
);

/*
Таблица Отделы
Поля:
UID
Наименование отдела
*/
DROP TABLE IF EXISTS departments;
CREATE TABLE departments(
	id 				INT UNSIGNED UNIQUE NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name 			VARCHAR(100)
);

DROP TABLE IF EXISTS companys;
CREATE TABLE companys(
	id 				INT UNSIGNED UNIQUE NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name 			VARCHAR(100)
);

/*
Таблица1 Пользователи. Отображет список сотрудников компании
Поля:
UID
ФИО
Должность
e-mail
Рабочий телефон
Мобильный телефон
Отдел
Офис
Компания
Дата устройства на работу
*/
DROP TABLE IF EXISTS employee;
CREATE TABLE employee(
	id 				INT UNSIGNED UNIQUE NOT NULL PRIMARY KEY AUTO_INCREMENT,
	fio 			VARCHAR(100) NOT NULL,
	position_ 		INT UNSIGNED NOT NULL,
	salary_ 		INT UNSIGNED NOT NULL,
	email 			VARCHAR(50),
	work_phone 		VARCHAR(15),
	mobile_phone 	VARCHAR(10),
	department 		INT UNSIGNED NOT NULL,
	office 			VARCHAR(30),
	company 		INT UNSIGNED NOT NULL,
	date_of_entry 	DATETIME,
	
	FOREIGN KEY (position_) REFERENCES positions(id),
	FOREIGN KEY (department) REFERENCES departments(id),
	FOREIGN KEY (company) REFERENCES companys(id)
);


/*
Таблица Состав отдела
Поля:
Идентифкатор отдела
Идентифиатор сотрудника
*/
DROP TABLE IF EXISTS department_stuff;
CREATE TABLE department_stuff(
	id_department 	INT UNSIGNED,
	id_employee		INT UNSIGNED,
	
	FOREIGN KEY (id_department) REFERENCES employee(id),
	FOREIGN KEY (id_employee) REFERENCES employee(id)
);


/*
Таблица Задачи
UID
Наименование
Ответственный
Исполнитель
Дата начала
Дата окнчания
Оценка усилий
Затраченное время
Статус
Родительская задача
Логи
*/

DROP TABLE IF EXISTS task;
CREATE TABLE task(
	id 				INT UNSIGNED UNIQUE NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name 			VARCHAR(100),
	assignee 		INT UNSIGNED,
	reporter		INT UNSIGNED,
	date_begin 		DATETIME,
	date_end 		DATETIME,
	effort 			INT,
	elapsed_time	INT,
	status 			VARCHAR(15),
-- 	logs 			DATETIME 
	
	FOREIGN KEY (assignee) REFERENCES employee(id),
	FOREIGN KEY (reporter) REFERENCES employee(id)
);

/*
Таблица Логи
UID
Дата
Кол-во логгируемого времени
Исполнитель
Комментарий
*/

DROP TABLE IF EXISTS time_logger;
CREATE TABLE time_logger(
	id 				INT UNIQUE NOT NULL PRIMARY KEY AUTO_INCREMENT,
	task_id			INT UNSIGNED,
	log_data 		DATETIME,
	amount_of_time	INT,
	employee_id		INT UNSIGNED,
	comment			VARCHAR(500),
	
	FOREIGN KEY (task_id) REFERENCES task(id),
	FOREIGN KEY (employee_id) REFERENCES employee(id)
);


/*
Таблица Команда
UID
Наименование
Идентификатор сотрудника
Роль в проекте
*/

CREATE TABLE team(
	id 				INT UNSIGNED UNIQUE NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name 			VARCHAR(100),
	description		VARCHAR(100)
);

/*
Таблица4 Проект
UID
Наименование
Краткий идентификатор проекта
Руководитель проекта
Команда
Дата начала
Дата окнчания
Бюджет
Статус
*/

CREATE TABLE project(
	id 				INT UNSIGNED UNIQUE NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name 			VARCHAR(100),
	shortcut 		VARCHAR(10),
	project_lead	INT UNSIGNED,
	team_id 		INT UNSIGNED,
	date_start 		DATETIME,
	date_end 		DATETIME,
	budget 			INT,
	status 			VARCHAR(15),
-- 	logs 			DATETIME 
	
	FOREIGN KEY (team_id) REFERENCES team(id),
	FOREIGN KEY (project_lead) REFERENCES employee(id)
);



CREATE TABLE team_stuff(
	id_team			INT UNSIGNED,
	id_employee		INT UNSIGNED,
-- 	empl_function	VARCHAR(30),
	
	FOREIGN KEY (id_team) REFERENCES team(id),
	FOREIGN KEY (id_employee) REFERENCES employee(id)
);


-- Заполняем таблицы
-- Компании
INSERT INTO companys(name) VALUES
('РТИ'),
('ВТиСС');

-- Отделы
INSERT INTO departments (name) VALUES
('Отдел 1'),
('Отдел 2'),
('Отдел 3');

-- Офисы
INSERT INTO positions(name, min_salary, max_salary) VALUES
('Инженер', 80, 120),
('Программист', 80, 120),
('Начальник отдела', 100, 140),
('Руководитель проекта', 100, 140);

-- Работники
INSERT INTO employee (fio, position_, salary_, email ,work_phone,mobile_phone, department, office, company, date_of_entry) VALUES
('Сидоров Иван Иванович', 1, 95, 'sidorov@mail.ru', 883130451213310,9503334455,1,'304',1,NOW()),
('Сидорова Мария Сергеевна', 1, 90, 'sidorova@mail.ru', 883130451213311,9503334450,1,'304',1,NOW()),
('Печенькин Сергей Викторович', 2, 102, 'pechenkin@mail.ru', 883130451213312,9503334456,1,'614',1,NOW()),
('Королев Никита Валерьевич', 3, 130, 'korolev@mail.ru', 883130451213313,9503334457,1,'702',1,NOW()),
('Сергеева Елизавета Викторовна', 4, 115, 'sergeeva@mail.ru', 883130451213319,9503334452,1,'24',2,NOW());

-- Команда
INSERT INTO team (name, description) VALUES
('Команда 1', 'Команда разработки проекта 1'),
('Команда 2', 'Команда разработки проекта 2');


-- Состав команды
INSERT INTO team_stuff (id_team, id_employee) VALUES
(1,1),
(1,2),
(1,3),
(1,4);

-- Отделы
INSERT INTO project (name, shortcut, project_lead, team_id, date_start, date_end, budget, status) VALUES
('Проект 1', 'Prj1', 1, 1, '2007-03-20', '2007-03-20', 100000, 'INPROGRESS'),
('Проект 2', 'Prj2', 2, 1, '2007-03-20', '2007-03-20', 100000, 'FINISHED');

-- Задачи
INSERT INTO task(name, assignee, reporter, date_begin, date_end, effort, elapsed_time, status) VALUES
('Задача 1', 1, 2, '2007-03-20', '2007-04-20', 40, 20, 'IN PROGRESS'),
('Задача 2', 1, 2, '2007-03-20', '2007-04-20', 40, 20, 'IN PROGRESS'),
('Задача 3', 1, 2, '2007-03-20', '2007-04-20', 40, 20, 'IN PROGRESS');



-- Запрос
SELECT position_, name
FROM employee e
INNER JOIN positions p ON p.id = e.position_
WHERE e.department = 1;

-- Представления
DROP VIEW IF EXISTS employes_and_positions;
CREATE VIEW employes_and_positions(employee, positions) AS 
SELECT e.fio, p.name 
FROM 
employee AS e
JOIN 
positions AS p 
ON p.id = e.position_ ;

DROP VIEW IF EXISTS teams_and_employes;
CREATE VIEW teams_and_employes(employee, team, team_stuff) AS 
SELECT t.name, e.fio, t.description
FROM 
team_stuff ts
JOIN employee e ON e.id = ts.id_employee
JOIN team t ON ts.id_team = t.id;

-- Процедура
DROP PROCEDURE IF EXISTS avg_salary;

DELIMITER //;
CREATE PROCEDURE avg_salary ()
BEGIN
	SELECT AVG(salary_) as avg_salary FROM employee
END
//
DELIMITER ;
CALL avg_salary ();
