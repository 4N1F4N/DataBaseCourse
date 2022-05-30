/*1*/
SELECT 
	students.name, 
	students.surname, 
	hobby.name 
FROM 
	students, 
	stud_hobby, 
	hobby 
WHERE 
	stud_hobby.id_stud = students.n_z 
	AND stud_hobby.id_hobby = hobby.id;
/*2*/
SELECT 
	students.name, 
	students.surname, 
	hobby.name, 
	stud_hobby.date_finish - stud_hobby.date_start AS days
FROM 
	students, 
	stud_hobby, 
	hobby 
WHERE 
	stud_hobby.id_stud = students.n_z 
	AND stud_hobby.id_hobby = hobby.id 
	AND stud_hobby.date_finish - stud_hobby.date_start NOTNULL
ORDER BY 
	days DESC
LIMIT 1;
/*3*/
SELECT
	students.name, 
	students.surname, 
	students.n_z, 
	students.date_birth
FROM 
	students, 
	stud_hobby, 
	hobby,
	(SELECT students.n_z AS n_z, SUM(hobby.risk)
	FROM students, stud_hobby, hobby
	WHERE students.n_z = stud_hobby.id_stud AND stud_hobby.id_hobby = hobby.id
	GROUP BY students.n_z) AS risk_sum
WHERE 
	students.n_z = stud_hobby.id_stud 
	AND stud_hobby.id_hobby = hobby.id  
	AND students.n_z = risk_sum.n_z 
	AND students.score > (SELECT AVG(students.score) FROM students)
	AND risk_sum.sum > 0.9
/*4*/
SELECT
	students.name, 
	students.surname, 
	students.n_z, 
	students.date_birth, 
	hobby.name, 
	(DATE_PART('year', stud_hobby.date_finish) - DATE_PART('year', stud_hobby.date_start)) * 12 +
	DATE_PART('month', stud_hobby.date_finish) - DATE_PART('month', stud_hobby.date_start) AS hobby_month
FROM 
	students, 
	stud_hobby, 
	hobby
WHERE 
	students.n_z = stud_hobby.id_stud 
	AND stud_hobby.id_hobby = hobby.id
	AND stud_hobby.date_finish NOTNULL
ORDER BY hobby_month DESC;
/*5*/
SELECT
	students.name, 
	students.surname, 
	students.n_z, 
	students.date_birth, 
	(DATE_PART('year', CAST(CURRENT_DATE AS date)) - DATE_PART('year', students.date_birth)) AS age
FROM 
	students, 
	stud_hobby, 
	hobby,
	(SELECT students.n_z AS n_z
	FROM students, stud_hobby, hobby
	WHERE students.n_z = stud_hobby.id_stud AND stud_hobby.id_hobby = hobby.id AND stud_hobby.date_finish IS NULL
	GROUP BY students.n_z) AS hobby_sum
WHERE 
	students.n_z = stud_hobby.id_stud 
	AND stud_hobby.id_hobby = hobby.id
	AND (DATE_PART('year', CAST(CURRENT_DATE AS date)) - DATE_PART('year', students.date_birth)) >= 23
	AND stud_hobby.date_finish IS NULL
	AND hobby_sum.n_z = students.n_z
GROUP BY
	students.name,
	students.surname, 
	students.n_z, 
	students.date_birth
/*6*/
SELECT 
	"group", 
	ROUND(AVG(score), 2) AS average 
FROM 
	students, 
	stud_hobby, 
	hobby
WHERE 
	students.n_z = stud_hobby.id_stud 
	AND stud_hobby.id_hobby = hobby.id 
	AND stud_hobby.date_finish IS NULL
GROUP BY 
	"group" 
ORDER BY 
	"group";
/*7*/

/*8*/
SELECT
	hobby.name
FROM students, 
	stud_hobby, 
	hobby,
	(SELECT students.n_z as n_z
	FROM students
	WHERE students.score = (SELECT MAX(score) FROM students)) AS stud_max
WHERE students.n_z = stud_hobby.id_stud 
	AND stud_hobby.id_hobby = hobby.id
	AND stud_hobby.id_stud = students.n_z
	AND students.n_z = stud_max.n_z
/*9*/
SELECT
	hobby.name
FROM students, 
	stud_hobby, 
	hobby
