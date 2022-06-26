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

DROP TABLE IF EXISTS log;
CREATE TABLE log(
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
	sortcut 		VARCHAR(10),
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
	empl_function	VARCHAR(30),
	
	FOREIGN KEY (id_team) REFERENCES team(id),
	FOREIGN KEY (id_employee) REFERENCES employee(id)
);


/*
Таблица Активность в Confluence
*/


/*
Таблица Активность в Git
*/

/*
Таблица Активность в Conficon
*/