/* 테이블 초기화 및 테스트데이터 입력!! */

/* Drop Tables */

DROP TABLE JAVACODE_BOARD CASCADE CONSTRAINTS;


/* Drop Sequences */

DROP SEQUENCE SEQ_JAVACODE_BOARD;


/* Create Sequences */

CREATE SEQUENCE SEQ_JAVACODE_BOARD;







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




/* 테스트 계정 */
insert into MSM_USER values ('aaa','aaa','이재민','jmlee825@naver.com','010-1234-5678','1986-08-25','서울 성북구', 0);


select boardnum ,title ,to_char(updatedate,'yyyy-mm-dd') updatedate from JAVACODE_BOARD order by boardnum desc;
select boardnum ,title ,to_char(updatedate,'yyyy-mm-dd') updatedate from JAVACODE_BOARD where tag like 'windows' order by boardnum desc; 
select * from JAVACODE_BOARD;
commit;

