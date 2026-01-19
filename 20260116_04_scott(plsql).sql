SELECT USER
SELECT USER
FROM DUAL;
--==>> SCOTT


--○ 프로시저 생성
-- 프로시저명: PRC_TEST_INSERT
-- 프로시저 기능: 『20260116_03_scott.sql』파일에서 생성한
--                세 개의 테이블에 데이터 추가
CREATE OR REPLACE PROCEDURE PRC_TEST_INSERT
( P_NAME    IN  TEST1.NAME%TYPE     -- VARCHAR2(20)   → 크기 지정하지 않음
, P_BIRTH   IN  TEST2.BIRTH%TYPE
, P_SCORE   IN  TEST3.SCORE%TYPE
)
IS
    V_NUM   TEST1.NUM%TYPE;
    V_PAN   TEST3.PAN%TYPE;
BEGIN
    
    SELECT TEST_SEQ.NEXTVAL INTO V_NUM
    FROM DUAL;
    
    IF (P_SCORE >= 80) THEN
        V_PAN := '우수';
    ELSIF (P_SCORE >= 60) THEN
        V_PAN := '보통';
    ELSE
        V_PAN := '노력';
    END IF;
    
    INSERT INTO TEST1(NUM, NAME)
    VALUES(V_NUM, P_NAME);
    
    INSERT INTO TEST2(NUM, BIRTH)
    VALUES(V_NUM, P_BIRTH);
    
    INSERT INTO TEST3(NUM, SCORE, PAN)
    VALUES(V_NUM, P_SCORE, V_PAN);
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_TEST_INSERT이(가) 컴파일되었습니다.


--○ 프로시저 수정
-- 프로시저명: PRC_TEST_INSERT
-- 위에서 작성한 프로시저를 다음과 같은 방식으로도 처리할 수 있다.
CREATE OR REPLACE PROCEDURE PRC_TEST_INSERT
( P_NAME    IN  TEST1.NAME%TYPE     
, P_BIRTH   IN  TEST2.BIRTH%TYPE
, P_SCORE   IN  TEST3.SCORE%TYPE
)
IS
    V_PAN   TEST3.PAN%TYPE;
BEGIN
    IF (P_SCORE >= 80) THEN
        V_PAN := '우수';
    ELSIF (P_SCORE >= 60) THEN
        V_PAN := '보통';
    ELSE
        V_PAN := '노력';
    END IF;
    
    INSERT INTO TEST1(NUM, NAME)
    VALUES(TEST_SEQ.NEXTVAL, P_NAME);
    
    INSERT INTO TEST2(NUM, BIRTH)
    VALUES(TEST_SEQ.CURRVAL, P_BIRTH);
    
    INSERT INTO TEST3(NUM, SCORE, PAN)
    VALUES((SELECT MAX(NUM) FROM TEST1), P_SCORE, V_PAN);
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_TEST_INSERT이(가) 컴파일되었습니다.

--○ 프로시저 생성
-- 프로시저명: PRC_TEST_UPDATE
-- 프로시저 기능: 『20260116_03_scott.sql』파일에서 생성한
--                 테이블의 데이터 수정
-- - TEST1 : 이름
-- - TEST2 : 생년월일
-- - TEST3 : 점수와 판정
-- EXEC PRC_TEST_UPDATE(1, '둘리', '2025-12-20', 90);
CREATE OR REPLACE PROCEDURE PRC_TEST_UPDATE
( P_NUM     IN    TEST1.NUM%TYPE
, P_NAME    IN    TEST1.NAME%TYPE
, P_BIRTH   IN    TEST2.BIRTH%TYPE
, P_SCORE   IN    TEST3.SCORE%TYPE
)
IS
    V_PAN   TEST3.PAN%TYPE;
