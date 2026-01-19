
SELECT USER
FROM DUAL;
--=>> HR

--○ EMPLOYEES 테이블의 직원들 SALARY를 10% 인상한다.
--   단, 부서명이 'IT'인 경우로 한정한다.
--    (EMPLOYEES 테이블에는 부서명 컬럼이 존재하지 않는다.)
--    (쿼리문 실행 이후 변경된 결과를 확인한 후 ROLLBACK 할 것)

SELECT SALARY "급여", SALARY*1.1 "인상된급여"
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT'
                        );
--==>>
/*
급여      인상된급여
---------- ----------
      9000       9900
      6000       6600
      4800       5280
      4800       5280
      4200       4620
*/
                        
UPDATE EMPLOYEES
SET SALARY = SALARY*1.1
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT'
                        );
--==>> 5개 행 이(가) 업데이트되었습니다.

-- 확인
SELECT SALARY "급여"
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT'
                        );
--==>>
/*
      급여
----------
      9900
      6600
      5280
      5280
      4620

*/

ROLLBACK;
--==>> 롤백 완료.


--○ EMPLOYEES 테이블에서 JOB_TITLE이 『Sales Manager』인 사원의
-- SALARY를 해당 직무(직종)의 최고 급여(MAX_SALARY)로 수정하는 쿼리문을 구성한다.
-- 단, 입사일이 2006년 이전(해당 년도 제외) 입사자에 한하여
-- 적용할 수 있도록 한다.
-- (이번에도 쿼리문 실행 이후 변경된 결과를 확인한 후 ROLLBACK 할 것)

SELECT *
FROM EMPLOYEES; -- JOB_ID

SELECT *
FROM JOBS;  -- JOB_TITLE, MAX_SALARY

SELECT LAST_NAME, SALARY, JOB_ID
    ,  (   SELECT MAX_SALARY
           FROM JOBS
           WHERE JOB_TITLE = 'Sales Manager' 
        ) "변경된급여" , HIRE_DATE
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager'
                )
    AND EXTRACT(YEAR FROM HIRE_DATE) < 2006; 
    
    
SELECT E.LAST_NAME, E.SALARY, E.JOB_ID
    ,  (   SELECT J.MAX_SALARY
           FROM JOBS J
           WHERE E.JOB_ID = J.JOB_ID
        ) "변경된급여" , E.HIRE_DATE
FROM EMPLOYEES E
WHERE E.JOB_ID = (SELECT J.JOB_ID
                FROM JOBS J
                WHERE JOB_TITLE = 'Sales Manager'
                )
    AND EXTRACT(YEAR FROM E.HIRE_DATE) < 2006; 
--=>>
/*
LAST_NAME                     SALARY JOB_ID     변경된급여 HIRE_DATE 
------------------------- ---------- ---------- ---------- ----------
Russell                        14000 SA_MAN          20080 2004-10-01
Partners                       13500 SA_MAN          20080 2005-01-05
Errazuriz                      12000 SA_MAN          20080 2005-03-10
*/

UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE = 'Sales Manager' )
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager'
                )
    AND EXTRACT(YEAR FROM HIRE_DATE) < 2006; 
             

UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE = 'Sales Manager' )
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager'
                )
    AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006; 
--==>> 3개 행 이(가) 업데이트되었습니다
    
SELECT E.FIRST_NAME, E.SALARY, E.JOB_ID
    , E.HIRE_DATE
FROM EMPLOYEES E
WHERE E.JOB_ID = (SELECT J.JOB_ID
                FROM JOBS J
                WHERE JOB_TITLE = 'Sales Manager'
                )
    AND EXTRACT(YEAR FROM E.HIRE_DATE) < 2006; 
--==>>
/*
LAST_NAME                     SALARY JOB_ID     HIRE_DATE 
------------------------- ---------- ---------- ----------
Russell                        20080 SA_MAN     2004-10-01
Partners                       20080 SA_MAN     2005-01-05
Errazuriz                      20080 SA_MAN     2005-03-10
*/

-- 롤백
ROLLBACK;
--==>> 롤백 완료.


SELECT *
FROM DEPARTMENTS;   -- DEPARTMENT_NAME, DEPARTMENT_ID

-- Finance
-- Executive
-- Accounting



--○ EMPLOYEES 테이블에서 SALARY를
--   각 부서의 이름 별로 다른 인상률을 적용하여 수정할 수 있도록 한다.
--  - Finance       10%
--  - Executive     15%
--  - Accounting    20%
--  - 나머지부서     0%
-- (이 또한 쿼리문 실행 이후 변경될 결과를 확인한 후 ROLLBACK 할 것)
            
