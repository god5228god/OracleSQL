SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT SYSDATE                    -- 오라클 내부 함수
FROM DUAL;
--==>> 25/12/31                   → 날짜 타입

SELECT LOCALTIMESTAMP
FROM DUAL;
--==>> 25/12/31 09:12:53.525000000 → 날짜 타입

SELECT '안녕하세요'
FROM DUAL;
--==>> 안녕하세요                 → 문자 타입

SELECT 10 + 20.4
FROM DUAL;
--==>> 30.4                       → 숫자 타입


-- ○ EMP 테이블에서 사원번호, 사원명, 급여, 커미션 항목을 조회
SELECT *
FROM EMP;

SELECT 사원번호, 사원명, 급여, 커미션
FROM EMP;

SELECT EMPNO, ENAME, SAL, COMM
FROM EMP;
--==>>
/*
7369	SMITH	800	
7499	ALLEN	1600    	300
7521	WARD	1250    	500
7566	JONES	2975	
7654	MARTIN	1250	    1400
7698	BLAKE	2850	
7782	CLARK	2450	
7788	SCOTT	3000	
7839	KING	5000	
7844	TURNER	1500    	0
7876	ADAMS	1100	
7900	    JAMES	950	
7902    	FORD	3000	
7934	MILLER	1300	
*/


-- ○ EMP 테이블에서 부서번호가 20번인 직원들의 정보 중
--    사원번호, 사원명, 직종명, 급여, 부서번호 조회
SELECT *
FROM EMP;

SELECT 사원번호, 사원명, 직종명, 급여, 부서번호
FROM EMP
WHERE 부서번호가 20;

SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE DEPTNO == 20;
--==>> 에러발생
/*
ORA-00936: missing expression
00936. 00000 -  "missing expression"
*Cause:    
*Action:
61행, 15열에서 오류 발생
*/

SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 20;
--==>>
/*
7369	SMITH	CLERK	    800	    20
7566	JONES	MANAGER	    2975	20
7788	SCOTT	ANALYST	    3000	    20
7876	ADAMS	CLERK	    1100    	20
7902    	FORD	ANALYST	    3000    	20
*/


-- ※ 테이블을 조회하는 과정에서 각 칼럼(항목)에 별칭(ALIAS)을 부여할 수 있다.(AS 사용가능)
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 20;

SELECT EMPNO AS "사원번호", ENAME "사원명", 
JOB 직종명, SAL "급 여", DEPTNO"부서 번호"     -- ""는 AS일 때 사용, 생략도 가능(""생략시에는 별칭 안에 공백을 허용하지 않음)
FROM EMP
WHERE DEPTNO = 20;


-- ※ 테이블을 조회하는 과정에서 별칭(ALIAS)의 기본 구문은
--    『AS "별칭이름"』의 형태로 작성되며
--    이때, 『AS』는 생략이 가능하다.
--    또한, 『""』도 생략할 수 있다.
--    하지만, 『""』를 생략하게 되면 별칭 이름에 공백은 사용할 수 없다.
--    공백은 해당 컬럼에 대한 서술의 종결을 의미하므로
--    이름 내부에 공백을 사용할 경우 『""』를 사용하여
--    별칭을 부여할 수 있도록 처리해야 한다.


-- ○ EMP 테이블에서 부서번호가 20번과 30번 직원들의 데이터를
--    사원번호, 사원명, 직종명, 급여, 부서번호 항목으로 조회한다.
--    단, 별칭(ALIAS)을 사용한다.
SELECT *
FROM EMP;

SELECT 사원번호, 사원명, 직종명, 급여, 부서번호
FROM EMP
WHERE 부서번호가 20번과 30번

SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명, SAL 급여, DEPTNO 부서번호
FROM EMP
WHERE DEPTNO = 20 || DEPTNO = 30;
--==>> 에러 발생
/*
ORA-00933: SQL command not properly ended
00933. 00000 -  "SQL command not properly ended"
*Cause:    
*Action:
119행, 100열에서 오류 발생
*/

SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명, SAL 급여, DEPTNO 부서번호
FROM EMP
WHERE DEPTNO = 20 OR DEPTNO = 30;
--==>>
/*
7369	SMITH	CLERK	    800	    20
7499	ALLEN	SALESMAN	1600    	30
7521	WARD	SALESMAN	1250	    30
7566	JONES	MANAGER 	2975	20
7654	MARTIN	SALESMAN	1250    	30
7698	BLAKE	MANAGER	    2850    	30
7788	SCOTT	ANALYST	    3000	    20
7844	TURNER	SALESMAN	1500	    30
7876	ADAMS	CLERK	    1100    	20
7900    	JAMES	CLERK	    950	    30
7902    	FORD	ANALYST	    3000	    20
*/

SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명, SAL 급여, DEPTNO 부서번호
FROM EMP
WHERE DEPTNO IN(20, 30);
--> 『IN』연산자를 활용하여 이와 같이 처리할 수 있으며
--   앞서 『OR』로 처리한 구문과 같은 결과를 반환하게 된다.
/*
7369	SMITH	CLERK	    800	    20
7499	ALLEN	SALESMAN	1600    	30
7521	WARD	SALESMAN	1250	    30
7566	JONES	MANAGER 	2975	20
7654	MARTIN	SALESMAN	1250    	30
7698	BLAKE	MANAGER	    2850    	30
7788	SCOTT	ANALYST	    3000	    20
7844	TURNER	SALESMAN	1500	    30
7876	ADAMS	CLERK	    1100    	20
7900    	JAMES	CLERK	    950	    30
7902    	FORD	ANALYST	    3000	    20
*/


-- ○EMP테이블에서 직종이 CLERK인 사원들의 정보를 모두 조회한다.
SELECT *
FROM EMP
WHERE 직종이 CLERK;

SELECT *
FROM EMP
WHERE JOB = CLER;
--==>> 에러 발생
/*
ORA-00904: "CLER": invalid identifier
00904. 00000 -  "%s: invalid identifier"
*Cause:    
*Action:
172행, 13열에서 오류 발생
*/

SELECT *
FROM EMP
WHERE JOB = 'CLERK';
--==>>
/*
7369	SMITH	CLERK	7902	    80/12/17	800		20
7876	ADAMS	CLERK	7788	87/07/13	1100		20
7900	    JAMES	CLERK	7698	81/12/03	950		30
7934	MILLER	CLERK	7782	82/01/23	1300		10
*/

SELECT *
FROM EMP
WHERE JOB = 'clerk';
--==>> 조회 결과 없음 (데이터는 대소문자 구분 필수)

-- ※ 오라클에서 입력된 데이터(값)만틈은
--    반드시 대소문자 구분을 엄격히 수행한다.


-- ○ EMP 테이블에서 직종이 CLERK인 사원들 중
--    20번 부서에 근무하는 사원들의 
--    사원번호, 사원명, 직종명, 급여, 부서번호 항목을 조회한다.

SELECT 사원번호, 사원명, 직종명, 급여, 부서번호
FROM EMP
WHERE 직종이 CLERK 0번 부서에 근무;

SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종명", SAL "급여", DEPTNO "부서번호"
FROM EMP
WHERE JOB = 'CLERK' AND DEPTNO = 20;
--==>>
/*
7369	SMITH	CLERK	800	    20
7876	ADAMS	CLERK	1100    	20
*/


