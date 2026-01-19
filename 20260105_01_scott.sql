SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT *
FROM TBL_SAWON;
--==>>
/*
1001	조세빈	9804112234567	11/01/03    	3000
1002	강명철	0002113234567	17/01/05	    2000
1003	이수빈	9709061234567	05/08/16	    5000
1004	정세찬	9104281234567	98/02/10    	6000
1005	이재용	7512121234567	90/10/10    	2000
1006	이이영	8904051234567	09/06/05	    1000
1007	아이유	9304022234567	12/07/13    	3000
1008	이상이	8512162234567	99/08/16    	2000
1009	남궁민	0102033234567	10/07/01    	1000
1010	윤주열	0502203234567	15/10/20    	3000
*/

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1011, '선동열', '7012181234567', TO_DATE('1990-10-10', 'YYYY-MM-DD'), 3000);
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1012, '선우용녀', '7205062234567', TO_DATE('1998-08-08', 'YYYY-MM-DD'), 2000);
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1013, '남희석', '7509231234567', TO_DATE('2002-05-15', 'YYYY-MM-DD'), 1000);
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1014, '선우선', '0203044234567', TO_DATE('2012-05-13', 'YYYY-MM-DD'), 2000);
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1015, '남궁민', '0512123234567', TO_DATE('2015-07-13', 'YYYY-MM-DD'), 1000);
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1016, '남진', '7108051234567', TO_DATE('1999-07-13', 'YYYY-MM-DD'), 2000);
--==>> 1 행 이(가) 삽입되었습니다. * 6

-- ※ 날짜 형식 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


-- ○ 확인
SELECT *
FROM TBL_SAWON;
--==>>
/*
1001	    조세빈	    9804112234567	2011-01-03	3000
1002	    강명철	    0002113234567	2017-01-05	2000
1003	    이수빈	    9709061234567	2005-08-16	5000
1004    	정세찬	    9104281234567	1998-02-10	6000
1005	    이재용	    7512121234567	1990-10-10	2000
1006	    이이영	    8904051234567	2009-06-05	1000
1007    	아이유	    9304022234567	2012-07-13	3000
1008    	이상이	    8512162234567	1999-08-16	2000
1009    	남궁민	    0102033234567	2010-07-01	1000
1010    	윤주열	    0502203234567	2015-10-20	3000
1011    	선동열	    7012181234567	1990-10-10	3000
1012    	선우용녀	7205062234567	1998-08-08	2000
1013    	남희석	    7509231234567	2002-05-15	1000
1014    	선우선	    0203044234567	2012-05-13	2000
1015    	남궁민	    0512123234567	2015-07-13	1000
1016    	남진	    7108051234567	1999-07-13	2000
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ TBL_SAWON 테이블에서 강명철 사원의 정보를 모두 조회한다.
SELECT *
FROM TBL_SAWON 
WHERE SANAME = '강명철';
--==>> 1002	강명철	0002113234567	2017-01-05	2000

SELECT *
FROM TBL_SAWON 
WHERE SANAME LIKE '강명철';
--==>> 1002	강명철	0002113234567	2017-01-05	2000

--※LIKE: 동사 → 좋아하다.
--        부사 → ~와 같이, ~처럼

--○ WILD CARD(CHARACTER) → 『%』
--  『LIKE』와 함게 사용되는 『%』는 모든 글자를 의미한다.
--  『LIKE』와 함게 사용되는 『_』는 아무 글자 한 개를 의미한다.

SELECT *
FROM TBL_SAWON
WHERE SANAME LIKE '%빈';
--==>> 
/*
1001	조세빈	9804112234567	2011-01-03	3000
1003	이수빈	9709061234567	2005-08-16	5000
*/


--○ TBL_SAWON 테이블에서 성씨가 정씨인 사원의
--   사원명, 주민번호, 급여 항목을 조회한다.
SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '정';
--==>> 조회 결과 없음

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '정__';
--==>> 정세찬	9104281234567	6000

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME = '정__';
--==>> 조회 결과 없음

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '정%';
--==>> 정세찬	9104281234567	6000

--○ 데이터 추가 입력
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1017, '정우', '8502031234567', TO_DATE('1999-10-10', 'YYYY-MM-DD'), 2000);
--==>>1 행 이(가) 삽입되었습니다.
SELECT *
FROM TBL_SAWON;

COMMIT;

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '정__';
--==>> 정세찬	9104281234567	6000

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '정_';
--==>> 정우	8502031234567	2000

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '정%';
--==>>
/*
정세찬	9104281234567	6000
정우	8502031234567	2000
*/


--○ TBL_SAWON 테이블에서 이름의 마지막 글자가 『빈』으로
--  끝나는 사원의 사원명, 주민번호, 입사일, 급여 항목을 조회한다.
SELECT SANAME, JUBUN, HIREDATE, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '__빈';
--==>>
/*
조세빈	9804112234567	2011-01-03	3000
이수빈	9709061234567	2005-08-16	5000
*/

SELECT SANAME, JUBUN, HIREDATE, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '%빈';
--==>>
/*
조세빈	9804112234567	2011-01-03	3000
이수빈	9709061234567	2005-08-16	5000
*/


--○ TBL_SAWON 테이블에서 이름의 두 번째 글자가 『이』인 사원의
--   사원명, 주민번호, 입사일, 급여 항목을 조회한다.
SELECT SANAME, JUBUN, HIREDATE, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '_이_';
--==>>
/*
이이영	8904051234567	2009-06-05	1000
아이유	9304022234567	2012-07-13	3000
*/

SELECT SANAME, JUBUN, HIREDATE, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '_이%';
--==>>
/*
이이영	8904051234567	2009-06-05	1000
아이유	9304022234567	2012-07-13	3000
*/


--○ TBL_SAWON 테이블에서 이름에 '이'라는 글자가
--   하나라도 포함이 되어 있으면 그 사원의
--   사원명, 주민번호, 입사일, 급여 항목을 조회한다.
SELECT SANAME, JUBUN, HIREDATE, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '%이%';
--==>>
/*
이수빈	9709061234567	2005-08-16	5000
이재용	7512121234567	1990-10-10	2000
이이영	8904051234567	2009-06-05	1000
아이유	9304022234567	2012-07-13	3000
이상이	8512162234567	1999-08-16	2000
*/

--○ TBL_SAWON 테이블에서 이름에 '이'라는 글자가
--   연속으로 두 번 포함되어 있으면 그 사원의
--   사원명, 주민번호, 입사일, 급여 항목을 조회한다.
SELECT SANAME, JUBUN, HIREDATE, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '%이이%';
--==>> 이이영	8904051234567	2009-06-05	1000

--○ TBL_SAWON 테이블에서 이름에 '이'라는 글자가
--   연속적이지 않더라도 두 번 포함되어 있으면 그 사원의
--   사원명, 주민번호, 입사일, 급여 항목을 조회한다.
SELECT SANAME, JUBUN, HIREDATE, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '%이%이%';
--==>
/*
이이영	8904051234567	2009-06-05	1000
이상이	8512162234567	1999-08-16	2000
*/


--○ TBL_SAWON 테이블에서 성씨가 '선'씨인 사원의
-- 사원명, 주민번호, 입사일, 급여 항목을 조회한다.
SELECT SANAME, JUBUN, HIREDATE, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '선%';

