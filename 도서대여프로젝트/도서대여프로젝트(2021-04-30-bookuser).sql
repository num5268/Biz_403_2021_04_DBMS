--bookuser 접속

CREATE TABLE tbl_books(
bk_isbn	CHAR(13)		PRIMARY KEY,
bk_title	nVARCHAR2(125)	NOT NULL,	
bk_ccode	CHAR(5)	NOT NULL	,
bk_acode	CHAR(5)	NOT NULL	,
bk_date	    VARCHAR2(10)		,
bk_price	NUMBER		,
bk_pages	NUMBER		
);
DROP TABLE tbl_books;
DROP TABLE tbl_comp;
DROP TABLE tbl_author;

CREATE TABLE tbl_comp(
cp_code	CHAR(5)		PRIMARY KEY,
cp_title	nVARCHAR2(125)	NOT NULL	,
cp_ceo	nVARCHAR2(20)		,
cp_tel	VARCHAR2(20)		,
cp_addr	nVARCHAR2(125)		,
cp_genre	nVARCHAR2(30)		
);

CREATE TABLE tbl_author(
au_code	CHAR(5)		PRIMARY KEY,
au_name	nVARCHAR2(50)	NOT NULL,	
au_tel	VARCHAR2(20)		,
au_addr	nVARCHAR2(125)		,
au_genre	nVARCHAR2(30)		
);

-- 3개의 테이블을 join
DROP VIEW VIEW_도서정보;

CREATE VIEW VIEW_도서정보 AS(
SELECT B.bk_isbn AS isbn,
        b.bk_title AS 도서명,
        c.cp_title AS 출판사명,
        c.cp_ceo AS 출판사대표,
        a.au_name AS 저자명,
        a.au_tel AS 저자연락처,
        b.bk_date AS 출판일,
        b.bk_price AS 가격,
        b.bk_pages AS 페이지
FROM tbl_books B
    LEFT JOIN tbl_comp C
        ON B.bk_ccode = c.cp_code
    LEFT JOIN tbl_author A
        ON b.bk_acode = a.au_code
);
-- 단독 TABLE로 생성된 VIEW는 INSERT, UPDATE, DELETE를
-- 실행할수 있다
-- TABLE JOIN한 결과로 생성된 VIEW는 읽기 전용
--      INSERT, UPDATE, DELETE를 실행할수없다

SELECT
    *
FROM "VIEW_도서정보";

DELETE FROM tbl_books;
        
