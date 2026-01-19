SELECT USER
FROM DUAL;
--==>> SCOTT



-- 분석 함수
-- - 집계 함수
-- - 그룹 함수
-- - 윈도우 함수


-- 집계 함수
-- SUM() 합, AVG() 평균, COUNT() 카운트, MAX() 최대값, MIN() 최소값
-- , VARIANCE() 분산, STDDEV() 표준편차
-- → 다중 행을 대상으로 처리한 단일 결과 반환
--    처리해야 할 데이터들 중 NULL이 존재하면 
--    이 NULL은 제외하고 연산을 수행

SELECT COMM
FROM EMP;

-- SUM()
-- EMP 테이블을 대상으로 전체 사원들의 급여 총 합을 조회한다.

SELECT SUM(SAL) "결과확인"
FROM EMP;
--==>> 29025
--> 800 + 1600 + 1250 + 2975 + 1250 + 2850 + 2450 + 3000 + 5000 + 1500 + 1100 + 950 + 3000 + 1300

SELECT SUM(COMM) "결과확인"
FROM EMP;
--==>> 2200
--> (null) + 300 + 500 + (null) + 1400 + (null) + (null) + (null) + (null) + 0 + (null) + (null) + (null) + (null) = (null) 
-- 300 + 500 + 1400 + 0         -- (null)을 연산과정에 애초에 포함시키지 않는다.


-- COUNT()
-- 행의 갯수를 조회하여 결과값 반환
SELECT COUNT(ENAME) "결과확인"
FROM EMP;
--==>> 14

SELECT COUNT(COMM) "결과확인"
FROM EMP;
--==>> 4        -- (null)은 카운트하지 않음

SELECT COUNT(*) "결과확인"
FROM EMP;
--==>> 14       -- 일반적으로 전체를 대상으로 카운트를 함

-- AVG()
-- 평균 반환
SELECT AVG(SAL) "결과확인"
FROM EMP;
--==>> 2073.214285714285714285714285714285714286

SELECT SUM(SAL) / COUNT(SAL) "결과확인"
FROM EMP;
--==>> 2073.214285714285714285714285714285714286

SELECT AVG(COMM) "결과확인"
FROM EMP;
--==>> 550

SELECT SUM(COMM) / COUNT(COMM) "결과확인"
FROM EMP;
--==>> 550

SELECT SUM(COMM) / COUNT(*) "결과확인"
FROM EMP;
--==>> 157.142857142857142857142857142857142857


--※ 표준편차의 제곱이 분산
--   분산의 제곱근이 표준편차
SELECT AVG(SAL), VARIANCE(SAL), STDDEV(SAL)
FROM EMP;
--==>> 
/*
2073.214285714285714285714285714285714286	    → 급여 평균
1398313.87362637362637362637362637362637	    → 급여 분산
1182.503223516271699458653359613061928508       → 급여 표준편차
*/

SELECT POWER(STDDEV(SAL), 2) "급여표준편차제곱"
    , VARIANCE(SAL) "급여분산"
FROM EMP;
--==>>
/*
1398313.87362637362637362637362637362637
1398313.87362637362637362637362637362637
*/

SELECT SQRT(VARIANCE(SAL)) "급여분산제곱근"
    , STDDEV(SAL) "급여표준편차"
FROM EMP;
--==>>
/*
1182.503223516271699458653359613061928508
1182.503223516271699458653359613061928508
*/


-- MAX() / MIN()
-- 최대값 / 최소값 반환

SELECT MAX(SAL) "COL1"
    , MIN(SAL) "COL2"
FROM EMP;
--==>> 5000 800


--※ 주의
SELECT ENAME, SAL
FROM EMP;
--==>>
/*
SMITH	 800
ALLEN	1600
WARD	1250
JONES	2975
MARTIN	1250
BLAKE	2850
CLARK	2450
SCOTT	3000
KING	5000
TURNER	1500
ADAMS	1100
JAMES	 950
FORD	3000
MILLER	1300
*/

SELECT ENAME, SUM(SAL) "결과확인"
FROM EMP;
--==>> 에러 발생
/*
ORA-00937: not a single-group group function
00937. 00000 -  "not a single-group group function"
*Cause:    
*Action:
1,467행, 8열에서 오류 발생
*/

SELECT DEPTNO, SUM(SAL) "결과확인"
FROM EMP;
--==>> 에러 발생
/*
ORA-00937: not a single-group group function
00937. 00000 -  "not a single-group group function"
*Cause:    
*Action:
1,479행, 8열에서 오류 발생
*/

SELECT DEPTNO, SUM(SAL) "결과확인"
FROM EMP
GROUP BY DEPTNO;
--==>>
/*
30	 9400
20	10875
10	 8750
*/

SELECT DEPTNO, SUM(SAL) "결과확인"
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
--==>>
/*
10	 8750
20	10875
30	 9400
*/

SELECT DEPTNO "부서번호",  SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY DEPTNO;
--==>>
/*
30	 9400
20	15875
10	 8750
*/

SELECT DEPTNO "부서번호",  SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
    10	  8750
    20	 15875
    30	  9400
(null)	 34025
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--=>> Session이(가) 변경되었습니다.


SELECT *
FROM TBL_EMP;

SELECT *
FROM TBL_EMP
WHERE EMPNO = 9000;

DELETE
FROM TBL_EMP
WHERE EMPNO = 9000;
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_EMP;

COMMIT;
--==>> 커밋 완료.