-- ○ EMP 테이블에서 10번 부서에 근무하는 직원들 중
--    급여가 2500 이상인 사원들의 
--    사원명, 직종명, 급여, 부서번호 항목을 조회한다.

SELECT 사원명, 직종명, 급여, 부서번호 
FROM EMP
WHERE 10번 부서   급여가 2500 이상

SELECT ENAME "사원명", JOB "직종명", SAL "급여", DEPTNO "부서번호"
FROM EMP
WHERE DEPTNO = 10 AND SAL >= 2500;
--==>>
/*
KING	PRESIDENT	5000	    10
*/

-- ※ 테이블 복사
--> 내부적으로 대상 테이블 내부에 있는 데이터의 내용만 복사하는 과정

DESCRIBE EMP;
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

CREATE TABLE EMPCOPY
(
EMPNO     NUMBER(4)    
,ENAME    VARCHAR2(10) 
,JOB      VARCHAR2(9)  
,MGR      NUMBER(4)    
,HIREDATE DATE         
,SAL      NUMBER(7,2)  
,COMM     NUMBER(7,2)  
,DEPTNO   NUMBER(2) 
);
--==>> Table EMPCOPY이(가) 생성되었습니다.

SELECT *
FROM EMPCOPY;
--==>> 조회 결과 없음

SELECT *
FROM EMP;

INSERT INTO EMPCOPY VALUES(7369, 'SMITH','CLERK',7902 ,TO_DATE('80/12/17', 'YY/MM/DD'),800,NULL,20);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM EMPCOPY;
/*
INSERT INTO EMPCOPY VALUES(7499, 'ALLEN','SALESMAN',7698 ,TO_DATE('81/02/20', 'YY/MM/DD'), 1600, 300, 30);
                      ...
                      ...
                      ...

*/

CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP이(가) 생성되었습니다.

SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902    	80/12/17	    800		20
7499	ALLEN	SALESMAN	7698	81/02/20	    1600	300	30
7521	WARD	SALESMAN	7698	81/02/22	    1250	500	30
7566	JONES	MANAGER	    7839	81/04/02    	2975		20
7654	MARTIN	SALESMAN	7698	81/09/28    	1250	1400	30
7698	BLAKE	MANAGER	    7839	81/05/01    	2850		30
7782	CLARK	MANAGER	    7839	81/06/09    	2450		10
7788	SCOTT	ANALYST	    7566	87/07/13	    3000		20
7839	KING	PRESIDENT		    81/11/17	5000		10
7844	TURNER	SALESMAN	7698	81/09/08	    1500	0	30
7876	ADAMS	CLERK	    7788	87/07/13	    1100		20
7900	    JAMES	CLERK	    7698	81/12/03    	950		30
7902	    FORD	ANALYST	    7566	81/12/03	    3000		20
7934	MILLER	CLERK	    7782	82/01/23	    1300		10
*/

--○ 확인
SELECT *
FROM TBL_EMP;

SELECT *
FROM EMP;

DESC TBL_EMP;
DESC EMP;

CREATE TABLE TBL_DEPT
AS
SELECT *
FROM DEPT;
--==>>Table TBL_DEPT이(가) 생성되었습니다.

--○ 복사(데이터 위주)한 테이블 확인
SELECT *
FROM TBL_DEPT;

SELECT *
FROM DEPT;

DESC TBL_DEPT;
DESC DEPT;


-- ○ 커멘트(COMMENT) - 주석
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
DEPT	        TABLE	
EMP 	        TABLE	
BONUS	        TABLE	
SALGRADE	    TABLE	
TBL_EXAMPLE1	TABLE	
TBL_EXAMPLE2	TABLE	
EMPCOPY	        TABLE	
TBL_EMP	        TABLE	
TBL_DEPT	    TABLE	
*/

-- ○ 테이블의 커멘트(COMMENT) 정보 입력
COMMENT ON TABLE TBL_EMP IS '사원데이터';
--==>>Comment이(가) 생성되었습니다.

-- ○ 커멘트 정보 입력 이후 다시 확인
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_DEPT	    TABLE	
TBL_EMP	        TABLE	사원데이터
EMPCOPY	        TABLE	
TBL_EXAMPLE2	TABLE	
TBL_EXAMPLE1	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT	        TABLE	
*/

-- ○ 테이블 레벨의 커멘트 정보 입력(TBL_DEPT → 부서데이터)
COMMENT ON TABLE TBL_DEPT IS '부서데이터';
--==>> Comment이(가) 생성되었습니다.

-- ○ 커멘트 정보 입력 이후 다시 확인
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_DEPT	    TABLE	부서데이터
TBL_EMP	        TABLE	사원데이터
EMPCOPY	        TABLE	
TBL_EXAMPLE2	TABLE	
TBL_EXAMPLE1	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT	        TABLE	
*/

-- ○ 컬럼 레벨의 커멘트 정보 확인
SELECT *
FROM USER_COL_COMMENTS;
--==>>
/*
TBL_DEPT	    LOC	
EMPCOPY	        JOB	
EMP	            JOB	
TBL_EXAMPLE2	NAME	
DEPT	        LOC	
BONUS	        COMM	
BONUS	        SAL	
EMP	            SAL	
SALGRADE	    LOSAL	
TBL_EMP	        EMPNO	
EMPCOPY	        EMPNO	
TBL_EMP	        ENAME	
TBL_EMP	        SAL	
EMPCOPY	        DEPTNO	
EMPCOPY	        ENAME	
TBL_DEPT	    DEPTNO	
TBL_EMP	        DEPTNO	
EMPCOPY	        MGR	
EMP	            DEPTNO	
SALGRADE	    HISAL	
EMP	            EMPNO	
TBL_EXAMPLE1	NAME	
DEPT	        DEPTNO	
DEPT	        DNAME	
EMPCOPY	        HIREDATE	
EMP	            COMM	
SALGRADE	    GRADE	
TBL_EXAMPLE1	ADDR	
TBL_EXAMPLE2	ADDR	
EMP	            HIREDATE	
TBL_EXAMPLE2	NO	
TBL_DEPT	    DNAME	
BONUS	        JOB	
TBL_EXAMPLE1	NO	
TBL_EMP	        HIREDATE	
EMPCOPY	        COMM	
EMPCOPY	        SAL	
EMP	            ENAME	
EMP         	MGR	
TBL_EMP	        JOB	
TBL_EMP	        COMM	
TBL_EMP	        MGR	
BONUS	        ENAME	
*/

-- ○ 컬럼 레벨의 커멘트 정보 확인
-- 43 레코드 중 TBL_DEPT 테이블에 포함되어 있는 컬럼만 조회
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_DEPT';
--==>>
/*
TBL_DEPT	DEPTNO	    -- 부서번호
TBL_DEPT	DNAME	    -- 부서이름
TBL_DEPT	LOC	        -- 부서위치
*/

-- ○ 테이블에 소속된(포함된) 컬럼 레벨의 커멘트 정보 입력(설정)
COMMENT ON COLUMN TBL_DEPT.DEPTNO IS '부서번호';
--==>> Comment이(가) 생성되었습니다.
COMMENT ON COLUMN TBL_DEPT.DNAME IS '부서이름';
--==>> Comment이(가) 생성되었습니다.
COMMENT ON COLUMN TBL_DEPT.LOC IS '부서위치';
--==>> Comment이(가) 생성되었습니다.

