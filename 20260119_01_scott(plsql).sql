SELECT USER
FROM DUAL;
--==>> SCOTT

SET SERVEROUTPUT ON;
--==>> 작업이 완료되었습니다.

SELECT *
FROM TBL_INSABACKUP;

DECLARE
    V_NUM   TBL_INSA.NUM%TYPE;
    V_COUNT NUMBER;
BEGIN
     V_NUM := 8001;
    
    DELETE
    FROM TBL_INSABACKUP
    WHERE NUM = V_NUM;
    
    V_COUNT := SQL%ROWCOUNT;        -- COMMIT 전에 수행 CHECK!
    -- 『SQL%ROWCOUNT』
    -- 해당 SQL문의 영향을 받는 행의 갯수 확인 
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE(V_COUNT || ' 레코드 삭제');
END;
--==>>
/*
0 레코드 삭제


PL/SQL 프로시저가 성공적으로 완료되었습니다.

*/

DECLARE
    V_NUM   TBL_INSA.NUM%TYPE;
BEGIN
     V_NUM := 8001;
    
    DELETE
    FROM TBL_INSABACKUP
    WHERE NUM = V_NUM;
    
    
    -- 『SQL%NOTFOUND』
    -- 해당 SQL문의 영향을 받는 행의 수가 없을 경우 TRUE 반환 
    IF(SQL%NOTFOUND)   THEN
        RAISE_APPLICATION_ERROR(-20100, '데이터가 존재하지 않습니다.');
    END IF;
    
    COMMIT;
    
END;
--==>> 에러 발생 
/*
ORA-20100: 데이터가 존재하지 않습니다.
*/


DECLARE
    V_NUM   TBL_INSABACKUP.NUM%TYPE;
    V_NAME  TBL_INSABACKUP.NAME%TYPE;
    V_COUNT NUMBER;
BEGIN
    V_NUM := 1001;
    
    SELECT NAME INTO V_NAME
    FROM TBL_INSABACKUP
    WHERE NUM = V_NUM;
    
    V_COUNT := SQL%ROWCOUNT;
    
    DBMS_OUTPUT.PUT_LINE(V_COUNT || ' 레코드가 존재합니다.');