--○ 실습 환경 구성을 위한 추가 데이터 입력
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(8001, '고윤정', 'CLERK', 7566, SYSDATE, 1500, 10, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(8002, '하성운', 'CLERK', 7566, SYSDATE, 1000, 0, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(8003, '김다미', 'SALESMAN', 7698, SYSDATE, 2000, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(8004, '아이유', 'SALESMAN', 7698, SYSDATE, 2500, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(8005, '카리나', 'SALESMAN', 7698, SYSDATE, 1000, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_EMP;
--==>>
/*
                         :
8001	고윤정	CLERK	    7566	2026-01-07	1500	    10	
8002	하성운	CLERK	    7566	2026-01-07	1000	    0 	
8003	김다미	SALESMAN	7698	2026-01-07	2000		
8004	아이유	SALESMAN	7698	2026-01-07	2500		
8005	카리나	SALESMAN	7698	2026-01-07	1000		
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.


SELECT DEPTNO "부서번호",  SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
    10	 8750
    20	10875
    30	 9400
(null)	 8000       -- 부서번호가 NULL인 데이터들끼리의 급여 합
(null)	37025       -- 모든 부서의 급여 합
*/

-- 위에서 조회한 내용을 아래와 같이 조회할 수 있도록 쿼리문을 구성한다.
/*
-------------------
부서번호    급여합
-------------------
10	         8750
20	        10875
30	         9400
인턴	     8000          -- (null)
모든부서	37025          -- (null)
-------------------
*/

SELECT CASE WHEN THEN ELSE END "부서번호"
FROM TBL_EMP;

SELECT CASE DEPTNO WHEN NULL THEN '인턴' 
                   ELSE DEPTNO 
        END "부서번호"
FROM TBL_EMP;
--==>> 에러 발생
/*
ORA-00932: inconsistent datatypes: expected CHAR got NUMBER
00932. 00000 -  "inconsistent datatypes: expected %s got %s"
*Cause:    
*Action:
288행, 29열에서 오류 발생
*/
-->> 데이터타입 불일치


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
DEPTNO      NUMBER(2)       -- CHECK  
*/

SELECT CASE DEPTNO WHEN NULL THEN '인턴' 
                   ELSE TO_CHAR(DEPTNO) 
        END "부서번호"
FROM TBL_EMP;
--==>>
/*
20
30
30
20
30
30
10
20
10
30
20
30
20
10
(null)
(null)
(null)
(null)
(null)
*/

SELECT CASE WHEN DEPTNO IS NULL THEN '인턴' 
            ELSE TO_CHAR(DEPTNO) 
        END "부서번호"
FROM TBL_EMP;
--==>>
/*
20
30
30
20
30
30
10
20
10
30
20
30
20
10
인턴
인턴
인턴
인턴
인턴
*/

SELECT CASE WHEN DEPTNO IS NULL THEN '인턴' 
            ELSE TO_CHAR(DEPTNO) 
        END "부서번호"
        , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY DEPTNO;
--==>>
/*
30	     9400
인턴	 8000
20	    10875
10	     8750
*/

SELECT CASE WHEN DEPTNO IS NULL THEN '인턴' 
            ELSE TO_CHAR(DEPTNO) 
        END "부서번호"
        , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
--===>>
/*
10	     8750
20	    10875
30	     9400
인턴	 8000
*/

SELECT CASE WHEN DEPTNO IS NULL THEN '인턴' 
            ELSE TO_CHAR(DEPTNO) 
        END "부서번호"
        , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO) 
ORDER BY DEPTNO;
--==>>
/*
10	     8750
20	    10875
30	     9400
인턴	 8000
인턴	37025
*/

SELECT NVL(DEPTNO, '인턴') "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY DEPTNO;
--==>>
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/
--> 데이터타입 불일치

SELECT NVL2(DEPTNO, TO_CHAR(DEPTNO), '인턴') "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY DEPTNO;
--==>>
/*
30	     9400
인턴	 8000
20	    10875
10	     8750
*/

SELECT NVL2(DEPTNO, TO_CHAR(DEPTNO), '인턴') "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	     8750
20	    10875
30	     9400
인턴	 8000
인턴	37025
*/


--○ GROUPING()
SELECT DEPTNO "부서번호", SUM(SAL) "급여합" , GROUPING(DEPTNO) "그루핑결과"
FROM TBL_EMP
GROUP BY DEPTNO;
--==>>
/*
30	    9400    	0
(null)	8000	    0
20	    10875	0
10	    8750	    0
*/

SELECT DEPTNO "부서번호", SUM(SAL) "급여합" , GROUPING(DEPTNO) "그루핑결과"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750	    0
20	    10875	0
30	    9400    	0
(null)	8000	    0       -- 데이터 자체가 NULL
(null)	37025	1       -- 묶음 처리 → ROLLUP
*/

SELECT CASE WHEN DEPTNO IS NULL AND GROUPING(DEPTNO) = 0 THEN '인턴'
            WHEN DEPTNO IS NULL AND GROUPING(DEPTNO) = 1 THEN '모든부서'
            ELSE TO_CHAR(DEPTNO)
        END "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

--==>>
/*
10	         8750
20	        10875
30	         9400
인턴	     8000
모든부서	37025
*/

SELECT CASE GROUPING(DEPTNO) WHEN  0 THEN DEPTNO
            ELSE '모든부서'
        END "부서번호"
      , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>> 에러 발생
/*
ORA-00932: inconsistent datatypes: expected NUMBER got CHAR
00932. 00000 -  "inconsistent datatypes: expected %s got %s"
*Cause:    
*Action:
496행, 18열에서 오류 발생
*/

SELECT CASE GROUPING(DEPTNO) WHEN  0 THEN TO_CHAR(DEPTNO)
            ELSE '모든부서'
        END "부서번호"
      , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
(null)	     8000
모든부서	37025
*/

SELECT CASE GROUPING(DEPTNO) WHEN  0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '모든부서'
        END "부서번호"
      , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
인턴	     8000
모든부서	37025
*/


--○ TBL_SAWON 테이블을 대상으로 다음과 같이 조회될 수 있도록 쿼리문을 구성한다.
/*
-------------------------
    성별      급여합
-------------------------
    남         xxxx
    여         xxxx
    모든사원   xxxxx
-------------------------
*/
SELECT *
FROM TBL_SAWON;

SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '3') THEN '남' 
            WHEN SUBSTR(JUBUN,7,1) IN ('2', '4') THEN '여' 
            ELSE '성별확인불가' 
        END "성별"
      , SAL "급여"
FROM TBL_SAWON;
--==>>
/*
여	 100
남	2000
남	5000
남	6000
남	2000
남	1000
여	3000
남	2000
남	1000
남	3000
남	3000
여	2000
남	1000
여	2000
남	1000
남	2000
남	2000
*/

SELECT CASE GROUPING(T.성별) WHEN 1 THEN '모든사원'
            ELSE T.성별
        END "성별", SUM(T.급여) "급여합"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '3') THEN '남' 
                WHEN SUBSTR(JUBUN,7,1) IN ('2', '4') THEN '여' 
                ELSE '성별확인불가' 
            END "성별"
         ,  SAL "급여"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남	        31000
여	         7100
모든사원	38100
*/


SELECT *
FROM VIEW_SAWON;


--○ TBL_SAWON 테이블을 연령대별 인원수 형태로
--   조회할 수 있도록 쿼리문을 구성한다.
/*
--------------------------
    연령대     인원수
--------------------------
      20           X
      30           X
      40           X
      50           X
     전체         XX
---------------------------
*/

SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2) + 1899)) 
            WHEN SUBSTR(JUBUN,7,1) IN ('3','4') THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2) + 1999))
            ELSE -1
        END "나이"
