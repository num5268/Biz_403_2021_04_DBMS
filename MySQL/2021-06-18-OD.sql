use mydb;
select * from tbl_books;
select * from tbl_author;
select * from tbl_company;
select * from tbl_member;
drop table tbl_member;

create table tbl_member (
	username varchar(20) primary key,
    password varchar(20),
	name varchar(20),
	nname varchar(20),
	email varchar(50),
	
	tel varchar(20),
	addr varchar(125)
);

create database myst;
use myst;
drop table tbl_student;
create table tbl_student(
st_num	CHAR(8)	,
st_name	VARCHAR(20)	NOT NULL,	
st_dept	VARCHAR(20)	NOT NULL,	
st_grade int	NOT NULL,	
st_tel	VARCHAR(15)	NOT NULL,	
st_addr	VARCHAR(125),
primary key(st_num)		
);
create table tbl_score(
sc_seq	CHAR(8)	primary key,
sc_stnum	CHAR(8)	NOT NULL	,
sc_subject	VARCHAR(20)	NOT NULL,	
sc_score	INT	NOT NULL	
);
drop table tbl_score;
alter table tbl_score add foreign key(sc_stnum) references tbl_student(st_num);
show databases;
show tables;
select * from tbl_student;
select * from tbl_score;
insert into tbl_student(st_num, st_name, st_dept, st_grade, st_tel, st_addr)
VALUES("20210001","홍길동","컴퓨터공학","2","010-2202-1353","서울시");