/*1*/
/*Добавление нового сотрудника*/
INSERT INTO users (name, surname, patronymic, role, level_access)
VALUES ('Анатолий', 'Томилов', 'Сергеевич', 'User', 1)
/*2*/
/*Выдача прав определенному пользователю*/
UPDATE users SET level_access = 2 WHERE id = 1
/*3*/

/*4*/

/*5*/
/*Запрос на доступ*/
INSERT INTO access_requests (id_user, id_room)
VALUES (1, 2)
/*6*/
/*Нахождение по праву доступа*/
SELECT * FROM users WHERE users.level_access = 1
/*Нахождение по имено*/
SELECT * FROM users WHERE users.name = ''
/*Нахождение по фамилии*/
SELECT * FROM users WHERE users.surname = ''
/*Нахождение по отчеству*/
SELECT * FROM users WHERE users.patronymic = 1
/*7*/
/*Информация о всех действиях пользователя*/
SELECT 
	users.id,
	visits.date_start,
	visits.date_finish
FROM 
	users,
	visits
WHERE 
	users.id = visits.id_user
/*Информация о дествиях в определенной комнате*/
SELECT 
	users.id,
	visits.date_start,
	visits.date_finish
FROM 
	users,
	visits
WHERE 
	users.id = visits.id_user
	AND visits.id_room = 1
/*8*/

/*9*/
/*Удаление прав определенному пользователю*/
UPDATE users SET level_access = 1 WHERE id = 1
/*10*/
/*Инциденты сортированные по дате*/
SELECT 
	*
FROM 
	incidents
ORDER BY
	incidents.date ASC
/*Инциденты сортированные по пользователям*/
SELECT 
	visits.id_user,
	incidents.*
FROM 
	incidents,
	visits
WHERE
	incidents.id_visit = visits.id
ORDER BY
	visits.id_user ASC