END;
--==>>
/*
1 레코드가 존재합니다.


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


DECLARE
    V_NUM   TBL_INSABACKUP.NUM%TYPE;
    V_NAME  TBL_INSABACKUP.NAME%TYPE;
    V_BASICPAY  TBL_INSABACKUP.BASICPAY%TYPE;
    V_COUNT NUMBER;
BEGIN
    V_NUM := 8001;
    
    SELECT NAME, BASICPAY INTO V_NAME, V_BASICPAY
    FROM TBL_INSABACKUP
    WHERE NUM = V_NUM;
    
    V_COUNT := SQL%ROWCOUNT;
    -- 『SQL%ROWCOUNT』
    -- 해당 SQL문의 영향을 받는 행의 수 확인
    -- 행의 수를 확인할 수 없는 경우 예외 발생
    
    DBMS_OUTPUT.PUT_LINE('개수: '|| V_COUNT);
    DBMS_OUTPUT.PUT_LINE('이름: '|| V_NAME);
    DBMS_OUTPUT.PUT_LINE('급여: '|| V_BASICPAY);
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('데이터가 존재하지 않습니다.');
END;
--==>>
/*
데이터가 존재하지 않습니다.


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 프로시저 생성
-- 프로시저명: PRC_CURTEST
-- 프로시저 기능: 조건에 만족하는 데이터 가져오는 기능
-- EXEC PRC_CURTEST('서울');
-- → TBL_INSA 테이블에 대해서
-- 지역이 서울인 사원들에 대해서만 『사원명 기본급 지역』 형태로 출력
CREATE OR REPLACE PROCEDURE PRC_CURTEST
(P_CITY IN TBL_INSA.CITY%TYPE)
IS
    V_NAME      TBL_INSA.NAME%TYPE;
    V_BASICPAY  TBL_INSA.BASICPAY%TYPE;
    V_CITY      TBL_INSA.CITY%TYPE;

    -- 커서 정의
    CURSOR CUR_INSA_LIST
    IS
    SELECT NAME, BASICPAY, CITY
    FROM TBL_INSA
    WHERE CITY = P_CITY;
    
BEGIN
    -- 커서 오픈
    OPEN  CUR_INSA_LIST;
    LOOP
        FETCH CUR_INSA_LIST INTO  V_NAME, V_BASICPAY, V_CITY;
        
        EXIT WHEN CUR_INSA_LIST%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(V_NAME || ' ' || V_BASICPAY || ' ' || V_CITY);

    END LOOP;
    -- 커서 클로즈
    CLOSE CUR_INSA_LIST; 
END;
--==>> Procedure PRC_CURTEST이(가) 컴파일되었습니다.


EXEC PRC_CURTEST('인천');


--○ 프로시저 수정
-- 프로시저명: PRC_CURTEST
-- 프로시저 기능: 조건에 만족하는 데이터 가져오는 기능
--                단, FOR LOOP 사용
-- EXEC PRC_CURTEST('서울');
-- → TBL_INSA 테이블에 대해서
-- 지역이 서울인 사원들에 대해서만 『사원명 기본급 지역』 형태로 출력
CREATE OR REPLACE PROCEDURE PRC_CURTEST
(P_CITY IN  TBL_INSA.CITY%TYPE
)
IS
    -- 커서 정의
    CURSOR CUR_INSA_LIST
    IS
    SELECT NAME, BASICPAY, CITY
    FROM TBL_INSA
    WHERE CITY = P_CITY;
BEGIN
    FOR R IN CUR_INSA_LIST LOOP
        DBMS_OUTPUT.PUT_LINE(R.NAME || ' ' || R.BASICPAY || ' ' || R.CITY);
    END LOOP;
END;

EXEC PRC_CURTEST('서울');



--○ 파라미터가 있는 커서 정의
-- 프로시저명: PRC_CURTEST
CREATE OR REPLACE PROCEDURE PRC_CURTEST
( P_CITY    IN  TBL_INSA.CITY%TYPE
)
IS
    V_NAME  TBL_INSA.NAME%TYPE;
    V_BASICPAY  TBL_INSA.BASICPAY%TYPE;
    
    -- 커서 정의(→ 파라미터가 있는 커서)
    CURSOR CUR_INSA_LIST(PP_CITY TBL_INSA.CITY%TYPE)
    IS
    SELECT NAME, BASICPAY
    FROM TBL_INSA
    WHERE CITY = PP_CITY;
BEGIN
    
    -- 커서 OPEN → 커서를 OPEN하며 파라미터 전달
    OPEN CUR_INSA_LIST(P_CITY);
    
    LOOP
        FETCH CUR_INSA_LIST INTO V_NAME, V_BASICPAY;
        EXIT WHEN CUR_INSA_LIST%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_NAME ||'  '||V_BASICPAY);
    END LOOP;
    
    -- 커서 CLOSE
    CLOSE CUR_INSA_LIST;
    
END;
--==>>Procedure PRC_CURTEST이(가) 컴파일되었습니다.

EXEC PRC_CURTEST('서울');



-- ※ WHERE CURRENT OF
--   - FETCH 문에 의해 가장 최근에 처리된 행을 참조하기 위해
--     『WHERE CURRENT OF 커서이름』절로 DELETE나 UPDATE문 작성이 가능하다.
--   - 이 절을 사용하기 위해서는 참조하는 커서가 있어야 하며,
--     FOR UPDATE 절이 커서 선언 쿼리문 안에 있어야 한다.

-- 테이블 복사(데이터만)
CREATE TABLE INSA1
AS
SELECT *
FROM TBL_INSA;
--==>> Table INSA1이(가) 생성되었습니다.

-- 확인
SELECT *
FROM INSA1;


--○ 프로시저 생성
-- 프로시저명: PRC_INSA1
-- 프로시저 기능: 『WHERE CURRENT OF』 활용
CREATE OR REPLACE PROCEDURE PRC_INSA1
IS
    V_NAME INSA1.NAME%TYPE;
    V_BASICPAY  INSA1.BASICPAY%TYPE;
    
    CURSOR CUR_INSA1_LIST
    IS
    SELECT NAME, BASICPAY
    FROM INSA1
    WHERE CITY = '서울'
    FOR UPDATE;         -- 커서를 이용하여 UPDATE를 수행할 경우 반드시 필요함 CHECK!
BEGIN
    OPEN CUR_INSA1_LIST;
    
    LOOP
        FETCH CUR_INSA1_LIST INTO V_NAME, V_BASICPAY;
        
        UPDATE INSA1
        SET BASICPAY = BASICPAY * 1.1
        WHERE CURRENT OF CUR_INSA1_LIST;        -- CHECK
        
        EXIT WHEN CUR_INSA1_LIST%NOTFOUND;      -- 마지막 처리 후 예외 발생 CHECK
        DBMS_OUTPUT.PUT_LINE(V_NAME || '   ' || V_BASICPAY);
        
    END LOOP;
    
    COMMIT; 
    
    CLOSE CUR_INSA1_LIST;
    
    EXCEPTION 
        WHEN OTHERS THEN
            COMMIT;
END;

SELECT NAME, BASICPAY
FROM INSA1
WHERE CITY = '서울';
--==>>
/*
NAME                   BASICPAY
-------------------- ----------
홍길동                  2610000
한석봉                  1420000
김영년                   950000
유관순                  1020000
박문수                  2300000
김인수                  2500000
김말자                  1900000
우재옥                  1100000
김영길                  2340000
김말숙                   920000
지재환                  2450000
김미나                  1020000
이재영                   960400
양미옥                  1100000
지수환                  1060000
산마루                  2100000
권영미                  2260000
정한나                  1000000
임수봉                   890000
김신애                   900000

*/

EXEC PRC_INSA1;