-- ○ 커멘트 데이터가 입력된 테이블의 컬럼 레벨의 데이터 확인
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_DEPT';
--==>>
/*
TBL_DEPT	DEPTNO	부서번호
TBL_DEPT	DNAME	부서이름
TBL_DEPT	LOC	    부서위치
*/

DESC TBL_EMP;
--==>>
/*
이름       널? 유형           
-------- -- ------------ 
EMPNO       NUMBER(4)       -- 사원번호
ENAME       VARCHAR2(10)    -- 사원명
JOB         VARCHAR2(9)     -- 직종명
MGR         NUMBER(4)       -- 관리자사원번호
HIREDATE    DATE            -- 입사일
SAL         NUMBER(7,2)     -- 급여
COMM        NUMBER(7,2)     -- 수당
DEPTNO      NUMBER(2)       -- 부서번호
*/

-- ○ TBL_EMP 테이블에 소속된(포함된) 
--    컬럼에 대한 커멘트 정보 입력(설정)
COMMENT ON COLUMN TBL_EMP.EMPNO IS '사원번호';
COMMENT ON COLUMN TBL_EMP.ENAME IS '사원명';
COMMENT ON COLUMN TBL_EMP.JOB IS '직종명';
COMMENT ON COLUMN TBL_EMP.MGR IS '관리자사원번호';
COMMENT ON COLUMN TBL_EMP.HIREDATE IS '입사일';
COMMENT ON COLUMN TBL_EMP.SAL IS '급여';
COMMENT ON COLUMN TBL_EMP.COMM IS '수당';
COMMENT ON COLUMN TBL_EMP.DEPTNO IS '부서번호';
--==>> Comment이(가) 생성되었습니다. * 8

-- ○ 커멘트 데이터가 입력된 테이블의 컬럼 레벨의 정보 확인
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_EMP';
--==>>
/*
TBL_EMP	EMPNO	    사원번호
TBL_EMP	ENAME	    사원명
TBL_EMP	JOB	        직종명
TBL_EMP	MGR	        관리자사원번호
TBL_EMP	HIREDATE	입사일
TBL_EMP	SAL	        급여
TBL_EMP	COMM	    수당
TBL_EMP	DEPTNO	    부서번호
*/


-- ■■■ 기존 테이블에 컬럼 구조의 추가 및 제거 ■■■ --

SELECT *
FROM TBL_EMP;

-- ○ TBL_EMP 테이블에 주민등록번호 데이터를 담을 수 있는 컬럼 추가
ALTER TABLE TBL_EMP
ADD SSN CHAR(13);
--==>> Table TBL_EMP이(가) 변경되었습니다.

-- ※ 맨 앞에 0이 들어올 가능성이 있는 숫자가 조합된 데이터일 경우
--    숫자로만 구성된 데이터라 할지라도 숫자형이 아닌 
--    문자형으로 데이터타입을 구성해야 한다.

SELECT 0001234
FROM DUAL;
--==>> 1234

SELECT '0001234'
FROM DUAL;
--==>> 0001234

DESC TBL_EMP;
--==>>
/*
이름       널? 유형           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2)    
SSN         CHAR(13)    ◀◀◀   
*/

SELECT *
FROM TBL_EMP;
--> SSN 컬럼이 정상적으로 추가된 상황임을 확인

SELECT EMPNO, ENAME, SSN, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
FROM TBL_EMP;
--> 테이블 내에서 컬럼의 순서는 구조적으로 의미 없음

-- ○ TBL_EMP 테이블에서 추가한 SSN(주민등록번호) 컬럼 제거
ALTER TABLE TBL_EMP
DROP COLUMN SSN;
--==>> Table TBL_EMP이(가) 변경되었습니다.

-- ○ 확인
DESC TBL_EMP;
--==>>
/*
이름       널? 유형           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2)  
*/

SELECT *
FROM TBL_EMP;
--> SSN(주민등록번호) 컬럼이 정상적으로 제거되었음을 확인

DELETE
FROM TBL_EMP;

SELECT * 
FROM TBL_EMP;
--==>> 조회결과 없음
--> 테이블의 구조는 그대로 남아있는 상테에서
--  데이터 모두 소실(삭제)된 상황임을 확인

-- ○ 테이블을 구조적으로 제거
DROP TABLE TBL_EMP;
--==>> Table TBL_EMP이(가) 삭제되었습니다.

SELECT *
FROM TBL_EMP;
--==>> 에러 발생
/*
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:
607행, 6열에서 오류 발생
*/


-- ○ 테이블 다시 생성(EMP 테이블 복사)

CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP이(가) 생성되었습니다.



--------------------------------------------------------------------------------




-- ■■■ NULL의 처리 ■■■ --

SELECT 5, 10+5, 10*5, 10-5, 10/5
FROM DUAL;
--==>> 5	15	50	5	2

SELECT 5 "COL1", 10+5 "COL2", 10*5 "COL3", 10-5 "COL4", 10/5 "COL5"
FROM DUAL;
--==>> 5	15	50	5	2

SELECT NULL "COL1", NULL+5 "COL2", NULL*5 "COL3", NULL-5 "COL4", NULL/5 "COL5"
FROM DUAL;
--==>> (null) (null) (null) (null) (null)

SELECT NULL "COL1", 10+NULL "COL2", 10*NULL "COL3", 10-NULL "COL4", 10/NULL "COL5"
FROM DUAL;
--==>> (null) (null) (null) (null) (null)

-- ※ 관찰 결과
--    『NULL』은 상태의 값을 의미하며, 실제 존재하지 않는 값이기 때문에
--    오라클에서 이러한 NULL이 연산 과정에 포함될 경우 그 결과는 무조건 NULL이다.



-- ○ TBL_EMP 테이블에서 수당(COMM, 커미션)이 NULL인 직원의
--    사원명, 직종명, 급여, 수당 항목을 조회한다.

SELECT 사원명, 직종명, 급여, 수당
FROM TBL_EMP
WHERE 수당(COMM, 커미션)이 NULL;

SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM = NULL;
--==>> 조회 결과 없음

SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM = (null);
--==>> 조회 결과 없음

SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM = 'NULL';
--==>> 에러 발생        -- 데이터타입 불일치
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

DESC TBL_EMP;
--> COMM 컬럼은 숫자형 데이터 타입을 취하고 있음을 확인

-- ※『NULL』은 실제 존재하지 않는 값이기 때문에 일반적인 연산자를 활용하여 비교할 수 없다.
--    즉, 산술적인 비교 연산을 수행할 수 없다는 의미
--    NULL을 대상으로 사용할 수 없는 연산자들 
--    → >=, <=. >, <, =, !=, ^=. <>

SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM IS NULL;
--==>>
/*
SMITH	CLERK	    800	
JONES	MANAGER	    2975	
BLAKE	MANAGER	    2850	
CLARK	MANAGER	    2450	
SCOTT	ANALYST	    3000	
KING	PRESIDENT	5000	
ADAMS	CLERK	    1100	
JAMES	CLERK	    950	
FORD	ANALYST	    3000	
MILLER	CLERK	    1300	
*/


-- ○ TBL_EMP 테이블에서 20번 부서에 근무하지 않는 직원들의
--   사원번호, 사원명, 직종명, 부서번호 항목을 조회한다.

SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명, DEPTNO 부서번호
FROM TBL_EMP
WHERE 20번 부서에 근무하지 않는 직원;

SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명, DEPTNO 부서번호
FROM TBL_EMP
WHERE DEPTNO != 20;

SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명, DEPTNO 부서번호
FROM TBL_EMP
WHERE DEPTNO ^= 20;

SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명, DEPTNO 부서번호
FROM TBL_EMP
WHERE DEPTNO <> 20;
--==>>
/*
7499	ALLEN	SALESMAN	30
7521	WARD	SALESMAN	30
7654	MARTIN	SALESMAN	30
7698	BLAKE	MANAGER	    30
7782	CLARK	MANAGER	    10
7839	KING	PRESIDENT	10
7844	TURNER	SALESMAN	30
7900	    JAMES	CLERK	    30
7934	MILLER	CLERK	    10
*/


-- ○ TBL_EMP 테이블에서 커미션(수당, COMM)이 NULL이 아닌 직원들의
--    사원명, 직종명, 급여, 커미션 항목을 조회한다.

SELECT ENAME 사원명, JOB 직종명, SAL 급여, COMM 커미션
FROM TBL_EMP
WHERE 커미션(수당, COMM)이 NULL이 아니다.

SELECT ENAME 사원명, JOB 직종명, SAL 급여, COMM 커미션
FROM TBL_EMP
WHERE COMM IS NOT NULL;
--==>>
/*
ALLEN	SALESMAN	1600    	300
WARD	SALESMAN	1250	    500
MARTIN	SALESMAN	1250	    1400
TURNER	SALESMAN	1500    	0
*/

SELECT ENAME 사원명, JOB 직종명, SAL 급여, COMM 커미션
FROM TBL_EMP
WHERE NOT COMM IS NULL;
--==>>
/*
ALLEN	SALESMAN	1600    	300
WARD	SALESMAN	1250	    500
MARTIN	SALESMAN	1250	    1400
TURNER	SALESMAN	1500    	0
*/


-- ○ TBL_EMP 테이블에서 모든 사원들의
--    사원명, 사원번호, 급여, 커미션, 연봉 항목을 조회한다.
--    이 과정에서 급여(SAL)는 매일 지급하는 것으로 산정한다.
--    또한, 수당(COMM)은 매년 지급하는 것으로 간주한다.

SELECT *
FROM TBL_EMP;

SELECT ENAME "사원명", EMPNO "사원번호", SAL "급여", COMM "커미션"
       , (SAL * 12) + COMM "연봉" 
FROM TBL_EMP;

-- ○ NVL()
SELECT NULL "COL1", NVL(NULL, 10) "COL2", NVL(5, 10) "COL3"
FROM DUAL;
--==>> (null)   10    5
-- 첫 번째 파라미터 값이 NULL이면, 두 번째 파라미터 값을 반환한다.
-- 첫 번째 파라미터 값이 NULL이 아니면, 그 값(첫 번째 파라미터)을 그대로 반환한다.

SELECT ENAME "사원명", COMM "수당", NVL(COMM, 0) "수당처리"
FROM TBL_EMP
WHERE EMPNO = 7566;
--==>> JONES (null)	0

SELECT ENAME "사원명", EMPNO "사원번호", SAL "급여", COMM "커미션"
       , (SAL * 12) + NVL(COMM, 0) "연봉" 
FROM TBL_EMP;
--==>>
/*
SMITH	7369	800		    9600
ALLEN	7499	1600	  300	19500
WARD	7521	1250	  500	15500
JONES	7566	2975		35700
MARTIN	7654	1250	  1400	16400
BLAKE	7698	2850		    34200
CLARK	7782	2450		    29400
SCOTT	7788	3000		    36000
KING	7839	5000		    60000
TURNER	7844	1500	   0	    18000 
ADAMS	7876	1100		    13200
JAMES	7900    	950		    11400
FORD	7902    	3000		    36000
MILLER	7934	1300		    15600
*/

-- ○ NVL2()
--> 첫 번째 파라미터 값이 NULL이 아닌 경우, 두 번째 파라미터 값을 반환하고,
--  첫 번째 파라미터 값이 NULL인 경우, 세 번째 파라미터 값을 반환한다.

SELECT ENAME, COMM, NVL2(COMM, '청기올려','백기올려') "결과확인"
FROM TBL_EMP;
--==>> 
/*
SMITH		백기올려
ALLEN	300	청기올려
WARD	500	청기올려
JONES		백기올려
MARTIN	1400	청기올려
BLAKE		백기올려
CLARK		백기올려
SCOTT		백기올려
KING		백기올려
TURNER	0	청기올려
ADAMS		백기올려
JAMES		백기올려
FORD		백기올려
MILLER		백기올려
*/
SELECT ENAME "사원명", EMPNO "사원번호", SAL "급여", COMM "커미션"
       , NVL2(COMM, SAL * 12 + COMM, SAL * 12) "연봉" 
FROM TBL_EMP;

SELECT ENAME "사원명", EMPNO "사원번호", SAL "급여", COMM "커미션"
       , (SAL * 12) + NVL2(COMM, COMM, 0) "연봉" 
FROM TBL_EMP;
--==>>
/*
SMITH	7369	 800		     9600
ALLEN	7499	1600	  300	19500
WARD	7521	1250	  500	15500
JONES	7566	2975		35700
MARTIN	7654	1250	  1400	16400
BLAKE	7698	2850		    34200
CLARK	7782	2450		    29400
SCOTT	7788	3000		    36000
KING	7839	5000		    60000
TURNER	7844	1500	   0	    18000 
ADAMS	7876	1100		    13200
JAMES	7900    	 950		    11400
FORD	7902    	3000		    36000
MILLER	7934	1300		    15600
*/

-- ○ COALESCE()
--> 매개변수 제한이 없는 형태로 인지하고 활용할 수 있다.
--  맨 앞에 있는 매개변수부터 차례로 NULL인지 아닌지 확인하여
--  NULL이 아닐 경우 적용(반환, 처리)하고,
--  NULL인 경우에는 그 다음 매개변수 값으로 적용(반환, 처리)한다.
--  NVL()함수나 NVL2()함수와 비교해서
--  모든 경우의 수를 고려할 수 있는 특징을 가지고 있다.

SELECT NULL "기본확인"
        , COALESCE(NULL, NULL, NULL, NULL, 10) "결과확인 1"
        , COALESCE(NULL, NULL, NULL, NULL, NULL, NULL, 20) "결과확인 2"
        , COALESCE(NULL, NULL, 30, NULL, NULL, NULL, 10) "결과확인 3"
FROM DUAL;
--==>> (null) 10 20	30

-- ○ 실습 환경 조성을 위한 추가 데이터 입력
INSERT INTO TBL_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO)
VALUES(8000, '조세빈', 'SALESMAN', 7839, SYSDATE, 10);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, COMM, DEPTNO)
VALUES(8001, '정세찬', 'SALESMAN', 7839, SYSDATE, 100, 10);
--==>> 1 행 이(가) 삽입되었습니다.