BEGIN
    IF (P_SCORE >= 80) THEN
        V_PAN := '우수';
    ELSIF (P_SCORE >= 60) THEN
        V_PAN := '보통';
    ELSE
        V_PAN := '노력';
    END IF;
    
    UPDATE TEST1
    SET NAME = P_NAME
    WHERE NUM = P_NUM;
    
    UPDATE TEST2
    SET BIRTH = P_BIRTH
    WHERE NUM = P_NUM;
    
    UPDATE TEST3
    SET SCORE = P_SCORE, PAN = V_PAN
    WHERE NUM = P_NUM;
    
    COMMIT;
    
END;
--==>> Procedure PRC_TEST_UPDATE이(가) 컴파일되었습니다.


--○ 프로시저 생성
-- 프로시저명: PRC_TEST_DELETE
-- 프로시저 기능: 『20260116_03_scott.sql』파일에서 생성한
--                 테이블의 데이터 삭제
-- EXEC PRC_TEST_DELETE(1);
-- → TEST1, TEST2, TEST3 테이블의 NUM이 1인 데이터 삭제
CREATE OR REPLACE PROCEDURE PRC_TEST_DELETE
( P_NUM  IN   TEST1.NUM%TYPE)
IS
BEGIN
    DELETE 
    FROM TEST3
    WHERE NUM = P_NUM;
    
    DELETE 
    FROM TEST2
    WHERE NUM = P_NUM;
    
    DELETE 
    FROM TEST1          --※ TEST1 테이블의 데이터가
    WHERE NUM = P_NUM;  --   가장 마지막에 삭제되어야 한다.
    
    COMMIT;
END;
--==>> Procedure PRC_TEST_DELETE이(가) 컴파일되었습니다.


SET SERVEROUTPUT ON;
--==>> 작업 완료



--○ 프로시저 생성
-- 프로시저명: PRC_NUM_SELECT
-- 프로시저 기능: 『20260116_03_scott.sql』파일에서 생성한
--                 테이블에서 번호에 해당하는 데이터 출력
-- EXEC PRC_NUM_SELECT(2);
-- → TEST1, TEST2, TEST3 테이블의 NUM이 2인 데이터 출력
CREATE OR REPLACE PROCEDURE PRC_NUM_SELECT
( P_NUM     IN  TEST1.NUM%TYPE)
IS
    V_NAME      TEST1.NAME%TYPE;
    V_BIRTH     TEST2.BIRTH%TYPE;
    V_SCORE     TEST3.SCORE%TYPE;
    V_PAN       TEST3.PAN%TYPE;
BEGIN
    SELECT T1.NAME, T2.BIRTH, T3.SCORE, T3.PAN
        INTO V_NAME, V_BIRTH, V_SCORE, V_PAN
    FROM TEST1 T1 JOIN TEST2 T2
    ON T1.NUM = T2.NUM
        JOIN TEST3 T3
        ON T1.NUM = T3.NUM
    WHERE T1.NUM = P_NUM;
    
    /*
    DBMS_OUTPUT.PUT_LINE(V_NAME || '   ');      _LINE이 개행처리
    DBMS_OUTPUT.PUT_LINE(V_BIRTH || '   ');
    DBMS_OUTPUT.PUT_LINE(V_SCORE || '   ');
    DBMS_OUTPUT.PUT_LINE(V_PAN);
    */
    DBMS_OUTPUT.PUT(V_NAME || '   ');
    DBMS_OUTPUT.PUT(V_BIRTH || '   ');
    DBMS_OUTPUT.PUT(V_SCORE || '   ');
    DBMS_OUTPUT.PUT_LINE(V_PAN);

END;

--==>> Procedure PRC_NUM_SELECT이(가) 컴파일되었습니다.


--○ 프로시저 생성
-- 프로시저명: PRC_TEST_ALL
-- 프로시저 기능: 『20260116_03_scott.sql』파일에서 생성한
--                 테이블의 전체 데이터 출력
-- EXEC PRC_TEST_ALL;
-- → TEST1, TEST2, TEST3 테이블의 전체 데이터 출력

