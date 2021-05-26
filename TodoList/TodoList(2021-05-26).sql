use myDB;

CREATE TABLE tbl_todolist(
	td_seq bigint auto_increment primary KEY,
    td_sdate varchar(13) not null, -- 추가된 날짜
    td_stime varchar(13) not null, -- 추가된 시간
    td_doit varchar(300) not null,
    
    td_edate varchar(13) default '', -- 완료된 날짜
    td_etime varchar(13) default ''  -- 완료된 시간
);

desc tbl_todolist;

select * from tbl_todolist;