FROM TBL_SAWON;

SELECT CASE WHEN T.나이 >= 50 THEN 50
            WHEN T.나이 >= 40 THEN 40
            WHEN T.나이 >= 30 THEN 30
            WHEN T.나이 >= 20 THEN 20
            ELSE -1
        END "연령대"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2) + 1899)) 
                WHEN SUBSTR(JUBUN,7,1) IN ('3','4') THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2) + 1999))
                ELSE -1
            END "나이"
    FROM TBL_SAWON
) T;

SELECT CASE GROUPING(S.연령대)  WHEN 1 THEN '전체'
            ELSE TO_CHAR(S.연령대)
        END "연령대", COUNT(*) "인원수"
FROM
(
    SELECT CASE WHEN T.나이 >= 50 THEN 50
                WHEN T.나이 >= 40 THEN 40
                WHEN T.나이 >= 30 THEN 30
                WHEN T.나이 >= 20 THEN 20
                ELSE -1
            END "연령대"
            
    FROM
    (
        SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2) + 1899)) 
                    WHEN SUBSTR(JUBUN,7,1) IN ('3','4') THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2) + 1999))
                    ELSE -1
                END "나이"
        FROM TBL_SAWON
    ) T
) S
GROUP BY ROLLUP(S.연령대);
--==>> 
/*
20	    6
30	    4
40	    2
50	    5
전체	17
*/


----- 모범 풀이

-- 방법 1 → INLINE VIEW를 두 번 중첩

SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1899)
            WHEN SUBSTR(JUBUN,7,1) IN ('3','4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1999)
            ELSE -1
        END "나이"
FROM TBL_SAWON;
--==>>
/*
29
27
30
36
52
38
34
42
26
22
57
55
52
25
22
56
42
*/

SELECT CASE WHEN T.나이 >= 50 AND T.나이 < 60 THEN 50 
            WHEN T.나이 >= 40 THEN 40
            WHEN T.나이 >= 30 THEN 30 
            WHEN T.나이 >= 20 THEN 20
            WHEN T.나이 >= 10 THEN 10 
            ELSE -1
        END "연령대"
FROM 
(
    -- 나이
    SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1899)
                WHEN SUBSTR(JUBUN,7,1) IN ('3','4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1999)
                ELSE -1
            END "나이"
    FROM TBL_SAWON
) T;
--==>>
/*
20
20
30
30
50
30
30
40
20
20
50
50
50
20
20
50
40
*/
SELECT Q.연령대
        ,COUNT(Q.연령대) "인원수"
FROM
(
    SELECT CASE WHEN T.나이 >= 50 AND T.나이 < 60 THEN 50 
                WHEN T.나이 >= 40 THEN 40
                WHEN T.나이 >= 30 THEN 30 
                WHEN T.나이 >= 20 THEN 20
                WHEN T.나이 >= 10 THEN 10 
                ELSE -1
            END "연령대"
    FROM 
    (
        -- 나이
        SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1899)
                    WHEN SUBSTR(JUBUN,7,1) IN ('3','4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1999)
                    ELSE -1
                END "나이"
        FROM TBL_SAWON
    ) T
) Q
GROUP BY Q.연령대;
--==>>
/*
30	4
20	6
50	5
40	2
*/
SELECT CASE GROUPING(Q.연령대) WHEN 0 THEN TO_CHAR(Q.연령대) 
            ELSE '전체' END "연령대"
        ,COUNT(Q.연령대) "인원수"
FROM
(
    SELECT CASE WHEN T.나이 >= 50 AND T.나이 < 60 THEN 50 
                WHEN T.나이 >= 40 THEN 40
                WHEN T.나이 >= 30 THEN 30 
                WHEN T.나이 >= 20 THEN 20
                WHEN T.나이 >= 10 THEN 10 
                ELSE -1
            END "연령대"
    FROM 
    (
        -- 나이
        SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1899)
                    WHEN SUBSTR(JUBUN,7,1) IN ('3','4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1999)
                    ELSE -1
                END "나이"
        FROM TBL_SAWON
    ) T
) Q
GROUP BY ROLLUP(Q.연령대);
--==>>
/*
20	    6
30	    4
40	    2
50	    5
전체	17
*/

-- 방법 2 → INLINE VIEW를 한 번만 중첩

SELECT 28 나이1, 32 나이2, 49 나이3
    , TRUNC(28, -1) 연령대1, TRUNC(32, -1) 연령대2, TRUNC(49 , -1) 연령대3
FROM DUAL;
--==>> 28	32	49	20	30	40

-- 연령대
SELECT TRUNC(CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') 
                  THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1899)
                  WHEN SUBSTR(JUBUN,7,1) IN ('3','4') 
                  THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1999)
                  ELSE -1
             END, -1)  "연령대"
