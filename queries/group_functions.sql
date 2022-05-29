/*1*/
SELECT "group", COUNT("group") AS stud_count FROM students GROUP BY "group" ORDER BY "group" ASC;
/*2*/
SELECT "group", MAX(score) AS max, ROUND(AVG(score), 2) AS average FROM students GROUP BY "group" ORDER BY "group" ASC;
/*3*/
SELECT surname, COUNT(surname) AS count FROM students GROUP BY surname ORDER BY surname ASC;
/*4*/
SELECT EXTRACT(YEAR FROM date_birth) AS year_birth, COUNT(EXTRACT(YEAR FROM date_birth)) AS count FROM students GROUP BY EXTRACT(YEAR FROM date_birth) ORDER BY EXTRACT(YEAR FROM date_birth) ASC;
/*5*/
SELECT substr(CAST("group" AS character), 1, 1), ROUND(AVG(score), 2) AS average FROM students GROUP BY substr(CAST("group" AS character), 1, 1) ORDER BY substr(CAST("group" AS character), 1, 1) ASC;
/*6*/
SELECT "group", ROUND(AVG(score), 2) FROM students WHERE CAST("group" as character) LIKE '2%' GROUP BY "group" ORDER BY ROUND(AVG(score), 2) DESC LIMIT 1;
/*7*/
SELECT "group", ROUND(AVG(score), 2) FROM students  GROUP BY "group" HAVING ROUND(AVG(score), 2) <= 3.5 ORDER BY ROUND(AVG(score), 2) ASC;
/*8*/
SELECT "group", COUNT("group") AS count, MAX(score) AS max, ROUND(AVG(score), 2) AS average, MIN(score) AS min FROM students  GROUP BY "group";
/*9*/
SELECT distinct on ("group") "group", name, surname, MAX(score) FROM students WHERE "group" = 2025 GROUP BY "group", name, surname;
/*10*/
SELECT distinct on ("group") "group", name, surname, MAX(score) FROM students  GROUP BY "group", name, surname;