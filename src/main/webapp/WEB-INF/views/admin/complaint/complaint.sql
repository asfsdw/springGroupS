SHOW TABLES;
DESC complaint;
DROP TABLE complaint;
SELECT * FROM complaint;

CREATE TABLE complaint (
	idx INT NOT NULL auto_increment,
	part VARCHAR(15) NOT NULL,
	partIdx INT NOT NULL,
	cpMid VARCHAR(30),
	cpContent TEXT NOT NULL,
	cpDate DATETIME DEFAULT now(),
	progress VARCHAR(10) DEFAULT '신고접수',	/*진행상황*/
	PRIMARY KEY(idx),
	FOREIGN KEY(cpMid) REFERENCES member(mid) ON UPDATE CASCADE ON DELETE CASCADE
);

SELECT c.*, b.title AS title, b.nickName AS name, b.mid AS mid, b.content AS content, b.complaint AS complaint FROM complaint c LEFT JOIN board b ON c.partIdx = b.idx ORDER BY idx;