--※ 데이터베이스 설계 시 성과 이름을 분리해서 처리해야 할
--   업무 계획이 있다면(지금 당장은 아니더라도)
--   테이블에서 성 컬럼과 이름 컬럼을 분리하여 구성해야 한다.

UPDATE TBL_SAWON
SET JUBUN = '8512161234567'
WHERE SANAME = '이상이';

SELECT *
FROM TBL_SAWON;

COMMIT;

--○ TBL_SAWON 테이블에서 여직원들의 사원명, 주민번호, 급여 항목을 조회한다.
SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE JUBUN LIKE '______2______' OR JUBUN LIKE '______4______';

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE JUBUN LIKE '______2%' OR JUBUN LIKE '______4%';
--==>>
/*
조세빈	9804112234567	3000
아이유	9304022234567	3000
선우용녀	7205062234567	2000
선우선	0203044234567	2000
*/


--○ 실습 테이블 생성
-- 테이블명 : TBL_WATCH
CREATE TABLE TBL_WATCH
( WATCH_NAME    VARCHAR2(20)
, BIGO          VARCHAR2(100)
);
--==>>  Table TBL_WATCH이(가) 생성되었습니다.

--○ 데이터 입력
INSERT INTO TBL_WATCH(WATCH_NAME, BIGO)
VALUES('금시계', '순금 99.99% 함유된 최고급 시계');
INSERT INTO TBL_WATCH(WATCH_NAME, BIGO)
VALUES('은시계', '고객 만족도 99.99점을 획든한 시계');
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_WATCH;
--==>> 
/*
금시계	순금 99.99% 함유된 최고급 시계
은시계	고객 만족도 99.99점을 획든한 시계
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ TBL_WATCH 테이블에서 BIGO(비고) 컬럼에
--   『99.99%』라는 글자가 들어있는 행(레코드)의 정보를 조회한다.
SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '99.99%';
--==>> 조회 결과 없음

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99%';
--==>>
/*
금시계	순금 99.99% 함유된 최고급 시계
은시계	고객 만족도 99.99점을 획든한 시계
*/

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99%%';
--==>>
/*
금시계	순금 99.99% 함유된 최고급 시계
은시계	고객 만족도 99.99점을 획든한 시계
*/

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99\%%' ESCAPE '\';
--==>> 금시계	순금 99.99% 함유된 최고급 시계

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99$%%' ESCAPE '$';
--==>> 금시계	순금 99.99% 함유된 최고급 시계

--※ ESCAPE로 정한 문자의 다음 한 글자는 와일드카드에서 탈출시키도록 처리하는 구문
--  『ESCAPE'\'』
--   일반적으로 키워드 아닌, 연산자 아닌, 사용빈도가 낮은 특수문자(특수기호)를 사용.


--------------------------------------------------------------------------------


-- ■■■ COMMIT / ROLLBACK ■■■ --

SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/

--○ 데이터 입력
INSERT INTO TBL_DEPT(DEPTNO, DNAME, LOC)
VALUES(50, '개발부', '서울');

--○ 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	    서울
*/


-- 50	개발부	    서울
-- 이 데이터는 TBL_DEPT 테이블에 저장되어 있는
-- 하드디스크 상에 물리적으로 적용되어 저장된 것이 아니라
-- 메모리(RAM) 상에 입력된 것이다.


--○ 롤백
ROLLBACK;
--==>> 롤백 완료.

--○ 롤백 이후 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/

-- 50	개발부	    서울
-- 에 대한 데이터가 소실되었음을 확인(→ 존재하지 않음)

--○ 데이터 입력
INSERT INTO TBL_DEPT(DEPTNO, DNAME, LOC)
VALUES(50, '개발부', '서울');
--==>> 1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	    서울
*/

--> 메모리 상에 입력된 이 데이터를
--  실제 하드디스크 상에 물리적으로 저장하기 위해서는
--  COMMIT을 수행해야 한다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	    서울
*/

--○ 롤백
ROLLBACK;
--==>> 롤백 완료.

--○롤백 이후 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	    서울
*/

-- 롤백(ROLLBACK)을 수행했음에도 불구하고
-- 50	개발부	    서울
-- 데이터는 소실되지 않았음을 확인

--※ 커밋(COMMIT)을 실행한 이후로
--   DML 구문(INSERT, UPDATE, DELETE 등)을 통해
--   변경된 데이터만 취소할 수 있는 것일 뿐
--   DML 구문(INSERT, UPDATE, DELETE 등)을 사용한 후 COMMIT하고 나서
--   롤백(ROLLBACK)을 실행해봐야 이전 상태로 되돌릴 수 없다.(아무 소용이 없다.)



--○ 데이터 수정
UPDATE TBL_DEPT
SET DNAME = '연구부', LOC = '경기'
WHERE DEPTNO = 50;
--==>> 1 행 이(가) 업데이트되었습니다.

--○ 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	연구부	    경기
*/


---○ 롤백
ROLLBACK;
--==>> 롤백 완료.

---○ 롤백 이후 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	    서울
*/
--> 수정(UPDATE)을 수행하기 이전 상태로 복원되었음을 확인

--○ 데이터 수정
UPDATE TBL_DEPT
SET DNAME = '연구부', LOC = '경기'
WHERE DEPTNO = 50;
--==>> 1 행 이(가) 업데이트되었습니다.

--○ 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	연구부	    경기
*/

---○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	연구부	    경기
*/

---○ 롤백
ROLLBACK;
--==>> 롤백 완료.

---○ 롤백 이후 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	연구부	    경기
*/

--○ 데이터 삭제
SELECT *
FROM TBL_DEPT
WHERE DEPTNO = 50;
--==>> 50	연구부	경기

DELETE
FROM TBL_DEPT
WHERE DEPTNO = 50;
--==>>1 행 이(가) 삭제되었습니다.

--○ 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
*/
-->50번 부서의 데이터가 삭제되었음을 확인

---○ 롤백
ROLLBACK;
--==>> 롤백 완료.

---○ 롤백 이후 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	연구부	    경기
*/


--------------------------------------------------------------------------------

-- ■■■ 정렬(ORDER BY)절 ■■■ --

SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종", SAL "급여"
        , SAL*12+NVL(COMM, 0) "연봉"
FROM TBL_EMP;
--==>>
/*
SMITH	20	CLERK	     800	     9600
ALLEN	30	SALESMAN	1600    	19500
WARD	30	SALESMAN	1250	    15500
JONES	20	MANAGER	    2975	35700
MARTIN	30	SALESMAN	1250    	16400
BLAKE	30	MANAGER	    2850    	34200
CLARK	10	MANAGER	    2450    	29400
SCOTT	20	ANALYST	    3000    	36000
KING	10	PRESIDENT	5000    	60000
TURNER	30	SALESMAN	1500    	18000
ADAMS	20	CLERK	    1100    	13200
JAMES	30	CLERK	     950	    11400
FORD	20	ANALYST	    3000    	36000
MILLER	10	CLERK	    1300    	15600
*/

SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종", SAL "급여"
        , SAL*12+NVL(COMM, 0) "연봉"
FROM TBL_EMP
ORDER BY DEPTNO ASC;        -- DEPTNO → 부서번호 기준 정렬
                            -- ASC    → 오름차순 정렬
