CREATE TABLE tbl_foods(
    fd_fcode	CHAR(7)		PRIMARY KEY,
    fd_fname	nVARCHAR2(50)	NOT NULL,	
    fd_num	NUMBER	NOT NULL	,
    fd_mcode	CHAR(6)	NOT NULL,	
    fd_clcode	CHAR(4)	NOT NULL,	
    fd_serv	NUMBER	NOT NULL	,
    fd_capa	NUMBER	NOT NULL	,
    fd_ener	NUMBER	NOT NULL	,
    fd_prot	NUMBER	NOT NULL	,
    fd_fat	NUMBER	NOT NULL	,
    fd_carb	NUMBER	NOT NULL	,
    fd_sug	NUMBER	NOT NULL	
);

CREATE TABLE tbl_company(
    cp_ccode	CHAR(6)		PRIMARY KEY,
    cp_cname	VARCHAR2(100)	NOT NULL	
);

CREATE TABLE tbl_items(
    it_icode	CHAR(4)		PRIMARY KEY,
    it_iname	nVARCHAR2(10)	NOT NULL	
);
DROP TABLE TBL_COMPANY;

ALTER TABLE tbl_foods
ADD CONSTRAINT fk_company
FOREIGN KEY (fd_mcode)
REFERENCES tbl_company(cp_ccode);

ALTER TABLE tbl_foods
ADD CONSTRAINT fk_items
FOREIGN KEY (fd_clcode)
REFERENCES tbl_items(it_icode);

CREATE VIEW view_식품정보 AS(
    SELECT f.fd_fcode AS 식품코드,
            f.fd_fname AS 식품명,
            f.fd_serv AS 제공량,
            f.fd_capa AS 총내용량,
            f.fd_ener AS 에너지,
            f.fd_prot AS 단백질,
            f.fd_fat AS 지방,
            f.fd_carb AS 탄수화물,
            f.fd_sug AS 총당류,
            f.fd_mcode AS 제조사코드,
            f.fd_clcode AS 분류코드,
            c.cp_cname AS 제조사명,
            i.it_iname AS 분류명
    FROM tbl_foods F
        LEFT JOIN tbl_company C
            ON F.fd_mcode = c.cp_ccode
        LEFT JOIN tbl_items I
            ON F.fd_clcode = i.it_icode
);
DROP VIEW view_식품정보;

CREATE TABLE tbl_myfoods(
    mf_isbn CHAR(6) PRIMARY KEY,
    mf_date VARCHAR2(15) NOT NULL,
    mf_code CHAR(7) NOT NULL,
    mf_intk NUMBER NOT NULL
);

DROP TABLE tbl_myfoods;

SELECT MF.mf_isbn AS 일련번호,
        MF.mf_date AS 날짜,
        mf.mf_code AS 식품코드,
        MF.mf_intk AS 섭취량
       
FROM tbl_myfoods MF
    LEFT JOIN tbl_foods FD
        ON mf.mf_code = fd.fd_fcode;
        
INSERT INTO tbl_myfoods(mf_isbn, mf_date, mf_code, mf_intk )
    VALUES ('0001','2021-05-09','PD00017',1);
INSERT INTO tbl_myfoods(mf_isbn, mf_date, mf_code, mf_intk )
    VALUES ('0002','2021-05-09','PD00102',2);
INSERT INTO tbl_myfoods(mf_isbn, mf_date, mf_code, mf_intk )
    VALUES ('0003','2021-05-09','PD00222',1);
INSERT INTO tbl_myfoods(mf_isbn, mf_date, mf_code, mf_intk )
    VALUES ('0004','2021-05-09','PD01001',1);

CREATE VIEW view_섭취정보 AS(
    SELECT MF.mf_isbn AS 일련번호,
            MF.mf_date AS 날짜,
            mf.mf_code AS 식품코드,
            MF.mf_intk AS 섭취량
           
    FROM tbl_myfoods MF
        LEFT JOIN tbl_foods FD
            ON mf.mf_code = fd.fd_fcode
);

SELECT 
        MF.mf_date AS 날짜,
        fd.fd_fname AS 식품명,
        MF.mf_intk AS 섭취량,
        fd.fd_capa AS 총내용량,
            fd.fd_ener AS 에너지,
            fd.fd_prot AS 단백질,
            fd.fd_fat AS 지방,
            fd.fd_carb AS 탄수화물,
            fd.fd_sug AS 총당류
FROM tbl_foods FD
    LEFT JOIN tbl_myfoods MF
        ON mf.mf_isbn = fd.fd_fcode;
        

     