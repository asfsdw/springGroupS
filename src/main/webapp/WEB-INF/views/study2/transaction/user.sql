SELECT * FROM user;
show tables;
DESC user;
DESC user2;

CREATE TABLE user (
	idx INT NOT NULL auto_increment,
	mid VARCHAR(20) NOT NULL,
	name VARCHAR(20) NOT NULL,
	age INT DEFAULT 20,
	address VARCHAR(15) DEFAULT '서울',
	PRIMARY KEY(idx)
);

INSERT INTO user VALUES(DEFAULT, 'admin', '관리자', 22, '청주');
INSERT INTO user VALUES(DEFAULT, 'hkd1234', '홍길동', DEFAULT, DEFAULT);
INSERT INTO user VALUES(DEFAULT, 'kms1234', '김말숙', 29, '제주');
INSERT INTO user VALUES(DEFAULT, 'ikj1234', '이기자', 42, '광주');
INSERT INTO user VALUES(DEFAULT, 'ohn1234', '오하늘', 32, '청주');

DROP TABLE user2;
CREATE TABLE user2 (
	mid VARCHAR(4) NOT NULL,
	job VARCHAR(10),
	FOREIGN KEY(mid) REFERENCES user(mid)
);