WHERE students.n_z = stud_hobby.id_stud 
	AND stud_hobby.id_hobby = hobby.id
	AND stud_hobby.id_stud = students.n_z
	AND students.score < 3.5
	AND students.score >= 2.5
	AND stud_hobby.date_finish IS NULL
	AND CAST(students.group AS character) LIKE '2%'
/*10*/

/*11*/

/*12*/
SELECT
	DISTINCT ON (substr(CAST(students.group AS character),1, 1))
	substr(CAST(students.group AS character),1, 1), 
	hobby.name
FROM 
	students, 
	stud_hobby, 
	hobby
WHERE 
	students.n_z = stud_hobby.id_stud 
	AND stud_hobby.id_hobby = hobby.id
	AND stud_hobby.id_stud = students.n_z
	AND stud_hobby.date_finish IS NULL
/*13*/
SELECT
	students.n_z,
	students.name,
	students.surname,
	students.date_birth,
	substr(CAST(students.group AS character),1, 1) AS course
FROM
	students,
	stud_hobby,
	hobby,
	(SELECT
		students.n_z AS n_z
	FROM
		students,
		stud_hobby,
		hobby
	WHERE
		students.n_z = stud_hobby.id_stud 
		AND stud_hobby.id_hobby = hobby.id
		AND stud_hobby.date_finish IS NULL
		AND students.score >= 4.5
	GROUP BY
		students.n_z
	) AS good_stud
WHERE
	students.n_z = stud_hobby.id_stud 
	AND stud_hobby.id_hobby = hobby.id
	AND good_stud.n_z = students.n_z
ORDER BY
	course ASC,
	students.date_birth DESC
/*14*/

/*15*/
SELECT 
	hobby.name,
	COUNT(students.n_z)
FROM 
	students,
	stud_hobby,
	hobby
WHERE
	students.n_z = stud_hobby.id_stud 
	AND stud_hobby.id_hobby = hobby.id
GROUP BY
	hobby.name

/*16*/
SELECT
	hobby.id
FROM
	hobby,
	(SELECT 
		hobby.name,
		COUNT(students.n_z)
	FROM 
		students,
		stud_hobby,
		hobby
	WHERE
		students.n_z = stud_hobby.id_stud 
		AND stud_hobby.id_hobby = hobby.id
	GROUP BY
		hobby.name
	ORDER BY 
		count DESC
	LIMIT 1) AS max_hobby
WHERE
	hobby.name = max_hobby.name
/*17*/
SELECT
	students.*
FROM
	students,
	stud_hobby,
	hobby,
	(SELECT 
		hobby.name,
		COUNT(students.n_z)
	FROM 
		students,
		stud_hobby,
		hobby
	WHERE
		students.n_z = stud_hobby.id_stud 
		AND stud_hobby.id_hobby = hobby.id
	GROUP BY
		hobby.name
	ORDER BY 
		count DESC
	LIMIT 1) AS max_hobby
WHERE
	hobby.name = max_hobby.name
	AND students.n_z = stud_hobby.id_stud 
	AND stud_hobby.id_hobby = hobby.id
/*18*/
SELECT 
	hobby.name,
	hobby.risk
FROM 
	hobby
ORDER BY 
	hobby.risk DESC
LIMIT 3
/*19*/
SELECT
	students.name,
	students.surname,
	MAX(CURRENT_DATE - stud_hobby.date_start) AS hobby_duration
FROM
	students,
	stud_hobby
WHERE
	students.n_z = stud_hobby.id_stud
	AND stud_hobby.date_finish IS NULL
GROUP BY
	students.name,
	students.surname
ORDER BY
	hobby_duration DESC
LIMIT 10;
/*20*/
SELECT
	stud_group.stud_group
FROM
	(SELECT
		students.name,
		students.surname,
		students.group AS stud_group,
		MAX(CURRENT_DATE - stud_hobby.date_start) AS hobby_duration
	FROM
		students,
		stud_hobby
	WHERE
		students.n_z = stud_hobby.id_stud
		AND stud_hobby.date_finish IS NULL
	GROUP BY
		students.name,
		students.surname,
		students.group
	ORDER BY
		hobby_duration DESC
	LIMIT 10) AS stud_group
GROUP BY
	stud_group
