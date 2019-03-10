/* 테이블 초기화 및 테스트데이터 입력!! */

/* Drop Tables */

DROP TABLE JAVACODE_BOARD CASCADE CONSTRAINTS;
DROP TABLE JAVACODE_USER CASCADE CONSTRAINTS;

/* Drop Sequences */

DROP SEQUENCE SEQ_JAVACODE_BOARD;


/* Create Sequences */

CREATE SEQUENCE SEQ_JAVACODE_BOARD;





/* Create Tables */

CREATE TABLE JAVACODE_USER
(
	u_id varchar2(20) NOT NULL,
	u_pwd varchar2(20) NOT NULL,
	u_name varchar2(20) NOT NULL,
	u_email varchar2(40) NOT NULL,
	u_phone varchar2(30),
	u_birth varchar2(50),
	u_address varchar2(70),
	PRIMARY KEY (u_id)
);



CREATE TABLE JAVACODE_BOARD
(
	s_boardNum number NOT NULL,
	s_title varchar2(50) ,
	s_content varchar2(2000),
	s_tag varchar2(100) ,
	s_insertDate date,
	s_updateDate date,
	s_custid varchar2(20) references MSM_USER on delete cascade ,
	PRIMARY KEY (s_boardNum)
);



/* 테스트 계정 */
