--○ 현재 오라클 서버에 접속한 자신의 계정 조회
show user
--==>> USER이(가) "SYS"입니다.
-- sqlplus 유틸리티 상태일 때 사용하는 명령어


-- 단일행 주석문 처리(라인 단위 주석)

/*
다중행
주석문
처리
(블럭 단위 주석)
*/

select user
from dual;
--==>> SYS

SELECT USER
FROM DUAL;
--==>> SYS


-- ○ 관찰

1+2;
--==>> SP2-0734: "1+2..."(으)로 시작되는 알 수 없는 명령 - 나머지 행은 무시됩니다.

select 1+2;
--==>> 에러 발생
--     ORA-00923: FROM keyword not found where expected

SELECT 1+2
FROM DUAL;
--==>> 3

select 1+2 from dual;
--==>> 3

select 1 + 2
from dual;
--==>> 3

select 1  +  2
from dual;
--==>> 3

SelecT 1 + 2
frOm Dual;
--==>> 3

select '쌍용강북교육센터D강의장'
from dual;
--==>> 쌍용강북교육센터D강의장

select "쌍용강북교육센터D강의장"
from dual;
--==>> 에러 발생
--     ORA-00972: identifier is too long

select 3.14 + 1.23
from dual;
--==>> 4.37

Select 1.23456 + 1.23456
From Dual;
--==>> 2.46912

SELECT 10 * 5
FROM DUAL;
--==>> 50

SElect 1000 / 23
FroM DuaL;
--==>> 43.47826086956521739130434782608695652174


-- ○ 오라클 서버에 존재하는 사용자 계정 상태 조회
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
SYS	                OPEN
SYSTEM	            OPEN
ANONYMOUS	        OPEN
HR	                OPEN
APEX_PUBLIC_USER	LOCKED
FLOWS_FILES	        LOCKED
APEX_040000	        LOCKED
OUTLN	            EXPIRED & LOCKED
DIP	                EXPIRED & LOCKED
ORACLE_OCM	        EXPIRED & LOCKED
XS$NULL	            EXPIRED & LOCKED
MDSYS	            EXPIRED & LOCKED
CTXSYS	            EXPIRED & LOCKED
DBSNMP	            EXPIRED & LOCKED
XDB	                EXPIRED & LOCKED
APPQOSSYS	        EXPIRED & LOCKED
*/



SELECT USERNAME, ACCOUNT_STATUS, PASSWORD, LOCK_DATE
FROM DBA_USERS;
--==>>
/*
SYS	                OPEN		
SYSTEM	            OPEN		
ANONYMOUS	        OPEN		
HR	                OPEN		
APEX_PUBLIC_USER	LOCKED		            14/05/29
FLOWS_FILES	        LOCKED		            14/05/29
APEX_040000	        LOCKED		            14/05/29
OUTLN	            EXPIRED & LOCKED		25/12/29
DIP	                EXPIRED & LOCKED		14/05/29
ORACLE_OCM	        EXPIRED & LOCKED		14/05/29
XS$NULL 	        EXPIRED & LOCKED		14/05/29
MDSYS	            EXPIRED & LOCKED		14/05/29
CTXSYS	            EXPIRED & LOCKED		25/12/29
DBSNMP	            EXPIRED & LOCKED		14/05/29
XDB	                EXPIRED & LOCKED		14/05/29
APPQOSSYS	        EXPIRED & LOCKED		14/05/29
*/

--> 『DBA_』로 시작하는 Oracle Data Dictionary View
--  오로지 관리자 권한으로 접속했을 때만 조회가 가능하다
--  아직은 데이터 딕셔너리 개념을 잡지 못해도 상관없다.

-- ○ 『hr』사용자 계정 잠금 상태로 설정
ALTER USER HR ACCOUNT LOCK;
--==>> User HR이(가) 변경되었습니다.

-- ○ 다시 사용자 계정 정보 조회
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
/--==>>
/*
SYS	                OPEN
SYSTEM	            OPEN
ANONYMOUS	        OPEN
APEX_PUBLIC_USER	LOCKED
FLOWS_FILES	        LOCKED
APEX_040000	        LOCKED
HR	                LOCKED
OUTLN	            EXPIRED & LOCKED
DIP             	EXPIRED & LOCKED
ORACLE_OCM	        EXPIRED & LOCKED
XS$NULL     	    EXPIRED & LOCKED
MDSYS	            EXPIRED & LOCKED
CTXSYS	            EXPIRED & LOCKED
DBSNMP	            EXPIRED & LOCKED
XDB	                EXPIRED & LOCKED
APPQOSSYS	        EXPIRED & LOCKED
*/


-- ○ hr 사용자 계정을 잠금 해제 상태로 설정
ALTER USER HR ACCOUNT UNLOCK;
--==>> User HR이(가) 변경되었습니다.

SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
SYS	                OPEN
SYSTEM	            OPEN
ANONYMOUS	        OPEN
HR	                OPEN
APEX_PUBLIC_USER	LOCKED
FLOWS_FILES	        LOCKED
APEX_040000	        LOCKED
OUTLN	            EXPIRED & LOCKED
DIP	                EXPIRED & LOCKED
ORACLE_OCM	        EXPIRED & LOCKED
XS$NULL	            EXPIRED & LOCKED
MDSYS	            EXPIRED & LOCKED
CTXSYS	            EXPIRED & LOCKED
DBSNMP	            EXPIRED & LOCKED
XDB	                EXPIRED & LOCKED
APPQOSSYS	        EXPIRED & LOCKED
*/

--------------------------------------------------------------------------------

-- ○ TABLESPACE 생성

-- ※ TABLESPACE란?
--   세그먼트(SEGMENT: 테이블, 인덱스,...)를 담아두는(저장해두는)
--   오라클의 논리적인 저장 구조를 의미한다.