/*21*/
DROP VIEW IF EXISTS stud_view;
CREATE OR REPLACE VIEW stud_view AS
	SELECT
		students.n_z,
		students.name,
		students.surname
	FROM
		students
	ORDER BY
		students.score DESC;
SELECT
	*
FROM
	stud_view
/*22*/
DROP VIEW IF EXISTS stud_view;
CREATE OR REPLACE VIEW stud_view AS
	SELECT
		DISTINCT ON (course)
		substr(CAST(students.group AS character), 1, 1) AS course,
		hobby.name,
		COUNT(hobby.id)
	FROM
		students,
		stud_hobby,
		hobby
	WHERE
		students.n_z = stud_hobby.id_stud
		AND stud_hobby.id_hobby = hobby.id
	GROUP BY
		course,
		hobby.name
	ORDER BY
		course,
		hobby.name;
SELECT
	*
FROM
	stud_view
/*23*/

/*24*/
DROP VIEW IF EXISTS stud_view;
CREATE OR REPLACE VIEW stud_view AS
	SELECT
		substr(CAST(students.group AS character), 1, 1) AS course,
		COUNT(students.n_z) AS count_stud,
		SUM(CAST(students.score >= 4.5 AS integer)) AS count_good_stud
	FROM
		students
	GROUP BY
		course
	ORDER BY
		course;
SELECT
	*
FROM
	stud_view
/*25*/
DROP VIEW IF EXISTS stud_view;
CREATE OR REPLACE VIEW stud_view AS
	SELECT
		hobby.name AS hobby_name,
		COUNT(students.n_z) as count_stud
	FROM
		students,
		stud_hobby,
		hobby
	WHERE
		students.n_z = stud_hobby.id_stud 
		AND stud_hobby.id_hobby = hobby.id
	GROUP BY
		hobby_name
	ORDER BY
		count_stud DESC
	LIMIT 1;
SELECT
	stud_view.hobby_name
FROM
	stud_view
/*26*/

/*27*/
SELECT
	DISTINCT ON (letter)
	substr(students.name, 1, 1) AS letter,
	MAX(students.score) AS max_score,
	ROUND(AVG(students.score), 2) AS avg_score,
	MIN(students.score) AS min_score
FROM
	students
GROUP BY
	letter
HAVING
	ROUND(AVG(students.score), 2) > 3.6
ORDER BY
	letter
/*28*/
SELECT
	substr(CAST(students.group AS character), 1, 1) AS course,
	students.surname AS surname,
	MAX(students.score) AS max_score,
	MIN(students.score) AS min_score
FROM
	students
GROUP BY
	course,
	surname
ORDER BY
	course,
	surname
/*29*/
SELECT
	EXTRACT(YEAR FROM students.date_birth) AS year_birth,
	COUNT(stud_hobby.id_hobby)
FROM
	students,
	stud_hobby
WHERE
	students.n_z = stud_hobby.id_stud
GROUP BY
	year_birth
ORDER BY
	year_birth
/*30*/
SELECT
	DISTINCT ON (letter)
	substr(students.name, 1, 1) AS letter,
	MAX(hobby.risk) AS max_score,
	MIN(hobby.risk) AS min_score
FROM
	students,
	stud_hobby,
	hobby
WHERE
	students.n_z = stud_hobby.id_stud 
	AND stud_hobby.id_hobby = hobby.id
GROUP BY
	letter
HAVING
	ROUND(AVG(students.score), 2) > 3.6
ORDER BY
	letter
/*31*/
SELECT
	EXTRACT(MONTH FROM students.date_birth) AS month_birth,
	ROUND(AVG(students.score), 2) AS avg_score
FROM
	students,
	stud_hobby,
	hobby
WHERE
	students.n_z = stud_hobby.id_stud
	AND stud_hobby.id_hobby = hobby.id
	AND hobby.name = 'Киноклуб'
GROUP BY
	month_birth
ORDER BY
	month_birth
/*32*/
SELECT
	DISTINCT ON (students.name)
	students.name,
	students.surname,
	students.group
FROM
	students,
	stud_hobby,
	hobby
WHERE
	students.n_z = stud_hobby.id_stud
	AND stud_hobby.id_hobby = hobby.id
ORDER BY
	students.name,
	students.surname,
	students.group
/*33*/

/*34*/

/*35*/

/*36*/

/*37*/

/*38*/

/*39*/

/*40*/