--○ 프로시저 수정
-- 프로시저명: PRC_INSA1
-- 프로시저 기능: 『WHERE CURRENT OF』 활용
CREATE OR REPLACE PROCEDURE PRC_INSA1
IS
    CURSOR CUR_INSA1_LIST
    IS
    SELECT NAME, BASICPAY
    FROM INSA1
    WHERE CITY = '서울'
    FOR UPDATE;         --  커서를 활용하여 UPDATE를 수행할 경우 반드시 작성
    -- 『FOR UPDATE』
    -- - 이 절은 SELECT 문으로 조회한 특정 행(ROW)에 대해
    --   배타적 잠금(EXCLUSIVE LOCK)을 설정하는 역할 수행
    -- - 이 데이터를 수정할 예정이니
    --   이 작업을 마칠 때까지 다른 사용자가 수정이나 삭제하지 못하도록 해라
    --   (즉, 다른 세션에서 해당 행을 UPDATE하거나 DELETE하는 것을 방지)
BEGIN
    FOR REC IN CUR_INSA1_LIST LOOP
    
        UPDATE INSA1
        SET BASICPAY =  ROUND(BASICPAY * (10/11))
        WHERE CURRENT OF CUR_INSA1_LIST;
        
        DBMS_OUTPUT.PUT_LINE(REC.NAME || '   ' || REC.BASICPAY);
    END LOOP;
    
   -- COMMIT;
END;
--==>> Procedure PRC_INSA1이(가) 컴파일되었습니다.

SELECT NAME, BASICPAY
FROM INSA1;

ROLLBACK;

EXEC PRC_INSA1;



-- ■■■ SYS_REFCURSOR ■■■ --
-- ※ 9i 이전 → REF_CURSOR
--    9i 이후 → SYS_REFCURSOR

-- ○ 개요
--   - 테이블의 여러 행(ROW)을 반복적으로 조회하기 위해
--     오라클에서 자체 제공하는 레퍼런스 커서(REFERENCE CURSOR)를 사용할 수 있다.

-- ○ 프로시저 생성 1
-- 프로시저명: PRC_INSA_SELECT
CREATE OR REPLACE PROCEDURE PRC_INSA_SELECT
( P_RESULT  OUT SYS_REFCURSOR
)
IS
BEGIN
    -- 커서 생성과 동시 OPEN
    OPEN P_RESULT 
    FOR
    SELECT NAME, BASICPAY + SUDANG "PAY"
    FROM INSA1;
END;
--==>> Procedure PRC_INSA_SELECT이(가) 컴파일되었습니다.


-- ○ 프로시저 생성 2
-- 프로시저명: PRC_INSA_LIST
CREATE OR REPLACE PROCEDURE PRC_INSA_LIST
IS
    V_RESULT    SYS_REFCURSOR;
    V_NAME      INSA1.NAME%TYPE;
    V_PAY       NUMBER;
BEGIN
    PRC_INSA_SELECT(V_RESULT);
    
    LOOP
        FETCH   V_RESULT INTO V_NAME, V_PAY;
        EXIT WHEN V_RESULT%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_NAME || '   ' || V_PAY);
    END LOOP;
END;

--==>> Procedure PRC_INSA_LIST이(가) 컴파일되었습니다.

EXEC PRC_INSA_LIST;
--==>>
/*
홍길동   4021301
이순신   1520000
이순애   2710000
김정훈   2124200
한석봉   2239022
이기자   2415000
장인철   1400000
김영년   1535895
나윤균   1060400
김종서   2670000
유관순   1633382
정한국   994000
조미숙   1704000
황진이   1230000
이현숙   1154000
이상헌   2500000
엄용수   1160000
이성길   1003000
박문수   3532430
유영희   1020000
홍길남   995000
이영숙   2140000
김인수   3830250
김말자   2951790
우재옥   1770510
김숙남   1200000
김영길   3595994
이남신   1002000
김말숙   1470972
정정해   2428000
지재환   3747045
심심해   988000
김미나   1597382
이정석   1260000
정영희   1190000
이재영   1596121
최석규   2537000
손인수   2150000
고순정   2170000
박세열   2230000
문길수   2450000
채정희   1220000
양미옥   1820510
지수환   1771946
홍원신   1112000
허경운   2800000
산마루   3186610
이기상   2156000
이미성   1430000
이미인   2053000
권영미   3412866
권옥경   1125000
김싱식   1068000
정상호   1094000
정한나   1568100
전용재   2150000
이미경   2680000
김신제   2130000
임수봉   1405049
김신애   1419690
*/



--------------------------------------------------------------------------------

--○ 실습 테이블 생성
-- 테이블명: SCORE
CREATE TABLE SCORE
( NUM   NUMBER(7)
, NAME  VARCHAR2(20)
, BIRTH DATE
, KOR   NUMBER(3)
, ENG   NUMBER(3)
, MAT   NUMBER(3)
, CONSTRAINT SCORE_NUM_PK PRIMARY KEY(NUM)
);
--==>> Table SCORE이(가) 생성되었습니다.

