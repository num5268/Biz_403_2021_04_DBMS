CREATE TABLE tbl_todolist (
    td_seq NUMBER PRIMARY KEY,
    td_work NVARCHAR2(300) NOT NULL,
    td_date VARCHAR2(15) NOT NULL,
    td_time VARCHAR2(15) NOT NULL,
    td_place VARCHAR2(300) NOT NULL
);
DROP TABLE tbl_todolist;
DROP SEQUENCE seq_todolist;


CREATE SEQUENCE seq_todolist
START WITH 1 INCREMENT BY 1;

INSERT INTO tbl_todolist(td_seq, td_work, td_date, td_time, td_place)
VALUES(SEQ_TODOLIST.nextval,'서블릿 실습','2021-05-24','02:20:54','404호 강의실');