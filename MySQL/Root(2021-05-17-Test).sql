-- 현재 존재하는 DataBase 를 보여달라
SHOW databases;

-- 지금부터 MYSQL DataBase 를 사용하겠다
-- 사용자와 연관 없이 기본적으로 사용할 
-- DataBase를 지정하여 사용할 준비 
USE MYSQL;

-- 현재 접속한 DataBase(mysql)에 있는 
-- 모든 table을 보여달라
SHOW tables;

-- myDB라는 Database( 데이터 저장소 ) 생성
CREATE database myDB;

-- 생성된 저장소 확인 
SHOW DATABASES;

-- MySQL 에서는 사용할 DB를 open 하기
-- USE 명령을 사용하여 DB open
USE MyDB;

-- 현재 DB(MyDB)에 있는 모든 Table을 보여달라
show tables;

-- MySQL 에서는 일련번호와 관련된 칼럼에 
-- AUTO_INCREMENT 옵션을 설정하면
-- INSERT 할때 값을 지정하지 않아도
-- 자동으로 ID, SEQ 값을 생성하여
-- 칼럼에 추가하여 준다.
create TABLE tbl_test(
	id bigint primary key 
			auto_increment,
    name varchar(50) not null,
    tel varchar(20),
    addr varchar(125)
);
show tables;
DESC tbl_test;
insert into tbl_test(name, tel, addr)
value('홍길동','010-111-1111','서울시');

select * from tbl_test;

-- MySQL은 Linux 
create TABLE tbl_books(
bk_isbn	CHAR(13)		PRIMARY KEY,
bk_comp VARCHAR(15) NOT NULL,
bk_title	VARCHAR(125)	NOT NULL	,
bk_author	VARCHAR(50)	NOT NULL	,
bk_trnans	VARCHAR(20)	NOT NULL	,
bk_date	VARCHAR(10)		,
bk_pages	INT		,
bk_price	INT		
);

show tables;

desc tbl_books;
drop table tbl_books;
select * from tbl_books;

SELECT count(*)
FROM tbl_books;

-- 도서 가격이 25000원 이상인 데이터 
select *
from tbl_books
WHERE bk_price >= 20000;

-- 도서 가격이 만원 이상 2만원 이하
select * 
from tbl_books
WHERE bk_price between 10000 AND 20000;

select * 
from tbl_books
WHERE bk_price >= 10000 
		AND bk_price <=20000;
        
-- 도서명에 '왕' 문자열이 있는 데이터 
select * 
from tbl_books
WHERE bk_title LIKE '%왕%';

-- Java 등 코딩에서 중간 문자열 검색
-- Oracle '%' || '왕' || '%'
-- MYSQL concat('%','왕','%')
select * 
FROM tbl_books
WHERE bk_title 
LIKE concat('%','왕','%'); -- '%' || '왕' || '%'

select left(bk_date,4)
from tbl_books;

-- 방행일이 2018년인 도서들
select *
from tbl_books
WHERE left(bk_date,4) = '2018';

-- 전체 데이터를 날짜 순으로 보여라
select *
from tbl_books
order by bk_date;

-- 도서명을 역순으로 정렬하여 보여라
select * 
FROM tbl_books
ORDER BY bk_title DESC;

-- 처음 3개의 데이터만 보여라
select * 
from tbl_books
LIMIT 3;

-- 4(0부터 시작하여 3번)번째 데이터 부터 2개
-- 게시판 등 코딩에서 pagination을 
-- 구현할때 사용하는 방법
select * 
from tbl_books
LIMIT 3,2;

CREATE database bookRent;

USE BookRent;

create table tbl_books(
bk_isbn	CHAR(13)		PRIMARY KEY,
bk_title	VARCHAR(125)	NOT NULL,	
bk_ccode	CHAR(5)	NOT NULL	,
bk_acode	CHAR(5)	NOT NULL	,
bk_date	VARCHAR(20)		,
bk_price	INT		,
bk_pages	INT		
);
drop table tbl_books;
create table tbl_company(
cp_code	CHAR(5)		PRIMARY KEY,
cp_title	VARCHAR(125)	NOT NULL	,
cp_ceo	VARCHAR(20)		,
cp_tel	VARCHAR(20)		,
cp_addr	VARCHAR(125)	,	
cp_genre	VARCHAR(10)		

);
create table tbl_author(
au_code	CHAR(5)		PRIMARY KEY,
au_name	VARCHAR(50)	NOT NULL	,
au_tel	VARCHAR(20)		,
au_addr	VARCHAR(125)	,	
au_genre	VARCHAR(30)		

);
create table tbl_buyer(
bu_code	CHAR(5)		PRIMARY KEY,
bu_name	VARCHAR(50)	NOT NULL	,
bu_birth	INT	NOT NULL	,
bu_tel	VARCHAR(20)		,
bu_addr	VARCHAR(125)		

);
CREATE TABLE tbl_book_rent(
br_seq	INT		PRIMARY KEY 
		auto_increment,
br_sdate	VARCHAR(10)	NOT NULL	,
br_isbn	CHAR(13)	NOT NULL	,
br_bcode	CHAR(5)	NOT NULL	,
br_edate	VARCHAR(10)		,
br_price	INT		
);