--○ 실습 데이터 입력
INSERT INTO SCORE(NUM, NAME, BIRTH, KOR, ENG, MAT)
VALUES(1, '홍길동', TO_DATE('2025-10-10', 'YYYY-MM-DD'), 80, 80, 80);
INSERT INTO SCORE(NUM, NAME, BIRTH, KOR, ENG, MAT)
VALUES(2, '강감찬', TO_DATE('2025-11-11', 'YYYY-MM-DD'), 90, 50, 50);
--==>> 1 행 이(가) 삽입되었습니다. * 2


--○ 확인
SELECT *
FROM SCORE;
--==>>
/*
1	홍길동	2025-10-10	80	80	80
2	강감찬	2025-11-11	90	50	50
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.


-- ○ 프로시저 생성 1
-- 프로시저명: PRC_SCORE_SELECT
-- 『SYS_REFCURSOR』를 활용하여 번호, 이름, 총점 구성
CREATE OR REPLACE PROCEDURE PRC_SCORE_SELECT
( P_RESULT OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN P_RESULT
    FOR
    SELECT NUM, NAME, (KOR+ENG+MAT) "TOT"
    FROM SCORE;
END;


-- ○ 프로시저 생성 2
-- 프로시저명: PRC_SCORE_LIST
-- 『PRC_SCORE_SELECT』 프로시저를 활용하여
-- 번호, 이름, 총점 출력
CREATE OR REPLACE PROCEDURE PRC_SCORE_LIST
IS
    V_RESULT    SYS_REFCURSOR;
    V_NUM       SCORE.NUM%TYPE;
    V_NAME      SCORE.NAME%TYPE;
    V_TOT       NUMBER;
BEGIN
    PRC_SCORE_SELECT(V_RESULT);
    
    LOOP
        FETCH V_RESULT INTO V_NUM, V_NAME, V_TOT;
    
        EXIT WHEN V_RESULT%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_NUM || '  ' || V_NAME ||' ' || V_TOT);
    END LOOP;
END;


EXEC PRC_SCORE_LIST;
--==>>
/*
1  홍길동 240
2  강감찬 190


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 프로시저 생성
CREATE OR REPLACE PROCEDURE PRC_SCORE_SELECT
(P_RESULT IN SYS_REFCURSOR
)
IS
    V_NUM   SCORE.NUM%TYPE;
    V_NAME  SCORE.NAME%TYPE;
    V_BIRTH SCORE.BIRTH%TYPE;
    V_KOR   SCORE.KOR%TYPE;
    V_ENG   SCORE.ENG%TYPE;
    V_MAT   SCORE.MAT%TYPE;
BEGIN
    LOOP
        FETCH P_RESULT INTO V_NUM, V_NAME, V_BIRTH, V_KOR, V_ENG, V_MAT;
        EXIT WHEN P_RESULT%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_NUM||'  ' ||V_NAME||'  '||V_BIRTH||'  ' ||(V_KOR+V_ENG+V_MAT));
    END LOOP;
    
END;
--==>> Procedure PRC_SCORE_SELECT이(가) 컴파일되었습니다.


--○ 프로시저 수정
-- 프로시저명: PRC_SCORE_LIST
CREATE OR REPLACE PROCEDURE PRC_SCORE_LIST
IS
    V_RESULT    SYS_REFCURSOR;
BEGIN
    OPEN V_RESULT
    FOR
    SELECT NUM, NAME, BIRTH, KOR, ENG, MAT
    FROM SCORE;
    
    PRC_SCORE_SELECT(V_RESULT);
    
    CLOSE V_RESULT;
END;
--==>> Procedure PRC_SCORE_LIST이(가) 컴파일되었습니다.

--○ 프로시저 호출(실행
EXEC PRC_SCORE_LIST;
--==>>
/*
1  홍길동  2025-10-10  240
2  강감찬  2025-11-11  190


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- ■■■ 동적 SQL ■■■ --

--○ 개요
--  - 동적 쿼리는 프로시저 등에서 인자로 받은 변수를 조합하여
--    쿼리문을 생성하여 사용하는 경우를 말한다.
--  - 예를 들자면, 사용자별 게시판을 동적으로 생성하는 경우 등을 말한다.

-- ※ 주의
--  - RESOURCE 롤은 테이블을 생성할 수는 있지만
--    동적 SQL을 이용하여 테이블을 생성할 수는 없다.
--  - 동적 SQL을 활용하여 테이블을 생성하기 위해서는
--    『CREATE TABLE』 권한을 설정해 주어야 한다.

--○ 형식 및 구조(동적 SQL 실행)
EXECUTE IMMEDIATE 동적쿼리문자열
[INTO {DEFINE_VAR1 [, DEFINE_VAR2, ...] | PLSQL_RECORD}]
[USING [IN | OUT | IN OUT] BIND_ARG1 [, [IN | OUT | IN OUT] BIND_ARG2, ...]];

--○ 동적 테이블을 생성하는 프로시저 생성 1
-- 프로시저명: PRC_DYNTEST1
CREATE OR REPLACE PROCEDURE PRC_DYNTEST1
( P_TNAME   VARCHAR2                        -- 생성할 테이블의 이름
)
IS
    -- 실행될 SQL 구문을 문자열 형태로 바인딩
    V_SQL_STMT  VARCHAR2(4000);
BEGIN
    V_SQL_STMT := 'CREATE TABLE ' || P_TNAME;        -- 공백 CHECK
    V_SQL_STMT:= V_SQL_STMT || '( NUM   NUMBER PRIMARY KEY';
    V_SQL_STMT:= V_SQL_STMT || ', NAME  VARCHAR2(20) )';
    
    -- 동적으로 쿼리 실행
    EXECUTE IMMEDIATE V_SQL_STMT;
    
    DBMS_OUTPUT.PUT_LINE('테이블 생성');
END;
--==>> Procedure PRC_DYNTEST1이(가) 컴파일되었습니다.

SELECT TNAME
FROM TAB;
--==>>
/*
BONUS
DEPT
EMP
EMPCOPY
EXAM1
INSA1
SALGRADE
SCORE
TBL_AAA
TBL_BOARD
TBL_DEPT
TBL_EMP
TBL_EXAMPLE1
TBL_EXAMPLE2
TBL_FILES
TBL_IDPW
TBL_INSA
TBL_INSABACKUP
TBL_JUMUN
TBL_JUMUNBACKUP
TBL_MEMBER
TBL_SAWON
TBL_SAWONBACKUP
TBL_STUDENTS
TBL_SUNGJUK
TBL_WATCH
TBL_상품
TBL_입고
TBL_출고
TEST1
TEST2
TEST3
VIEW_SAWON
VIEW_SAWON2
VIEW_TEST
*/