UPDATE EMPLOYEES
SET SALARY = CASE WHEN DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                         FROM DEPARTMENTS
                                         WHERE DEPARTMENT_NAME = 'Finance') 
                  THEN SALARY * 1.1 
                  WHEN DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                         FROM DEPARTMENTS
                                         WHERE DEPARTMENT_NAME = 'Executive') 
                  THEN SALARY * 1.15 
                  WHEN DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                         FROM DEPARTMENTS
                                         WHERE DEPARTMENT_NAME = 'Accounting')
                  THEN SALARY * 1.2 
                  ELSE SALARY 
               END;
--==>> 107개 행 이(가) 업데이트되었습니다.

UPDATE EMPLOYEES
SET SALARY = CASE WHEN DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                         FROM DEPARTMENTS
                                         WHERE DEPARTMENT_NAME = 'Finance') 
                  THEN SALARY * 1.1 
                  WHEN DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                         FROM DEPARTMENTS
                                         WHERE DEPARTMENT_NAME = 'Executive') 
                  THEN SALARY * 1.15 
                  WHEN DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                         FROM DEPARTMENTS
                                         WHERE DEPARTMENT_NAME = 'Accounting')
                  THEN SALARY * 1.2 
                  ELSE SALARY 
               END
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                         FROM DEPARTMENTS
                         WHERE DEPARTMENT_NAME IN('Finance','Executive','Accounting'));
--==>> 11개 행 이(가) 업데이트되었습니다. --> 이 쿼리가 메모리를 훨씬 덜 쓰는 쿼리

             
UPDATE EMPLOYEES E
SET SALARY = (
            CASE WHEN 'Finance' IN (SELECT DEPARTMENT_NAME
                                        FROM DEPARTMENTS D
                                        WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID ) 
                 THEN SALARY * 1.1 
                 WHEN 'Executive' IN (SELECT DEPARTMENT_NAME
                                        FROM DEPARTMENTS D
                                        WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID ) 
                 THEN SALARY * 1.15 
                 WHEN 'Accounting' IN (SELECT DEPARTMENT_NAME
                                        FROM DEPARTMENTS D
                                        WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID ) 
                 THEN SALARY * 1.2 
                 ELSE SALARY 
             END);


ROLLBACK;
--==>> 롤백 완료.




-- ■■■ DELETE ■■■ --

-- 1. 테이블에서 지정된 행(레코드)을 삭제하는 데 사용하는 구문

-- 2. 형식 및 구조
DELETE [FROM] 테이블명
[WHERE 조건절];

SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 198;

DELETE
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 1 행 이(가) 삭제되었습니다.

ROLLBACK;
--==>>롤백 완료.

--○ EMPLOYEES 테이블에서 직원들의 데이터를 삭제한다.
--   단, 부서명이 'IT'인 경우로 한정한다.

--※ 실제로는 EMPLOYEES 테이블의 데이터가(→ 삭제 액션을 수행하고자 하는 대상)
--   다른 테이블(혹은 자기 자신 테이블)에 의해 참조당하고 있는 경우
--   삭제되지 않을 수 있다는 상황을 인지해야 하며
--   그에 대한 이유도 알아야한다.

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT'
                        );
                        
DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT'
                        ); 
--==>> 에러 발생( MANAGER_ID 컬럼이 EMPLOYEE_ID를 참조하고 있기 때문에)
/*
ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found
*/


-- ■■■ 뷰(VIEW) ■■■ --

-- 1. 뷰(VIEW)란 이미 특정한 데이터베이스 내에 존재하는
--    하나 이상의 테이블에서 사용자가 얻기 원하는 데이터들만을
--    원하는 형태로 정확하고 편하게 가져오기 위하여
--    사전에 원하는 컬럼들만 모아서 만들어놓은 가상의 테이블로
--    편의성 및 보안에 목적이 있다.

--    가상의 테이블이란 뷰가 실제로 존재하는 테이블(객체)이 아니라
--    하나 이상의 테이블에서 파생된 또다른 정보를 볼 수 있는 방법이며
--    그 정보를 추출해내는 SQL 문장이라고 볼 수 있다.

-- 2. 형식 및 구조
-- CREATE [OR REPLACE] VIEW 뷰이름
-- [(ALIAS[, ALIAS,...])]
-- AS
-- 서브쿼리(SUBQUERY)
-- [WITH CHECK OPTION]
-- [WITH READ ONLY];


--○ 뷰(VIEW) 생성
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME
    ,  D.DEPARTMENT_NAME, L.CITY
    ,  C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
    AND D.LOCATION_ID = L.LOCATION_ID(+)
    AND L.COUNTRY_ID = C.COUNTRY_ID(+)
    AND C.REGION_ID = R.REGION_ID(+);