FROM TBL_SAWON;


SELECT CASE GROUPING(T.연령대) WHEN 0 THEN TO_CHAR(T.연령대) 
            ELSE '전체' 
        END "연령대"
    , COUNT(T.연령대) "인원수"
FROM
(
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') 
                      THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1899)
                      WHEN SUBSTR(JUBUN,7,1) IN ('3','4') 
                      THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1999)
                      ELSE -1
                 END, -1)  "연령대"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.연령대);
--==>>
/*
20	    6
30	    4
40	    2
50	    5
전체	17
*/

-- ○ ROLLUP 활용 및 CUBE
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY 1, 2;
--==>>
/*
10	CLERK	    1300
10	MANAGER	    2450
10	PRESIDENT	5000
20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER 	2975
30	CLERK	    950
30	MANAGER 	2850
30	SALESMAN	5600
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	     1300
10	    MANAGER	     2450
10	    PRESIDENT	 5000
10	    (null)	     8750       -- 10번 부서의 모든 직종의 급여 합
20	    ANALYST 	 6000
20	    CLERK	     1900
20	    MANAGER	     2975
20	    (null)	    10875       -- 20번 부서의 모든 직종의 급여 합
30	    CLERK	      950
30	    MANAGER	     2850
30	    SALESMAN	 5600
30	    (null)	     9400       -- 30번 부서의 모든 직종의 급여 합
(null)	(null)	    29025       -- 모든 부서의 모든 직종의 급여 합
*/

--○ CUBE → ROLLUP보다 더 자세한 결과
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    (null)	    8750     -- 10번 부서의 모든 직종의 급여 합
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20	    (null)	   10875     -- 20번 부서의 모든 직종의 급여 합
30	    CLERK	     950
30	    MANAGER	    2850
30	    SALESMAN	5600
30	    (null)	    9400     -- 30번 부서의 모든 직종의 급여 합
(null)	ANALYST	    6000     -- 모든 부서 ANALYST 직종의 급여 합
(null)	CLERK	    4150     -- 모든 부서 CLERK 직종의 급여 합
(null)	MANAGER	    8275     -- 모든 부서 MANAGER 직종의 급여 합
(null)	PRESIDENT	5000     -- 모든 부서 PRESIDENT 직종의 급여 합
(null)	SALESMAN	5600     -- 모든 부서 SALESMAN 직종의 급여 합
(null)	(null)	   29025     -- 모든 부서의 모든 직종의 급여 합
*/

--※ ROLLUP()과 CUBE()는
--   그룹을 묶어주는 방식이 다르다.(→ 차이)

-- ROLLUP(A,B,C)
-- → (A,B,C) / (A,B) / (A) / ()

-- CUBE(A,B,C)
-- → (A,B,C) / (A,B) / (A,C)/ (B,C) / (A) / (B) / (C) / ()
 
--> 이와 같은 상황으로
-- 원하는 결과를 얻지 못하거나 (→ ROLLUP)
-- 불필요하게 지나친 결과물을 얻게되기 때문에 (→ CUBE)
-- 조회하고자 하는 그룹만 『GROUPING SETS()』를 이용하여
-- 묶어주는 방식으로 처리할 수 있다.

SELECT CASE WHEN THEN ELSE END "부서번호"
    , CASE WHEN THEN ELSE END "직종"
    , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1,2;

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴') 
            ELSE '전체부서' 
        END "부서번호"
      , CASE GROUPING(JOB) WHEN 0 THEN JOB 
             ELSE '전체직종' 
         END "직종"
      , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)         -- ROLLUP()를 사용한 결과 CHECK