CREATE TABLESPACE TBS_EDUA                   -- CREATE 유형 개체명    → 생성
DATAFILE 'C:\TESTORADATA\TBS_EDUA01.DBF'     -- 물리적으로 연결되는 데이터 파일
SIZE 4M                                      -- 물리적 데이터 파일의 용량   
EXTENT MANAGEMENT LOCAL                      -- 오라클 서버가 세그먼트를 알아서 관리
SEGMENT SPACE MANAGEMENT AUTO;               -- 세그먼트 공간 관리도 자동으로 오라클 서버가 해라
--==>> TABLESPACE TBS_EDUA이(가) 생성되었습니다.

-- ※ 테이블스페이스 생성 구문을 실행하기 전에
--    물리적인 경로에 디렉터리(C:\TESTORADATA) 생성하고 진행해야
--    에러 발생하지 않는다.

-- ○ 생성된 테이블스페이스 조회
-- 테이블스페이스명: TBS_EDUA

SELECT *
FROM DBA_TABLESPACES;
--==>>
/*
SYSTEM	    8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
SYSAUX	    8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
UNDOTBS1	8192	65536		1	2147483645	2147483645		65536	ONLINE	UNDO	    LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOGUARANTEE	NO	HOST	NO	
TEMP	    8192	1048576	1048576	1		    2147483645	0	1048576	ONLINE	TEMPORARY	NOLOGGING	NO	LOCAL	UNIFORM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
USERS	    8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
TBS_EDUA	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
*/


-- ○ 물리적인 파일 이름 조회
SELECT *
FROM DBA_DATA_FILES;
--==>>
/*
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\USERS.DBF 	4	USERS	104857600	12800	AVAILABLE	4	YES	11811160064	1441792	1280	103809024	12672	ONLINE
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSAUX.DBF	2	SYSAUX	692060160	84480	AVAILABLE	2	YES	34359721984	4194302	1280	691011584	84352	ONLINE
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\UNDOTBS1.DBF	3	UNDOTBS1	398458880	48640	AVAILABLE	3	YES	524288000	64000	640	397410304	48512	ONLINE
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSTEM.DBF	1	SYSTEM	377487360	46080	AVAILABLE	1	YES	629145600	76800	1280	376438784	45952	SYSTEM
C:\TESTORADATA\TBS_EDUA01.DBF	                5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE
*/


-- ○오라클 사용자 계정 생성
-- 생성 계정명 : rimyuhwon
-- 설정 패스워드 : java004$
CREATE USER rimyuhwon IDENTIFIED BY java004$
DEFAULT TABLESPACE TBS_EDUA;
--> rimyuhwon 이라는 사용자를 만들어라
--  이 계정의 패스워드는 java004$로 설정해라
--  이 계정을 통해 생성하는 오라클 객체는(세그먼트들은)
--  기본적으로(DEFAULT) TBS_EDUA라는 테이블스페이스에
--  생성할 수 있도록 설정해라
--==>> User RIMYUHWON이(가) 생성되었습니다.


-- ※ 생성된 오라클 사용자 계정(rimyuhwon)을 통해
--    오라클 서버 접속 시도
--    → 실패(접속 불가) →『CREATE SESSION』 권한이 없기 때문에

-- ○ 생성된 오라클 사용자 계정(rimyuhwon)에
--    오라클 서버 접속이 가능할 수 있도록
--    『CREATE SESSION』 권한 부여 → SYS

GRANT CREATE SESSION TO rimyuhwon;
--==>> Grant을(를) 성공했습니다.

-- ※ 생성된 오라클 사용자 계정(rimyuhwon)을 통해
--    오라클 서버 접속 시도
--    → 성공

-- ※ 생성된 오라클 사용자 계정(rimyuhwon)을 통해
--    테이블을 생성하는 과정에서 에러 발생

-- ○ 생성된 오라클 사용자 계정(rimyuhwon)의
--    시스템 관련 권한 조회

SELECT *
FROM DBA_SYS_PRIVS;
--==>>
/*
            :
RIMYUHWON	CREATE SESSION	NO
            :
*/

SELECT *
FROM DBA_SYS_PRIVS 
WHERE GRANTEE = 'RIMYUHWON';
--==>> RIMYUHWON	CREATE SESSION	NO

-- ○ 생성된 오라클 사용자 계정(rimyuhwon)에
--    테이블 생성이 가능할 수 있도록 권한 부여
--    (→ 『CREATE TABLE』)

GRANT CREATE TABLE TO RIMYUHWON;
//--==>> Grant을(를) 성공했습니다.

-- ※ 생성된 오라클 사용자 계정(rimyuhwon)을 통해
--    다시 테이블을 생성하는 과정에서 에러 발생
--    → 테이블스페이스에서 사용할 수 있는 공간이 없어서

-- ○ 생성된 오라클 사용자 계정(rimyuhwon)에
--    테이블스페이스(TBS_EDUA)에서 사용할 수있는
--    공간(할당량) 크기 지정 → 무제한(UNLIMITED)

ALTER USER RIMYUHWON
QUOTA UNLIMITED ON TBS_EDUA;
--==>> User RIMYUHWON이(가) 변경되었습니다.



-- ○ 사용자 계정 생성
create user scott
identified by tiger;
--==>> User SCOTT이(가) 생성되었습니다.

-- ○ 권한 부여
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO SCOTT;
--==>> Grant을(를) 성공했습니다.

-- ○기본 테이블스페이스 설정
ALTER USER SCOTT DEFAULT TABLESPACE USERS;
--==>> User SCOTT이(가) 변경되었습니다.

-- ○임시 테이블스페이스 설정
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;
--==>> User SCOTT이(가) 변경되었습니다.