--==>> View VIEW_EMPLOYEES이(가) 생성되었습니다.


--※ RESOURCE 롤(ROLL, 역할 → 권한 묶음)만으로는
--   뷰(VIEW)를 생성할 수 없다.


--○ 생성한 뷰(VIEW) 조회
SELECT *
FROM VIEW_EMPLOYEES;
--==>>
/*
Alexander	Hunold	IT	Southlake	United States of America	Americas
Bruce	Ernst	IT	Southlake	United States of America	Americas
David	Austin	IT	Southlake	United States of America	Americas
Valli	Pataballa	IT	Southlake	United States of America	Americas
Diana	Lorentz	IT	Southlake	United States of America	Americas
Matthew	Weiss	Shipping	South San Francisco	United States of America	Americas
Adam	Fripp	Shipping	South San Francisco	United States of America	Americas
Payam	Kaufling	Shipping	South San Francisco	United States of America	Americas
Shanta	Vollman	Shipping	South San Francisco	United States of America	Americas
Kevin	Mourgos	Shipping	South San Francisco	United States of America	Americas
Julia	Nayer	Shipping	South San Francisco	United States of America	Americas
Irene	Mikkilineni	Shipping	South San Francisco	United States of America	Americas
James	Landry	Shipping	South San Francisco	United States of America	Americas
Steven	Markle	Shipping	South San Francisco	United States of America	Americas
Laura	Bissot	Shipping	South San Francisco	United States of America	Americas
Mozhe	Atkinson	Shipping	South San Francisco	United States of America	Americas
James	Marlow	Shipping	South San Francisco	United States of America	Americas
TJ	Olson	Shipping	South San Francisco	United States of America	Americas
Jason	Mallin	Shipping	South San Francisco	United States of America	Americas
Michael	Rogers	Shipping	South San Francisco	United States of America	Americas
Ki	Gee	Shipping	South San Francisco	United States of America	Americas
Hazel	Philtanker	Shipping	South San Francisco	United States of America	Americas
Renske	Ladwig	Shipping	South San Francisco	United States of America	Americas
Stephen	Stiles	Shipping	South San Francisco	United States of America	Americas
John	Seo	Shipping	South San Francisco	United States of America	Americas
Joshua	Patel	Shipping	South San Francisco	United States of America	Americas
Trenna	Rajs	Shipping	South San Francisco	United States of America	Americas
Curtis	Davies	Shipping	South San Francisco	United States of America	Americas
Randall	Matos	Shipping	South San Francisco	United States of America	Americas
Peter	Vargas	Shipping	South San Francisco	United States of America	Americas
Winston	Taylor	Shipping	South San Francisco	United States of America	Americas
Jean	Fleaur	Shipping	South San Francisco	United States of America	Americas
Martha	Sullivan	Shipping	South San Francisco	United States of America	Americas
Girard	Geoni	Shipping	South San Francisco	United States of America	Americas
Nandita	Sarchand	Shipping	South San Francisco	United States of America	Americas
Alexis	Bull	Shipping	South San Francisco	United States of America	Americas
Julia	Dellinger	Shipping	South San Francisco	United States of America	Americas
Anthony	Cabrio	Shipping	South San Francisco	United States of America	Americas
Kelly	Chung	Shipping	South San Francisco	United States of America	Americas
Jennifer	Dilly	Shipping	South San Francisco	United States of America	Americas
Timothy	Gates	Shipping	South San Francisco	United States of America	Americas
Randall	Perkins	Shipping	South San Francisco	United States of America	Americas
Sarah	Bell	Shipping	South San Francisco	United States of America	Americas
Britney	Everett	Shipping	South San Francisco	United States of America	Americas
Samuel	McCain	Shipping	South San Francisco	United States of America	Americas
Vance	Jones	Shipping	South San Francisco	United States of America	Americas
Alana	Walsh	Shipping	South San Francisco	United States of America	Americas
Kevin	Feeney	Shipping	South San Francisco	United States of America	Americas
Donald	OConnell	Shipping	South San Francisco	United States of America	Americas
Douglas	Grant	Shipping	South San Francisco	United States of America	Americas
Shelley	Higgins	Accounting	Seattle	United States of America	Americas
William	Gietz	Accounting	Seattle	United States of America	Americas
Nancy	Greenberg	Finance	Seattle	United States of America	Americas
Daniel	Faviet	Finance	Seattle	United States of America	Americas
John	Chen	Finance	Seattle	United States of America	Americas
Ismael	Sciarra	Finance	Seattle	United States of America	Americas
Jose Manuel	Urman	Finance	Seattle	United States of America	Americas
Luis	Popp	Finance	Seattle	United States of America	Americas
Steven	King	Executive	Seattle	United States of America	Americas
Neena	Kochhar	Executive	Seattle	United States of America	Americas
Lex	De Haan	Executive	Seattle	United States of America	Americas
Den	Raphaely	Purchasing	Seattle	United States of America	Americas
Alexander	Khoo	Purchasing	Seattle	United States of America	Americas
Shelli	Baida	Purchasing	Seattle	United States of America	Americas
Sigal	Tobias	Purchasing	Seattle	United States of America	Americas
Guy	Himuro	Purchasing	Seattle	United States of America	Americas
Karen	Colmenares	Purchasing	Seattle	United States of America	Americas
Jennifer	Whalen	Administration	Seattle	United States of America	Americas
Michael	Hartstein	Marketing	Toronto	Canada	Americas
Pat	Fay	Marketing	Toronto	Canada	Americas
Susan	Mavris	Human Resources	London	United Kingdom	Europe
John	Russell	Sales	Oxford	United Kingdom	Europe
Karen	Partners	Sales	Oxford	United Kingdom	Europe
Alberto	Errazuriz	Sales	Oxford	United Kingdom	Europe
Gerald	Cambrault	Sales	Oxford	United Kingdom	Europe
Eleni	Zlotkey	Sales	Oxford	United Kingdom	Europe
Peter	Tucker	Sales	Oxford	United Kingdom	Europe
David	Bernstein	Sales	Oxford	United Kingdom	Europe
Peter	Hall	Sales	Oxford	United Kingdom	Europe
Christopher	Olsen	Sales	Oxford	United Kingdom	Europe
Nanette	Cambrault	Sales	Oxford	United Kingdom	Europe
Oliver	Tuvault	Sales	Oxford	United Kingdom	Europe
Janette	King	Sales	Oxford	United Kingdom	Europe
Patrick	Sully	Sales	Oxford	United Kingdom	Europe
Allan	McEwen	Sales	Oxford	United Kingdom	Europe
Lindsey	Smith	Sales	Oxford	United Kingdom	Europe
Louise	Doran	Sales	Oxford	United Kingdom	Europe
Sarath	Sewall	Sales	Oxford	United Kingdom	Europe
Clara	Vishney	Sales	Oxford	United Kingdom	Europe
Danielle	Greene	Sales	Oxford	United Kingdom	Europe
Mattea	Marvins	Sales	Oxford	United Kingdom	Europe
David	Lee	Sales	Oxford	United Kingdom	Europe
Sundar	Ande	Sales	Oxford	United Kingdom	Europe
Amit	Banda	Sales	Oxford	United Kingdom	Europe
Lisa	Ozer	Sales	Oxford	United Kingdom	Europe
Harrison	Bloom	Sales	Oxford	United Kingdom	Europe
Tayler	Fox	Sales	Oxford	United Kingdom	Europe
William	Smith	Sales	Oxford	United Kingdom	Europe
Elizabeth	Bates	Sales	Oxford	United Kingdom	Europe
Sundita	Kumar	Sales	Oxford	United Kingdom	Europe
Ellen	Abel	Sales	Oxford	United Kingdom	Europe
Alyssa	Hutton	Sales	Oxford	United Kingdom	Europe
Jonathon	Taylor	Sales	Oxford	United Kingdom	Europe
Jack	Livingston	Sales	Oxford	United Kingdom	Europe
Charles	Johnson	Sales	Oxford	United Kingdom	Europe
Hermann	Baer	Public Relations	Munich	Germany	Europe
Kimberely	Grant				
*/


--○ 뷰(VIEW) 구조 확인
DESC VIEW_EMPLOYEES;
--==>>
/*
이름              널?       유형           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME          VARCHAR2(30) 
CITY                     VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25) 
*/

--○ 뷰(VIEW) 소스 확인                   -- CHECK!
SELECT VIEW_NAME, TEXT                    -- TEXT
FROM USER_VIEWS                           -- USER_VIEWS
WHERE VIEW_NAME = 'VIEW_EMPLOYEES';
--==>>
/*
SELECT E.FIRST_NAME, E.LAST_NAME
    ,  D.DEPARTMENT_NAME, L.CITY
    ,  C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
    AND D.LOCATION_ID = L.LOCATION_ID(+)
    AND L.COUNTRY_ID = C.COUNTRY_ID(+)
    AND C.REGION_ID = R.REGION_ID(+)
*/



