ORDER BY 1,2;       
--==>>
/*
10	        CLERK	    1300
10	        MANAGER	    2450
10	        PRESIDENT	5000
10	        전체직종	    8750
20	        ANALYST	    6000
20	        CLERK	    1900
20	        MANAGER	    2975
20	        전체직종	    10875
30	        CLERK	    950
30	        MANAGER	    2850
30	        SALESMAN	5600
30	        전체직종	    9400
인턴	    CLERK	    2500
인턴	    SALESMAN	5500
인턴	    전체직종	    8000
전체부서	전체직종	    37025
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴') 
            ELSE '전체부서' 
        END "부서번호"
      , CASE GROUPING(JOB) WHEN 0 THEN JOB 
             ELSE '전체직종' 
         END "직종"
      , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB),(DEPTNO),())  -- GROUPING SETS()를 사용한 결과 CHECK
ORDER BY 1,2;                                      -- → ROLLUP()과 같은 결과
--==>>
/*
10	        CLERK	    1300
10	        MANAGER	    2450
10	        PRESIDENT	5000
10	        전체직종	    8750
20	        ANALYST	    6000
20	        CLERK	    1900
20	        MANAGER	    2975
20	        전체직종	    10875
30	        CLERK	    950
30	        MANAGER	    2850
30	        SALESMAN	5600
30	        전체직종	    9400
인턴	    CLERK	    2500
인턴	    SALESMAN	5500
인턴	    전체직종	    8000
전체부서	전체직종	    37025
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴') 
            ELSE '전체부서' 
        END "부서번호"
      , CASE GROUPING(JOB) WHEN 0 THEN JOB 
             ELSE '전체직종' 
         END "직종"
      , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)       -- CUBE()를 사용한 결과 CHECK
ORDER BY 1,2;                    
--==>>
/*
10	        CLERK	    1300
10	        MANAGER	    2450
10	        PRESIDENT	5000
10	        전체직종	    8750
20	        ANALYST	    6000
20	        CLERK	    1900
20	        MANAGER	    2975
20	        전체직종	    10875
30	        CLERK	    950
30	        MANAGER	    2850
30	        SALESMAN	5600
30	        전체직종	    9400
인턴	    CLERK	    2500
인턴	    SALESMAN	5500
인턴	    전체직종	    8000
전체부서	ANALYST	    6000
전체부서	CLERK	    6650
전체부서	MANAGER	    8275
전체부서	PRESIDENT	5000
전체부서	SALESMAN	11100
전체부서	전체직종	    37025
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴') 
            ELSE '전체부서' 
        END "부서번호"
      , CASE GROUPING(JOB) WHEN 0 THEN JOB 
             ELSE '전체직종' 
         END "직종"
      , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB),(DEPTNO),(JOB),())  -- GROUPING SETS()를 사용한 결과 CHECK
ORDER BY 1,2;                                            -- → CUBE()과 같은 결과
--==>>
/*
10	        CLERK	    1300
10	        MANAGER	    2450
10	        PRESIDENT	5000
10	        전체직종	    8750
20	        ANALYST	    6000
20	        CLERK	    1900
20	        MANAGER	    2975
20	        전체직종	    10875
30	        CLERK	    950
30	        MANAGER	    2850
30	        SALESMAN	5600
30	        전체직종	    9400
인턴	    CLERK	    2500
인턴	    SALESMAN	5500
인턴	    전체직종	    8000
전체부서	ANALYST	    6000
전체부서	CLERK	    6650
전체부서	MANAGER	    8275
전체부서	PRESIDENT	5000
전체부서	SALESMAN	11100
전체부서	전체직종	    37025
*/

SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

--○ TBL_EMP 테이블에서 입사년도별 인원수를 조회한다.
/*
---------------------------
    입사년도    인원수
---------------------------
    1980            1
    1981           10
    1982            1
    1987            2
    2026            5
    전체           19
---------------------------
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
FROM TBL_EMP;

SELECT CASE GROUPING(T.입사년도) WHEN 0 THEN TO_CHAR(T.입사년도) 
            ELSE '전체' 
        END "입사년도"
     , COUNT(*)
FROM
(
    SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
    FROM TBL_EMP
) T
GROUP BY ROLLUP(T.입사년도);


--==>>
/*
1980     1
1981    10
1982	 1
1987	 2
2026	     5
전체	19
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE));
--==>>
/*
1980    	1
1981	10
1982	1
1987	2
2026    	5
(null)	19
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE));

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY GROUPING SETS((EXTRACT(YEAR FROM HIREDATE)),());

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')
ORDER BY 1;
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
1,135행, 26열에서 오류 발생
*/

SELECT TO_CHAR(HIREDATE, 'YYYY') "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY EXTRACT(YEAR FROM HIREDATE)
ORDER BY 1;
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
1,149행, 17열에서 오류 발생
*/

SELECT TO_NUMBER(TO_CHAR(HIREDATE, 'YYYY')) "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY EXTRACT(YEAR FROM HIREDATE)
ORDER BY 1;
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
1,163행, 26열에서 오류 발생
*/

SELECT TO_CHAR(HIREDATE, 'YYYY') "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
1,177행, 16열에서 오류 발생
*/

--> 데이터타입이 일치하더라도  GROUP BY로 묶은 형식으로 똑같이 SELECT에서 묶어야 에러나지 않음



--------------------------------------------------------------------------------

-- ■■■ HAVING절 ■■■ --

--○ EMP 테이블에서 부서번호가 20, 30인 부서를 대상으로
--   부서의 총 급여가 10000보다 적을 경우만 부서별 총 급여를 조회할 수 있도록 쿼리문을 구성한다.

SELECT DEPTNO "부서번호", SUM(SAL) "총급여"
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO;
--==>>
/*
30	9400
20	10875
*/

SELECT DEPTNO "부서번호", SUM(SAL) "총급여"
FROM EMP
WHERE DEPTNO IN (20, 30)
    AND SUM(SAL) < 10000
