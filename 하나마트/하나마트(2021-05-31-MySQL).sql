-- 하나마트
-- database생성
CREATE DATABASE nhDB;
-- 사용할 DataBase에 연결하기
use myDB;
DROP TABLE TBL_IOLIST;
use nhDB;

-- Table 생성
CREATE TABLE tbl_iolist(
	io_seq	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
	io_date	VARCHAR(10)	NOT NULL	,
    io_time	VARCHAR(10)	NOT NULL	,
	io_pname	VARCHAR(50)	NOT NULL,	
	io_dname	VARCHAR(50)	NOT NULL,	
	io_dceo	VARCHAR(20)	NOT NULL	,
	io_inout	VARCHAR(5)	NOT NULL,	
	io_qty	INT	NOT NULL	,
	io_price	INT	NOT NULL,	
	io_total	INT		
);

DESC TBL_IOLIST;
select * FROM tbl_iolist;
select count(*) from tbl_iolist;

-- 매입과 매출 합계
-- io_inout 칼럼 1이면 매입, 2이면 매출
-- 수량 * 단가를 곱하여 합계계산
select (io_qty * io_price) 합계 
from tbl_iolist;

-- 통계함수
-- 매입합계, 통계
select (io_qty * io_price) 합계
from tbl_iolist
group by io_inout;

select io_inout, 
	SUM(io_qty * io_price) 합계
from tbl_iolist
group by io_inout;

-- Oracle DECODE(조건, true, false)
select case when io_inout = '1'then '매입'
			when io_inout = '2'then '매출'
			end AS '구분',
		sum(io_qty * io_price) AS '합계'
from tbl_iolist
group by io_inout;

-- if(조건, true, false) : MySQL 전용함수
select if(io_inout = '1', '매입', '매출') AS 구분,
		sum(io_qty * io_price) AS 합계
from tbl_iolist
group by io_inout;

-- 매입합계와 매출합계를 PIVOT형식으로 조회
select 
		SUM(if(io_inout = '1', io_qty * io_price, 0)) AS매입,
		SUM(if(io_inout = '2', io_qty * io_price, 0)) AS매출
from tbl_iolist;

-- 일자별로 매입 매출 합계
select io_date AS 일자,
		SUM(if(io_inout = '1', io_qty * io_price, 0)) AS 매입,
		SUM(if(io_inout = '2', io_qty * io_price, 0)) AS 매출
from tbl_iolist
group by io_date
order by io_date;

-- 각 거래처별로 매입 매출 합계
-- PIVOT 방식으로 조회하기
select io_dname AS 거래처,
		SUM(if(io_inout = '1', io_qty * io_price, 0)) AS 매입,
		SUM(if(io_inout = '2', io_qty * io_price, 0)) AS 매출
from tbl_iolist
group by io_dname
order by io_dname;

-- 표준 SQL을 사용하여 거래처별로 매입 매출 합계
select io_dname,
	sum(case when io_inout = '1' then io_qty * io_price else 0 END) AS 매입,
    sum(case when io_inout = '2' then io_qty * io_price else 0 END) AS 매출
from tbl_iolist
group by io_dname;

-- 2020년 4월의 매입매출 전체리스트 조회
-- 2020년 4월의 거래처별로 매입매출 합계
select *
from tbl_iolist
where io_date between '2020-04-01' AND '2020-04-30';

-- left, mid right
-- 문자열 칼럼의 데이터를 일부만 추출할때
-- LEFT(칼럼, 개수) : 왼쪽부터 문자열 추출
-- MID(칼럼, 위치, 개수) : 중간문자열 추출
-- Oracle SUBSTR(칼럼, 위치, 개수)
-- RIGHT(칼럼, 개수) : 오른쪽부터 문자열 추출

select * from tbl_iolist
where left(io_date,7) = '2020-04';

select left('대한민국',2);
select left('Republic of',2);
-- MySQL은 언어와 관계없이 글자수로 인식
select left('대한민국',2), left('Korea',2);
select MID('대한민국',2,2), MID('Korea',2,2);
select right('대한민국',2), right('Korea',2);

select io_date,
		SUM(if(io_inout = '1', io_qty * io_price, 0)) AS 매입,
		SUM(if(io_inout = '2', io_qty * io_price, 0)) AS 매출
from tbl_iolist
where io_date between '2020-04-01' AND '2020-04-30'
group by io_date
order by io_date;

-- 2021-06-01 시험
-- 데이터베이스 구현 서술형 select 위주 
-- table 생성하기 update명령 등


