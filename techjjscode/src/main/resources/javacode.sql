/* 테이블 초기화 및 테스트데이터 입력!! */

/* Drop Tables */

DROP TABLE JAVACODE_BOARD CASCADE CONSTRAINTS;
DROP TABLE JAVACODE_USER CASCADE CONSTRAINTS;
DROP TABLE JAVACODE_BOARD2 CASCADE CONSTRAINTS;

/* Drop Sequences */

DROP SEQUENCE SEQ_JAVACODE_BOARD;
DROP SEQUENCE SEQ_JAVACODE_BOARD2;

/* Create Sequences */

CREATE SEQUENCE SEQ_JAVACODE_BOARD;
CREATE SEQUENCE SEQ_JAVACODE_BOARD2;

CREATE TABLE JAVACODE_USER
(
	id varchar2(20) NOT NULL,
	password varchar2(20) NOT NULL,
	permission varchar2(10)
);


CREATE TABLE JAVACODE_BOARD
(
	boardnum number NOT NULL,
	title varchar2(100) NOT NULL,
	content CLOB NOT NULL,
	tag varchar2(100) ,
	originalfile varchar2(100) ,
	savedfile varchar2(100) ,
	updatedate date DEFAULT SYSDATE,
	category varchar2(100),
	PRIMARY KEY (boardnum)
);
CREATE TABLE JAVACODE_BOARD2
(
	boardnum number NOT NULL,
	title varchar2(100) NOT NULL,
	content CLOB NOT NULL,
	name varchar2(20) ,
	originalfile varchar2(100) ,
	savedfile varchar2(100) ,
	updatedate date DEFAULT SYSDATE,
	boardType varchar2(20),
	PRIMARY KEY (boardnum)
);




select boardnum ,title ,to_char(updatedate,'yyyy-mm-dd') updatedate from JAVACODE_BOARD order by boardnum desc;
select boardnum ,title ,to_char(updatedate,'yyyy-mm-dd') updatedate from JAVACODE_BOARD where tag like 'windows' order by boardnum desc; 
select * from JAVACODE_BOARD;
select distinct category from JAVACODE_BOARD order by category desc;




commit;