CREATE OR REPLACE PROCEDURE PRC_TEST_ALL
IS
BEGIN
    FOR REC IN (SELECT T1.NAME, T2.BIRTH, T3.SCORE, T3.PAN
                   FROM TEST1 T1 JOIN TEST2 T2
                   ON T1.NUM = T2.NUM
                      JOIN TEST3 T3
                      ON T1.NUM = T3.NUM) LOOP
                      
        DBMS_OUTPUT.PUT(REC.NAME  || '   ');
        DBMS_OUTPUT.PUT(REC.BIRTH || '   ');
        DBMS_OUTPUT.PUT(REC.SCORE || '   ');
        DBMS_OUTPUT.PUT_LINE(REC.PAN);
        
    END LOOP;
END;
--==>> Procedure PRC_TEST_ALL이(가) 컴파일되었습니다.


--※ 프로시저에 전달되는 매개변수(파라미터)
--   - 『IN』 파라미터
--      호출자에 의해 프로시저로 전달되는 파라미터이며,
--      '읽기' 전용의 값으로 프로시저는 이 파라미터의 값을 변경할 수 없다.
--   - 『OUT』 파라미터
--     프로시저에서 값을 변경할 수 있고,
--      '쓰기'기능으로 프로시저가 데이터를 호출자에게 돌려주는 기능이다.
--      OUT 파라미터는 디폴트 값을 지정할 수 없다.
--   - 『IN OUT』 파라미터
--      프로시저가 읽고 쓰는 작업을 동시에 할 수 있는 파라미터이다.



--○ 프로시저 생성
-- 프로시저명: PRC_OUT_LIST
-- 프로시저 기능: OUT 파라미터 활용
CREATE OR REPLACE PROCEDURE PRC_OUT_LIST
( P_ID      IN  NUMBER
, P_NAME    OUT VARCHAR2
, P_SCORE   OUT NUMBER
)
IS
BEGIN
    SELECT NAME, SCORE INTO P_NAME, P_SCORE    -- CHECK!
    FROM EXAM1
    WHERE ID = P_ID;
END;
--==>> Procedure PRC_OUT_LIST이(가) 컴파일되었습니다.

VARIABLE NAME VARCHAR2(20);
VARIABLE SCORE NUMBER;

EXEC PRC_OUT_LIST(5, :NAME, :SCORE);
SELECT :NAME, :SCORE
FROM DUAL;
--==>> 
/*
:NAME       :SCORE
-------- --------- 
장보고         97
*/


--○ 프로시저 생성
-- 프로시저명: PRC_INOUT_TEST
-- 프로시저 기능: IN OUT 파라미터 활용
CREATE OR REPLACE PROCEDURE PRC_INOUT_TEST
( P_A   IN OUT NUMBER
)
IS
    V_B NUMBER := 1;
BEGIN
    FOR N IN 1 .. P_A LOOP
       V_B := V_B * 2;
    END LOOP;
    
    P_A := V_B;
END;
--==>> Procedure PRC_INOUT_TEST이(가) 컴파일되었습니다.

VARIABLE N NUMBER;
EXEC :N := 10;
EXEC PRC_INOUT_TEST(:N);
PRINT N;
--==>> 
/*
         N
----------
      1024
*/



-- ■■■ 사용자 정의 구조체 변수 ■■■ --

--○ 형식 및 구조
TYPE 레코드명
IS
RECORD
( 필드명1 데이터타입 [[NOT NULL] { := | DEFAULT} EXPR]
[, 필드명2 데이터타입 [[NOT NULL] { := | DEFAULT} EXPR]
, ...]
)


DECLARE
    -- 구조체 변수 정의
    TYPE MYDATA
    IS
    RECORD
    ( V_NAME    TBL_INSA.NAME%TYPE
    , V_PAY     NUMBER
    );
    
    -- 변수 선언
    -- REC라는 이름의 변수를 MYDATA 타입으로
    REC MYDATA;
BEGIN
    SELECT NAME, BASICPAY+SUDANG INTO REC.V_NAME, REC.V_PAY
    FROM TBL_INSA
    WHERE NUM = 1001;
    
    DBMS_OUTPUT.PUT_LINE('이름 : ' || REC.V_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || REC.V_PAY);
END;

--==>>
/*
이름 : 홍길동
급여 : 2810000
*/


