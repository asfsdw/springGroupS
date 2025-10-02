show tables;

CREATE TABLE kakaoAddress (
	idx INT NOT NULL auto_increment PRIMARY KEY,
	address VARCHAR(50) NOT NULL,	/*지점명*/
	latitude DOUBLE NOT NULL, /*위도*/
	longitude DOUBLE NOT NULL /*경도*/
);

SELECT * FROM kakaoAddress;