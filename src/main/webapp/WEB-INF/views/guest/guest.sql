show tables;
DESC guest;
SELECT * FROM guest;
SELECT * FROM guest LIMIT 0,5;
SELECT * FROM guest LIMIT 5,5;

DROP TABLE guest;
SELECT COUNT(*) AS cnt FROM guest;

CREATE TABLE guest (
	idx				INT NOT NULL auto_increment PRIMARY KEY,	/*방명록 고유번호*/
	name			VARCHAR(20)	NOT NULL,											/*방명록 작성자 성명*/
	content		TEXT				NOT NULL,											/*방명록 글 내용*/
	email			VARCHAR(50),															/*메일주소*/
	homePage	VARCHAR(50),															/*홈페이지(블로그) 주소*/
	vDate			DATETIME		DEFAULT now(),								/*방문일자*/
	hostIP		VARCHAR(30)																/*방문자의 접속 IP*/
);

INSERT INTO guest VALUES (DEFAULT, '관리자', '방명록 서비스를 시작합니다.', 'solra@daum.net', 'github.com/asfsdw', DEFAULT, '192.168.50.53');

SELECT * FROM guest WHERE concat(year(vDate),'-',month(vDate),'-',day(vDate)) >= concat(year(now()),'-',month(now()),'-',day(now()-7));
SELECT *, (SELECT count(*) FROM guest WHERE concat(year(vDate),'-',month(vDate),'-',day(vDate)) >= concat(year(now()),'-',month(now()),'-',day(now()-7))) AS newCount FROM guest WHERE concat(year(vDate),'-',month(vDate),'-',day(vDate)) >= concat(year(now()),'-',month(now()),'-',day(now()-7)) LIMIT 1;