EXEC PRC_DYNTEST1('ABCD');
--==>>
/*
테이블 생성


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


SELECT TNAME
FROM TAB;
--==>>
/*
ABCD        ◀◀◀◀ 
BONUS
DEPT
EMP
EMPCOPY
EXAM1
INSA1
SALGRADE
SCORE
TBL_AAA
TBL_BOARD
TBL_DEPT
TBL_EMP
TBL_EXAMPLE1
TBL_EXAMPLE2
TBL_FILES
TBL_IDPW
TBL_INSA
TBL_INSABACKUP
TBL_JUMUN
TBL_JUMUNBACKUP
TBL_MEMBER
TBL_SAWON
TBL_SAWONBACKUP
TBL_STUDENTS
TBL_SUNGJUK
TBL_WATCH
TBL_상품
TBL_입고
TBL_출고
TEST1
TEST2
TEST3
VIEW_SAWON
VIEW_SAWON2
VIEW_TEST
*/


EXEC PRC_DYNTEST1('ABCD');
--==>> 에러 발생
/*
ORA-00955: name is already used by an existing object
*/


--○ 동적 테이블을 생성하는 프로시저 수정 2
-- 프로시저명: PRC_DYNTEST1
CREATE OR REPLACE PROCEDURE PRC_DYNTEST1
( P_TNAME   VARCHAR2                        -- 생성할 테이블의 이름
)
IS
    -- 실행될 SQL 구문을 문자열 형태로 바인딩
    V_SQL_STMT  VARCHAR2(4000);
BEGIN
    V_SQL_STMT := 'CREATE TABLE ' || P_TNAME;        -- 공백 CHECK
    V_SQL_STMT:= V_SQL_STMT || '( NUM   NUMBER PRIMARY KEY';
    V_SQL_STMT:= V_SQL_STMT || ', NAME  VARCHAR2(20) )';
    
    -- 동적으로 쿼리 실행
    -- FOR TEMP IN (SELECT TNAME FROM TAB WHERE TNAME = P_TNAME) LOOP
    FOR TEMP IN (SELECT TNAME FROM TAB WHERE TNAME = UPPER(P_TNAME)) LOOP   
        EXECUTE IMMEDIATE 'DROP TABLE ' || P_TNAME || ' PURGE';
        DBMS_OUTPUT.PUT_LINE('테이블 삭제');
        EXIT;
    END LOOP;
    
    EXECUTE IMMEDIATE V_SQL_STMT;
    
    DBMS_OUTPUT.PUT_LINE('테이블 생성');
END;
--==>> Procedure PRC_DYNTEST1이(가) 컴파일되었습니다.