-- ■■■ CURSOR(커서) ■■■ --


--○ 개요
--  - 오라클에서 하나의 레코드가 아닌 여러 레코드로 구성된
--    작업 영역에서 SQL문을 실행하고 그 과정에서 발생한 정보를
--    저장하기 위하여 커서(CURSOR)를 사용하며,
--    커서에는 암시적 커서와 명시적 커서가 있다.
--  - 암시적 커서는 모든 SQL문에 존재하며,
--    SQL 실행 후 오직 하나의 행(ROW)만 출력하게 된다.
--    그러나, SQL문을 실행한 결과물(RESULT SET)이
--    여러 행(ROW)으로 구성된 경우
--    커서(CURSOR)를 명시적으로 선언해야 여러 행(ROW)을 다룰 수 있다.

--○ 암시적(IMPLICIT) 커서
--   - 암시적인 커서는 오라클이나 PL/SQL 실행 매커니즘에 의해 처리되는 SQL문장이
--     처리되는 곳에 대한 익명의 주소(ADDRESS)로
--     오라클 데이터베이스에서 실행되는 모든 SQL 문장은 암시적인 커서이며,
--     암시적인 커서 속성이 사용될 수 있다.

-- ○ 암시적(IMPLICIT) 커서의 속성
--    - SQL%ROWCOUNT: 해당 SQL문의 영향을 받는 행의 수
--    - SQL%FOUND: 해당 SQL문의 영향을 받는 행의 수가 1개 이상일 경우 TRUE
--    - SQL%NOTFOUND: 해당 SQL문의 영향을 받는 행의 수가 없을 경우 TRUE
--    - SQL%ISOPEN: 항상 FALSE. (→ 상황에 따라 암시적 커서가 열려있는지의 여부 확인)

-- ○ 명시적(EMPLICIT) 커서
--   - 명시적인 커서는 프로그래머에 의해 선언되며
--     이름이 있는 커서로 여러 행(ROW)을 다룰 수 있다.
--   - 작업순서
--     CURSOR 선언 → CURSOR OPEN → FETCH → CURSOR CLOSE

-- ○ 형식 및 구조
--  - CURSOR 선언
CURSOR 커서이름
IS
[SELECT 문];
--> 실행하고자 하는 SELECET문을 작성한다.

--  - CURSOR OPEN
OPEN 커서이름;
--> OPEN은 커서에서 선언된 SELECT문의 실행을 의미한다.

--  - FETCH
LOOP
    FETCH 커서이름 INTO 변수명1, 변수명2;
    EXIT WHEN [조건];
END LOOP;
--> OPEN된 SELECT문에 의해 검색된 하나의 행 정보를 읽어 OUT 변수에 대입한다.
--  반환되는 결과가 여러 개인 경우 LOOP ~ END LOOP와 같은 반복문을 이용하여
--  마지막 행이 읽혀질 때까지 계속 읽게 된다.

--  - CURSOR CLOSE
CLOSE 커서이름;
--> 선언된 SELECT문의 선언을 해제한다.


--※ FOR LOOP 구문에서 커서 사용(CURSOR FOR LOOPS)
--  - FOR LOOP 문을 사용하면 커서의 OPEN, FETCH, CLOSE가 자동으로 처리되므로
--    따로 기술할 필요가 없고, 레코드 이름도 자동 선언되므로
--    따로 선언할 필요가 없다.
--  - 형식 및 구조
FOR 레코드명 IN 커서명 LOOP
    -- 처리 구문;
    ...
END LOOP;


-- ※ WHERE CURRENT OF
--   - FETCH 문에 의해 가장 최근에 처리된 행을 참조하기 위해
--     『WHERE CURRENT OF 커서이름』절로 DELETE나 UPDATE문 작성이 가능하다.
--   - 이 절을 사용하기 위해서는 참조하는 커서가 있어야 하며,
--     FOR UPDATE 절이 커서 선언 쿼리문 안에 있어야 한다.


