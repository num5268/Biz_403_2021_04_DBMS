-- gbUser 접속 화면
CREATE DATABASE GuestBook;
use GuestBook;
show databases;

drop table tbl_guest_book;
CREATE TABLE tbl_guest_book(
	gb_seq  BIGINT	AUTO_INCREMENT	PRIMARY KEY,
	gb_date	VARCHAR(10)	NOT NULL,
	gb_time	VARCHAR(10)	NOT NULL,
	gb_writer	VARCHAR(30)	NOT NULL,	
	gb_email	VARCHAR(30)	NOT NULL,	
	gb_password	VARCHAR(125)	NOT NULL,
	gb_content	VARCHAR(2000)	NOT NULL	
);

INSERT INTO 
tbl_guest_book(gb_date, gb_time, gb_writer, gb_email
	, gb_password, gb_content)
values('2021-05-18','10:20:00','num5268','num5268@gmail.com'
	, '12345','내일은 석가탄신일');
    
select * from tbl_guest_book;
SELECT COUNT(*) FROM tbl_guest_book;
SELECT * FROM tbl_guest_book
WHERE gb_date = '2021-05-18';

SELECT * FROM tbl_guest_book
ORDER BY gb_seq desc;

-- 날짜와 시간기준으로 최근글이 제일 먼저 보이도록
select * from tbl_guest_book
order by gb_date desc, gb_time desc;

-- update, delete를 수행할때는
-- 2개 이상의 레코드에 영향이 미치는 명령은
-- 매우 신중하게 실행해야 한다
-- 가장 좋은 방법은 변경, 삭제하고자 하는 데이터가
-- 여러개 있더라도 가급적 PK를 기준으로 
-- 1개씩 처리하는 것이 좋다
update tbl_guest_book
set gb_time = '10:36:00'
where gb_seq = 3;

select * from tbl_guest_book;

delete from tbl_guest_book
where gb_seq = '1';

rollback;

select 30 * 40;

-- MySQL 고유함수로 문자열을 연결할때
select concat('대한','민국','만세');

select * from tbl_guest_book
where gb_content like '%내일%';

select * from tbl_guest_book
where gb_content like concat('%','내일','%');

-- Oracle의 decode()와 유사한 형태의 조건연산
-- gb_seq 의 값이 짝수이면 짝수로 표시
-- 아니면 홀수로 표시
select if( MOD(gb_seq, 2) = 0,'짝수','홀수')
from tbl_guest_book;

select floor(rand() * 100) ; 
select
	if(mod(floor(rand() * 100),2)=0,'짝수','홀수');
    
select count(*) from tbl_guest_book;
select * from tbl_guest_book;

select * from tbl_guest_book
where gb_writer = '지눌';

select * from tbl_guest_book
order by gb_date desc, gb_time desc;

select * from tbl_guest_book
where gb_content
like '%국가%'
order by gb_date desc, gb_time desc;

create view view_방명록 AS(
select gb_seq AS '일련번호',
		gb_date AS '등록일자',
        gb_time AS '등록시간',
        gb_writer AS '등록자이름',
        gb_email AS '등록email',
        gb_password AS '비밀번호',
        gb_content AS '내용'
from tbl_guest_book
);

select * from view_방명록;
