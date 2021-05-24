create database todoList;
use todoList;
show databases;

CREATE TABLE tbl_todolist (
    td_seq BIGINT auto_increment PRIMARY KEY,
    td_work VARCHAR(300) NOT NULL,
    td_date VARCHAR(15) NOT NULL,
    td_place VARCHAR(300) NOT NULL
);

insert into tbl_todolist(td_work, td_date, td_place)
values('서블릿 실습','2021-05-24','403호 강의실');

insert into tbl_todolist(td_work, td_date, td_place)
values('데이터베이스 실습','2021-05-24','404호 강의실');
SELECT * FROM tbl_todolist;