--==>>
/*
CLARK	10	MANAGER	    2450	    29400
KING	10	PRESIDENT	5000    	60000
MILLER	10	CLERK	    1300    	15600
JONES	20	MANAGER	    2975	35700
FORD	20	ANALYST	    3000	    36000
ADAMS	20	CLERK	    1100    	13200
SMITH	20	CLERK	     800	     9600
SCOTT	20	ANALYST	    3000	    36000
WARD	30	SALESMAN	1250    	15500
TURNER	30	SALESMAN	1500	    18000
ALLEN	30	SALESMAN	1600	    19500
JAMES	30	CLERK	     950	    11400
BLAKE	30	MANAGER	    2850	    34200
MARTIN	30	SALESMAN	1250	1    6400
*/

SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종", SAL "급여"
        , SAL*12+NVL(COMM, 0) "연봉"
FROM TBL_EMP
ORDER BY DEPTNO;         -- DEPTNO → 부서번호 기준 정렬
                         -- ASC    →  오름차순 정렬 → 생략 가능
--==>>
/*
CLARK	10	MANAGER	    2450	    29400
KING	10	PRESIDENT	5000    	60000
MILLER	10	CLERK	    1300    	15600
JONES	20	MANAGER	    2975	35700
FORD	20	ANALYST	    3000	    36000
ADAMS	20	CLERK	    1100    	13200
SMITH	20	CLERK	     800	     9600
SCOTT	20	ANALYST	    3000	    36000
WARD	30	SALESMAN	1250    	15500
TURNER	30	SALESMAN	1500	    18000
ALLEN	30	SALESMAN	1600	    19500
JAMES	30	CLERK	     950	    11400
BLAKE	30	MANAGER	    2850	    34200
MARTIN	30	SALESMAN	1250	1    6400
*/

SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종", SAL "급여"
        , SAL*12+NVL(COMM, 0) "연봉"
FROM TBL_EMP
ORDER BY DEPTNO DESC;    -- DEPTNO → 부서번호 기준 정렬
                         -- DESC    →  내림차순 정렬 → 생략 불가
--==>>
/*
BLAKE	30	MANAGER	    2850    	34200
TURNER	30	SALESMAN	1500    	18000
ALLEN	30	SALESMAN	1600	    19500
MARTIN	30	SALESMAN	1250	    16400
WARD	30	SALESMAN	1250	    15500
JAMES	30	CLERK	     950	    11400
SCOTT	20	ANALYST	    3000    	36000
JONES	20	MANAGER	    2975	35700
SMITH	20	CLERK	     800	     9600
ADAMS	20	CLERK	    1100    	13200
FORD	20	ANALYST	    3000	    36000
KING	10	PRESIDENT	5000    	60000
MILLER	10	CLERK	    1300    	15600
CLARK	10	MANAGER	    2450    	29400
*/

DESC TBL_EMP;

SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종", SAL "급여"
        , SAL*12+NVL(COMM, 0) "연봉"
FROM TBL_EMP
ORDER BY SAL DESC;      -- SAL  → 급여 기준 정렬
                        -- DESC →  내림차순 정렬 
--==>>
/*
KING	10	PRESIDENT	5000	    60000
FORD	20	ANALYST	    3000	    36000
SCOTT	20	ANALYST	    3000	    36000
JONES	20	MANAGER	    2975	35700
BLAKE	30	MANAGER	    2850	    34200
CLARK	10	MANAGER	    2450	    29400
ALLEN	30	SALESMAN	1600	    19500
TURNER	30	SALESMAN	1500	    18000
MILLER	10	CLERK	    1300	    15600
WARD	30	SALESMAN	1250	    15500
MARTIN	30	SALESMAN	1250	    16400
ADAMS	20	CLERK	    1100	    13200
JAMES	30	CLERK	     950	    11400
SMITH	20	CLERK	     800	     9600
*/

SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종", SAL "급여"
        , SAL*12+NVL(COMM, 0) "연봉"
FROM TBL_EMP
ORDER BY SAL*12+NVL(COMM, 0) DESC; 
--==>>
/*
KING	10	PRESIDENT	5000    	60000
FORD	20	ANALYST	    3000	    36000
SCOTT	20	ANALYST	    3000	    36000
JONES	20	MANAGER 	2975	35700
BLAKE	30	MANAGER	    2850	    34200
CLARK	10	MANAGER	    2450	    29400
ALLEN	30	SALESMAN	1600    	19500
TURNER	30	SALESMAN	1500    	18000
MARTIN	30	SALESMAN	1250    	16400
MILLER	10	CLERK	    1300	    15600
WARD	30	SALESMAN	1250	    15500
ADAMS	20	CLERK	    1100	    13200
JAMES	30	CLERK	     950	    11400
SMITH	20	CLERK	     800	     9600
*/

SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종", SAL "급여"
        , SAL*12+NVL(COMM, 0) "연봉"
FROM TBL_EMP
ORDER BY 연봉 DESC; 
--==>>
/*
KING	10	PRESIDENT	5000    	60000
FORD	20	ANALYST	    3000	    36000
SCOTT	20	ANALYST	    3000	    36000
JONES	20	MANAGER 	2975	35700
BLAKE	30	MANAGER	    2850	    34200
CLARK	10	MANAGER	    2450	    29400
ALLEN	30	SALESMAN	1600    	19500
TURNER	30	SALESMAN	1500    	18000
MARTIN	30	SALESMAN	1250    	16400
MILLER	10	CLERK	    1300	    15600
WARD	30	SALESMAN	1250	    15500
ADAMS	20	CLERK	    1100	    13200
JAMES	30	CLERK	     950	    11400
SMITH	20	CLERK	     800	     9600
*/
-->> ORDER BY절보다 SELECT절이 먼저 처리되기 때문에(→ SELECT 문의 처리 순서상)
--   테이블의 컬럼명 대신 SELECT 절에서 부여한 별칭(ALIAS)을
--   ORDER BY절에서 사용해도 문제가 발생하지 않는다.(가능하다)


SELECT ENAME "사원명", DEPTNO "부서 번호", JOB "직종", SAL "급여"
        , SAL*12+NVL(COMM, 0) "연봉"
FROM TBL_EMP
ORDER BY 부서 번호 DESC; 
--==>> 에러 발생

SELECT ENAME "사원명", DEPTNO "부서 번호", JOB "직종", SAL "급여"
        , SAL*12+NVL(COMM, 0) "연봉"
FROM TBL_EMP
ORDER BY "부서 번호" DESC; 
--==>>
/*
BLAKE	30	MANAGER	    2850	    34200
TURNER	30	SALESMAN	1500	    18000
ALLEN	30	SALESMAN	1600    	19500
MARTIN	30	SALESMAN	1250    	16400
WARD	30	SALESMAN	1250    	15500
JAMES	30	CLERK	     950	    11400
SCOTT	20	ANALYST	    3000	    36000
JONES	20	MANAGER	    2975	35700
SMITH	20	CLERK	     800	     9600
ADAMS	20	CLERK	    1100	    13200
FORD	20	ANALYST	    3000    	36000
KING	10	PRESIDENT	5000    	60000
MILLER	10	CLERK	    1300    	15600
CLARK	10	MANAGER	    2450    	29400
*/

SELECT ENAME "사원명", DEPTNO "부서 번호", JOB "직종", SAL "급여"
        , SAL*12+NVL(COMM, 0) "연봉"
