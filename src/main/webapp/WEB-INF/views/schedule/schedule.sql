SELECT * FROM schedule;

CREATE TABLE schedule (
	idx INT NOT NULL auto_increment,	/*일정관리 고유번호*/
	mid VARCHAR(20) NOT NULL,					/*사용자 아이디*/
	sDate DATETIME NOT NULL,					/*일정등록 일자*/
	part VARCHAR(20) NOT NULL,				/*일정 분류*/
	content TEXT NOT NULL,						/*일정 내용*/
	PRIMARY KEY(idx),
	FOREIGN KEY(mid) REFERENCES member(mid) ON DELETE CASCADE
);

INSERT INTO schedule VALUES(DEFAULT, 'ohn1234','2025-09-14', '학습', '프로젝트 설계서 제안.');
INSERT INTO schedule VALUES(DEFAULT, 'ohn1234','2025-09-24', '학습', 'DB설계서 완성하기');
INSERT INTO schedule VALUES(DEFAULT, 'ohn1234','2025-09-24', '학습', '리뷰 포인트 숙제');
INSERT INTO schedule VALUES(DEFAULT, 'ohn1234','2025-09-24', '학습', '스케쥴에 관리자 공지 모두 보이기');
INSERT INTO schedule VALUES(DEFAULT, 'ohn1234','2025-09-26', '학습', '프로젝트 계획서 제출');
INSERT INTO schedule VALUES(DEFAULT, 'ohn1234','2025-09-29', '학습', '프로젝트 시작~~');
INSERT INTO schedule VALUES(DEFAULT, 'admin','2025-09-29', '공지', '시스템 점검일');
INSERT INTO schedule VALUES(DEFAULT, 'ohn1234','2025-09-29', '업무', '업무일지 정리');
INSERT INTO schedule VALUES(DEFAULT, 'ohn1234','2025-09-30', '학습', '프로젝트 중간점검');
INSERT INTO schedule VALUES(DEFAULT, 'ohn1234','2025-10-06', '학습', '프로젝트 발표, 장소:그린컴퓨터 402호, 시간:10시~18시');
INSERT INTO schedule VALUES(DEFAULT, 'ohn1234','2025-12-26', '학습', '그린컴퓨터 수료식');

SELECT * FROM schedule WHERE mid = 'ohn1234' ORDER BY sDate;
SELECT * FROM schedule WHERE mid = 'ohn1234' AND sDate = '2025-09' ORDER BY sDate; /*에러*/
SELECT * FROM schedule WHERE mid = 'ohn1234' AND sDate = '2025-09-24' ORDER BY sDate;
SELECT * FROM schedule WHERE mid = 'ohn1234' AND sDate = date_format('2025-09','%Y-%m') ORDER BY sDate; /*에러는 아님*/
SELECT * FROM schedule WHERE mid = 'ohn1234' AND substring(sDate,1,7) = '2025-09' ORDER BY sDate;
SELECT * FROM schedule WHERE mid = 'ohn1234' AND substring(sDate,2,6) = '025-09' ORDER BY sDate;	/*sql의 substring은 시작 인덱스(1~), 꺼낼 갯수이다.*/
SELECT * FROM schedule WHERE mid = 'ohn1234' AND substring(sDate,1,7) = '2025-09' GROUP BY part ORDER BY sDate;
SELECT *, count(part) AS partCnt FROM schedule WHERE mid = 'ohn1234' AND substring(sDate,1,7) = '2025-09' GROUP BY part ORDER BY sDate;
SELECT *, count(part) AS partCnt FROM schedule WHERE mid = 'ohn1234' AND substring(sDate,1,7) = '2025-09' GROUP BY sDate, part ORDER BY sDate;
select * from schedule where mid='ohn1234' and date_format('2025-09-24', '%Y-%m-%d')='2025-09-24';