GROUP BY DEPTNO;
--==>> 에러발생
/*
ORA-00934: group function is not allowed here
00934. 00000 -  "group function is not allowed here"
*Cause:    
*Action:
1,215행, 23열에서 오류 발생
*/

SELECT DEPTNO "부서번호", SUM(SAL) "총급여"
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000;
--==>>
/*
30	9400
*/

-- 위아래 코드를 보면 WHERE에 쓴 조건을 HAVING에도 쓸 수는 있는데
-- WHERE를 쓰는게 더 리소스 소모가 적어서 WHERE로 쓸 수 있는 부분은 HAVING에 쓰지 않는다.

SELECT DEPTNO "부서번호", SUM(SAL) "총급여"
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000
    AND DEPTNO IN (20, 30);
--==>>
/*
30	9400
*/


--※ 그룹 함수는 2 LEVEL까지 중첩해서 사용할 수 있다.
--   이마저도 MS-SQL은 불가능

SELECT SUM(SAL)"결과확인"
FROM EMP
GROUP BY DEPTNO;
--==>>
/*
9400
10875
8750
*/

SELECT MAX(SUM(SAL)) "결과확인"
FROM EMP
GROUP BY DEPTNO;
--==>> 10875


--※ RANK()
--   DENSE_RANK()
--   → ORACLE 9i부터 적용  MS-SQL 2005부터 적용

--※ 하위 버전에서 RANK()나 DENSE_RANK()와 같은 함수를 사용할 수 없기 때문에
--   이를 대체하여 결과를 얻어낼 수 있는 방법을 강구해야 한다.

-- 예를 들어
-- 급여의 순위를 구하고자 한다면
-- 해당 사원의 급여보다 더 큰 값이 몇 개인지 확인한 후
-- 그 확인한 숫자에 +1을 추가 연산해주면 그것이 곧 등수가 된다.

-- SMITH 사원의 급여 등수
SELECT COUNT(*) "결과확인"
FROM EMP
WHERE SAL > 800;     -- SMITH의 급여 800

SELECT COUNT(*) + 1 "SMITH의 급여 등수"
FROM EMP
WHERE SAL > 800;    -- SMITH의 급여 800
--==>> 14

-- ALLEN 사원의 급여 등수
SELECT COUNT(*) + 1 "ALLEN의 급여 등수"
FROM EMP
WHERE SAL > 1600;  -- ALLEN의 급여 800
--==>> 7


--※ 상관 서브 쿼리(서브 상관 쿼리)
--   메인 쿼리에 있는 테이블의 컬럼이
--   서브 쿼리의 조건절(WHERE, HAVING절)에 사용되는 경우
--   우리는 이 쿼리문을 상관 서브 쿼리(서브 상관 쿼리)라고 부른다.

SELECT ENAME "사원명", SAL "급여", (1) "급여등수"
FROM EMP;

SELECT ENAME "사원명", SAL "급여", (SELECT COUNT(*) + 1
                                    FROM EMP
                                    WHERE SAL> 800) "급여등수"
FROM EMP;

SELECT ENAME "사원명", SAL "급여", (SELECT COUNT(*) + 1
                                    FROM EMP
                                    WHERE SAL> 1600) "급여등수"
FROM EMP;

SELECT ENAME "사원명", SAL "급여", (SELECT COUNT(*) + 1
                                    FROM EMP E2
                                    WHERE E2.SAL> E1.SAL) "급여등수"
FROM EMP E1;

SELECT ENAME "사원명", SAL "급여", (SELECT COUNT(*) + 1
                                    FROM EMP E2
                                    WHERE E2.SAL> E1.SAL) "급여등수"
FROM EMP E1
ORDER BY 3;
--==>>
/*
KING	5000    	1
FORD	3000    	2
SCOTT	3000    	2
JONES	2975	4
BLAKE	2850    	5
CLARK	2450	    6
ALLEN	1600	    7
TURNER	1500	    8
MILLER	1300	    9
WARD	1250	    10
MARTIN	1250	    10
ADAMS	1100	    12
JAMES	950	    13
SMITH	800	    14
*/

--○ EMP 테이블을 대상으로
--   사원명, 급여, 부서번호, 부서내급여등수, 전체급여등수 항목을 조회한다.
--   단, RANK()함수는 사용하지 않고, 서브 상관 쿼리를 활용할 수 있도록 한다.

SELECT *
FROM EMP;

SELECT ENAME "사원명", SAL "급여", DEPTNO "부서번호"
    ,(  SELECT COUNT(*) + 1
        FROM EMP E3
        WHERE E1.DEPTNO = E3.DEPTNO
            AND E3.SAL > E1.SAL
     ) "부서내급여등수"
    ,(SELECT COUNT(*) + 1
      FROM EMP E2
      WHERE E2.SAL> E1.SAL
     ) "전체급여등수"
FROM EMP E1
ORDER BY 3;

-- 모범 풀이
SELECT ENAME "사원명"
     , SAL "급여"
     , DEPTNO "부서번호"
     , (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.SAL > E1.SAL
            AND E2.DEPTNO = E1.DEPTNO) "부서내급여등수"
     , (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.SAL > E1.SAL) "전체급여등수"
FROM EMP E1
ORDER BY E1.DEPTNO, E1.SAL DESC;
--==>>
/*
KING	5000	    10	1	1
CLARK	2450	    10	2	6
MILLER	1300	    10	3	9
SCOTT	3000	    20	1	2
FORD	3000	    20	1	2
JONES	2975	20	3	4
ADAMS	1100	    20	4	12
SMITH	800	    20	5	14
BLAKE	2850	    30	1	5
ALLEN	1600	    30	2	7
TURNER	1500    	30	3	8
MARTIN	1250    	30	4	10
WARD	1250    	30	4	10
JAMES	950	    30	6	13
*/

