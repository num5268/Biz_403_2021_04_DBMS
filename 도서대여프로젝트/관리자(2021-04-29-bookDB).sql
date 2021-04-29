-- tablespace만들기
-- 여기는 관리자접속
-- 프로젝트에서 사용할 TableSpace user 생성
CREATE TABLESPACE RentBookDB
DATAFILE 'C:/oraclexe/data/rentbook.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

CREATE USER bookuser IDENTIFIED BY bookuser
DEFAULT TABLESPACE RentBookDB;

GRANT DBA TO bookuser;