-- ○ 커서 이용 전 상황(단일 행 접근 시)
DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL  INTO V_NAME, V_TEL
    FROM TBL_INSA
    WHERE NUM = 1001;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || '    ' || V_TEL);
END;
--==>> 홍길동    011-2356-4528


-- ○ 커서 이용 전 상황(다중 행 접근 시)
DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL  INTO V_NAME, V_TEL
    FROM TBL_INSA;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || '    ' || V_TEL);
END;
--==>> 에러 발생
/*
ORA-01422: exact fetch returns more than requested number of rows
*/

-- ○ 커서 이용 전 상황(다중 행 접근 시 - 단순 반복문 활용)
DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    V_NUM   TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        SELECT NAME, TEL INTO V_NAME, V_TEL
        FROM TBL_INSA
        WHERE NUM = V_NUM;
            DBMS_OUTPUT.PUT_LINE(V_NAME || '    ' || V_TEL);
            V_NUM := V_NUM + 1;
            
        EXIT WHEN V_NUM >= 1061;
    END LOOP;
END;
--==>>
/*
홍길동    011-2356-4528
이순신    010-4758-6532
이순애    010-4231-1236
김정훈    019-5236-4221
한석봉    018-5211-3542
이기자    010-3214-5357
장인철    011-2345-2525
김영년    016-2222-4444
나윤균    019-1111-2222
김종서    011-3214-5555
유관순    010-8888-4422
정한국    018-2222-4242
조미숙    019-6666-4444
황진이    010-3214-5467
이현숙    016-2548-3365
이상헌    010-4526-1234
엄용수    010-3254-2542
이성길    018-1333-3333
박문수    017-4747-4848
유영희    011-9595-8585
홍길남    011-9999-7575
이영숙    017-5214-5282
김인수    
김말자    011-5248-7789
우재옥    010-4563-2587
김숙남    010-2112-5225
김영길    019-8523-1478
이남신    016-1818-4848
김말숙    016-3535-3636
정정해    019-6564-6752
지재환    019-5552-7511
심심해    016-8888-7474
김미나    011-2444-4444
이정석    011-3697-7412
정영희    
이재영    011-9999-9999
최석규    011-7777-7777
손인수    010-6542-7412
고순정    010-2587-7895
박세열    016-4444-7777
문길수    016-4444-5555
채정희    011-5125-5511
양미옥    016-8548-6547
지수환    011-5555-7548
홍원신    011-7777-7777
허경운    017-3333-3333
산마루    018-0505-0505
이기상    
이미성    010-6654-8854
이미인    011-8585-5252
권영미    011-5555-7548
권옥경    010-3644-5577
김싱식    011-7585-7474
정상호    016-1919-4242
정한나    016-2424-4242
전용재    010-7549-8654
이미경    016-6542-7546
김신제    010-2415-5444
임수봉    011-4151-4154
김신애    011-4151-4444

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


-- ○ 커서 이용 상황(다중 행 접근 시)
DECLARE
    -- 주요 변수 선언
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    
    -- 커서 변수 선언(→ 커서 정의)
    CURSOR CUR_INSA_SELECT
    IS
    SELECT NAME, TEL
    FROM TBL_INSA;
    
BEGIN
    
    -- 커서 오픈
    OPEN CUR_INSA_SELECT;
    
    -- 커서 오픈 시 쏟아져 나오는 데이터들 처리(→ 잡아내기 → 반복처리)
    LOOP
        -- 한 행 한 행(레코드 단위로) 끄집어내어 가져오는 행위 → 『FETCH』
        FETCH CUR_INSA_SELECT INTO V_NAME, V_TEL;
        
        -- 반복문을 빠져나가는 조건 → 커서의 데이터 모두 소진 시
        EXIT WHEN CUR_INSA_SELECT%NOTFOUND;     -- 명시적 커서에서도 사용 가능
        
        -- 출력
        DBMS_OUTPUT.PUT_LINE(V_NAME || '   ' ||V_TEL);
        
    END LOOP;

    -- 커서 클로즈
    CLOSE CUR_INSA_SELECT;
    
END;
--==>>
/*

*/