SELECT *
FROM EMP
ORDER BY DEPTNO, HIREDATE;

--○ EMP 테이블을 대상으로 다음과 같이 조회될 수 있도록 쿼리문을 구성한다.
/*
---------------------------------------------------------------------------
    사원명     부서번호       입사일     급여       부서내입사별급여누적
---------------------------------------------------------------------------
    CLARK         10        1981-06-09    2450              2450
    KING          10        1981-11-17    5000              7450
    MILLER        10        1982-01-23    1300              8750
    SMITH         20        1980-12-17     800               800
    JONES         20        1981-04-02    2975              3775
    FORD          20        1981-12-09    3000              6775
                                :
                                :
-----------------------------------------------------------------------------
*/

SELECT ENAME "사원명", DEPTNO "부서번호", HIREDATE "입사일",  SAL "급여"
    ,(SELECT SUM(E2.SAL)
      FROM EMP E2
      WHERE E2.DEPTNO = E1.DEPTNO
        AND E2.HIREDATE <= E1.HIREDATE
      ) "부서내급여누적"
FROM EMP E1
ORDER BY 2, 3 ;

-- 모범풀이

SELECT ENAME "사원명", DEPTNO "부서번호", HIREDATE "입사일",  SAL "급여"
    ,(SELECT SUM(E2.SAL)
      FROM EMP E2
      WHERE E2.DEPTNO = E1.DEPTNO) "부서내입사별급여누적"
FROM EMP E1
ORDER BY 2, 3 ;

SELECT ENAME "사원명", DEPTNO "부서번호", HIREDATE "입사일",  SAL "급여"
    ,(SELECT SUM(E2.SAL)
      FROM EMP E2
      WHERE E2.DEPTNO = E1.DEPTNO
        AND E2.HIREDATE <= E1.HIREDATE) "부서내입사별급여누적"
FROM EMP E1
ORDER BY 2, 3 ;
--==>>
/*
CLARK	10	1981-06-09	2450 	2450
KING	10	1981-11-17	5000    	7450
MILLER	10	1982-01-23	1300    	8750
SMITH	20	1980-12-17	 800	     800
JONES	20	1981-04-02	2975	3775
FORD	20	1981-12-03	3000	    6775
SCOTT	20	1987-07-13	3000	   10875
ADAMS	20	1987-07-13	1100	   10875
ALLEN	30	1981-02-20	1600	    1600
WARD	30	1981-02-22	1250	    2850
BLAKE	30	1981-05-01	2850	    5700
TURNER	30	1981-09-08	1500	    7200
MARTIN	30	1981-09-28	1250	    8450
JAMES	30	1981-12-03	 950	    9400
*/

SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

--○ TBL_EMP 테이블에서 입사한 사원의 수가 가장 많았을 때의
--   입사년월과 인원수를 조회할 수 있도록 쿼리문을 구성한다.
/*
----------------------------
    입사년월       인원수
----------------------------
     2026-01          5
----------------------------
*/

SELECT 입사년월, 인원수
FROM
(
    SELECT SUBSTR(TO_CHAR(HIREDATE),1,7) "입사년월",COUNT(*) "인원수"
    FROM TBL_EMP
    GROUP BY SUBSTR(TO_CHAR(HIREDATE),1,7)
)
WHERE 인원수 = (
    SELECT MAX(인원수)
    FROM
    (
        SELECT COUNT(*) "인원수"
        FROM TBL_EMP
        GROUP BY SUBSTR(TO_CHAR(HIREDATE),1,7)
    )  
);


-- 모범 답안
SELECT ENAME, HIREDATE
FROM TBL_EMP
ORDER BY 2;
--==>>
/*
SMITH	1980-12-17
ALLEN	1981-02-20
WARD	1981-02-22
JONES	1981-04-02
BLAKE	1981-05-01
CLARK	1981-06-09
TURNER	1981-09-08
MARTIN	1981-09-28
KING	1981-11-17
FORD	1981-12-03
JAMES	1981-12-03
MILLER	1982-01-23
SCOTT	1987-07-13
ADAMS	1987-07-13
고윤정	2026-01-07
김다미	2026-01-07
아이유	2026-01-07
카리나	2026-01-07
하성운	2026-01-07
*/

SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
    , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>>
/*
1981-05	1
1981-12	2
1982-01	1
1981-09	2
1981-02	2
1981-11	1
2026-01	5
1980-12	1
1981-04	1
1987-07	2
1981-06	1
*/

SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
    , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = 5;                -- 인원수 확인
--==>>
/*
2026-01	5
*/

SELECT COUNT(*)
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>>
/*
1
2
1
2
2
1
5
1
1
2
1
*/

SELECT MAX(COUNT(*))
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>> 5


SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
    , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = 
    (SELECT MAX(COUNT(*))
    FROM TBL_EMP
    GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
    );   
--==>> 2026-01	5


--○ ROW_NUMBER()
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "관찰"
    , ENAME "사원명", SAL "급여", HIREDATE "입사일"
FROM EMP;

