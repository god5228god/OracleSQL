SELECT USER
FROM DUAL;
--==>> SCOTT

--○ 게시물 리스트 조회
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

--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO = 3;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_BOARD
WHERE NO = 7;

--○ 게시물 작성
INSERT INTO TBL_BOARD(NO, TITLE, CONTENTS, NAME, PW, CREATED) 
VALUES(SEQ_BOARD.NEXTVAL, '설문', '좋아하는 야구팀은?', '임유훤', 'java004$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO = 6;
--==>> 1 행 이(가) 삭제되었습니다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 확인
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	게시물테스트  	조금만 기운냅시다	    강명철	java004$    	2026-01-07
2	건강 관리	    다들 건강 챙깁시다	    안진모	java004$	    2026-01-07
4	오타쟁이	    오타를 줄여 나갑시다	강명철	java004$	    2026-01-07
5	여기까지	    오늘은 여기까지	        정세찬	java004$	    2026-01-07
8	설문	        좋아하는 야구팀은?	    임유훤	java004$	    2026-01-08
*/

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
    , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
5	설문	        임유훤	2026-01-08
4	여기까지	    정세찬	2026-01-07
3	오타쟁이	    강명철	2026-01-07
2	건강 관리	    안진모	2026-01-07
1	게시물테스트	    강명철	2026-01-07
*/


--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO = 5;
--==>> 1 행 이(가) 삭제되었습니다.


--○ 게시물 작성
INSERT INTO TBL_BOARD(NO, TITLE, CONTENTS, NAME, PW, CREATED) 
VALUES(SEQ_BOARD.NEXTVAL, '공지', '기본을 지키며 살아갑시다', '윤주열', 'java004$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
    , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
5	공지	        윤주열	2026-01-08
4	설문	        임유훤	2026-01-08
3	오타쟁이	    강명철	2026-01-07
2	건강 관리	    안진모	2026-01-07
1	게시물테스트	    강명철	2026-01-07
*/

SELECT *
FROM TBL_BOARD;



--------------------------------------------------------------------------------


-- ■■■ JOIN(조인) ■■■ --
SELECT *
FROM EMP;

SELECT *
FROM DEPT;

SELECT *
FROM SALGRADE;

-----------------------------------------------------------------------------------------
--7369	SMITH	CLERK	    7902	    1980-12-17	800		    20  RESEARCH    	DALLAS  1등급
--7499	ALLEN	SALESMAN	7698	1981-02-20	1600    	300	30  SALES	    CHICAGO 3등급
--                                          :
--


-- 1. SQL 1992 CODE
SELECT *
FROM EMP, DEPT;                     -- CROSS JOIN
--> 수학에서 말하는 데카르트 곱(Caterisan Product)
--  두 테이블을 합친(결합한) 모든 경우의 수

-- Equi Join : 서로 정확히 일치하는 데이터들 끼리 연결시키는 결합
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
--==>>
/*

     EMPNO ENAME      JOB              MGR HIREDATE          SAL       COMM     DEPTNO     DEPTNO DNAME          LOC          
---------- ---------- --------- ---------- ---------- ---------- ---------- ---------- ---------- -------------- -------------
      7369 SMITH      CLERK           7902 1980-12-17        800                    20         20 RESEARCH       DALLAS       
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30         30 SALES          CHICAGO      
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30         30 SALES          CHICAGO      
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20         20 RESEARCH       DALLAS       
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30         30 SALES          CHICAGO      
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30         30 SALES          CHICAGO      
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10         10 ACCOUNTING     NEW YORK     
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20         20 RESEARCH       DALLAS       
      7839 KING       PRESIDENT            1981-11-17       5000                    10         10 ACCOUNTING     NEW YORK     
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30         30 SALES          CHICAGO      
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20         20 RESEARCH       DALLAS       
      7900 JAMES      CLERK           7698 1981-12-03        950                    30         30 SALES          CHICAGO      
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20         20 RESEARCH       DALLAS       
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10         10 ACCOUNTING     NEW YORK     
*/

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>>
/*

     EMPNO ENAME      JOB              MGR HIREDATE          SAL       COMM     DEPTNO     DEPTNO DNAME          LOC          
---------- ---------- --------- ---------- ---------- ---------- ---------- ---------- ---------- -------------- -------------
      7369 SMITH      CLERK           7902 1980-12-17        800                    20         20 RESEARCH       DALLAS       
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30         30 SALES          CHICAGO      
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30         30 SALES          CHICAGO      
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20         20 RESEARCH       DALLAS       
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30         30 SALES          CHICAGO      
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30         30 SALES          CHICAGO      
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10         10 ACCOUNTING     NEW YORK     
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20         20 RESEARCH       DALLAS       
      7839 KING       PRESIDENT            1981-11-17       5000                    10         10 ACCOUNTING     NEW YORK     
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30         30 SALES          CHICAGO      
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20         20 RESEARCH       DALLAS       
      7900 JAMES      CLERK           7698 1981-12-03        950                    30         30 SALES          CHICAGO      
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20         20 RESEARCH       DALLAS       
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10         10 ACCOUNTING     NEW YORK     
*/

SELECT *
FROM EMP;
SELECT *
FROM SALGRADE;

-- Non Equi Join: 범위 안에 적합한 데이터들끼지 결합시키는 방식
SELECT *
FROM EMP, SALGRADE
WHERE EMP.SAL BETWEEN SALGRADE.LOSAL AND SALGRADE.HISAL;
--==>>
/*
     EMPNO ENAME      JOB              MGR HIREDATE          SAL       COMM     DEPTNO      GRADE      LOSAL      HISAL
---------- ---------- --------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
      7369 SMITH      CLERK           7902 1980-12-17        800                    20          1        700       1200
      7900 JAMES      CLERK           7698 1981-12-03        950                    30          1        700       1200
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20          1        700       1200
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30          2       1201       1400
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30          2       1201       1400
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10          2       1201       1400
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30          3       1401       2000
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30          3       1401       2000
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10          4       2001       3000
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30          4       2001       3000
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20          4       2001       3000
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20          4       2001       3000
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20          4       2001       3000
      7839 KING       PRESIDENT            1981-11-17       5000                    10          5       3001       9999
*/

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;
--==>>
/*
     EMPNO ENAME      JOB              MGR HIREDATE          SAL       COMM     DEPTNO      GRADE      LOSAL      HISAL
---------- ---------- --------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
      7369 SMITH      CLERK           7902 1980-12-17        800                    20          1        700       1200
      7900 JAMES      CLERK           7698 1981-12-03        950                    30          1        700       1200
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20          1        700       1200
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30          2       1201       1400
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30          2       1201       1400
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10          2       1201       1400
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30          3       1401       2000
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30          3       1401       2000
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10          4       2001       3000
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30          4       2001       3000
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20          4       2001       3000
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20          4       2001       3000
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20          4       2001       3000
      7839 KING       PRESIDENT            1981-11-17       5000                    10          5       3001       9999
*/


-- Equi Join 시 『+』를 활용한 결합 방법
SELECT *
FROM TBL_EMP;
SELECT *
FROM TBL_DEPT;

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>>
/*
     EMPNO ENAME      JOB              MGR HIREDATE          SAL       COMM     DEPTNO     DEPTNO DNAME          LOC          
---------- ---------- --------- ---------- ---------- ---------- ---------- ---------- ---------- -------------- -------------
      7369 SMITH      CLERK           7902 1980-12-17        800                    20         20 RESEARCH       DALLAS       
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30         30 SALES          CHICAGO      
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30         30 SALES          CHICAGO      
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20         20 RESEARCH       DALLAS       
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30         30 SALES          CHICAGO      
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30         30 SALES          CHICAGO      
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10         10 ACCOUNTING     NEW YORK     
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20         20 RESEARCH       DALLAS       
      7839 KING       PRESIDENT            1981-11-17       5000                    10         10 ACCOUNTING     NEW YORK     
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30         30 SALES          CHICAGO      
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20         20 RESEARCH       DALLAS
      7900 JAMES      CLERK           7698 1981-12-03        950                    30         30 SALES          CHICAGO      
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20         20 RESEARCH       DALLAS       
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10         10 ACCOUNTING     NEW YORK   
*/

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
--> 총 19건의 데이터가 결합되어 조회된 상황
--  즉, 부서번호를 갖지 못한 사원들(5인)도 모두 조회된 상황
--==>>
/*
     EMPNO ENAME      JOB              MGR HIREDATE          SAL       COMM     DEPTNO     DEPTNO DNAME          LOC          
---------- ---------- --------- ---------- ---------- ---------- ---------- ---------- ---------- -------------- -------------
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10         10 ACCOUNTING     NEW YORK     
      7839 KING       PRESIDENT            1981-11-17       5000                    10         10 ACCOUNTING     NEW YORK     
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10         10 ACCOUNTING     NEW YORK     
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20         20 RESEARCH       DALLAS       
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20         20 RESEARCH       DALLAS       
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20         20 RESEARCH       DALLAS       
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20         20 RESEARCH       DALLAS       
      7369 SMITH      CLERK           7902 1980-12-17        800                    20         20 RESEARCH       DALLAS       
      7900 JAMES      CLERK           7698 1981-12-03        950                    30         30 SALES          CHICAGO      
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30         30 SALES          CHICAGO      
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30         30 SALES          CHICAGO
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30         30 SALES          CHICAGO      
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30         30 SALES          CHICAGO      
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30         30 SALES          CHICAGO      
      8005 카리나     SALESMAN        7698 2026-01-07       1000                                                              
      8004 아이유     SALESMAN        7698 2026-01-07       2500                                                              
      8003 김다미     SALESMAN        7698 2026-01-07       2000                                                              
      8001 고윤정     CLERK           7566 2026-01-07       1500         10                                                   
      8002 하성운     CLERK           7566 2026-01-07       1000          0                                                   

*/

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--> 총 16건의 데이터가 결합되어 조회된 상황
--  즉, 부서에 소속된 사원이 아무도 없는 부서(2개 부서)도 모두 조회된 상황
--==>>
/*
     EMPNO ENAME      JOB              MGR HIREDATE          SAL       COMM     DEPTNO     DEPTNO DNAME          LOC          
---------- ---------- --------- ---------- ---------- ---------- ---------- ---------- ---------- -------------- -------------
      7369 SMITH      CLERK           7902 1980-12-17        800                    20         20 RESEARCH       DALLAS       
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30         30 SALES          CHICAGO      
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30         30 SALES          CHICAGO      
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20         20 RESEARCH       DALLAS       
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30         30 SALES          CHICAGO      
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30         30 SALES          CHICAGO      
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10         10 ACCOUNTING     NEW YORK     
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20         20 RESEARCH       DALLAS       
      7839 KING       PRESIDENT            1981-11-17       5000                    10         10 ACCOUNTING     NEW YORK     
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30         30 SALES          CHICAGO      
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20         20 RESEARCH       DALLAS 
      7900 JAMES      CLERK           7698 1981-12-03        950                    30         30 SALES          CHICAGO      
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20         20 RESEARCH       DALLAS       
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10         10 ACCOUNTING     NEW YORK     
                                                                                               50 연구부         경기         
                                                                                               40 OPERATIONS     BOSTON   
*/

--※ 『(+)』가 없는 쪽 테이블의 데이터를 먼저 구성한 후
--   『(+)』가 있는 쪽 테이블의 데이터를 하나하나 확인하여 결합시키는 형태로
--    JOIN이 이루어진다.

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
--> 위와 같은 이유로 이런 형식의 JOIN 구문은 존재하지 않는다.


-- 2. SQL 1999 CODE → 『JOIN』 키워드 등장 → JOIN 유형 명시
--                      결합 조건은 『WHERE』 대신 『ON』

-- CROSS JOIN
SELECT *
FROM EMP CROSS JOIN DEPT;
--==>>
/*

     EMPNO ENAME      JOB              MGR HIREDATE          SAL       COMM     DEPTNO     DEPTNO DNAME          LOC          
---------- ---------- --------- ---------- ---------- ---------- ---------- ---------- ---------- -------------- -------------
      7369 SMITH      CLERK           7902 1980-12-17        800                    20         10 ACCOUNTING     NEW YORK     
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30         10 ACCOUNTING     NEW YORK     
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30         10 ACCOUNTING     NEW YORK     
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20         10 ACCOUNTING     NEW YORK     
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30         10 ACCOUNTING     NEW YORK     
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30         10 ACCOUNTING     NEW YORK     
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10         10 ACCOUNTING     NEW YORK     
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20         10 ACCOUNTING     NEW YORK     
      7839 KING       PRESIDENT            1981-11-17       5000                    10         10 ACCOUNTING     NEW YORK     
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30         10 ACCOUNTING     NEW YORK     
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20         10 ACCOUNTING     NEW YORK     
      7900 JAMES      CLERK           7698 1981-12-03        950                    30         10 ACCOUNTING     NEW YORK     
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20         10 ACCOUNTING     NEW YORK     
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10         10 ACCOUNTING     NEW YORK     
      7369 SMITH      CLERK           7902 1980-12-17        800                    20         20 RESEARCH       DALLAS       
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30         20 RESEARCH       DALLAS       
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30         20 RESEARCH       DALLAS       
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20         20 RESEARCH       DALLAS       
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30         20 RESEARCH       DALLAS       
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30         20 RESEARCH       DALLAS       
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10         20 RESEARCH       DALLAS       
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20         20 RESEARCH       DALLAS       
      7839 KING       PRESIDENT            1981-11-17       5000                    10         20 RESEARCH       DALLAS       
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30         20 RESEARCH       DALLAS       
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20         20 RESEARCH       DALLAS       
      7900 JAMES      CLERK           7698 1981-12-03        950                    30         20 RESEARCH       DALLAS       
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20         20 RESEARCH       DALLAS       
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10         20 RESEARCH       DALLAS       
      7369 SMITH      CLERK           7902 1980-12-17        800                    20         30 SALES          CHICAGO      
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30         30 SALES          CHICAGO      
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30         30 SALES          CHICAGO      
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20         30 SALES          CHICAGO      
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30         30 SALES          CHICAGO      
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30         30 SALES          CHICAGO      
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10         30 SALES          CHICAGO      
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20         30 SALES          CHICAGO      
      7839 KING       PRESIDENT            1981-11-17       5000                    10         30 SALES          CHICAGO      
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30         30 SALES          CHICAGO      
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20         30 SALES          CHICAGO      
      7900 JAMES      CLERK           7698 1981-12-03        950                    30         30 SALES          CHICAGO      
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20         30 SALES          CHICAGO      
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10         30 SALES          CHICAGO      
      7369 SMITH      CLERK           7902 1980-12-17        800                    20         40 OPERATIONS     BOSTON       
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30         40 OPERATIONS     BOSTON       
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30         40 OPERATIONS     BOSTON       
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20         40 OPERATIONS     BOSTON       
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30         40 OPERATIONS     BOSTON       
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30         40 OPERATIONS     BOSTON       
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10         40 OPERATIONS     BOSTON       
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20         40 OPERATIONS     BOSTON       
      7839 KING       PRESIDENT            1981-11-17       5000                    10         40 OPERATIONS     BOSTON       
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30         40 OPERATIONS     BOSTON       
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20         40 OPERATIONS     BOSTON       
      7900 JAMES      CLERK           7698 1981-12-03        950                    30         40 OPERATIONS     BOSTON       
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20         40 OPERATIONS     BOSTON       
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10         40 OPERATIONS     BOSTON      
*/

-- INNER JOIN
SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--==>>
/*
     EMPNO ENAME      JOB              MGR HIREDATE          SAL       COMM     DEPTNO     DEPTNO DNAME          LOC          
---------- ---------- --------- ---------- ---------- ---------- ---------- ---------- ---------- -------------- -------------
      7369 SMITH      CLERK           7902 1980-12-17        800                    20         20 RESEARCH       DALLAS       
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30         30 SALES          CHICAGO      
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30         30 SALES          CHICAGO      
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20         20 RESEARCH       DALLAS       
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30         30 SALES          CHICAGO      
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30         30 SALES          CHICAGO      
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10         10 ACCOUNTING     NEW YORK     
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20         20 RESEARCH       DALLAS       
      7839 KING       PRESIDENT            1981-11-17       5000                    10         10 ACCOUNTING     NEW YORK     
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30         30 SALES          CHICAGO      
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20         20 RESEARCH       DALLAS       
      7900 JAMES      CLERK           7698 1981-12-03        950                    30         30 SALES          CHICAGO      
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20         20 RESEARCH       DALLAS       
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10         10 ACCOUNTING     NEW YORK     
*/

--※ INNER JOIN 시 INNER는 생략 가능
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--==>>
/*
     EMPNO ENAME      JOB              MGR HIREDATE          SAL       COMM     DEPTNO     DEPTNO DNAME          LOC          
---------- ---------- --------- ---------- ---------- ---------- ---------- ---------- ---------- -------------- -------------
      7369 SMITH      CLERK           7902 1980-12-17        800                    20         20 RESEARCH       DALLAS       
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30         30 SALES          CHICAGO      
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30         30 SALES          CHICAGO      
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20         20 RESEARCH       DALLAS       
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30         30 SALES          CHICAGO      
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30         30 SALES          CHICAGO      
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10         10 ACCOUNTING     NEW YORK     
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20         20 RESEARCH       DALLAS       
      7839 KING       PRESIDENT            1981-11-17       5000                    10         10 ACCOUNTING     NEW YORK     
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30         30 SALES          CHICAGO      
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20         20 RESEARCH       DALLAS       
      7900 JAMES      CLERK           7698 1981-12-03        950                    30         30 SALES          CHICAGO      
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20         20 RESEARCH       DALLAS       
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10         10 ACCOUNTING     NEW YORK     
*/

SELECT *
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;
--==>>
/*
     EMPNO ENAME      JOB              MGR HIREDATE          SAL       COMM     DEPTNO      GRADE      LOSAL      HISAL
---------- ---------- --------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
      7369 SMITH      CLERK           7902 1980-12-17        800                    20          1        700       1200
      7900 JAMES      CLERK           7698 1981-12-03        950                    30          1        700       1200
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20          1        700       1200
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30          2       1201       1400
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30          2       1201       1400
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10          2       1201       1400
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30          3       1401       2000
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30          3       1401       2000
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10          4       2001       3000
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30          4       2001       3000
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20          4       2001       3000
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20          4       2001       3000
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20          4       2001       3000
      7839 KING       PRESIDENT            1981-11-17       5000                    10          5       3001       9999
*/


-- OUTER JOIN
SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
--> 방향이 지정된 쪽 테이블(→ LEFT)의 데이터를 먼저 나열한 후
--  방향이 지정되지 않을 쪽 테이블들의 데이터를 각각 확인하여 결합시키는 형태로
--  JOIN을 수행한다.
--==>>
/*

     EMPNO ENAME      JOB              MGR HIREDATE          SAL       COMM     DEPTNO     DEPTNO DNAME          LOC          
---------- ---------- --------- ---------- ---------- ---------- ---------- ---------- ---------- -------------- -------------
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10         10 ACCOUNTING     NEW YORK     
      7839 KING       PRESIDENT            1981-11-17       5000                    10         10 ACCOUNTING     NEW YORK     
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10         10 ACCOUNTING     NEW YORK     
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20         20 RESEARCH       DALLAS       
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20         20 RESEARCH       DALLAS       
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20         20 RESEARCH       DALLAS       
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20         20 RESEARCH       DALLAS       
      7369 SMITH      CLERK           7902 1980-12-17        800                    20         20 RESEARCH       DALLAS       
      7900 JAMES      CLERK           7698 1981-12-03        950                    30         30 SALES          CHICAGO      
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30         30 SALES          CHICAGO      
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30         30 SALES          CHICAGO      
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30         30 SALES          CHICAGO      
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30         30 SALES          CHICAGO      
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30         30 SALES          CHICAGO      
      8005 카리나     SALESMAN        7698 2026-01-07       1000                                                              
      8004 아이유     SALESMAN        7698 2026-01-07       2500                                                              
      8003 김다미     SALESMAN        7698 2026-01-07       2000                                                              
      8001 고윤정     CLERK           7566 2026-01-07       1500         10                                                   
      8002 하성운     CLERK           7566 2026-01-07       1000          0    
*/

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
--==>>
/*
     EMPNO ENAME      JOB              MGR HIREDATE          SAL       COMM     DEPTNO     DEPTNO DNAME          LOC          
---------- ---------- --------- ---------- ---------- ---------- ---------- ---------- ---------- -------------- -------------
      7369 SMITH      CLERK           7902 1980-12-17        800                    20         20 RESEARCH       DALLAS       
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30         30 SALES          CHICAGO      
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30         30 SALES          CHICAGO      
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20         20 RESEARCH       DALLAS       
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30         30 SALES          CHICAGO      
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30         30 SALES          CHICAGO      
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10         10 ACCOUNTING     NEW YORK     
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20         20 RESEARCH       DALLAS       
      7839 KING       PRESIDENT            1981-11-17       5000                    10         10 ACCOUNTING     NEW YORK     
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30         30 SALES          CHICAGO      
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20         20 RESEARCH       DALLAS       
      7900 JAMES      CLERK           7698 1981-12-03        950                    30         30 SALES          CHICAGO      
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20         20 RESEARCH       DALLAS       
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10         10 ACCOUNTING     NEW YORK     
                                                                                               50 연구부         경기         
                                                                                               40 OPERATIONS     BOSTON       
*/

SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
--==>>
/*
     EMPNO ENAME      JOB              MGR HIREDATE          SAL       COMM     DEPTNO     DEPTNO DNAME          LOC          
---------- ---------- --------- ---------- ---------- ---------- ---------- ---------- ---------- -------------- -------------
      7369 SMITH      CLERK           7902 1980-12-17        800                    20         20 RESEARCH       DALLAS       
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30         30 SALES          CHICAGO      
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30         30 SALES          CHICAGO      
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20         20 RESEARCH       DALLAS       
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30         30 SALES          CHICAGO      
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30         30 SALES          CHICAGO      
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10         10 ACCOUNTING     NEW YORK     
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20         20 RESEARCH       DALLAS       
      7839 KING       PRESIDENT            1981-11-17       5000                    10         10 ACCOUNTING     NEW YORK     
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30         30 SALES          CHICAGO      
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20         20 RESEARCH       DALLAS       
      7900 JAMES      CLERK           7698 1981-12-03        950                    30         30 SALES          CHICAGO      
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20         20 RESEARCH       DALLAS       
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10         10 ACCOUNTING     NEW YORK     
      8002 하성운     CLERK           7566 2026-01-07       1000          0                                                   
      8001 고윤정     CLERK           7566 2026-01-07       1500         10                                                   
      8003 김다미     SALESMAN        7698 2026-01-07       2000                                                              
      8004 아이유     SALESMAN        7698 2026-01-07       2500                                                              
      8005 카리나     SALESMAN        7698 2026-01-07       1000                                                              
                                                                                               50 연구부         경기         
                                                                                               40 OPERATIONS     BOSTON    
*/

--※ OUTER JOIN에서 OUTER는 생략가능

SELECT *
FROM TBL_EMP E LEFT JOIN TBL_DEPT D         -- OUTER JOIN
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT JOIN TBL_DEPT D        -- OUTER JOIN
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL JOIN TBL_DEPT D         -- OUTER JOIN
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D              -- INNER JOIN
ON E.DEPTNO = D.DEPTNO;


SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D          
ON E.DEPTNO = D.DEPTNO
AND JOB = 'CLERK';
--> 조회는 가능하지만 부적합함
--==>>
/*
7369	SMITH	CLERK	7902	    1980-12-17	800		20	20	RESEARCH	DALLAS
7876	ADAMS	CLERK	7788	1987-07-13	1100		20	20	RESEARCH	DALLAS
7900	    JAMES	CLERK	7698	1981-12-03	950		30	30	SALES	    CHICAGO
7934	MILLER	CLERK	7782	1982-01-23	1300		10	10	ACCOUNTING	NEW YORK
*/

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D          
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
--> 이런 형태의 조회가 바람직함
--==>>
/*
7369	SMITH	CLERK	7902	    1980-12-17	800		20	20	RESEARCH	DALLAS
7876	ADAMS	CLERK	7788	1987-07-13	1100		20	20	RESEARCH	DALLAS
7900	    JAMES	CLERK	7698	1981-12-03	950		30	30	SALES	    CHICAGO
7934	MILLER	CLERK	7782	1982-01-23	1300		10	10	ACCOUNTING	NEW YORK
*/


--------------------------------------------------------------------------------

--○ EMP 테이블과 DEPT 테이블을 대상으로
--   직종이 MANAGER와 CLERK인 사원들만
--   부서번호, 부서명, 사원명, 직종명, 급여 항목을 조회한다.
--   --------  ------  ------  ------ ------
--    DEPTNO    DNAME   ENAME   JOB     SAL
--   --------  ------  ------  ------ ------
--     E, D       D       E       E      E
SELECT *
FROM EMP;

SELECT *
FROM DEPT;

SELECT D.DEPTNO "부서번호", D.DNAME "부서명", E.ENAME "사원명", E.JOB "직종명", E.SAL "급여"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.JOB IN('MANAGER', 'CLERK');
--==>>
/*
 부서번호 부서명          사원명    직종명           급여
---------- -------------- ---------- --------- ----------
        20 RESEARCH       SMITH      CLERK            800
        20 RESEARCH       JONES      MANAGER         2975
        30 SALES          BLAKE      MANAGER         2850
        10 ACCOUNTING     CLARK      MANAGER         2450
        20 RESEARCH       ADAMS      CLERK           1100
        30 SALES          JAMES      CLERK            950
        10 ACCOUNTING     MILLER     CLERK           1300
*/

SELECT DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>> 에러 발생
/*
ORA-00918: column ambiguously defined
00918. 00000 -  "column ambiguously defined"
*Cause:    
*Action:
636행, 8열에서 오류 발생
*/
--> 두 테이블 간 중복되는 컬럼에 대한 소속 테이블을
--  정해줘야(명시해줘야) 한다.

SELECT DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 두 테이블 간 중복되는 컬럼에 대해 소속 테이블을 명시하는 경우
-- 부서(DEPT), 사원(EMP) 중 어떤 테이블을 지정해도
-- 쿼리문 수행에 대한 결과 반환에는 문제가 없다.(차이가 없다)

-- ※ 하지만
--    두 테이블 간 중복되는 컬럼에 대한 소속 테이블을 명시하는 경우
--    기본적으로 부모 테이블의 컬럼을 참조할 수 있도록 해야 한다.

--       DEPTNO
-- EMP ---------- DEPT
--(자식)         (부모)


--○ 최종 쿼리
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 두 테이블 간 중복된 컬럼이 아니더라도
-- 소속 테이블을 명시할 수 있기를 권장한다.

SELECT D.DEPTNO "부서번호", D.DNAME "부서명", E.ENAME "사원명", E.JOB "직종명", E.SAL "급여"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;


--○ SELF JOIN (자기 조인)
-- EMP 테이블의 데이터를 다음과 같이 조회할 수 있도록 쿼리문을 구성한다.

-- EMPNO    ENAME       JOB         MGR                                 → ① → E1
--                                 EMPNO        ENAME           JOB     → ② → E2
--------------------------------------------------------------------------
-- 사원번호 사원명     직종명     관리자번호   관리자명    관리자직종명
--------------------------------------------------------------------------
--  7369     SMITH      CLERK        7902        FORD       ANALYST 
--  7499     ALLEN      SALESMAN     7698        BLAKE      MANAGER           

SELECT *
FROM EMP;

SELECT E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명", E1.MGR "관리자번호"
    , E2.ENAME "관리자명", E2.JOB  "관리자직종명"
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+);

SELECT E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명", E1.MGR "관리자번호"
    , E2.ENAME "관리자명", E2.JOB "관리자직종명"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;

------ 모범 풀이
SELECT EMPNO, ENAME, JOB, MGR
FROM EMP;

SELECT EMPNO, ENAME, JOB
FROM EMP;

SELECT E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명", -- E1.MGR "관리자번호" (부모자식관계는 없지만 여기엔 null이 포함)
      E2.EMPNO "관리자번호" , E2.ENAME "관리자명", E2.JOB  "관리자직종명"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;
--==>>
/*
 사원번호 사원명      직종명     관리자번호 관리자명  관리자직종명   
---------- ---------- --------- ---------- ---------- ---------
      7902 FORD       ANALYST         7566 JONES      MANAGER  
      7788 SCOTT      ANALYST         7566 JONES      MANAGER  
      7900 JAMES      CLERK           7698 BLAKE      MANAGER  
      7844 TURNER     SALESMAN        7698 BLAKE      MANAGER  
      7654 MARTIN     SALESMAN        7698 BLAKE      MANAGER  
      7521 WARD       SALESMAN        7698 BLAKE      MANAGER  
      7499 ALLEN      SALESMAN        7698 BLAKE      MANAGER  
      7934 MILLER     CLERK           7782 CLARK      MANAGER  
      7876 ADAMS      CLERK           7788 SCOTT      ANALYST  
      7782 CLARK      MANAGER         7839 KING       PRESIDENT
      7698 BLAKE      MANAGER         7839 KING       PRESIDENT
      7566 JONES      MANAGER         7839 KING       PRESIDENT
      7369 SMITH      CLERK           7902 FORD       ANALYST  
*/