EXEC PRC_DYNTEST1('ABCD');
--==>>
/*
테이블 삭제
테이블 생성


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/



--○ 동적 테이블을 생성하는 프로시저 생성 3
-- 프로시저명: PRC_DYNTEST2
CREATE OR REPLACE PROCEDURE PRC_DYNTEST2
IS
    -- 실행될 SQL구문을 문자열 형태로 바인딩
    V_SQL_STMT  VARCHAR2(200);
    
    V_ID    NUMBER;
    A_ID    NUMBER;
    V_MEMO  VARCHAR2(20);
    
    -- 사용자 정의 레코드 타입 정의
    TYPE MYTYPE
    IS
    RECORD
    ( T_ID      NUMBER
    , T_MEMO    VARCHAR2(20)
    );
    --> MYTYPE이라는 이름의 사용자 정의 레코드 타입
    --  레코드 타입은 여러 개의 필드(열)을 포함할 수 있는 복합 데이터 구조
    
    -- 사용자 정의 레코드 타입 변수 선언
    REC MYTYPE;
    --> 위에서 정의한 MYTYPE 타입의 변수 REC를 선언
    
BEGIN
    --  테이블이 존재하면 삭제
    FOR TEMP IN (SELECT TNAME FROM TAB WHERE TNAME = 'TEST') LOOP
        EXECUTE IMMEDIATE 'DROP TABLE TEST';
        --> 『EXECUTE IMMEDIATE』
        -- - 데이터베이스에서 SQL구문을 문자열 형태로 받아
        --   동적으로 준비하고 즉시 실행하는 명령어
        -- - 주로 SQL 구문 분석 및 실행을 런타임에 처리하며,
        --   테이블 생성(DDL), 데이터 삽입(DML), 동적 쿼리 등
        --   다양한 SQL을 문자열로 처리할 때 필수적인 동적 SQL 기능
        -- - DDL: 테이블 생성, 삭제, 변경 등 스키마 변경을 동적으로 처리할 때
        -- - DML: 조건이나 파라미터에 따라 INSERT, UPDATE, DELETE 문을
        --        동적으로 생성하여 실행할 때
        -- - SELECT: SELECT문을 동적으로 실행하여 결과를 변수(INTO절)나 커서로 받을 때
        
        EXIT;
    END LOOP;
    
    -- 테이블 생성
    EXECUTE IMMEDIATE 'CREATE TABLE TEST(T_ID NUMBER, T_MEMO VARCHAR2(20))';
    
    -- 데이터 입력
    V_SQL_STMT := 'INSERT INTO TEST VALUES(:1, :2)';
    --> 『:1』, 『:2』
    --> 바인드 변수(Bind Variables) 또는 플레이스홀더(Placeholders)
    
    -- ※ 바인드 변수(Bind Variables) 또는 플레이스홀더(Placeholders)
    --    - 데이터베이스에 명령을 실행시킬 때 실제 값을 입력하는 대신
    --      값이 들어간 위치를 지정해주는 역할을 수행
    
     -- ※ 바인드 변수(Bind Variables) 또는 플레이스홀더(Placeholders) 특징
     --    - SQL 삽입 공격(SQL Injection) 방지
     --      : 사용자가 입력한 데이터가 직접 SQL문에 포함되지 않아 보안성 향상
     --    - 성능 향상
     --      : 데이터베이스가 SQL문의 구조를 한 번만 파싱하고 캐시할 수 있어서
     --        동일한 구조의 문장을 반복해서 실행할 때 효율성 향상
     --    - 코드 가독성 및 유지보수
     --      : SQL구문과 실제 데이터가 분리되어 코드를 더 명확하게 작성할 수 있다.
     
     FOR N IN 1..5 LOOP     -- N → 1 2 3 4 5
        V_ID := N;
        V_MEMO := CHR(N+96);
        
        -- 동적 SQL 실행
        EXECUTE IMMEDIATE V_SQL_STMT USING V_ID, V_MEMO;
        --> 『USING V_ID, V_MEMO』
        -- - V_ID와 V_MEMO 변수의 실제 값을 순서대로 바인딩
     END LOOP;
     
     COMMIT;
     
     -- 데이터 출력
     V_SQL_STMT := 'SELECT * FROM TEST WHERE T_ID = :ID';
     A_ID := 1;
     
     -- 동적 SQL 실행
     EXECUTE IMMEDIATE V_SQL_STMT INTO REC USING A_ID;
     DBMS_OUTPUT.PUT_LINE(REC.T_ID || REC.T_MEMO);
    
    -- 데이터 수정(변경 값을 A_ID에 가져옴)
    V_ID :=1 ;
    V_SQL_STMT := 'UPDATE TEST SET T_ID = 100 WHERE T_ID = :1 RETURNING T_ID INTO :2';
    
    -- 동적 SQL 실행
    EXECUTE IMMEDIATE V_SQL_STMT USING V_ID RETURNING INTO A_ID;
    -->>  『RETURNING INTO A_ID』
    --     : 해당 쿼리문이 반환하는 반환값 저장
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE(A_ID||' 으로 ID 변경');
    
    -- 데이터 삭제
    V_ID := 3;
    V_SQL_STMT := 'DELETE FROM TEST WHERE T_ID = :ID';
    
    -- 동적 SQL 실행
    EXECUTE IMMEDIATE V_SQL_STMT USING V_ID;
    
    COMMIT;
END;
--==>> Procedure PRC_DYNTEST2이(가) 컴파일되었습니다.

EXEC PRC_DYNTEST2;
--==>>
/*
1a
100 으로 ID 변경


PL/SQL 프로시저가 성공적으로 완료되었습니다.

*/
SELECT *
FROM TEST;
--==>>
/*
100	a
2	b
4	d
5	e
*/



-- ■■■ TRIGGER(트리거) ■■■ --

-- 사전적인 의미: 방아쇠, 촉발시키다, 야기하다, 유발하다.

