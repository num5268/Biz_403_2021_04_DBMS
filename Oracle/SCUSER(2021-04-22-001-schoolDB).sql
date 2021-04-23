CREATE TABLE tbl_student(
    st_num CHAR(5),
    st_name NVARCHAR2(20),
    st_dept NVARCHAR2(10),
    st_grade VARCHAR2(5),
    st_tel VARCHAR2(20),
    st_addr NVARCHAR2(125)
);

INSERT INTO tbl_student(st_num,st_name,st_dept,st_grade)
VALUES ('00001', '홍길동', '국어국문','3' );

SELECT
    *
FROM tbl_student;

INSERT INTO tbl_student(st_num, st_dept, st_grade)
VALUES('00001', '컴퓨터공학', '2');

-- 위에서 생성한 TBL_STUDENT
-- 이름데이터가 없어도 데이터가 정상적으로 추가가 되어버린디ㅏ
-- 같은 학번의 데이터가 이미 추가되어 있어도 또다ㅣ시 
DROP TABLE tbl_student;

-- 1. 학생의 이름은 데이터가 반드시 있어야만 한다 
--     st_name(학생이름) 칼럼은 NOT NULL 이어야 한다
-- 2. 학번은 절대 중복되면 안된다.
--          tbl_student 테이블의 모든 데이터의 학번은 유일해야한다
CREATE TABLE tbl_student(
    st_num CHAR(5) UNIQUE NOT NULL ,
    st_name NVARCHAR2(20) not null ,
    st_dept NVARCHAR2(10),
    st_grade VARCHAR2(5), -- 숫자값을 입력, 숫자갑을 문자형으로 인식
    st_tel VARCHAR2(20), -- 000-0000-0000
    st_addr NVARCHAR2(125) 
);

-- 학생이름 데이터가 없으므로 INSERT 불가
INSERT INTO tbl_student(st_num, st_dept)
VALUES ('00001','컴퓨터공학');

-- 학생이름 데이터를 같이 포함하여 INSERT를 수행하자
-- 칼럼보다 데이터 개수가 적어서 INSERT 불가
INSERT INTO tbl_student(st_num, st_dept,st_name)
VALUES ('00001','컴퓨터공학','홍길동');

-- 아예 학번 칼럼을 제거하고 INSERT를 수행
-- 학번컬럼이 TOY NULL로 되어있어서 INSERT 불가

-- st_num 칼럼이 UNIQUE 인데 이미 존재하는 00001 학번으로
-- 데이터를 추가하려고 하니 문제가 있어서 INSERT불가
-- TABLE의 제약조건을 설정할때
--      UNIQUE는 매우 신중하게 선택해야 한다. 
INSERT INTO tbl_student( st_dept, st_name, st_num )
VALUES ('사회과학','이몽룡','00001');

INSERT INTO tbl_student( st_dept, st_name, st_num )
VALUES ('사회과학','이몽룡','00100');

INSERT INTO tbl_student( st_dept, st_name, st_num )
VALUES ('법학과','성춘향','00002');

SELECT
    *
FROM tbl_student;

-- 기본키 칼럼(PRIMARY KEY)
-- 데이터를 조회(SELECT)할때 st_num 칼럼을 기준으로 조회를 하면
-- 반드시 원하는 데이터 1개만 보여지는 조건을 만족하게하는 칼럼
-- 제약조건이 반드시 UNIQUE 하면서 NOT NULL 이어햐 한다.
-- 기본키는 제약조건에 UNIQUE 와 NOT NULL을 같이 설정해야 하는데
-- DBMS에서는 기본키 제약조건을 설정하는 키워드가 별도로 있다 

-- PRIMARY KEY : UNIQUE + NOT NULL + 기타 조건 
--              + INDEX(검색을 빨리하기위한 설정) 자동생성
-- 매우 강력한, 가장 우선순위가 높은 제약조건이다
DROP TABLE tbl_student;
CREATE TABLE tbl_student(
    st_num CHAR(5) PRIMARY KEY ,
    st_name NVARCHAR2(20) not null ,
    st_dept NVARCHAR2(10),
    st_grade VARCHAR2(5), -- 숫자값을 입력, 숫자값을 문자형으로 인식
    st_tel VARCHAR2(20), -- 000-0000-0000
    st_addr NVARCHAR2(125) 
);
-- TABLE의 구조를 보여달라
DESC tbl_student;

INSERT INTO tbl_student( st_dept, st_name, st_num )
VALUES ('법학과','성춘향','00100');
INSERT INTO tbl_student( st_dept, st_name, st_num )
VALUES ('사회과학','이몽룡','00001');
INSERT INTO tbl_student( st_dept, st_name, st_num )
VALUES ('컴퓨터공학','홍길동','00002');

SELECT
    *
FROM tbl_student;

-- PK로 설정된 칼럼에 조건을 부여하여 데이터 조회하기
SELECT
    *
FROM tbl_student
WHERE st_num = '00001';

SELECT
    *
FROM tbl_student;