FROM TBL_EMP
ORDER BY 2;         -- 두 번째 컬럼 →  DEPTNO → DEPTNO ASC → 부서번호 기준 오름차순 정렬
--> TBL_EMP 테이블이 갖고 있는 테이블의 고유한 컬럼의 순서가 아니라
--  SELECT 처리되는 과정에서 두 번째 컬럼(즉, DEPTNO)을 기준으로
--  정렬이 수행되는 것을 확인
--  ASC 생략된 상태 → 오름차순 정렬이 수행되는 것을 확인
--==>>
/*
CLARK	10	MANAGER	    2450    	29400
KING	10	PRESIDENT	5000    	60000
MILLER	10	CLERK	    1300    	15600
JONES	20	MANAGER	    2975	35700
FORD	20	ANALYST	    3000    	36000
ADAMS	20	CLERK	    1100    	13200
SMITH	20	CLERK	     800	     9600
SCOTT	20	ANALYST	    3000	    36000
WARD	30	SALESMAN	1250    	15500
TURNER	30	SALESMAN	1500	    18000
ALLEN	30	SALESMAN	1600	    19500
JAMES	30	CLERK	     950	    11400
BLAKE	30	MANAGER	    2850    	34200
MARTIN	30	SALESMAN	1250    	16400
*/

SELECT ENAME, DEPTNO, JOB, SAL
FROM TBL_EMP
ORDER BY 2, 4;     -- DEPTNO 기준 1차 정렬, SAL 기준 2차 정렬 ASC
--==>>
/*
MILLER	10	CLERK	    1300
CLARK	10	MANAGER	    2450
KING	10	PRESIDENT	5000
SMITH	20	CLERK	     800
ADAMS	20	CLERK	    1100
JONES	20	MANAGER	    2975
SCOTT	20	ANALYST	    3000
FORD	20	ANALYST	    3000
JAMES	30	CLERK	     950
MARTIN	30	SALESMAN	1250
WARD	30	SALESMAN	1250
TURNER	30	SALESMAN	1500
ALLEN	30	SALESMAN	1600
BLAKE	30	MANAGER 	2850
*/

SELECT ENAME, DEPTNO, JOB, SAL
FROM TBL_EMP
ORDER BY 2, 3, 4 DESC;
--> ① DEPTNO(부서번호) 기준 오름차순 정렬
--> ② JOB(직종) 기준 오름차순 정렬
--> ③ SAL(급여) 기준 내림차순 정렬
--  (3차 정렬 수행)
--==>>
/*
MILLER	10	CLERK	    1300
CLARK	10	MANAGER	    2450
KING	10	PRESIDENT	5000
SCOTT	20	ANALYST	    3000
FORD	20	ANALYST	    3000
ADAMS	20	CLERK	    1100
SMITH	20	CLERK	     800
JONES	20	MANAGER 	2975
JAMES	30	CLERK	     950
BLAKE	30	MANAGER	    2850
ALLEN	30	SALESMAN	1600
TURNER	30	SALESMAN	1500
MARTIN	30	SALESMAN	1250
WARD	30	SALESMAN	1250
*/


--------------------------------------------------------------------------------

--○ CONCAT() → 문자열 결합 함수
SELECT '안진모' || '양호열' "COL1"
     , CONCAT('안진모','양호열') "COL2"
FROM DUAL;
--==>> 안진모양호열	안진모양호열

SELECT ENAME || JOB "COL1"
    , CONCAT(ENAME,JOB) "COL2"
FROM TBL_EMP;
--==>>
/*
SMITHCLERK	    SMITHCLERK
ALLENSALESMAN	ALLENSALESMAN
WARDSALESMAN	WARDSALESMAN
JONESMANAGER	JONESMANAGER
MARTINSALESMAN	MARTINSALESMAN
BLAKEMANAGER	BLAKEMANAGER
CLARKMANAGER	CLARKMANAGER
SCOTTANALYST	SCOTTANALYST
KINGPRESIDENT	KINGPRESIDENT
TURNERSALESMAN	TURNERSALESMAN
ADAMSCLERK	    ADAMSCLERK
JAMESCLERK	    JAMESCLERK
FORDANALYST	    FORDANALYST
MILLERCLERK	    MILLERCLERK
*/

SELECT ENAME || JOB || DEPTNO "COL1"
    , CONCAT(ENAME, JOB, DEPTNO) "COL2"
FROM TBL_EMP;
--==>> 에러발생
/*
ORA-00909: invalid number of arguments
00909. 00000 -  "invalid number of arguments"
*Cause:    
*Action:
874행, 7열에서 오류 발생
*/

SELECT ENAME || JOB || DEPTNO "COL1"
    ,CONCAT(CONCAT(ENAME, JOB), DEPTNO) "COL2"
FROM TBL_EMP;
--==>>
/*
SMITHCLERK20	        SMITHCLERK20
ALLENSALESMAN30	    ALLENSALESMAN30
WARDSALESMAN30	    WARDSALESMAN30
JONESMANAGER20	    JONESMANAGER20
MARTINSALESMAN30    	MARTINSALESMAN30
BLAKEMANAGER30	    BLAKEMANAGER30
CLARKMANAGER10	    CLARKMANAGER10
SCOTTANALYST20	    SCOTTANALYST20
KINGPRESIDENT10	    KINGPRESIDENT10
TURNERSALESMAN30	    TURNERSALESMAN30
ADAMSCLERK20	        ADAMSCLERK20
JAMESCLERK30	        JAMESCLERK30
FORDANALYST20	    FORDANALYST20
MILLERCLERK10	    MILLERCLERK10
*/
--> 2개의 문자열(컬럼)을 결합시켜주는 기능을 가진 함수
-- 오로지 2개만 결합시킬 수 있다.
-- 내부적인 형 변환이 일어나며 결합을 수행하게 된다.
-- CONCAT()은 문자타입과 문자타입을 대상으로 결합을 수행하는 함수이지만
-- 내부적으로 숫자나 날짜를 문자 타입으로 바꿔주는 과정이 포함되어 있다.



-- cf) JAVA의 String.substring()
/*
    obj.substring()
    ---
    문자열.substring(n, m);     -- 문자열 추출
                     -----
                     n부터 n-1까지(0부터 시작하는 인덱스 적용)
*/

-- ○ SUBSTR() / SUBSTRB()
--    -------    --------
--    갯수 기반  바이트 기반

SELECT ENAME "COL1"
    , SUBSTR(ENAME, 1, 2) "COL2"
    , SUBSTR(ENAME, 2, 2) "COL3"
    , SUBSTR(ENAME, 3, 2) "COL4"
    , SUBSTR(ENAME, 2) "COL5"
FROM TBL_EMP;
--> 문자열을 추출하는 기능을 가진 함수
-- 첫 번째 파라미터 값은 대상 문자열(추출의 대상, TARGET)
-- 두 번째 파라미터 값은 추출을 시작하는 위치(단, 인덱스는 1부터 시작)
-- 세 번째 파라미터 값은 추출할 문자열의 갯수(생략시, 시작위치부터 끝까지)
--==>>
/*
SMITH	SM	MI	IT	MITH
ALLEN	AL	LL	LE	LLEN
WARD	WA	AR	RD	ARD
JONES	JO	ON	NE	ONES
MARTIN	MA	AR	RT	ARTIN
BLAKE	BL	LA	AK	LAKE
CLARK	CL	LA	AR	LARK
SCOTT	SC	CO	OT	COTT
KING	KI	IN	NG	ING
TURNER	TU	UR	RN	URNER
ADAMS	AD	DA	AM	DAMS
JAMES	JA	AM	ME	AMES
FORD	FO	OR	RD	ORD
MILLER	MI	IL	LL	ILLER
*/

