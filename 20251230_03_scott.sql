-- ○ 접속된 사용자 조회
SELECT USER
FROM DUAL;
--==>> SCOTT


-- ○ 테이블 생성
--    테이블명: DEPT
CREATE TABLE DEPT
( DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY
, DNAME VARCHAR2(14)
, LOC VARCHAR2(13) 
) ;
--==>> Table DEPT이(가) 생성되었습니다.


-- ○ 테이블 생성
--    테이블명: EMP
CREATE TABLE EMP
( EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY
, ENAME VARCHAR2(10)
, JOB VARCHAR2(9)
, MGR NUMBER(4)
, HIREDATE DATE
, SAL NUMBER(7,2)
, COMM NUMBER(7,2)
, DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT
);
--==>> Table EMP이(가) 생성되었습니다.


-- ○ 데이터 입력(DEPT)
INSERT INTO DEPT VALUES	(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES	(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES	(40,'OPERATIONS','BOSTON');
--==>> 1 행 이(가) 삽입되었습니다. * 4


-- ○ 데이터 입력(EMP)
INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,to_date('13-7-1987','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,to_date('13-7-1987','dd-mm-yyyy'),1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
--==>> 1 행 이(가) 삽입되었습니다. * 14


-- ○ 테이블 생성
--    테이블명: BONUS
CREATE TABLE BONUS
( ENAME VARCHAR2(10)
, JOB VARCHAR2(9)
, SAL NUMBER
, COMM NUMBER
) ;
--==>> Table BONUS이(가) 생성되었습니다.


-- ○ 테이블 생성
--    테이블명: SALGRADE
CREATE TABLE SALGRADE
( GRADE NUMBER
, LOSAL NUMBER
, HISAL NUMBER 
);
--==>> Table SALGRADE이(가) 생성되었습니다.


-- ○ 데이터 입력(SALGRADE)
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
--==>> 1 행 이(가) 삽입되었습니다. * 5


-- ○ 커밋
COMMIT;
--==> 커밋 완료.


-- ○ 현재 SCOTT 오라클 계정 사용자가 소유하고 있는 테이블 조회
SELECT *
FROM TAB;
--==>>
/*
BONUS	    TABLE	
DEPT	    TABLE	
EMP	        TABLE	
SALGRADE	TABLE	
*/


-- ○ 어떤 테이블스페이스에 저장되어 있는지 조회
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;
--==>>
/*
DEPT	    USERS
EMP	        USERS
BONUS	    USERS
SALGRADE	USERS
*/


-- ○ 테이블 생성
--    테이블 명: TBL_EXAMPLE1
CREATE TABLE TBL_EXAMPLE1
( NO    NUMBER(10)
, NAME  VARCHAR2(10)
, ADDR  VARCHAR2(20)
);
--==>> Table TBL_EXAMPLE1이(가) 생성되었습니다.


-- ○ 테이블 생성
--    테이블 명: TBL_EXAMPLE2
CREATE TABLE TBL_EXAMPLE2
( NO    NUMBER(10)
, NAME  VARCHAR2(10)
, ADDR  VARCHAR2(20)
) TABLESPACE TBS_EDUA;
--==>> Table TBL_EXAMPLE2이(가) 생성되었습니다


-- ※ TBL_EXAMPLE1과 TBL_EXAMPLE2 테이블이
--    어떤 테이블스페이스에 저장되어 있는지 조회
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;
--==>>
/*
DEPT	        USERS
EMP	            USERS
BONUS	        USERS
SALGRADE	    USERS
TBL_EXAMPLE1	USERS
TBL_EXAMPLE2	TBS_EDUA
*/


-------------------------------------------------------------------------------

-- ■■■ 관계형 데이터베이스 ■■■ --

-- 데이터를 테이블 형태로 저장시켜 놓은 것
-- 그리고 이들 각 테이블들 간의 관계를 설정하는 것.

/*=================================

    SELECT 문의 처리(PARSING) 순서
    
    
    SELECT 절       -- ⑤
    FROM 테이블명   -- ①
    WHERE 조건절    -- ②
    GROUP BY 절     -- ③
    HAVING 절       -- ④
    ORDER BY 절     -- ⑥

==================================*/


-- ○ 현재 접속된 오라클 사용자(SCOTT) 소유의
--      테이블(TABLE), 뷰(VIEW)의 목록을 조회

SELECT *
FROM TAB;
--==>>
/*
BONUS	        TABLE	→ 보너스 데이터 테이블
DEPT	        TABLE	→ DEPARTMENTS(부서) 데이터 테이블
EMP	            TABLE	→ EMPLOYEES(사원) 데이터 테이블
SALGRADE	    TABLE	→ SAL(급여)에 대한 GRADE(등급) 테이블
TBL_EXAMPLE1	TABLE	
TBL_EXAMPLE2	TABLE	
*/


-- ○ 각 데이블의 데이터 조회
SELECT *
FROM BONUS;
--==>> 데이터 존재하지 않음(→ 테이블의 구조만 확인 가능)

SELECT *
FROM DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/

SELECT *
FROM EMP;
--==>>
/*
7369	SMITH	CLERK	    7902	80/12/17	800		        20
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	    30
7566	JONES	MANAGER 	7839	81/04/02	2975		    20
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7698	BLAKE	MANAGER	    7839	81/05/01	2850		    30
7782	CLARK	MANAGER	    7839	81/06/09	2450		    10
7788	SCOTT	ANALYST	    7566	87/07/13	3000		    20
7839	KING	PRESIDENT		    81/11/17	5000		    10
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
7876	ADAMS	CLERK	    7788	87/07/13	1100		    20
7900	JAMES	CLERK	    7698	81/12/03	950		        30
7902	FORD	ANALYST	    7566	81/12/03	3000		    20
7934	MILLER	CLERK	    7782	82/01/23	1300		    10
*/

SELECT *
FROM SALGRADE;
--==>>
/*
1	700 	1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999
*/

-- ○ DEPT 테이블에 존재하는 컬럼의 정보(구조) 조회
DESCRIBE DEPT;
--==>>
/*
이름     널?       유형           
------ -------- ------------ 
DEPTNO NOT NULL NUMBER(2)    
DNAME           VARCHAR2(14) 
LOC             VARCHAR2(13) 
*/


-- ○ EMP 테이블에 존재하는 컬럼의 정보(구조) 조회
DESCRIBE EMP;
--==>>
/*
이름       널?       유형           
-------- -------- ------------ 
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2) 
*/

DESC DEPT;
--==>>
/*
이름     널?       유형           
------ -------- ------------ 
DEPTNO NOT NULL NUMBER(2)    
DNAME           VARCHAR2(14) 
LOC             VARCHAR2(13) 
*/


-- DEPTNO       DNAME       LOC
-- 부서번호     부서명      부서위치
-- NOT VULL     NULL허용    NULL허용

DESC EMP;
--==>> 
/*
이름       널?       유형           
-------- -------- ------------ 
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2)    
*/


-- EMPNO      ENAME     JOB       MGR       HIREDATE    SAL       COMM      DEPTNO
-- 사원번호   사원명    직종명    관리자    입사일      급여      수당      부서번호
-- NOT NULL   NULL허용  NULL허용  NULL허용  NULL허용    NULL허용  NULL허용   NULL허용


-- ○ 유형 → 입력 가능한 데이터의 범위 → 데이터 타입 → 자료형
/*
1. 숫자형
    NUMBER      → -10 38승 -1 ~ 10 38승
    NUMBER(2)   → -99 ~ 99
    NUMBER(3)   → -999 ~ 999
    NUMBER(4)   → -9999 ~ 9999
    NUMBER(4,1) → -999.9 ~ 999.9
    
비교) MS-SQL 서버의 정수 표현
    TINYINT     - 0 ~ 255           1Byte
    SMALLINT    - -32768 ~ 32767    2Byte
    INT         - -21억 ~ 21억      4Byte
    BIGINT      - -920경 ~ 920경     8Byte

비교) MS-SQL 서버의 실수 표현
    FLOAT, REAL
    
비교) MS-SQL 서버의 숫자 표현    
    DECIMAL, NUMERIC
    
비교) MS-SQL 서버의 문자 표현
    CHAR, VARCHAR, NVARCHAR
    
    
2. 문자형
   CHAR, NCHAR, VARCHAR2, NVARCHAR2
        
   CHAR         -- 고정형 크기
   CHAR(10)
   CHAR(10)     ← '포도'               4Byte이지만 10Byte를 소모
   CHAR(10)     ← '바나나'             6Byte이지만 10Byte를 소모
   CHAR(10)     ← '몽키바나나'        10Byte
   CHAR(10)     ← '드래곤후르츠'      10Byte를 초과하므로 입력불가
    
    
   VARCHAR2     -- 가변형 크기
   VARCHAR2(10)
   VARCHAR2(10)  ← '포도'           4Byte
   VARCHAR2(10)  ← '바나나'          6Byte
   VARCHAR2(10)  ← '몽키바나나'     10Byte
   VARCHAR2(10)  ← '드래곤후르츠'   10Byte를 초과하므로 입력불가
   
   
   NCHAR            -- 유니코드 기반(글자수) 고정형 크기
   NCHAR(10)        -- 10글자
   
   NVARCHAR2        -- 유니코드 기반(글자수) 가변형 크기
   NVARCHAR2(10)    -- 10글자
   
3. 날짜형
   DATE
*/

















