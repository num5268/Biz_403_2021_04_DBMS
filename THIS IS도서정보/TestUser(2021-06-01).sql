-- 여기는 testUser
CREATE TABLE tbl_books(
    bk_isbn	CHAR(13) PRIMARY KEY,
    bk_comp	CHAR(5)	NOT NULL,
    bk_title nVARCHAR2(125)	NOT NULL,
    bk_author CHAR(5) NOT NULL,
                
    bk_date	VARCHAR2(10),
    bk_pages	NUMBER,
    bk_price	NUMBER		
);

CREATE TABLE tbl_company(
	cp_code	CHAR(5)	PRIMARY KEY,
    cp_name	nVARCHAR2(125) NOT NULL,
    cp_ceo	nVARCHAR2(30) NOT NULL,
    cp_tel	VARCHAR2(20) NOT NULL,
    cp_addr	nVARCHAR2(125)		
);

CREATE TABLE tbl_author(
au_code	CHAR(5)	PRIMARY KEY,
au_name	nVARCHAR2(125)	NOT NULL,	
au_tel	VARCHAR2(20) ,
au_addr	nVARCHAR2(125)	
);

-- import된 데이터 확인
select COUNT(*) from tbl_books;
select COUNT(*) from tbl_company;
select COUNT(*) from tbl_author;

-- tbl_books 테이블에서
-- 각 출판사별로 몇권의 도서를 출판했는지 조회
select bk_comp, COUNT(*)
from tbl_books
GROUP BY BK_COMP;

SELECT bk_comp AS 코드
    ,cp_name AS 출판사명
    ,COUNT(*) AS 권수
FROM tbl_books B
    LEFT JOIN tbl_company C
        ON b.bk_comp = c.cp_code
GROUP BY bk_comp, cp_name
order BY bk_comp;

-- tbl_books 테이블에서 
-- 1.도서 가격이 2만원 이상인 도서들의 리스트
select *
from tbl_books
WHERE bk_price >= 20000;
-- 2.도서 가격이 2만원 이상인 도서들의 전체 합계금액
SELECT SUM(bk_price)
FROM tbl_books
WHERE bk_price >= 20000;

-- tbl_books, tbl_company, tbl_author 세개의 table JOIN 하여
-- ISBN, 도서명, 출판사명, 출판사대표, 저자, 저자 연락처 으로
-- 출력되도록 SQL 작성
SELECT bk_isbn AS ISBN,
        bk_title AS 도서명,
        cp_name AS 출판사명,
        cp_ceo AS 출판사대표,
        au_name AS 저자명,
        au_tel AS 저자연락처
FROM tbl_books B
    LEFT JOIN tbl_company C
        ON b.bk_comp = c.cp_code
    LEFT JOIN tbl_author A
        ON b.bk_author = a.au_code;

-- tbl_books, tbl_company, tbl_author 세개의 table JOIN 하여
-- ISBN, 도서명, 출판사명, 출판사대표, 
--      저자, 저자 연락처, 출판일 으로
-- 출력되도록 SQL 작성
-- 출판일이 2018년 데이터만
SELECT bk_isbn AS ISBN,
        bk_title AS 도서명,
        bk_date AS 출판일,
        cp_name AS 출판사명,
        cp_ceo AS 출판사대표,
        au_name AS 저자명,
        au_tel AS 저자연락처
FROM tbl_books B
    LEFT JOIN tbl_company C
        ON b.bk_comp = c.cp_code
    LEFT JOIN tbl_author A
        ON b.bk_author = a.au_code
--where bk_date BETWEEN '2018-01-01' AND '2018-12-31';
where SUBSTR(B.bk_date,0,4) = '2018';
/*
    SUBSTR(문자열 칼럼, 시작위치, 개수)
    MYSQL : LEFT(문자열 칼럼, 앞에서 몇개)
*/
CREATE VIEW view_도서정보 AS (
    SELECT 
            bk_isbn AS ISBN,
            bk_title AS 도서명,
            bk_date AS 출판일,
            cp_name AS 출판사명,
            cp_ceo AS 출판사대표,
            au_name AS 저자명,
            au_tel AS 저자연락처
    FROM tbl_books B
        LEFT JOIN tbl_company C
            ON b.bk_comp = c.cp_code
        LEFT JOIN tbl_author A
            ON b.bk_author = a.au_code
);