--○ TBL_SAWON 테이블에서 남직원들만
--   사원번호, 사원명, 주민번호, 급여 항목을 조회한다.
--   단, SUBSTR()함수를 활용하여 처리할 수 있도록 하며,
--   급여 기준 내림차순 정렬을 수행할 수 있도록 한다.
SELECT SANO, SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SUBSTR(JUBUN,7,1) = '1' 
   OR SUBSTR(JUBUN,7,1) = '3'
ORDER BY SAL DESC;
--==>>
/*
1004	    정세찬	9104281234567	6000
1003	    이수빈	9709061234567	5000
1010	    윤주열	0502203234567	3000
1011	    선동열	7012181234567	3000
1017	    정우	8502031234567	2000
1008    	이상이	8512161234567	2000
1005    	이재용	7512121234567	2000
1016	    남진	7108051234567	2000
1002    	강명철	0002113234567	2000
1015    	남궁민	0512123234567	1000
1013    	남희석	7509231234567	1000
1006    	이이영	8904051234567	1000
1009    	남궁민	0102033234567	1000
*/

SELECT SANO, SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SUBSTR(JUBUN,7,1) IN ('1', '3')
ORDER BY SAL DESC;
--==>>
/*
1004	    정세찬	9104281234567	6000
1003	    이수빈	9709061234567	5000
1010	    윤주열	0502203234567	3000
1011	    선동열	7012181234567	3000
1017	    정우	8502031234567	2000
1008    	이상이	8512161234567	2000
1005    	이재용	7512121234567	2000
1016	    남진	7108051234567	2000
1002    	강명철	0002113234567	2000
1015    	남궁민	0512123234567	1000
1013    	남희석	7509231234567	1000
1006    	이이영	8904051234567	1000
1009    	남궁민	0102033234567	1000
*/

--○ LENGTH() / LENGTHB()
--> LENGTH()는 글자 수를 반환, LENGTHB()는 바이트 수를 반환
SELECT ENAME "COL1"
    , LENGTH(ENAME) "COL2"
    , LENGTHB(ENAME) "COL3"
FROM TBL_EMP;
--==>>
/*
SMITH	5	5
ALLEN	5	5
WARD	4	4
JONES	5	5
MARTIN	6	6
BLAKE	5	5
CLARK	5	5
SCOTT	5	5
KING	4	4
TURNER	6	6
ADAMS	5	5
JAMES	5	5
FORD	4	4
MILLER	6	6
*/

--○ 데이터베이스 주요 파리미터 확인
SELECT *
FROM NLS_DATABASE_PARAMETERS;
--==>>
/*
NLS_LANGUAGE	            AMERICAN
NLS_TERRITORY	            AMERICA
NLS_CURRENCY	            $
NLS_ISO_CURRENCY	        AMERICA
NLS_NUMERIC_CHARACTERS	    .,
NLS_CHARACTERSET	        AL32UTF8
NLS_CALENDAR	            GREGORIAN
NLS_DATE_FORMAT	            DD-MON-RR
NLS_DATE_LANGUAGE	        AMERICAN
NLS_SORT	                BINARY
NLS_TIME_FORMAT	            HH.MI.SSXFF AM
NLS_TIMESTAMP_FORMAT	    DD-MON-RR HH.MI.SSXFF AM
NLS_TIME_TZ_FORMAT	        HH.MI.SSXFF AM TZR
NLS_TIMESTAMP_TZ_FORMAT	    DD-MON-RR HH.MI.SSXFF AM TZR
NLS_DUAL_CURRENCY	        $
NLS_COMP	                BINARY
NLS_LENGTH_SEMANTICS	    BYTE
NLS_NCHAR_CONV_EXCP	        FALSE
NLS_NCHAR_CHARACTERSET	    AL16UTF16
NLS_RDBMS_VERSION	        11.2.0.2.0
*/

--※ 한글 데이터를 처리할 경우
--   바이트 기반으로 처리해야만 하는 상황이라면
--   항상 인코딩 방식을 잘 체크하고 사용해야 한다.


--○ INSTR()
SELECT 'ORACLE ORAHOME BIORA' "COL1"
    , INSTR('ORACLE ORAHOME BIORA' , 'ORA', 1, 1) "COL2"
    , INSTR('ORACLE ORAHOME BIORA' , 'ORA', 1, 2) "COL3"
    , INSTR('ORACLE ORAHOME BIORA' , 'ORA', 2, 1) "COL4"
    , INSTR('ORACLE ORAHOME BIORA' , 'ORA', 2) "COL5"
    , INSTR('ORACLE ORAHOME BIORA' , 'ORA', 2, 2) "COL6"
FROM DUAL;
--==>> ORACLE ORAHOME BIORA	1	8	8	8	18
--> 첫 번째 파라미터 값에 해당하는 문자열에서 (대상 문자열, TARGET)
--  두 번째 파라미터 값을 통해 넘겨준 문자열이 등장하는 위치를 찾아라
--  세 번째 파라미터 값은 찾기 시작하는(즉, 스캔을 시작하는) 위치
--  네 번째 파라미터 값은 몇 번째 등장하는 값을 찾을 것인지에 대한 설정(1은 생략 가능)

SELECT '나의오라클 집으로오라 합니다' "COL1"
    , INSTR('나의오라클 집으로오라 합니다', '오라', 1) "COL2"      --  3
    , INSTR('나의오라클 집으로오라 합니다', '오라', 2) "COL3"      --  3
    , INSTR('나의오라클 집으로오라 합니다', '오라', 10) "COL4"     -- 10
    , INSTR('나의오라클 집으로오라 합니다', '오라', 11) "COL5"     --  0
FROM DUAL;
--> 네 번째 파라미터(마지막 파라미터)를 생략한 형태로 사용 → 1
--==>> 나의오라클 집으로오라 합니다	3	3	10	0


--○ REVERSE()
--> 대상 문자열(매개변수)을 거꾸로 반환한다.
SELECT 'ORACLE SERVER' "COL1"
    , REVERSE('ORACLE SERVER') "COL2"
    , REVERSE('오라클 서버') "COL3"  -- 한글 깨짐 유의
FROM DUAL;
--==>> ORACLE SERVER	REVRES ELCARO   ?뜄?????


--○ 실습 테이블 생성
-- 테이블명: TBL_FILES
CREATE TABLE TBL_FILES
( FILENO    NUMBER(3)
, FILENAME  VARCHAR2(100)
);
--==>> Table TBL_FILES이(가) 생성되었습니다.

--○ 데이터 입력
INSERT INTO TBL_FILES(FILENO, FILENAME) VALUES(1, 'C:\AAA\BBB\CCC\SALES.DOC');
INSERT INTO TBL_FILES(FILENO, FILENAME) VALUES(2, 'C:\AAA\PANMAE.XLSX');
INSERT INTO TBL_FILES(FILENO, FILENAME) VALUES(3, 'C:\RESEARCH.PPT');
INSERT INTO TBL_FILES(FILENO, FILENAME) VALUES(4, 'C:\DOCUMENTS\STUDY.HWP');
INSERT INTO TBL_FILES(FILENO, FILENAME) VALUES(5, 'C:\DOCUMENTS\TEMP\SIST\TEST.PDF');
INSERT INTO TBL_FILES(FILENO, FILENAME) VALUES(6, 'D:\SHARE\D\EXAMPLE.JPG');
INSERT INTO TBL_FILES(FILENO, FILENAME) VALUES(7, 'C:\USER\CLASSD\PROJECT\20260105_JAVA.PPTX');
INSERT INTO TBL_FILES(FILENO, FILENAME) VALUES(8, 'C:\ORACLESTUDY\20260105_01_SCOTT.SQL');
--==>> 1 행 이(가) 삽입되었습니다. * 8