--○ 확인
SELECT *
FROM TBL_EMP;
--==>>
/*
                                :
                                :
8000    	조세빈	SALESMAN	7839	25/12/31 (null)	 (null)	10	
8001	    정세찬	SALESMAN	7839	25/12/31 (null)		100	10	
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.

ALTER TABLE TBL_EMP
DROP COLUMN YSAL;


SELECT ENAME "사원명", EMPNO "사원번호", SAL "급여", COMM "커미션"
       , (SAL * 12) + NVL(COMM, 0) "연봉" 
FROM TBL_EMP;

SELECT ENAME "사원명", EMPNO "사원번호", SAL "급여", COMM "커미션"
       , (SAL * 12) + NVL2(COMM, COMM, 0) "연봉" 
FROM TBL_EMP;

SELECT  ENAME "사원명", EMPNO "사원번호", SAL "급여", COMM "커미션"
        , COALESCE(SAL*12+COMM, (SAL*12), COMM , 0) "연봉"
FROM TBL_EMP;
--==>>
/*
SMITH	7369	800		9600
ALLEN	7499	1600	300	19500
WARD	7521	1250	500	15500
JONES	7566	2975		35700
MARTIN	7654	1250	1400	16400
BLAKE	7698	2850		34200
CLARK	7782	2450		29400
SCOTT	7788	3000		36000
KING	7839	5000		60000
TURNER	7844	1500	0	18000
ADAMS	7876	1100		13200
JAMES	7900	    950		11400
FORD	7902	    3000		36000
MILLER	7934	1300		15600
조세빈	8000			        0
정세찬	8001		100	      100
*/


--------------------------------------------------------------------------------


SELECT SYSDATE
FROM DUAL;
--==>> 25/12/31                 → YY/MM/DD

--※ 날짜와 시간에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

SELECT SYSDATE
FROM DUAL;
--==>> 2025-12-31 14:40:21      → YYYY-MM-DD HH24:MI:SS


--○ 현재 날짜 및 시간을 반환하는 주요 함수
SELECT SYSDATE, CURRENT_DATE, LOCALTIMESTAMP
FROM DUAL;
--==>> 
/*
2025-12-31 14:42:53	
2025-12-31 14:42:53	
25/12/31 14:42:53.000000000
*/


--※ 날짜와 시간에 대한 세션 설정 다시 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

--○ 변경 이후 다시 조희
--   현재 날짜 및 시간을 반환하는 주요 함수
SELECT SYSDATE, CURRENT_DATE, LOCALTIMESTAMP
FROM DUAL;
--==>>
/*
2025-12-31	
2025-12-31	
25/12/31 14:44:13.000000000
*/

--○ 컬럼과 컬럼의 연결(결합)
--   문자 타입과 문자 타입의 연결
--   『+』연산자를 통합 결합 수행은 불가능 → 『||』 사용

SELECT 1 + 1
FROM DUAL;
--==>> 2

SELECT '윤주열', '유현선'
FROM DUAL;
--==>> 윤주열	유현선

SELECT '윤주열' + '유현선'
FROM DUAL;
--==>> 에러 발생
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

SELECT '윤주열' || '유현선'
FROM DUAL;
--==>> 윤주열유현선

SELECT ENAME, JOB
FROM TBL_EMP;
--==>>
/*
SMITH	CLERK
ALLEN	SALESMAN
WARD	SALESMAN
JONES	MANAGER
MARTIN	SALESMAN
BLAKE	MANAGER
CLARK	MANAGER
SCOTT	ANALYST
KING	PRESIDENT
TURNER	SALESMAN
ADAMS	CLERK
JAMES	CLERK
FORD	ANALYST
MILLER	CLERK
조세빈	SALESMAN
정세찬	SALESMAN
*/

SELECT ENAME || JOB
FROM TBL_EMP;
--==>>
/*
SMITHCLERK
ALLENSALESMAN
WARDSALESMAN
JONESMANAGER
MARTINSALESMAN
BLAKEMANAGER
CLARKMANAGER
SCOTTANALYST
KINGPRESIDENT
TURNERSALESMAN
ADAMSCLERK
JAMESCLERK
FORDANALYST
MILLERCLERK
조세빈SALESMAN
정세찬SALESMAN
*/

DESC TBL_EMP;
--==>>
/*
이름       널? 유형           
-------- -- ------------ 
EMPNO       NUMBER(4)       --  숫자 타입 
ENAME       VARCHAR2(10)    --  문자 타입
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2)  
*/

SELECT EMPNO || ENAME
FROM TBL_EMP;
--==>>
/*
7369SMITH
7499ALLEN
7521WARD
7566JONES
7654MARTIN
7698BLAKE
7782CLARK
7788SCOTT
7839KING
7844TURNER
7876ADAMS
7900JAMES
7902FORD
7934MILLER
8000조세빈
8001정세찬
*/

--      문자타입    날짜      문자     숫자       문자
--     __________  _______  ________   ___    _____________
SELECT '주열이는', SYSDATE, '에 연봉', 500 , '억을 희망한다.'
FROM DUAL;
--==>> 주열이는	2025-12-31	에 연봉	500	억을 희망한다.


--      문자타입      날짜        문자      숫자          문자
--     __________    _______    ________     ___      _____________
SELECT '주열이는 '|| SYSDATE || '에 연봉' || 500  || '억을 희망한다.'
FROM DUAL;
--==>> 주열이는 2025-12-31에 연봉500억을 희망한다.

-- ※ 오라클에서는 문자 타입의 형태로 타입을 변환하는 별도의 과정 없이
--    위에서 처리한 내용처럼 『||』만 삽입해주면 간단히 컬럼과 컬럼을
--    (서로 다른 종류의 데이터) 결합하는 것이 가능하다.
--    이와 비교하여 MS-SQL에서는 모든 데이터를 문자 타입으로 CONVERT해야한다.

SELECT *
FROM TBL_EMP;

--○ TBL_EMP 테이블의 데이터를 활용하여
--   모든 직원들의 데이터에 대해
--   다음과 같은 결과를 얻을 수 있도록 쿼리문을 구성한다.

-- SMITH의 현재 연봉은 9600인데, 희망 연봉은 19200이다.
-- ALLEN의 현재 연봉은 19500인데, 희망 연봉은 39000이다.
--                               :
--                               :


-- 실습 진행 전에 세빈, 세찬 사원 제거
SELECT *
FROM TBL_EMP
WHERE EMPNO = 8000 OR EMPNO = 8001;

SELECT *
FROM TBL_EMP
WHERE EMPNO IN(8000, 8001);

DELETE
FROM TBL_EMP
WHERE EMPNO IN(8000, 8001);
--==>> 2개 행 이(가) 삭제되었습니다.

--○ 확인
SELECT *
FROM TBL_EMP;
--> 원하는 데이터가 제대로 삭제되었음을 확인

-- 커밋
COMMIT;
--==>> 커밋 완료.

-- SMITH의 현재 연봉은 9600인데, 희망 연봉은 19200이다.
-- ALLEN의 현재 연봉은 19500인데, 희망 연봉은 39000이다.
SELECT ENAME || '의 현재 연봉은 ' || COALESCE(SAL*12+COMM, SAL*12, COMM, 0) 
        || '인데, 희망 연봉은 ' || COALESCE((SAL*12+COMM)*2, SAL*12*2, COMM*2, 0) || '이다.' 
FROM TBL_EMP;
--==>> 
/*
SMITH의 현재 연봉은 9600인데, 희망 연봉은 19200이다.
ALLEN의 현재 연봉은 19500인데, 희망 연봉은 39000이다.
WARD의 현재 연봉은 15500인데, 희망 연봉은 31000이다.
JONES의 현재 연봉은 35700인데, 희망 연봉은 71400이다.
MARTIN의 현재 연봉은 16400인데, 희망 연봉은 32800이다.
BLAKE의 현재 연봉은 34200인데, 희망 연봉은 68400이다.
CLARK의 현재 연봉은 29400인데, 희망 연봉은 58800이다.
SCOTT의 현재 연봉은 36000인데, 희망 연봉은 72000이다.
KING의 현재 연봉은 60000인데, 희망 연봉은 120000이다.
TURNER의 현재 연봉은 18000인데, 희망 연봉은 36000이다.
ADAMS의 현재 연봉은 13200인데, 희망 연봉은 26400이다.
JAMES의 현재 연봉은 11400인데, 희망 연봉은 22800이다.
FORD의 현재 연봉은 36000인데, 희망 연봉은 72000이다.
MILLER의 현재 연봉은 15600인데, 희망 연봉은 31200이다.
*/


