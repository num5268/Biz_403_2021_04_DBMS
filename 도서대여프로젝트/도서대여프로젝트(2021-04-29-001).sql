-- 여기는 도서대여프로젝트

DROP TABLE tbl_books;
CREATE TABLE tbl_books(
    bk_isbn	    CHAR(13)		PRIMARY KEY,
    bk_title	nVARCHAR2(125)	NOT NULL	,
    bk_ccode	CHAR(5)	NOT NULL	,
    bk_acode	CHAR(5)	NOT NULL	,
    bk_date	    VARCHAR2(10)		,
    bk_price	VARCHAR2(10)	,
    bk_pages	NUMBER		
);

iNSERT INTO tbl_books(bk_isbn,bk_title,bk_ccode,bk_acode,
    bk_date,bk_price,bk_pages) VALUES
    ('9791162540770','데스 바이 아마존','12345','54321',
    '2019-04-15','15000','272');
    
SELECT
    *
FROM tbl_books;

CREATE TABLE tbl_company(
    cp_code	    CHAR(5)		PRIMARY KEY,
    cp_title    nVARCHAR2(125)	NOT NULL,
    cp_ceo	    nVARCHAR2(20)	,
    cp_tel	    VARCHAR2(20)	,
    cp_addr	    nVARCHAR2(125)	,
    cp_genre	nVARCHAR2(30)		
);

CREATE TABLE tbl_author(
    au_code	    CHAR(5)		PRIMARY KEY,
    au_name	    nVARCHAR2(50)	NOT NULL,
    au_tel	    VARCHAR2(20)	,
    au_addr	    nVARCHAR2(125)	,
    au_genre	nVARCHAR2(30)		
);

-- 데이터 import후에 확인

SELECT COUNT(*) FROM tbl_books;
SELECT COUNT(*) FROM tbl_company;
SELECT COUNT(*) FROM tbl_author;

-- 3개의 TABLE을 JOIN하여 VIEW 만들기

CREATE VIEW view_도서정보 AS(
SELECT bk_isbn AS ISBN, bk_title AS 도서명,
        c.cp_title AS 출판사명, c.cp_ceo AS 출판사대표,
        a.au_name AS 저자명, a.au_tel AS 저자연락처,
    bk_date AS 출판일, bk_price AS 가격
FROM tbl_books B
    LEFT JOIN tbl_company C
        ON b.bk_ccode = c.cp_code
    LEFT JOIN tbl_author A
        ON b.bk_acode = a.au_code
);

SELECT * FROM tbl_books;

/*
고정문자열 type칼럼 주의사항
char() type의 문자열 칼럼은 실제 저장되는 데이터 type에 따라
주의를 해야 한다

만약 데이터가 숫자 값으로만 되어 있는 경우
00001, 00002 와 같이 입력할 경우 0을 삭제해버리는 경우가 있다

(엑셀에서 import하는)실제 데이터가 날짜 타입일경우
SQL의 날짜형 데이터로 변환한 후 다시 문자열로 변환하여 저장

칼럼을 PK로 설정하지 않는 경우는 가급적 CHAR로 설정하지 말고
VARCHAR2로 설정하는 것이 좋다.

고정문자열 칼럼으로 조회를 할때 아래와 같은 조건을 부여하면
데이터가 조회 되지 않는 현상이 발생할수 있다
WHERE 코드 = '00001'


*/

SELECT
    *
FROM "VIEW_도서정보";

-- 조건을 부여하여 찾기
-- PK칼럼으로 데이터 조회
SELECT * FROM "VIEW_도서정보"
WHERE ISBN = '9791162540695';

-- 도서명이 엘리트 문자열로 시작되는 모든(LIST) 데이터
SELECT * FROM "VIEW_도서정보"
WHERE "도서명" LIKE '엘리트%';

-- 출판사명에 넥 문자열이 포함된 모든 데이터
SELECT
    *
FROM "VIEW_도서정보"
WHERE "출판사명" LIKE '%넥%';

-- 출판일이 2018인 모든 데이터
SELECT * FROM "VIEW_도서정보"
WHERE "출판일" > '02-07-2019' AND "출판일" <= '03-02-2018';

SELECT * FROM "VIEW_도서정보"
WHERE "출판일" BETWEEN '01-01-2018' AND '12-12-2019';

-- SUBSTR() 함수를 사용한 문자열 자르기
-- SUBSTR(문자열데이터, 시작외치, 개수)
-- 타 DB에서는 LEFT(문자열, 몇글자) 함수를 사용
--      RIHGT(문자열, 몇글자) 오른쪽에서 몇글자
SELECT * FROM "VIEW_도서정보"
WHERE SUBSTR(출판일,4,0) = '2018';

-- 출판일 칼럼의 데이터를 앞에서 4글자만 잘라서 보여라
SELECT SUBSTR(출판일,0,4) FROM "VIEW_도서정보";
-- 출판일 칼럼의 데이터를 오른쪽으로 부터 4글자만 잘라서 보여라
SELECT SUBSTR(출판일,4) AS 출판월일 FROM "VIEW_도서정보";

-- 1 OR 1 = 1
DELETE FROM tbl_books 
WHERE bk_isbn = 1 OR 1 = 1; -- TRUE
commit;