SELECT USER
FROM DUAL;
--==>> HR

SET SERVEROUTPUT ON;
--==>> 작업이 완료되었습니다.
--○ %TYPE

-- 1. 특정 테이블에 포함되어 있는 컬럼의 자료형을 참조하는 데이터타입

-- 2. 형식 및 구조
변수명 테이블명.컬럼명%TYPE [:= 초기값];

DESC EMPLOYEES;
--==>>
/*
                :
FIRST_NAME              VARCHAR2(20) 
                :
*/

--○ EMPLOYEES 테이블의 특정 데이터(→ FIRST_NAME)를
--   변수에 저장하여 출력
DECLARE
  --VNAME VARCHAR2(20);
  VNAME EMPLOYEES.FIRST_NAME%TYPE;  -- VARCHAR2(20)
BEGIN
    -- CHECK! SELECT 쿼리로 얻어온 데이터(Alexander)를 변수(VNAME)에 담는 방법
    SELECT FIRST_NAME INTO VNAME
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;
    
    DBMS_OUTPUT.PUT_LINE(VNAME);
END;
--==>>
/*
Alexander


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ %ROWTYPE

-- 1. 테이블의 레코드와 같은 구조의 구조체 변수를 선언(여러 개의 컬럼)

-- 2. 형식 및 구조
변수명 테이블명%ROWTYPE;

DESC EMPLOYEES;
--==>>
/*
이름             널?       유형           
-------------- -------- ------------ 
EMPLOYEE_ID    NOT NULL NUMBER(6)    
FIRST_NAME              VARCHAR2(20) 
LAST_NAME      NOT NULL VARCHAR2(25) 
EMAIL          NOT NULL VARCHAR2(25) 
PHONE_NUMBER            VARCHAR2(20) 
HIRE_DATE      NOT NULL DATE         
JOB_ID         NOT NULL VARCHAR2(10) 
SALARY                  NUMBER(8,2)  
COMMISSION_PCT          NUMBER(2,2)  
MANAGER_ID              NUMBER(6)    
DEPARTMENT_ID           NUMBER(4)   
*/


--○ EMPLOYEES 테이블의 데이터 여러 개를 변수에 저장하여 출력
DECLARE
    --VNAME   VARCHAR2(20);
    --VPHONE  VARCHAR2(20);
    --VEMAIL  VARCHAR2(25);
    
    --VNAME   EMPLOYEES.FIRST_NAME%TYPE;      --VARCHAR2(20);
    --VPHONE  EMPLOYEES.PHONE_NUMBER%TYPE;    --VARCHAR2(20);
    --VEMAIL  EMPLOYEES.EMAIL%TYPE;           --VARCHAR2(25);
    
    VEMP    EMPLOYEES%ROWTYPE;
BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL --INTO VNAME, VPHONE, VEMAIL
        INTO VEMP.FIRST_NAME, VEMP.PHONE_NUMBER, VEMP.EMAIL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;
    
    DBMS_OUTPUT.PUT_LINE(VEMP.FIRST_NAME || ' - ' || VEMP.PHONE_NUMBER || ' - ' || VEMP.EMAIL);
END;
--==>>
/*
Alexander - 590.423.4567 - AHUNOLD


PL/SQL 프로시저가 성공적으로 완료되었습니다.

*/

--○ 사용자 정의 구조체 변수

-- 형식 및 구조
TYPE 레코드명 IS RECORD
( FIELD_NAME1 DATATYPE [ [NOT NULL] { := | DEFAULT } EXPR]
, FIELD_NAME2 DATATYPE [ [NOT NULL] { := | DEFAULT } EXPR]
[, ...]
);


-- EMPLOYEES  테이블을 활용한 사용자 정의 구조체 변수
DECLARE

    TYPE MYDATA IS RECORD
    ( VNAME     VARCHAR2(20)
    , VEMAIL    EMPLOYEES.EMAIL%TYPE
    );
    
    REC MYDATA;
BEGIN
    SELECT FIRST_NAME, EMAIL INTO REC.VNAME, REC.VEMAIL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;
    
    DBMS_OUTPUT.PUT_LINE('이름: ' || REC.VNAME);
    DBMS_OUTPUT.PUT_LINE('메일: ' || REC.VEMAIL);
END;
--==>>
/*
이름: Alexander
메일: AHUNOLD


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ EMPLOYEES 테이블의 여러명의 데이터 여러개를 변수에 저장하여 출력
DECLARE
    VEMP    EMPLOYEES%ROWTYPE;
BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL
        INTO VEMP.FIRST_NAME, VEMP.PHONE_NUMBER, VEMP.EMAIL
    FROM EMPLOYEES;
    
    DBMS_OUTPUT.PUT_LINE(VEMP.FIRST_NAME || ' - ' || VEMP.PHONE_NUMBER || ' - ' || VEMP.EMAIL);
END;
--==>> 에러 발생
/*
ORA-01422: exact fetch returns more than requested number of rows
ORA-06512: at line 4
01422. 00000 -  "exact fetch returns more than requested number of rows"
*Cause:    The number specified in exact fetch is less than the rows returned.
*Action:   Rewrite the query or change number of rows requested
*/

--> 여러 개의 행(ROW) 정보를 얻어와서 하나의 단일 변수에 담으려고 하면
--  변수에 저장하는 것 자체가 불가능한 상황임을 관찰할 수 있다.











