SELECT *
FROM TBL_FILES;
--==>>
/*
1	C:\AAA\BBB\CCC\SALES.DOC
2	C:\AAA\PANMAE.XLSX
3	C:\RESEARCH.PPT
4	C:\DOCUMENTS\STUDY.HWP
5	C:\DOCUMENTS\TEMP\SIST\TEST.PDF
6	D:\SHARE\D\EXAMPLE.JPG
7	C:\USER\CLASSD\PROJECT\20260105_JAVA.PPTX
8	C:\ORACLESTUDY\20260105_01_SCOTT.SQL
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.

SELECT FILENO "파일번호", FILENAME "파일명"
FROM TBL_FILES;
--==>>
/*
파일번호    파일명
-------- ---------------------------------------------------------------
    1	 C:\AAA\BBB\CCC\SALES.DOC
    2	 C:\AAA\PANMAE.XLSX
    3	 C:\RESEARCH.PPT
    4	 C:\DOCUMENTS\STUDY.HWP
    5	 C:\DOCUMENTS\TEMP\SIST\TEST.PDF
    6	 D:\SHARE\D\EXAMPLE.JPG
    7	 C:\USER\CLASSD\PROJECT\20260105_JAVA.PPTX
    8	 C:\ORACLESTUDY\20260105_01_SCOTT.SQL
*/

