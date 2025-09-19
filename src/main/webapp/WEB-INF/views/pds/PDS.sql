show tables;
select * from pds;

CREATE TABLE pds (
	idx INT NOT NULL auto_increment,	/*자료글 고유번호*/
	mid VARCHAR(20) NOT NULL,					/*자료 올린이 아이디*/
	nickName VARCHAR(20) NOT NULL,		/*자료 올린이 닉네임*/
	fName VARCHAR(200) NOT NULL,			/*업로드시 파일 이름*/
	fsName VARCHAR(200) NOT NULL,			/*서버 저장시 파일 이름*/
	fSize INT NOT NULL,								/*파일사이즈*/
	part VARCHAR(20) NOT NULL,				/*파일 분류(학습/여행/음식/_/기타)*/
	title VARCHAR(100) NOT NULL,			/*파일의 간단 설명*/
	content text,											/*파일의 상세 설명*/
	openSW CHAR(3) DEFAULT '공개',			/*파일 공개여부*/
	pwd VARCHAR(100),									/*비밀번호(SHA256)*/
	hostIP VARCHAR(30) NOT NULL,			/*업로드한 사람의 IP*/
	downNum INT DEFAULT 0,						/*다운로드 수*/
	fDate DATETIME DEFAULT now(),			/*파일 업로드한 날짜*/
	PRIMARY KEY(idx),
	FOREIGN KEY(mid) REFERENCES friend(mid) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(nickName) REFERENCES friend(nickName) ON UPDATE CASCADE ON DELETE NO ACTION
);

drop table pds;
SELECT *, timestampdiff(hour, fDate, now()) AS hourDiff, datediff(now(), fDate) AS dateDiff FROM pds ORDER BY idx DESC limit 1,10;
SELECT *, timestampdiff(hour, fDate, now()) AS hourDiff, datediff(now(), fDate) AS dateDiff WHERE part = '여행' FROM pds ORDER BY idx DESC;
alter table pds modify column fSize varchar(200);