/*
자주 사용할 것 같은 SELECT SQL은 view로 등록하면
언제든지 사용이 가능하다

그런데 자주 사용할 것 같지 않은경우
view 생성하면 아무래도 저장공간을 차지하게 된다

이럴때 한개의 SQL(SELECT)를 마치 가상의 table처럼
FROM 절에 부착하여 사용할수 있다
*/
select * from (
SELECT bk_isbn AS ISBN,
        bk_title AS 도서명,
        bk_date AS 출판일,
        cp_name AS 출판사명,
        cp_ceo AS 출판사대표,
        au_name AS 저자명,
        au_tel AS 저자연락처
FROM tbl_books B
    LEFT JOIN tbl_company C
        ON b.bk_comp = c.cp_code
    LEFT JOIN tbl_author A
        ON b.bk_author = a.au_code
)
WHERE SUBSTR(출판일,0,4) = '2018';

-- tbl_books와 tbl_company, tbl_bokks와 tbl_author FK 설정
-- bk_comp와 cp_code         bk_author와 au_code
-- PK 
-- 개체무결성을 보장하기 위한 조건
-- 내가 어떤 데이터를 수정, 삭제할때
-- 수정하거나 사제해서는 안되는 데이터는 유지하면서
-- 반드시 수정하거나 삭제하는 데이터는 수정, 삭제 된다
-- 수정이상, 삭제이상을 방지하는 방법
-- 중복된 데이터는 절대 추가될수 없다 : 삽입 이상을 방지하는 방법

-- FK 참조무결성  
-- 두개이상의 table을 연결하여 view(조회)를 할때
-- 어떤 데이터가 NULL 값으로 보이는 것을 방지하기 위한 조치

-- child(tbl_books):bk_comp         parent(tbl_comp):cp_code
-- 있을수 있고, 추가 가능       <<     있는 코드
-- 있어서는 안되고 추가 불가능  <<     없는 코드
-- 있는 코드                    >>     코드 삭제 불가능
-- 있는 코드                    >>     반드시 있어야 한다.


ALTER TABLE tbl_books -- 누구한테 1문제
ADD CONSTRAINT FK_COMP -- 이름
FOREIGN KEY (bk_comp) -- 누구의 칼럼
REFERENCES tbl_company(cp_code); -- 참조대상

ALTER TABLE tbl_books -- 누구한테
ADD CONSTRAINT FK_AUTHOR -- 이름
FOREIGN KEY (bk_author) -- 누구의 칼럼
REFERENCES tbl_author(au_code); -- 참조대상

-- 리처드 쇼튼의 연락처가 변경해보기
UPDATE tbl_author 
SET au_tel = '010-9898-7777'
where au_name = '리처드 쇼튼';

UPDATE tbl_author 
SET au_tel = '010-9898-6430'
where au_tel = '010-9898-6428';

-- 정보를 수정, 삭제하는 절차
-- 내가 수정, 삭제하고자하는 데잍터가 어떤 상태인지 조회

SELECT
    *
FROM tbl_author
where au_name = '리처드 쇼튼';

-- 수정하고자 하는 리처드 쇼튼의 PK를 확인했다
-- 수정,삭제 하고자 할때는 먼저 대상 데이터의 PK를 확인하고
-- PK를 WHERE 정레 포함하여 UPDATE, DELETE를 수행하자
UPDATE tbl_author -- 1문제
SET au_tel = '010-9898-6430'
WHERE au_code = 'AOOOO6';

-- 실무에서 UPDATE, DELETE를 2개이상 레코드에
-- 동시에 적용하는 것은 매우 위험한 코드이다
-- 꼭 필요한 경우가아니면
-- UPDATE, DELETE는 PK를 기준으로 한개씩 수행하는 것이 좋다