-- 방식1
SELECT ENAME || '의 현재 연봉은 ' || NVL(SAL*12+COMM, SAL*12) 
        || '인데, 희망 연봉은 ' || NVL(SAL*12+COMM, SAL*12)*2 || '이다.' 
FROM TBL_EMP;

-- 방식2
SELECT ENAME || '의 현재 연봉은 ' || NVL2(COMM, SAL*12+COMM, SAL*12) 
        || '인데, 희망 연봉은 ' || NVL2(COMM, SAL*12+COMM, SAL*12)*2 || '이다.' 
FROM TBL_EMP;

-- 방식3
SELECT ENAME || '의 현재 연봉은 ' || COALESCE(SAL*12+COMM, SAL*12, COMM, 0) 
        || '인데, 희망 연봉은 ' || COALESCE((SAL*12+COMM), SAL*12, COMM, 0)*2 || '이다.' 
FROM TBL_EMP;

SELECT *
FROM TBL_EMP;


-- SMITH's 입사일은 1980-12-17이다. 그리고 급여는 800이다.
-- ALLEN's 입사일은 1981-02-20이다. 그리고 급여는 1600이다.
--                              :
--                              :

SELECT ENAME || '''s 입사일은 ' || HIREDATE || '이다. 그리고 급여는 ' || SAL ||' 이다.'
FROM TBL_EMP;
--==>>
/*
SMITH's 입사일은 1980-12-17이다. 그리고 급여는 800 이다.
ALLEN's 입사일은 1981-02-20이다. 그리고 급여는 1600 이다.
WARD's 입사일은 1981-02-22이다. 그리고 급여는 1250 이다.
JONES's 입사일은 1981-04-02이다. 그리고 급여는 2975 이다.
MARTIN's 입사일은 1981-09-28이다. 그리고 급여는 1250 이다.
BLAKE's 입사일은 1981-05-01이다. 그리고 급여는 2850 이다.
CLARK's 입사일은 1981-06-09이다. 그리고 급여는 2450 이다.
SCOTT's 입사일은 1987-07-13이다. 그리고 급여는 3000 이다.
KING's 입사일은 1981-11-17이다. 그리고 급여는 5000 이다.
TURNER's 입사일은 1981-09-08이다. 그리고 급여는 1500 이다.
ADAMS's 입사일은 1987-07-13이다. 그리고 급여는 1100 이다.
JAMES's 입사일은 1981-12-03이다. 그리고 급여는 950 이다.
FORD's 입사일은 1981-12-03이다. 그리고 급여는 3000 이다.
MILLER's 입사일은 1982-01-23이다. 그리고 급여는 1300 이다.
*/

--※ 문자열을 나타내는 홑따옴표 사이에서(시작과 끝)
--   홑따옴표 두 개가 홑따옴표 하나(어퍼스트로피)를 의미한다.
--   홑따옴표 『'』 하나는 문자열의 시작을 나타내고
--   홑따옴표 『''』 두 개는 문자열 영역 안에서 어퍼스트로피를 나타내며
--   다시 등장하는 홑따옴표 『'』 하나가 문자열 영역의 종료를 의미하게 되는 것이다.

SELECT *
FROM EMP
WHERE JOB = 'SALESMAN';
--==>>
/*
7499	ALLEN	SALESMAN	7698	1981-02-20	1600    	300	30
7521	WARD	SALESMAN	7698	1981-02-22	1250    	500	30
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	    1400	30
7844	TURNER	SALESMAN	7698	1981-09-08	1500	    0	30
*/

SELECT *
FROM EMP
WHERE JOB = 'salesman';
--==>> 조회 결과 없음


-- ○ UPPER(), LOWER(), INITCAP()
SELECT 'oRacLe' "COL1", UPPER('oRacLe') "COL2", LOWER('oRacLe') "COL3", INITCAP('oRacLe') "COL4"
FROM DUAL;
--==>> oRacLe	ORACLE	oracle	Oracle
--> UPPER()는 모두 대문자로 변환하여 반환
--  LOWER()는 모두 소문자로 변환하여 반환
--  INITCAP()은 첫 글자만 대문자로 하고 나머지는 모두 소문자로 변환하여 반환


-- ○ 실습 환경 조성을 위한 추가 데이터 입력
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(8000, '강명철', 'saLesMAN', 7698, SYSDATE, 2000, 200, 30);
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(8001, '안진모', 'saLesMan', 7698, SYSDATE, 2000, 200, 30);
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(8002, '앙호열', 'salesman', 7698, SYSDATE, 2000, 200, 30);
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(8003, '유현선', 'SALEsman', 7698, SYSDATE, 2000, 200, 30);
--==>> 1 행 이(가) 삽입되었습니다. * 4

SELECT *
FROM TBL_EMP;
--==>>
/*
                        :
                        :
8000	    강명철	saLesMAN	7698	2025-12-31	2000	200	30
8001	    안진모	saLesMan	7698	2025-12-31	2000	200	30
8002	    앙호열	salesman	7698	2025-12-31	2000	200	30
8003    	유현선	SALEsman	7698	2025-12-31	2000	200	30
*/

--○ 커밋
COMMIT;
--==>>커밋 완료. 

--○ TBL_EMP 테이블에서 대소문자 구분 없이 세일즈맨 직종인 사원의
--   사원번호, 사원명, 직종, 입사일, 부서번호 항목을 조회한다.
--   (세일즈맨: SALESMAN, saLesMAN, saLesMan, salesman,SALEsman)

SELECT EMPNO, ENAME, JOB, HIREDATE, DEPTNO
FROM TBL_EMP
WHERE JOB = '세일즈맨';

SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종", HIREDATE "입사일", DEPTNO "부서번호"
FROM TBL_EMP
WHERE JOB = '세일즈맨';
    -- 'saLesMAN', 'SALESMAN', 'saLesMan', 'salesman', 'SALEsman'
SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종", HIREDATE "입사일", DEPTNO "부서번호"
FROM TBL_EMP
WHERE JOB = 'saLesMAN' OR JOB = 'SALESMAN' OR JOB = 'saLesMan' OR JOB = 'salesman' OR JOB = 'SALEsman'  ;
--==>>
/*
7499	ALLEN	SALESMAN	1981-02-20	30
7521	WARD	SALESMAN	1981-02-22	30
7654	MARTIN	SALESMAN	1981-09-28	30
7844	TURNER	SALESMAN	1981-09-08	30
8000	    강명철	saLesMAN	2025-12-31	30
8001	    안진모	saLesMan	2025-12-31	30
8002    	앙호열	salesman	2025-12-31	30
8003	    유현선	SALEsman	2025-12-31	30
*/

SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종", HIREDATE "입사일", DEPTNO "부서번호"
FROM TBL_EMP
WHERE JOB IN ('saLesMAN', 'SALESMAN', 'saLesMan', 'salesman', 'SALEsman');
--==>>
/*
7499	ALLEN	SALESMAN	1981-02-20	30
7521	WARD	SALESMAN	1981-02-22	30
7654	MARTIN	SALESMAN	1981-09-28	30
7844	TURNER	SALESMAN	1981-09-08	30
8000	    강명철	saLesMAN	2025-12-31	30
8001    	안진모	saLesMan	2025-12-31	30
8002    	앙호열	salesman	2025-12-31	30
8003	    유현선	SALEsman	2025-12-31	30
*/


--○ 관찰
SELECT EMPNO "사원번호", ENAME "사원명", UPPER(JOB) "직종", HIREDATE "입사일", DEPTNO "부서번호"
FROM TBL_EMP
WHERE WHERE JOB IN ('saLesMAN', 'SALESMAN', 'saLesMan', 'salesman', 'SALEsman');;



SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종", HIREDATE "입사일", DEPTNO "부서번호"
FROM TBL_EMP
WHERE UPPER(JOB) = 'SALESMAN';

SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종", HIREDATE "입사일", DEPTNO "부서번호"
FROM TBL_EMP
WHERE LOWER(JOB) = 'salesman';

SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종", HIREDATE "입사일", DEPTNO "부서번호"
FROM TBL_EMP
WHERE INITCAP(JOB) = 'Salesman';

SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종", HIREDATE "입사일", DEPTNO "부서번호"
FROM TBL_EMP
WHERE JOB = 사용자입력값;

SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종", HIREDATE "입사일", DEPTNO "부서번호"
FROM TBL_EMP
WHERE UPPER(JOB) = UPPER(사용자입력값);


--○ TBL_EMP 테이블에서 입사일이 1981년 9월 28일 입사한 직원의
--   사원명, 직종명, 입사일 항목을 조회한다.

SELECT 사원명, 직종명, 입사일
FROM TBL_EMP
WHERE 입사일이 1981년 9월 28일

SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE = 1981-09-28;
--==>> 에러발생
-- 뺄셈연산해버림

DESC TBL_EMP;
--==>>
/*
        :
HIREDATE  DATE
        :
*/

SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE = '1981-09-28';
--==>> MARTIN	SALESMAN	1981-09-28
-- 하지만 틀린 문법임 (오라클이 자동 형변환을 해줘서 나온 것임)

--○ TO_DATE()
SELECT 2025-12-31 "COL1"
      ,'2025-12-31' "COL2"
      , TO_DATE('2025-12-31', 'YYYY-MM-DD') "COL3"
FROM DUAL;
--==>> 1982	2025-12-31	2025-12-31

SELECT TO_DATE('2025-13-05', 'YYYY-MM-DD') "결과확인"
FROM DUAL;
--==>> 에러 발생
/*
ORA-01843: not a valid month
01843. 00000 -  "not a valid month"
*Cause:    
*Action:
*/

SELECT TO_DATE('2025-11-31' ,'YYYY-MM-DD') "결과확인"
FROM DUAL;
--==>> 에러 발생
/*
ORA-01839: date not valid for month specified
01839. 00000 -  "date not valid for month specified"
*Cause:    
*Action:
*/

SELECT TO_DATE('2040-02-29', 'YYYY-MM-DD') "결과확인"
FROM DUAL;
--==>> 2040-02-29

SELECT TO_DATE('2026-02-29', 'YYYY-MM-DD') "결과확인"
FROM DUAL;
--==>> 에러 발생
/*
ORA-01839: date not valid for month specified
01839. 00000 -  "date not valid for month specified"
*Cause:    
*Action:
*/

SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE = TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>> MARTIN	SALESMAN	1981-09-28


-- ○ TBL_EMP 테이블에서 입사일이 1981년 9월 28일 이후(해당일 포함)
--    입사한 직원의 사원명, 직종명, 입사일 항목을 조회한다.
SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE  입사일이 1981년 9월 28일 이후(해당일 포함);

SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE  HIREDATE가 TO_DATE('1981-09-28', 'YYYY-MM-DD') 이후(해당일 포함);

-- ※ 오라클에서는 날짜 데이터의 크기 비교가 가능하다.
--    오라클에서 날짜 데이터에 대한 크기 비교 시
--    과거보다 미래를 더 큰 값으로 간주하여 처리한다.

SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>>
/*
MARTIN	SALESMAN	1981-09-28
SCOTT	ANALYST	    1987-07-13
KING	PRESIDENT	1981-11-17
ADAMS	CLERK	    1987-07-13
JAMES	CLERK	    1981-12-03
FORD	ANALYST	    1981-12-03
MILLER	CLERK	    1982-01-23
강명철	saLesMAN	2025-12-31
안진모	saLesMan	2025-12-31
앙호열	salesman	2025-12-31
유현선	SALEsman	2025-12-31
*/


-- ○TBL_EMP 테이블에서 입사일이 1981년 4월 2일부터
--   1981년 9월 28일 사이에 입사한 직원들의
--   사원번호, 사원명, 직종명, 입사일 항목을 조회한다.(해당일 포함)

SELECT 사원번호, 사원명, 직종명, 입사일
FROM TBL_EMP
WHERE  1981년 4월 2일 <= 입사일 <= 1981년 9월 28일; 

SELECT 사원번호, 사원명, 직종명, 입사일
FROM TBL_EMP
WHERE  1981년 4월 2일 <= 입사일 
        AND  입사일 <= 1981년 9월 28일;
        
SELECT 사원번호, 사원명, 직종명, 입사일
FROM TBL_EMP
WHERE HIREDATE >= 1981년 4월 2일
 AND  HIREDATE <= 1981년 9월 28일;

SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02','YYYY-MM-DD')
  AND HIREDATE <= TO_DATE('1981-09-28','YYYY-MM-DD');
--==>>
/*
JONES	MANAGER	    1981-04-02
MARTIN	SALESMAN	1981-09-28
BLAKE	MANAGER	    1981-05-01
CLARK	MANAGER	    1981-06-09
TURNER	SALESMAN	1981-09-08
*/


-- ○ BETWEEN ⓐ AND ⓑ  → 날짜를 대상으로 적용
SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE BETWEEN TO_DATE('1981-04-02','YYYY-MM-DD') 
                   AND TO_DATE('1981-09-28','YYYY-MM-DD');
--==>>
/*
JONES	MANAGER	    1981-04-02
MARTIN	SALESMAN	1981-09-28
BLAKE	MANAGER	    1981-05-01
CLARK	MANAGER	    1981-06-09
TURNER	SALESMAN	1981-09-08
*/                  

-- ○ BETWEEN ⓐ AND ⓑ  → 숫자를 대상으로 적용           
SELECT EMPNO, ENAME, SAL
FROM TBL_EMP
WHERE SAL BETWEEN 1600 AND 2850;
--==>>
/*
7499	ALLEN	1600
7698	BLAKE	2850
7782	CLARK	2450
8000	    강명철	2000
8001	    안진모	2000
8002	    앙호열	2000
8003	    유현선	2000
*/

-- ○ BETWEEN ⓐ AND ⓑ  → 문자를 대상으로 적용     
SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE ENAME BETWEEN 'C' AND 'S';
--==>>
/*
7566	JONES	MANAGER	    2975
7654	MARTIN	SALESMAN	1250
7782	CLARK	MANAGER	    2450
7839	KING	PRESIDENT	5000
7900	    JAMES	CLERK	    950
7902	    FORD	ANALYST	    3000
7934	MILLER	CLERK	    1300
*/

-- ※ 『BETWEEN ⓐ AND ⓑ』는 날짜형, 숫자형, 문자형 데이터 모두를 대상으로 사용할 수 있다.
--   단, 문자형일 경우 아스키코드 순서를 따르기 때문에(사전식 배열9
--   대문자가 앞쪽에 위치하고, 소문자가 뒤쪽에 위치하며
--   『BETWEEN ⓐ AND ⓑ』는 쿼리문이 수행되는 시점에서
--   오라클 내부적으로는 부등호 연산자의 형태로 바뀌어 연산이 처리된다.

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE ENAME BETWEEN 'C' AND 's';
--                   67      115

                   
--○ ASCII()
SELECT ASCII('A') "COL1", ASCII('B') "COL2"
        ,ASCII('a') "COL3",ASCII('b') "COL4"
FROM DUAL;
--==>> 65	66	97	98

SELECT *
FROM TBL_EMP
WHERE EMPNO BETWEEN 8000 AND 8003;
--==>>
/*
8000	강명철	saLesMAN	7698	2025-12-31	2000	200	30
8001	안진모	saLesMan	7698	2025-12-31	2000	200	30
8002	앙호열	salesman	7698	2025-12-31	2000	200	30
8003	유현선	SALEsman	7698	2025-12-31	2000	200	30
*/

DELETE
FROM TBL_EMP
WHERE EMPNO BETWEEN 8000 AND 8003;              
--==>> 4개 행 이(가) 삭제되었습니다.          

-- 확인
SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	7902	1980-12-17	800		20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	300	30
7521	WARD	SALESMAN	7698	1981-02-22	1250	500	30
7566	JONES	MANAGER	7839	1981-04-02	2975		20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7698	BLAKE	MANAGER	7839	1981-05-01	2850		30
7782	CLARK	MANAGER	7839	1981-06-09	2450		10
7788	SCOTT	ANALYST	7566	1987-07-13	3000		20
7839	KING	PRESIDENT		1981-11-17	5000		10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	0	30
7876	ADAMS	CLERK	7788	1987-07-13	1100		20
7900	JAMES	CLERK	7698	1981-12-03	950		30
7902	FORD	ANALYST	7566	1981-12-03	3000		20
7934	MILLER	CLERK	7782	1982-01-23	1300		10
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ TBL_EMP 테이블에서 직종이 SALESMAN과 CLERK인 사원의
--   사원번호, 사원명, 직종명, 급여 항목을 조회한다.
SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종명", SAL "급여"
FROM TBL_EMP
WHERE JOB = 'SALESMAN' OR JOB ='CLERK';
--==>>
/*
7369	SMITH	CLERK	     800
7499	ALLEN	SALESMAN	1600
7521	WARD	SALESMAN	1250
7654	MARTIN	SALESMAN	1250
7844	TURNER	SALESMAN	1500
7876	ADAMS	CLERK	    1100
7900	    JAMES	CLERK	     950
7934	MILLER	CLERK	    1300
*/

SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종명", SAL "급여"
FROM TBL_EMP
WHERE JOB IN('SALESMAN','CLERK');
--==>>
/*
7369	SMITH	CLERK	     800
7499	ALLEN	SALESMAN	1600
7521	WARD	SALESMAN	1250
7654	MARTIN	SALESMAN	1250
7844	TURNER	SALESMAN	1500
7876	ADAMS	CLERK	    1100
7900	    JAMES	CLERK	     950
7934	MILLER	CLERK	    1300
*/

SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종명", SAL "급여"
FROM TBL_EMP
WHERE JOB = ANY('SALESMAN','CLERK');
--==>>
/*
7369	SMITH	CLERK	     800
7499	ALLEN	SALESMAN	1600
7521	WARD	SALESMAN	1250
7654	MARTIN	SALESMAN	1250
7844	TURNER	SALESMAN	1500
7876	ADAMS	CLERK	    1100
7900	    JAMES	CLERK	     950
7934	MILLER	CLERK	    1300
*/

-- ※ 위의 세 가지 유형의 퀴리문은 모두 같은 결과를 반환한다.
--    하지만, 맨 위의 쿼리문이 가장 빠르게 처리된다.
--    물론, 메모리에 대한 내용이 아니라 CPU에 대한 내용이므로
--    이 부분까지 감안해서 쿼리문의 내용을 구분하고 구성하는 일은 많지 않다.
--    → 『IN』과 『=ANY』는 같은 연산 효과를 가진다.
--       모두 내부적으로는 논리식의 OR구조로 변경되어 연산 처리된다.




--------------------------------------------------------------------------------

-- ※ 추가 실습 환경 구성을 위한 테이블 생성
-- 테이블: TBL_SAWON

CREATE TABLE TBL_SAWON
(SANO       NUMBER(4)
,SANAME     VARCHAR2(30)
,JUBUN      CHAR(13)
,HIREDATE   DATE     DEFAULT SYSDATE
,SAL        NUMBER(10)
);
--==>> Table TBL_SAWON이(가) 생성되었습니다.

SELECT *
FROM TBL_SAWON;
--==>> 조회 결과 없음

DESC TBL_SAWON;
--==>>
/*
이름       널? 유형           
-------- -- ------------ 
SANO        NUMBER(4)    
SANAME      VARCHAR2(30) 
JUBUN       CHAR(13)     
HIREDATE    DATE         
SAL         NUMBER(10)   
*/


--○ 데이터 입력
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1001, '조세빈', '9804112234567', TO_DATE('2011-01-03', 'YYYY-MM-DD'), 3000);
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1002, '강명철', '0002113234567', TO_DATE('2017-01-05', 'YYYY-MM-DD'), 2000);
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1003, '이수빈', '9709061234567', TO_DATE('2005-08-16', 'YYYY-MM-DD'), 5000);
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1004, '정세찬', '9104281234567', TO_DATE('1998-02-10', 'YYYY-MM-DD'), 6000);
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1005, '이재용', '7512121234567', TO_DATE('1990-10-10', 'YYYY-MM-DD'), 2000);
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1006, '이이영', '8904051234567', TO_DATE('2009-06-05', 'YYYY-MM-DD'), 1000);
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1007, '아이유', '9304022234567', TO_DATE('2012-07-13', 'YYYY-MM-DD'), 3000);
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1008, '이상이', '8512162234567', TO_DATE('1999-08-16', 'YYYY-MM-DD'), 2000);
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1009, '남궁민', '0102033234567', TO_DATE('2010-07-01', 'YYYY-MM-DD'), 1000);
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1010, '윤주열', '0502203234567', TO_DATE('2015-10-20', 'YYYY-MM-DD'), 3000);
--==>> 1 행 이(가) 삽입되었습니다. * 10

SELECT *
FROM TBL_SAWON;
--==>>
/*
1001	조세빈	9804112234567	2011-01-03	3000
1002	강명철	0002113234567	2017-01-05	2000
1003	이수빈	9709061234567	2005-08-16	5000
1004	정세찬	9104281234567	1998-02-10	6000
1005	이재용	7512121234567	1990-10-10	2000
1006	이이영	8904051234567	2009-06-05	1000
1007	아이유	9304022234567	2012-07-13	3000
1008	이상이	8512162234567	1999-08-16	2000
1009	남궁민	0102033234567	2010-07-01	1000
1010	윤주열	0502203234567	2015-10-20	3000
*/

COMMIT;
--==>> 커밋 완료.





