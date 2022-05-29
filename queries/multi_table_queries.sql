/*1*/
SELECT students.name, students.surname, hobby.name 
FROM students, stud_hobby, hobby 
WHERE stud_hobby.id_stud = students.n_z and stud_hobby.id_hobby = hobby.id;
/*2*/
SELECT students.name, students.surname, hobby.name, stud_hobby.date_finish - stud_hobby.date_start AS days
FROM students, stud_hobby, hobby 
WHERE stud_hobby.id_stud = students.n_z and stud_hobby.id_hobby = hobby.id AND stud_hobby.date_finish - stud_hobby.date_start NOTNULL
ORDER BY days DESC
LIMIT 1;
/*3*/
SELECT
	students.name, students.surname, students.n_z, students.date_birth
FROM students, 
	stud_hobby, 
	hobby,
	(SELECT students.n_z AS n_z, SUM(hobby.risk)
	FROM students, stud_hobby, hobby
	WHERE students.n_z = stud_hobby.id_stud AND stud_hobby.id_hobby = hobby.id
	GROUP BY students.n_z) AS risk_sum
WHERE students.n_z = stud_hobby.id_stud 
	AND stud_hobby.id_hobby = hobby.id  
	AND students.n_z = risk_sum.n_z 
	AND students.score > (SELECT AVG(students.score) FROM students)
	AND risk_sum.sum > 0.9
/*4*/
SELECT
	students.name, students.surname, students.n_z, students.date_birth, hobby.name, 
	(DATE_PART('year', stud_hobby.date_finish) - DATE_PART('year', stud_hobby.date_start)) * 12 +
	DATE_PART('month', stud_hobby.date_finish) - DATE_PART('month', stud_hobby.date_start) AS hobby_month
FROM students, 
	stud_hobby, 
	hobby
WHERE students.n_z = stud_hobby.id_stud 
	AND stud_hobby.id_hobby = hobby.id
	AND stud_hobby.date_finish NOTNULL
ORDER BY hobby_month DESC;
/*5*/
SELECT
	students.name, students.surname, students.n_z, students.date_birth, hobby.name, stud_hobby.date_finish,
	(DATE_PART('year', CAST(CURRENT_DATE AS date)) - DATE_PART('year', students.date_birth)) AS age
FROM students, 
	stud_hobby, 
	hobby,
	(SELECT students.n_z AS n_z
	FROM students, stud_hobby, hobby
	WHERE students.n_z = stud_hobby.id_stud AND stud_hobby.id_hobby = hobby.id AND stud_hobby.date_finish IS NULL
	GROUP BY students.n_z) AS hobby_sum
WHERE students.n_z = stud_hobby.id_stud 
	AND stud_hobby.id_hobby = hobby.id
	AND (DATE_PART('year', CAST(CURRENT_DATE AS date)) - DATE_PART('year', students.date_birth)) >= 23
	AND stud_hobby.date_finish IS NULL
	AND hobby_sum.n_z = students.n_z
/*6*/
SELECT "group", ROUND(AVG(score), 2) AS average 
FROM students, stud_hobby, hobby
WHERE students.n_z = stud_hobby.id_stud AND stud_hobby.id_hobby = hobby.id AND stud_hobby.date_finish IS NULL
GROUP BY "group" 
ORDER BY "group";
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

/*13*/

/*14*/

/*15*/

/*16*/

/*17*/

/*18*/

/*19*/

/*20*/

/*21*/

/*22*/

/*23*/

/*24*/

/*25*/

/*26*/

/*27*/

/*28*/

/*29*/

/*30*/

/*31*/

/*32*/

/*33*/

/*34*/

/*35*/

/*36*/

/*37*/

/*38*/

/*39*/

/*40*/