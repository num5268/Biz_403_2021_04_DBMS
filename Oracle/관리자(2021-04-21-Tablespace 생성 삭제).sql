-- 관리자 권한 접속

-- TableSpace 삭제하기
-- 반드시 옵션을 같이 작성하자
CREATE TABLESPACE iolistDB -- 반드시 있어야될곳
DATAFILE 'C:/oraclexe/data/iolist.dbf' -- 옵션
SIZE 1M AUTOEXTEND ON NEXT 1K; -- 옵션

-- TableSpace 생성하기
DROP TABLESPACE iolistDB
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS;

-- 사용자 삭제하기
DROP USER iouser CASCADE;

-- 사용자 생성하기
CREATE USER iouser IDENTIFIED BY iouser
DEFAULT TABLESPACE iolistdb;

-- 사용자에게 권한 부여
GRANT DBA TO iouser;