--○ TBL_FILES 테이블을 대상으로
--   위와 같이 조회될 수 있도록 쿼리문을 구성한다.
--   (파일명.확장자)
SELECT SUBSTR(FILENAME,LENGTH(FILENAME) - INSTR(REVERSE(FILENAME) , '\',1) + 2) "파일명.확장자"
FROM TBL_FILES;
--==>>
/*
SALES.DOC
PANMAE.XLSX
RESEARCH.PPT
STUDY.HWP
TEST.PDF
EXAMPLE.JPG
20260105_JAVA.PPTX
20260105_01_SCOTT.SQL
*/

SELECT SUBSTR(FILENAME, INSTR(FILENAME, '\', -1) + 1) "파일명.확장자"
FROM TBL_FILES;

SELECT FILENO "파일번호", FILENAME "경로포함파일명", SUBSTR(FILENAME,16, 9)"파일명"
FROM TBL_FILES
WHERE FILENO=1;
--==>> 1	C:\AAA\BBB\CCC\SALES.DOC	SALES.DOC

SELECT FILENO "파일번호", FILENAME "경로포함파일명"
    , SUBSTR(FILENAME,16, 9) "파일명"
FROM TBL_FILES;

SELECT FILENO "파일번호", FILENAME "경로포함파일명"
    , REVERSE(FILENAME) "거꾸로경로포함파일명"
FROM TBL_FILES;
--==>>
/*
1	C:\AAA\BBB\CCC\SALES.DOC	                COD.SELAS\CCC\BBB\AAA\:C
2	C:\AAA\PANMAE.XLSX	                        XSLX.EAMNAP\AAA\:C
3	C:\RESEARCH.PPT	                            TPP.HCRAESER\:C
4	C:\DOCUMENTS\STUDY.HWP	                    PWH.YDUTS\STNEMUCOD\:C
5	C:\DOCUMENTS\TEMP\SIST\TEST.PDF	            FDP.TSET\TSIS\PMET\STNEMUCOD\:C
6	D:\SHARE\D\EXAMPLE.JPG	                    GPJ.ELPMAXE\D\ERAHS\:D
7	C:\USER\CLASSD\PROJECT\20260105_JAVA.PPTX	XTPP.AVAJ_50106202\TCEJORP\DSSALC\RESU\:C
8	C:\ORACLESTUDY\20260105_01_SCOTT.SQL        	LQS.TTOCS_10_50106202\YDUTSELCARO\:C
*/

-- 최초 등장한 '\'의 직전까지 추출한 예상 결과
/*
COD.SELAS                \CCC\BBB\AAA\:C
XSLX.EAMNAP              \AAA\:C
TPP.HCRAESER             \:C
PWH.YDUTS                \STNEMUCOD\:C
FDP.TSET                 \TSIS\PMET\STNEMUCOD\:C
GPJ.ELPMAXE              \D\ERAHS\:D
LQS.TTOCS_10_50106202     \YDUTSELCARO\:C
*/

-- 최초 '\'가 등장하는 위치
SELECT INSTR(REVERSE(FILENAME), '\',1) "결과확인"
FROM TBL_FILES;
--==>>
/*
10
12
13
10
9
12
19
22
*/


SELECT FILENO "파일번호", FILENAME "경로포함파일명"
    , SUBSTR(REVERSE(FILENAME),1,(INSTR(REVERSE(FILENAME), '\',1)) -1) "거꾸로된 파일명"
FROM TBL_FILES;

SELECT FILENO "파일번호"
    , REVERSE(SUBSTR(REVERSE(FILENAME),1,(INSTR(REVERSE(FILENAME), '\',1)) -1)) "파일명"
FROM TBL_FILES;
--==>>
/*
1	SALES.DOC
2	PANMAE.XLSX
3	RESEARCH.PPT
4	STUDY.HWP
5	TEST.PDF
6	EXAMPLE.JPG
7	20260105_JAVA.PPTX
8	20260105_01_SCOTT.SQL
*/


--○ LPAD()
--> Byte 공간을 확보하여 왼쪽부터 문자로 채우는 기능을 가진 함수
SELECT 'ORACLE' "COL1"
    ,   LPAD('ORACLE' , 10 , '*') "COL2"
FROM DUAL;
--> ① 10Byte 공간을 확보한다.                    → 두 번째 파라미터 값에 의해
--  ② 확보한 공간에 'ORACLE' 문자열을 담는다.    → 첫 번째 파라미터 값에 의해
--  ③ 남아있는 Byte 공간(4Byte)을 왼쪽부터 세 번째 파라미터로 값을 채운다.
--  ④ 이렇게 구성된 최종 결과값을 반환한다.
--==>> ORACLE	****ORACLE

--○ RPAD()
--> Byte 공간을 확보하여 오른쪽부터 문자로 채우는 기능을 가진 함수
SELECT 'ORACLE' "COL1"
    ,   RPAD('ORACLE' , 10 , '*') "COL2"
FROM DUAL;
--> ① 10Byte 공간을 확보한다.                    → 두 번째 파라미터 값에 의해
--  ② 확보한 공간에 'ORACLE' 문자열을 담는다.    → 첫 번째 파라미터 값에 의해
--  ③ 남아있는 Byte 공간(4Byte)을 오른쪽부터 세 번째 파라미터로 값을 채운다.
--  ④ 이렇게 구성된 최종 결과값을 반환
--==>> ORACLE	ORACLE****

--○ LTRIM()
SELECT 'ORAORAORACLEORACLE' "COL1" --오라 오라 오라클 오라클
    ,LTRIM('ORAORAORACLEORACLE','ORA') "COL2"
    ,LTRIM('AAAORAORACLEORACLE','ORA') "COL3"
    ,LTRIM('ORA ORAORACLEORACLE','ORA') "COL4"
    ,LTRIM('                        ORAORAORACLEORACLE',' ') "COL5"
    ,LTRIM('                        ORAORAORACLEORACLE') "COL6" -- 왼쪽 공백 제거 함수로 활용
FROM DUAL;
--> 첫 번째 파라미터 값에 해당하는 문자열을 대상으로(대상 문자열, TARGET)
--  왼쪽부터 연속적으로 두 번째 파라미터 값에서 지정한 문자와 같은 문자가 등장할 경우
--  이를 제거한 결과값을 반환하게 된다.
--  단, 완성형으로 처리되지 않는다.
--==>> ORAORAORACLEORACLE	CLEORACLE	CLEORACLE	 ORAORACLEORACLE	ORAORAORACLEORACLE	ORAORAORACLEORACLE

SELECT LTRIM('김김김윤안박김문곽이엄엄안박정정박공','김윤안박') "결과확인"
FROM DUAL;
--==>> 문곽이엄엄안박정정박공

--○ RTRIM()
--> 첫 번째 파라미터 값에 해당하는 문자열을 대상으로(대상 문자열, TARGET)
--  오른쪽부터 연속적으로 두 번째 파라미터 값에서 지정한 문자와 같은 문자가 등장할 경우
--  이를 제거한 결과값을 반환하게 된다.
--  단, 완성형으로 처리되지 않는다.
SELECT 'OOORRRAAAAAARRRAAA' "COL1"
    , RTRIM('OOORRRAAAAAARRRAAA', 'ORA') "COL2"
    , RTRIM('OOORRRAAAAAARRRAAA', 'RA') "COL3"
FROM DUAL;
--==>> OOORRRAAAAAARRRAAA	(null)	OOO


--○ TRANSLATE()
--> 1:1로 바꾸는 과정을 수행한다.
SELECT TRANSLATE('MY ORACLE SERVER'
                , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                , 'abcdefghijklmnopqrstuvwxyz') "결과확인"
FROM DUAL;
--==>> my oracle server

SELECT TRANSLATE('010-3237-9225'
                , '0123456789'
                ,'영일이삼사오육칠팔구') "결과확인"
FROM DUAL;
--==>> 영일영-삼이삼칠-구이이오

--○ REPLACE()
SELECT REPLACE('MY ORACLE ORAHOME', 'ORA', '오라') "결과확인"
FROM DUAL;
--==>> MY 오라CLE 오라HOME


--------------------------------------------------------------------------------

--○ ROUND() 반올림을 처리해주는 함수
SELECT 48.678 "COL1"             -- 48.678
    , ROUND(48.678, 2) "COL2"    -- 48.68     -- 소수점 이하 둘째자리까지 표현(→ 셋째 자리에서 반올림)
    , ROUND(48.674, 2) "COL3"    -- 48.67
    , ROUND(48.674, 1) "COL4"    -- 48.7
    , ROUND(48.674, 0) "COL5"    -- 49
    , ROUND(48.674) "COL6"       -- 49        -- 두 번째 파라미터 값이 0일 경우 생략 가능
    , ROUND(48.674, -1) "COL7"   -- 50
    , ROUND(48.674, -2) "COL8"   -- 0
    , ROUND(48.674, -3) "COL9"   -- 0
FROM DUAL;
--==>> 48.678	48.68	48.67	48.7	49	49	50	0	0


--○ TRUNC() 절삭을 처리해주는 함수
SELECT 48.678 "COL1"             -- 48.678
    , TRUNC(48.678, 2) "COL2"    -- 48.67   -- 소수점 이하 둘째자리까지 표현(→ 셋째 자리에서 절삭)     
    , TRUNC(48.674, 2) "COL3"    -- 48.67
    , TRUNC(48.674, 1) "COL4"    -- 48.6
    , TRUNC(48.674, 0) "COL5"    -- 48      -- 두 번째 파라미터 값이 0일 경우 생략 가능
    , TRUNC(48.674) "COL6"       -- 48
    , TRUNC(48.674, -1) "COL7"   -- 40
    , TRUNC(48.674, -2) "COL8"   -- 0
    , TRUNC(48.674, -3) "COL9"   -- 0
FROM DUAL;
--==>> 48.678	48.67	48.67	48.6	48	48	40	0	0


-- + - * / %

--○ MOD() 나머지를 반환하는 함수 → 『%』
SELECT MOD(5, 2) "결과확인"
FROM DUAL;
--==>> 1
--> 5를 2로 나눈 나머지 결과값 반환

--○ POWER() 제곱의 결과를 발환하는 함수
SELECT POWER(5, 3) "RESULT"
FROM DUAL;
--==>> 125
-->> 5의 3제곱(5의 3승)을 결과값으로 반환

--○ SQRT() 루트 결과값을 반환하는 함수
SELECT SQRT(2) "RESULT"
FROM DUAL;
--==>>1.41421356237309504880168872420969807857
--> 루트2에 대한 결과값을 반환

--○ LOG() 로그 함수
SELECT LOG(10, 100) "RESULT1"
    , LOG(10, 20) "RESULT2"
FROM DUAL;
--==>> 2	1.30102999566398119521373889472449302677
-- ※오라클은 상용 로그만 지원하는 반면,
--   MS-SQL은 상용 로그와 자연 로그 모두 지원한다.

--○ 삼각 함수
SELECT SIN(1) "RESULT1", COS(1) "RESULT2" , TAN(1) "RESULT3"
FROM DUAL;
--==>>0.8414709848078965066525023216302989996233	0.5403023058681397174009366074429766037354	1.55740772465490223050697480745836017308

--○ 삼각 함수의 역함수(범위: -1 ~ 1)
SELECT ASIN(0.5) "RESULT1", ACOS(0.5) "RESULT2" , ATAN(0.5) "RESULT3"
FROM DUAL;
--==>> 0.52359877559829887307710723054658381405	1.04719755119659774615421446109316762805	0.4636476090008061162142562314612144020295

--○ SIGN() 서명, 부호, 특징
--  연산 결과값이 양수면 1, 0이면 0, 음수면 -1을 반환한다.
SELECT SIGN(5-1) "RESULT1"
    , SIGN(5-5) "RESULT2"
    , SIGN(5-9) "RESULT3"
FROM DUAL;
--==>> 1	0	-1
--※ 매출이나 수지와 관련하여 적자 및 흑자의 개념을 표현할 때 주로 사용한다.

--○ ASCII(), CHR() → 서로 대응하는 개념의 함수
SELECT ASCII('A') "RESULT1"
    , CHR(65) "RESULT2"
FROM DUAL;
--==>> 65	A
-- ASCII() : 매개변수로 넘겨받은 문자의 아스키코드 값을 반환한다.
-- CHR()   : 매개변수로 넘겨받은 숫자를 아스키코드 값으로 취하는 문자를 반환한다.


--------------------------------------------------------------------------------

--※ 날짜 관련 세션 설정
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

SELECT SYSDATE
FROM DUAL;
--==>> 2026-01-05 16:27:07

--※ 오라클에서 날짜 연산의 기본 단위는 DAY(일수)이다.

SELECT SYSDATE "COL1"       -- 2026-01-05 16:29:27      → 현재
    , SYSDATE + 1 "COL2"    -- 2026-01-06 16:29:27      → 1일 후
    , SYSDATE - 2 "COL3"    -- 2026-01-03 16:29:27      → 2일 전
    , SYSDATE + 3 "COL4"    -- 2026-01-08 16:29:27      → 3일 후
FROM DUAL;

--○ 시간 단위 연산
SELECT SYSDATE "COL1"       -- 2026-01-05 16:31:39      → 현재
    , SYSDATE + 1/24 "COL2" -- 2026-01-05 17:31:39      → 1시간 후
    , SYSDATE - 2/24 "COL3" -- 2026-01-05 14:31:39      → 2시간 전
FROM DUAL;

--○ 현재 시간과
--   현재 시간 기준 1일 2시간 3분 4초 후를 조회하는 쿼리문을 구성한다.
/*
-----------------------------------------------------------------------
    현재 시간           |       연산후 시간
-----------------------------------------------------------------------
2026-01-05 16:31:39     | 2026-01-06 18:34:43
-----------------------------------------------------------------------
*/
-- 방법 1.
SELECT SYSDATE "현재 시간"
    , SYSDATE + 1 + (2/24) + (3/24/60) + (4/24/60/60) "연산 후 시간"
FROM DUAL;
SELECT SYSDATE "현재 시간"
    , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "연산 후 시간"
FROM DUAL;
--==>> 2026-01-05 16:36:06	2026-01-06 18:39:10

-- 방법 2.
SELECT SYSDATE "현재 시간"
    , SYSDATE +((24*60*60) + (2*60*60) + (3*60) + 4) /(24*60*60) "연산 후 시간"
FROM DUAL;
--==>> 2026-01-05 16:45:01	2026-01-06 18:48:05

--※ 날짜 - 날짜 = 일수
-- ex) (2026-06-15) - (2026-01-05)
--      수료일     -   현재일

--※ 데이터 타입의 변환
SELECT TO_DATE('2026-06-15' , 'YYYY-MM-DD') "결과확인"
FROM DUAL;
--==>> 2026-06-15 00:00:00
-- 날짜 타입으로 변환

SELECT TO_DATE('2026-06-35' , 'YYYY-MM-DD') "결과확인"
FROM DUAL;
--==>> 에러 발생
/*
ORA-01847: day of month must be between 1 and last day of month
01847. 00000 -  "day of month must be between 1 and last day of month"
*Cause:    
*Action:
*/

--※ TO_DATE()함수를 통해 문자 타입을 날짜 타입으로 변환을 수행할 때
--   내부적으로 해당 날짜에 대한 유효성 검사가 이루어진다.

SELECT TO_DATE('2026-06-15' , 'YYYY-MM-DD') - TO_DATE('2026-01-05', 'YYYY-MM-DD') "결과확인"
FROM DUAL;
--==>> 161

--○ ADD_MONTHS() 개월 수를 더해주는 함수
SELECT SYSDATE "COL1"
    , ADD_MONTHS(SYSDATE, 2) "COL2"
    , ADD_MONTHS(SYSDATE, 3) "COL3"
    , ADD_MONTHS(SYSDATE, -2) "COL4"
    , ADD_MONTHS(SYSDATE, -3) "COL5"
FROM DUAL;
--==>> 
/*
2026-01-05 17:03:27	    → 현재
2026-03-05 17:03:27	    → 2개월 후
2026-04-05 17:03:27	    → 3개월 후
2025-11-05 17:03:27	    → 2개월 전
2025-10-05 17:03:27     → 3개월 전
*/
--> 개월 수를 더하고 빼기

--※ 날짜 관련 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

--○ MONTHS_BETWEEN()
-- 첫 번째 인자값에서 두 번째 인자값을 뺀 개월 수를 반환
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05_31', 'YYYY-MM-DD')) "RESULT"
FROM DUAL;
--==>> 283.184292114695340501792114695340501792
--> 개월 수의 차이를 반환하는 함수
--※ 결과값의 부호가 『-』(음수)로 반환되었을 경우에는
-- 첫 번째 인자값에 해당하는 날짜보다
-- 두 번째 인자값에 해당하는 날짜가 『미래』라는 의미로 확인할 수 있다.

SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2026-06-15', 'YYYY-MM-DD')) "RESULT"
FROM DUAL;
--==>> -5.29953068996415770609318996415770609319


--○ NEXT_DAY()
-- 첫 번째 인자값을 기준 날짜로 돌아오는 가장 빠른 요일 반환
SELECT NEXT_DAY(SYSDATE, '토') "COL1"
    , NEXT_DAY(SYSDATE, '수') "COL2"
FROM DUAL;
--==>> 2026-01-10	2026-01-07

--○ 추가 세션 설정 변경(관찰)
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==>> Session이(가) 변경되었습니다.

--○ 세션 설정 변경 이후 위의 쿼리문을 그대로 다시 실행
SELECT NEXT_DAY(SYSDATE, '토') "COL1"
    , NEXT_DAY(SYSDATE, '수') "COL2"
FROM DUAL;
--==>> 에러 발생
/*
ORA-01846: not a valid day of the week
01846. 00000 -  "not a valid day of the week"
*Cause:    
*Action:
*/

SELECT NEXT_DAY(SYSDATE, 'SAT') "COL1"
    , NEXT_DAY(SYSDATE, 'WED') "COL2"
FROM DUAL;
--==>> 2026-01-10   2026-01-07

--○ 추가 세션 설정 변경(관찰)
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session이(가) 변경되었습니다.

SELECT NEXT_DAY(SYSDATE, 'SAT') "COL1"
    , NEXT_DAY(SYSDATE, 'WED') "COL2"
FROM DUAL;
--==>> 에러 발생
/*
ORA-01846: not a valid day of the week
01846. 00000 -  "not a valid day of the week"
*Cause:    
*Action:
*/

SELECT NEXT_DAY(SYSDATE, '토') "COL1"
    , NEXT_DAY(SYSDATE, '수') "COL2"
FROM DUAL;
--==>> 2026-01-10   2026-01-07


--○ LAST_DAY()
-- 해당 날짜가 포함되어 있는 그 달의 마지막 날을 반환한다.
SELECT LAST_DAY(SYSDATE) "RESULT"
FROM DUAL;
--==>> 2026-01-31


--○ 오늘부로 명철이가 군대에 또 끌려(?)간다.
--  복무기간은 22개월로 한다.

-- 1. 전역 일자를 구한다.
SELECT ADD_MONTHS(SYSDATE, 22) "전역일자"
FROM DUAL;
--==>> 2027-11-05

-- 2. 하루 꼬박꼬박 세 끼 식사를 해야 한다고 가정하면
--    명철이가 몇 끼를 먹어야 집에 보내줄까

-- 복무기간 * 3
-- -------
-- 전역일자 - 현재일자

-- (전역일자 - 현재일자) * 3
SELECT (ADD_MONTHS(SYSDATE, 22) - SYSDATE) * 3 "몇끼?"
FROM DUAL;
--==>> 2007

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
-- Session이(가) 변경되었습니다.

--○ 현재 날짜 및 시간을 기준으로
--   수료일(2026-06-15 18:00:00)까지 남은 기간을
--   다음과 같은 형태로 조회할 수 있도록 쿼리문을 구성한다.

/*
---------------------------------------------------------------------
현재 시각            |  수료일             | 일  | 시간 | 분 | 초
---------------------------------------------------------------------
2026-01-05 17:33:54  | 2026-06-15 18:00:00  |  150 |  0  | 15 | 5
---------------------------------------------------------------------
*/

SELECT SYSDATE "현재 시각"
    , TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
    , TRUNC((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE) "일"
    , TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE
    ,((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE) - TRUNC((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE) 
FROM DUAL;































































