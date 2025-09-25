SHOW TABLES;
DESC crime;
SELECT * FROM crime ORDER BY year, police;

CREATE TABLE crime(
	idx INT NOT NULL auto_increment PRIMARY KEY,
	year INT NOT NULL,
	police VARCHAR(20) NOT NULL,
	robbery INT,
	theft INT,
	murder INT,
	violence INT
);

SELECT year, police, sum(robbery) AS totRobbery, sum(theft) AS totTheft, sum(murder) AS totMurder, sum(violence) AS totViolence,
	avg(robbery) AS avgRobbery, avg(theft) AS avgTheft, avg(murder) AS avgMurder, avg(violence) AS avgViolence
	FROM crime WHERE year = 2024 AND police LIKE '충북%' ORDER BY year, police;