--※ 게시판의 게시물 번호를
--  SEQUENCE(오라클)나 INDENTITY(MS-SQL)를 사용하게 되면
--  특정 게시물을 삭제했을 경우 삭제한 게시물 자리에
--  다음 번호를 가진 게시물이 등록되는 상황이 발생하게 된다.
--  이는, 보안 측면에서나 미관상 의도한 바와 다른 상황일 수 있기 때문에
--  ROW_NUMBER()의 사용을 고려해볼 수 있다.
--  관리의 목적으로 사용할 때는 SEQUENCE나 INDENTITY를 사용하지만
--  단순히 게시물을 목록화하여 사용자에게 리스트 형식으로 보여줄 때는
--  사용하지 않는 것이 좋다.

--※ 관찰
-- 테이블 생성
-- 테이블명: TBL_AAA
CREATE TABLE TBL_AAA
( NO        NUMBER
, NAME      VARCHAR2(40)
, GRADE     CHAR
);
--==>> Table TBL_AAA이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES (1, '강명철', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES (2, '안진모', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES (3, '양호열', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES (4, '유현선', 'C');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES (5, '윤주열', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES (6, '이수빈', 'C');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES (7, '임유훤', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES (8, '정세찬', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES (9, '조세빈', 'B');
--==>> 1 행 이(가) 삽입되었습니다. * 9

-- 확인
SELECT *
FROM TBL_AAA;
--==>>
/*
1	강명철	A
2	안진모	B
3	양호열	A
4	유현선	C
5	윤주열	B
6	이수빈	C
7	임유훤	B
8	정세찬	A
9	조세빈	B
*/

UPDATE TBL_AAA
SET NAME = '유현선', GRADE ='B'
WHERE NO IN (4, 7, 8);
--===>> 3개 행 이(가) 업데이트되었습니다.

-- 확인
SELECT *
FROM TBL_AAA;
--==>>
/*
1	강명철	A
2	안진모	B
3	양호열	A
4	유현선	B
5	윤주열	B
6	이수빈	C
7	유현선	B
8	유현선	B
9	조세빈	B
*/

COMMIT;

SELECT *
FROM TBL_AAA;

--○ SEQUENCE(시퀀스, 주문번호)
--   → 사전적인 의미: 1. (일련의) 연속적인 사건들 2.(사건, 행동 등의) 순서
CREATE SEQUENCE SEQ_BOARD       -- 시퀀스 기본 생성 구문(MS-SQL의 IDENTITY와 동일한 개념)
START WITH 1                    -- 시작값
INCREMENT BY 1                  -- 증가값
NOMAXVALUE                      -- 최대값 제한 없음
NOCACHE;                        -- 캐시 사용 안함(없음)
--==>> Sequence SEQ_BOARD이(가) 생성되었습니다.


--○ 테이블 생성
-- 테이블명: TBL_BOARD
CREATE TABLE TBL_BOARD                  -- TBL_BOARD라는 이름의 테이블 생성 → 게시판
( NO        NUMBER                      -- 게시물 번호       ×
, TITLE     VARCHAR2(50)                -- 게시물 제목       ○
, CONTENTS  VARCHAR2(2000)              -- 게시물 내용       ○
, NAME      VARCHAR2(20)                -- 게시물 작성자     △
, PW        VARCHAR2(20)                -- 게시물 패스워드   △
, CREATED   DATE    DEFAULT SYSDATE     -- 게시물 작성일     ×
);
--==>> Table TBL_BOARD이(가) 생성되었습니다.


--○ 데이터 입력  → 게시판에 게시물 작성
INSERT INTO TBL_BOARD(NO, TITLE, CONTENTS, NAME, PW, CREATED) 
VALUES(SEQ_BOARD.NEXTVAL, '게시물테스트', '조금만 기운냅시다', '강명철', 'java004$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD(NO, TITLE, CONTENTS, NAME, PW, CREATED) 
VALUES(SEQ_BOARD.NEXTVAL, '건강 관리', '다들 건강 챙깁시다', '안진모', 'java004$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD(NO, TITLE, CONTENTS, NAME, PW, CREATED) 
VALUES(SEQ_BOARD.NEXTVAL, '오늘은', '저녁 뭐 먹지', '강명철', 'java004$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD(NO, TITLE, CONTENTS, NAME, PW, CREATED) 
VALUES(SEQ_BOARD.NEXTVAL, '오타쟁이', '오타를 줄여 나갑시다', '강명철', 'java004$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD(NO, TITLE, CONTENTS, NAME, PW, CREATED) 
VALUES(SEQ_BOARD.NEXTVAL, '여기까지', '오늘은 여기까지', '정세찬', 'java004$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD(NO, TITLE, CONTENTS, NAME, PW, CREATED) 
VALUES(SEQ_BOARD.NEXTVAL, '집에가면', '눈을 쉬어주도록 합시다', '윤주열', 'java004$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD(NO, TITLE, CONTENTS, NAME, PW, CREATED) 
VALUES(SEQ_BOARD.NEXTVAL, '조심히', '다들 조심히 갑시다', '이수빈', 'java004$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_BOARD;
--==>>
/*
1	게시물테스트	    조금만 기운냅시다	    강명철	java004$	    2026-01-07
2	건강 관리	    다들 건강 챙깁시다	    안진모	java004$	    2026-01-07
3	오늘은	        저녁 뭐 먹지	        강명철	java004$	    2026-01-07
4	오타쟁이	    오타를 줄여 나갑시다	강명철	java004$	    2026-01-07
5	여기까지	    오늘은 여기까지        	정세찬	java004$	    2026-01-07
6	집에가면	    눈을 쉬어주도록 합시다	윤주열	java004$	    2026-01-07
7	조심히	        다들 조심히 갑시다	    이수빈	java004$	    2026-01-07
*/


COMMIT;
--==>> 커밋 완료.




