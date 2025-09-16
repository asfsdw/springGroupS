show tables;
DESC member;
SELECT * from member;

DROP TABLE member;

CREATE TABLE member(
	idx int not null auto_increment,	/*회원 고유번호*/
	mid varchar(30) not null,	/*회원 아이디 (중복검사: AJAX, REST AIP)*/
	pwd varchar(100) not null,	/*회원 비밀번호(Spring Security Password 암호화)*/
	nickName varchar(20) not null,	/*회원 닉네임(중복불가 무조건 공개, 중복검사: AJAX, REST AIP)*/
	name varchar(20) not null,	/*회원 이름*/
	email varchar(60) not null, /*회원 이메일(아이디, 비밀번호 분실 시, 이메일 인증처리) 입력시 이메일 형식 필수체크*/
	gender char(2) not null default '남자', /*회원 성별(라디오버튼)*/
	birthday datetime default now(), /*회원 생일(type=date형식)*/
	tel varchar(15), /*회원 전화번호(콤보상자. 010-1234-5678)*/
	address varchar(100),	/*회원 주소(다음 API활용: 우편번호/주소/상세주소/참조주소)*/
	homePage varchar(60),	/*회원 홈페이지*/
	job varchar(20),	/*회원 직업(콤보박스)*/
	hobby varchar(100),	/*회원 취미(체크박스. 취미가 두 개 이상이면 구분자 '/' 처리*/
	photo varchar(100) default 'noimage.jpg', /*회원 프로필 이미지(회원가입 시, 프로필 이미지 넣지 않으면 noimage.jpg*/
	content text,	/*회원 자기소개*/
	userInfor char(3) default '공개', /*회원 정보 공개여부*/
	userDel char(2) default 'NO',	/*회원 탈퇴 대기여부*/
	point int default 100,	/*회원 포인트(가입 포인트 100포인트, 1회 방문시 10포인트, 1일 최대 5회까지 허용, 물건 구매시 100원당 1포인트)*/
	level int default 3,	/*회원 등급(0관리자, 1우수회원, 2정회원, 3준회원, 99비회원, 999탈퇴대기회원)*/
	visitCnt int default 0,	/*회원 총 반문 횟수*/
	todayCnt int default 0,	/*회원 오늘 방문 횟수*/
	startDate datetime default now(), /*회원 가입일*/
	lastDate datetime default now(),	/*회원 마지막 접속일/탈퇴일*/
	primary key(idx),
	unique(mid)
);

INSERT INTO member VALUES(DEFAULT,'admin','1234','관리맨','관리자',DEFAULT,DEFAULT,'010-0000-0000','서울','admin@naver.com','https://','관리자','관리',DEFAULT,'관리자입니다.',DEFAULT,DEFAULT,DEFAULT,0,DEFAULT,DEFAULT,DEFAULT,DEFAULT);
UPDATE member SET level = level = 0 WHERE mid = 'admin';
SELECT *, (SELECT count(idx) FROM member WHERE concat(year(startDate),'-',month(startDate),'-',day(startDate)) >= concat(year(now()),'-',month(now()),'-',day(now())-7)) AS newCount FROM member;

SELECT *, 
			(SELECT count(*) FROM member 
			WHERE startDate >= date_add(now(), interval -7 day)) AS newCount, 
			(SELECT count(*) FROM member 
			WHERE level = 999) AS cancelMember FROM member
			WHERE startDate >= date_add(now(), interval -7 day);
			
SELECT *, to_days(now()) - to_days(lastDate) AS cancelDate FROM member ORDER BY mid;

SELECT *, concat(year(startDate),'-',month(startDate),'-',day(startDate)) AS 가입일, concat(year(now()),'-',month(now()),'-',day(now())-7) AS 오늘날짜 FROM member;