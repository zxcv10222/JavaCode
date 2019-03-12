/* 테이블 초기화 및 테스트데이터 입력!! */

/* Drop Tables */

DROP TABLE JAVACODE_BOARD CASCADE CONSTRAINTS;


/* Drop Sequences */

DROP SEQUENCE SEQ_JAVACODE_BOARD;


/* Create Sequences */

CREATE SEQUENCE SEQ_JAVACODE_BOARD;








CREATE TABLE JAVACODE_BOARD
(
	s_boardnum number NOT NULL,
	s_title varchar2(100) ,
	s_content CLOB,
	s_tag varchar2(100) ,
	s_originalfile varchar2(100) ,
	s_savedfile varchar2(100) ,
	s_insertDate date,
	s_folder varchar2(100),
	s_url varchar2(100),
	s_custid varchar2(20),
	PRIMARY KEY (s_boardNum)
);




/* 테스트 계정 */
insert into MSM_USER values ('aaa','aaa','이재민','jmlee825@naver.com','010-1234-5678','1986-08-25','서울 성북구', 0);


insert into JAVACODE_BOARD values ( 2 ,'ID' ,'test' ,'test2' );
insert into JAVACODE_BOARD values ( 1 ,'title' ,'content' ,'tag','orig','save',sysdate,sysdate,'url','id' );

select * from JAVACODE_BOARD;
commit;

