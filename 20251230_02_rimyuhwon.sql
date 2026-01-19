-- ○ 접속된 사용자 확인
SELECT USER
FROM DUAL;
--=>> RIMYUHWON


-- ○테이블 생성
-- 테이블명: TBL_ORAUSERTEST
CREATE TABLE TBL_ORAUSERTEST 
( NO    NUMBER(10)
, NAME  VARCHAR2(30)
);
--==>>
/*
ORA-01031: insufficient privileges(→ 권한 불충분)
01031. 00000 -  "insufficient privileges"
*Cause:    An attempt was made to perform a database operation without
           the necessary privileges.
*Action:   Ask your database administrator or designated security
           administrator to grant you the necessary privileges
*/
--> 현재 RIMYUHWON 계정은 CREATE SESSION 권한만 갖고 있으며
--  테이블을 생성할 수 있는 권한은 갖고 있지 않은 상태이다
--  그러므로 이 계정이 오라클 서버에 접속하여 테이블을 생성하기 위해서는
--  관리자로부터 테이블 생성 권한을 부여받아야 한다.

-- ○ 관리자(SYS)로 부터 『CREATE TABLE』 권한을 부여 받은 후
--      다시 테이블 생성
--  테이블명: TBL_ORAUSERTEST
CREATE TABLE TBL_ORAUSERTEST
( NO    NUMBER(10)
, NAME  VARCHAR2(30)
);
--==>> 에러 발생
/*
ORA-01950: no privileges on tablespace 'TBS_EDUA'
01950. 00000 -  "no privileges on tablespace '%s'"
*Cause:    User does not have privileges to allocate an extent in the
           specified tablespace.
*Action:   Grant the user the appropriate system privileges or grant the user
           space resource on the tablespace.
*/

--> 테이블 생성 권한(→『CREATE TABLE』)까지 부여 받은 상황이지만
-- RIMYUHWON 사용자 계정의 기본 테이블스페이스(DEFAULT TABLESPACE: TBS_EDUA)에 대한
-- 사용 권한(할당량)을 부여받지 못한 상태.
-- 그러므로 이 테이블스페이스를 사용할 수 있는 권한이 없다는
-- 에러 메시지를 오라클이 안내해 주고 있는 상황.


-- ○ 관리자(SYS)로 부터 테이블스페이스(TBS_EDUA)에 대한 할당량을 부여 받은 후
--      다시 테이블 생성
--  테이블명: TBL_ORAUSERTEST
CREATE TABLE TBL_ORAUSERTEST
( NO    NUMBER(10)
, NAME  VARCHAR2(30)
);
--==>> Table TBL_ORAUSERTEST이(가) 생성되었습니다.

-- ※ 자신에게 부여된 할당량 조회
SELECT *
FROM USER_TS_QUOTAS;
--==>> TBS_EDUA	65536	-1	8	-1	NO
--                      ---
--                     무제한