--○ 개요
--  - TRIGGER(트리거)란 DML 작업 즉, INSERT, UPDATE, DELETE와 같은 작업이 일어날 때
--    자동적으로 실행되는(유발되는, 촉발되는) 객체로
--    이와 같은 특징을 강조하여(부각시켜) DML TRIGGER라고 부르기도 한다.
--    TRIGGER(트리거)는 데이터 무결성 뿐 아니라
--    다음과 같은 작업에도 널리 사용된다.
--    ·자동으로 파생된 열 값 생성
--    ·잘못된 트랜잭션 방지
--    ·복잡한 보안 권한 강제 수행
--    ·분산 데이터베이스 노드 상에서 참조 무결성 강제 수행
--    ·복잡한 업무 규칙 강제 적용
--    ·투명한 이벤트 로깅 제공
--    ·복잡한 감사 제공
--    ·동기 테이블 복제 유지관리
--    ·테이블 엑세스 통계 수집
--  - TRRIGER(트리거)내에서는 COMMIT, ROLLBACK 구문을 사용할 수 없다.

--○ 특징 및 종류
--  - BEFORE STATEMENT TRIGGER
--    SQL 구문이 실행되기 전에 그 문장에 대해 한 번 실행
--  - BEFORE ROW TRIGGER
--    SQL 구문이 실행되기 전에(DML 작업을 수행하기 전에)
--    각 행(ROW)에 대해 한 번씩 실행
--  - AFTER STATEMENT TRIGGER
--    SQL 구문이 실행된 후에 그 문장 대해 한 번 실행
--  - AFTER ROW TRIGGER
--    SQL 구문이 실행된 후에(DML 작업을 수행한 후에)
--    각 행(ROW)에 대해 한 번씩 실행

--○ 형식 및 구조
CREATE [OR REPLACE] TRIGGER 트리거명
    [BEFORE] | [AFTER]
    이벤트1 [OR 이벤트2 [OR 이벤트3]] ON 테이블명
    [FOR EACH ROW [WHEN TRIGGER 조건]]
[DECLARE
    -- 선언 구문;]
BEGIN
    -- 실행 구문;
END;



-- ■■■ AFTER STATEMENT TRIGGER 상황 실습 ■■■ --
--※ DML 작업에 대한 이벤트 기록

--※ 실습 테이블 생성
--   『20260119_03_scott.sql』파일 참조
--    → TBL_TEST1 테이블 생성
--    → TBL_EVENTLOG 테이블 생성

--○ TRIGGER(트리거) 생성
-- 트리거명: TRG_EVENTLOG
CREATE OR REPLACE TRIGGER TRG_EVENTLOG
    AFTER
    INSERT OR UPDATE OR DELETE ON TBL_TEST1
DECLARE
BEGIN
    -- 이벤트 종류 구분(→ 조건문을 통한 분기 처리 가능)
    -- 조건에 대한 키워드 CHECK
    IF (INSERTING) THEN
        INSERT INTO TBL_EVENTLOG(MEMO)
        VALUES('INSERT 쿼리문이 수행되었습니다.');
    ELSIF (UPDATING) THEN
        INSERT INTO TBL_EVENTLOG(MEMO)
        VALUES('UPDATE 쿼리문이 수행되었습니다.'); 
    ELSIF (DELETING) THEN
        INSERT INTO TBL_EVENTLOG(MEMO)
        VALUES('DELETE 쿼리문이 수행되었습니다.');
    END IF;
    
    -- COMMIT; 하지 않음
    
END;
--==>> Trigger TRG_EVENTLOG이(가) 컴파일되었습니다.


-- ■■■ BEFORE STATEMENT TRIGGER 상황 실습 ■■■ --
--※ DML 작업 수행 전에 작업 가능 여부 확인
--   (보안 정책 적용 / 업무 규칙 적용)

--○ TRIGGER(트리거) 생성
-- 트리거명: TRG_TEST1_DML
CREATE OR REPLACE TRIGGER TRG_TEST1_DML
    BEFORE
    INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF (작업시간이 오전 8시 이전이거나 오후 6시 이후라면) THEN
        작업을 수행하지 못하도록 처리하겠다.
    END IF;
END;


CREATE OR REPLACE TRIGGER TRG_TEST1_DML
    BEFORE
    INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF (작업시간이 오전 8시 이전이거나 오후 6시 이후라면) THEN
        예외를 발생시키도록 처리하겠다.
    END IF;
END;


CREATE OR REPLACE TRIGGER TRG_TEST1_DML
    BEFORE
    INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF ( TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 8  
      OR TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17 )  THEN
        예외를 발생시키도록 처리하겠다.
    END IF;
END;


CREATE OR REPLACE TRIGGER TRG_TEST1_DML
    BEFORE
    INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF ( TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 8  
      OR TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17 )  THEN
      RAISE_APPLICATION_ERROR(-20003, '작업은 08:00 ~ 18:00 까지만 가능합니다.');
    END IF;
END;
--==>> Trigger TRG_TEST1_DML이(가) 컴파일되었습니다.



