show tables;
SELECT * FROM board;
SELECT * FROM boardReply;

CREATE TABLE board (
	idx INT NOT NULL auto_increment,	/*번호*/
	mid VARCHAR(20) NOT NULL,	/*올린 사람 아이디*/
	nickName VARCHAR(20) NOT NULL,	/*올린 사람 닉네임*/
	title VARCHAR(100) NOT NULL,	/*제목*/
	content text NOT NULL,	/*내용*/
	hostIP VARCHAR(30) NOT NULL,	/*올린 사람 아이피*/
	openSW CHAR(2) DEFAULT 'OK',	/*공개여부(OK, NO)*/
	readNum INT DEFAULT 0,	/*조회수*/
	good INT DEFAULT 0,	/*좋아요*/
	wDate DATETIME DEFAULT now(),	/*올린 날짜*/
	complaint CHAR(2) DEFAULT 'NO',	/*신고여부(OK, NO)*/
	PRIMARY KEY(idx),
	FOREIGN KEY(mid) REFERENCES friend(mid),
	FOREIGN KEY(nickName) REFERENCES friend(nickName) ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO board VALUES(DEFAULT, 'admin', '관리맨', '게시판 서비스를 시작합니다.', '즐거운 게시판 생활되세요.', '192.168.50.53', DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

DROP TABLE board;

/*날짜처리*/
SELECT *, timestampdiff(hour, wDate, now()) AS new FROM board ORDER BY idx DESC LIMIT 0,10;
SELECT *, timestampdiff(hour, wDate, now()) AS hourDiff, datediff(now(), wDate) AS dateDiff FROM board ORDER BY idx DESC LIMIT 0,10;

/*수정처리*/
UPDATE board SET title = '수정했습니다.', content = '수정했습니다.', hostIP = '127.0.0.1', openSW = 'OK' WHERE idx = 22;

/*이전글, 다음글 처리.*/
SELECT * FROM board WHERE idx < 11 ORDER BY idx DESC; /*이전글*/
SELECT idx, title FROM board WHERE idx < 11 ORDER BY idx DESC limit 1;
SELECT * FROM board WHERE idx > 11 ORDER BY idx; /*다음글*/

/*댓글 테이블 작성*/
CREATE TABLE boardReply (
	idx INT NOT NULL auto_increment,	/*댓글 번호*/
	boardIdx INT NOT NULL, /*댓글 쓴 게시글의 idx*/
	mid VARCHAR(20) NOT NULL,	/*댓글 올린 사람 ID*/
	nickName VARCHAR(20) NOT NULL,	/*댓글 올린 사람 닉네임*/
	content TEXT NOT NULL,	/*댓글 내용*/
	wDate DATETIME DEFAULT now(),	/*댓글 올린 날짜*/
	hostIP VARCHAR(30) NOT NULL,	/*댓글 올린 사람 IP*/
	PRIMARY KEY(idx),
	FOREIGN KEY(boardIdx) REFERENCES board(idx) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(mid) REFERENCES friend(mid),
	FOREIGN KEY(nickName) REFERENCES friend(nickName) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO boardReply VALUES(DEFAULT, 1, 'hkd1234', '홍장군', '댓글 연습입니다.',DEFAULT, '192.168.50.53');
INSERT INTO boardReply VALUES(DEFAULT, 1, 'ohn1234', '하늘', '댓글 연습입니다.',DEFAULT, '192.168.50.53');

SELECT * FROM boardReply WHERE boardIdx = 24;
SELECT *, timestampdiff(hour, wDate, now()) AS hourDiff, datediff(now(), wDate) AS dateDiff, (SELECT count(idx) FROM boardReply WHERE boardIdx = board.idx) AS replyCnt FROM board ORDER BY idx DESC LIMIT 0,10; 