-- ■■■ BEFORE ROW TRIGGER 상황 실습 ■■■ --
--※ 참조 관계가 설정된 데이터(자식) 삭제를 먼저 수행하는 모델

--○ TRIGGER(트리거) 생성
-- 트리거명: TRG_TEST1_DELETE
CREATE OR REPLACE TRIGGER TRG_TEST1_DELETE
    BEFORE
    DELETE ON TBL_TEST1
    FOR EACH ROW 
DECLARE
BEGIN
    DELETE
    FROM TBL_TEST2
    WHERE CODE = :OLD.CODE; 
END;

--※ 『:OLD』
--  - 참조 전 열의 값
--    (INSERT : 입력하기 이전 데이터 즉, 입력할 데이터
--     DELETE : 삭제하기 이전 데이터 즉, 삭제할 데이터)

--※ UPDATE → 개념적으로 DELETE 그리고  INSERT가 결합된 형태로 이해하자
--             이 과정에서 UPDATE하기 이전의 데이터는 『:OLD』
--             이 과정에서 UPDATE한 이후의 데이터는 『:NEW』

--※ 『:OLD』나 『:NEW』와 같은 키워드를
--    의사 레코드라고 부르며, 이들은 STATEMENT TRIGGER(문장 트리거)에서는
--    사용할(참조할) 수 없다.

--==>> Trigger TRG_TEST1_DELETE이(가) 컴파일되었습니다.


-- ■■■ AFTER ROW TRIGGER 상황 실습 ■■■ --
--※ 참조 관계의 테이블 관련 트랜잭션 처리

-- TBL_상품, TBL_입고, TBL_출고

--○ TBL_입고 테이블의 데이터 입력 시(입고 이벤트 발생 시)
--   TBL_상품 테이블의 해당 상품의 재고수량 변동 트리거 생성
-- 트리거명: TRG_IBGO
CREATE OR REPLACE TRIGGER TRG_IBGO
    AFTER
    INSERT ON TBL_입고
    FOR EACH ROW
BEGIN
    IF (INSERTING) THEN
        UPDATE TBL_상품
        SET 재고수량 = 재고수량 + :NEW.입고수량
        WHERE 상품코드 = :NEW.상품코드;
    END IF;

END;
--==>> Trigger TRG_IBGO이(가) 컴파일되었습니다.


--○ TBL_상품 테이블과 TBL_입고 테이블의 관계에서
--   입고수량, 재고수량의 트랜잭션 처리가 이루어질 수 있도록
--   TRG_IBGO 트리거를 수정한다.
CREATE OR REPLACE TRIGGER TRG_IBGO
    AFTER
    INSERT OR UPDATE OR DELETE ON TBL_입고    
    FOR EACH ROW
DECLARE
    V_재고수량  TBL_상품.재고수량%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    
    IF (INSERTING) THEN
        UPDATE TBL_상품
        SET 재고수량 = 재고수량 + :NEW.입고수량
        WHERE 상품코드 = :NEW.상품코드;
        
    ELSIF (UPDATING) THEN
        SELECT 재고수량 INTO V_재고수량
        FROM TBL_상품
        WHERE 상품코드 = :OLD.상품코드;
        
        IF(V_재고수량 + (:NEW.입고수량 - :OLD.입고수량) < 0 ) THEN
            RAISE USER_DEFINE_ERROR;
        END IF;
        
        UPDATE TBL_상품
        SET 재고수량 = 재고수량 + (:NEW.입고수량 - :OLD.입고수량)
        WHERE 상품코드 = :NEW.상품코드;
        
    ELSIF (DELETING) THEN
        SELECT 재고수량 INTO V_재고수량
        FROM TBL_상품
        WHERE 상품코드 = :OLD.상품코드;
        
        IF(V_재고수량 < :OLD.입고수량)  THEN
            RAISE USER_DEFINE_ERROR;
        END IF;
        
        UPDATE TBL_상품
        SET 재고수량 = 재고수량 - :OLD.입고수량
        WHERE 상품코드 = :OLD.상품코드;
    END IF;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20004, '재고부족');
END;


--○ TBL_상품 테이블과 TBL_출고 테이블의 관계에서
--   입고수량, 재고수량의 트랜잭션 처리가 이루어질 수 있도록
--   TRG_CHULGO 트리거를 수정한다.
CREATE OR REPLACE TRIGGER TRG_CHULGO
    AFTER
    INSERT OR UPDATE OR DELETE ON TBL_출고
    FOR EACH ROW
DECLARE
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    IF(INSERTING)   THEN
        -- 출고 테이블을 INSERT할 때
        -- 상품 테이블에 재고-출고 업데이트
        -- 재고가 출고보다 작으면 불가능
        IF(재고수량<출고수량)
            RAISE USER_DEFINE_ERROR;
        END IF;
        
        
    ELSIF (UPDATING) THEN
    -- 출고테이블을 UPDATE할 때(출고수량 변동)
    -- 상품테이블 재고수량 업데이트
    
    ELSIF (DELETING) THEN
    -- 출고테이블 DELETE할 때
    -- 상품테이블 재고수량 업데이트
    
    END IF;
END;


































