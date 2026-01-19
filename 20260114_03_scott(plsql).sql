SELECT USER
FROM DUAL;
--==>> SCOTT

SET SERVEROUTPUT ON;
--==>> 작업이 완료되었습니다.

SELECT *
FROM TBL_INSA;
--==>>
/*
1001	홍길동	771212-1022432	1998-10-11	서울	011-2356-4528	기획부	부장	2610000	200000
                                        :
                                        :
*/


--○ TBL_INSA 테이블의 여러 명의 데이터 여러 개를 변수에 저장하여 출력
--  (→ 단순 반복문 활용 출력)
DECLARE
    VINSA   TBL_INSA%ROWTYPE;
    VNUM    TBL_INSA.NUM%TYPE := 1001;
BEGIN
    
    LOOP
        SELECT NAME, TEL, BUSEO INTO VINSA.NAME, VINSA.TEL, VINSA.BUSEO
        FROM TBL_INSA
        WHERE NUM = VNUM;
        
        DBMS_OUTPUT.PUT_LINE(VINSA.NAME || ' - ' || VINSA.TEL || ' _ ' || VINSA.BUSEO);
        
        EXIT WHEN VNUM >= 1060;
        
        VNUM := VNUM + 1;   --VNUM을 1만큼 증가 → VNUM++;    VNUM += 1;
        
    END LOOP;
END;
--==>>
/*
홍길동 - 011-2356-4528 _ 기획부
이순신 - 010-4758-6532 _ 총무부
이순애 - 010-4231-1236 _ 개발부
김정훈 - 019-5236-4221 _ 영업부
한석봉 - 018-5211-3542 _ 총무부
이기자 - 010-3214-5357 _ 개발부
장인철 - 011-2345-2525 _ 개발부
김영년 - 016-2222-4444 _ 홍보부
나윤균 - 019-1111-2222 _ 인사부
김종서 - 011-3214-5555 _ 영업부
유관순 - 010-8888-4422 _ 영업부
정한국 - 018-2222-4242 _ 홍보부
조미숙 - 019-6666-4444 _ 홍보부
황진이 - 010-3214-5467 _ 개발부
이현숙 - 016-2548-3365 _ 총무부
이상헌 - 010-4526-1234 _ 개발부
엄용수 - 010-3254-2542 _ 개발부
이성길 - 018-1333-3333 _ 개발부
박문수 - 017-4747-4848 _ 인사부
유영희 - 011-9595-8585 _ 자재부
홍길남 - 011-9999-7575 _ 개발부
이영숙 - 017-5214-5282 _ 기획부
김인수 -  _ 영업부
김말자 - 011-5248-7789 _ 기획부
우재옥 - 010-4563-2587 _ 영업부
김숙남 - 010-2112-5225 _ 영업부
김영길 - 019-8523-1478 _ 총무부
이남신 - 016-1818-4848 _ 인사부
김말숙 - 016-3535-3636 _ 총무부
정정해 - 019-6564-6752 _ 총무부
지재환 - 019-5552-7511 _ 기획부
심심해 - 016-8888-7474 _ 자재부
김미나 - 011-2444-4444 _ 영업부
이정석 - 011-3697-7412 _ 기획부
정영희 -  _ 개발부
이재영 - 011-9999-9999 _ 자재부
최석규 - 011-7777-7777 _ 홍보부
손인수 - 010-6542-7412 _ 영업부
고순정 - 010-2587-7895 _ 영업부
박세열 - 016-4444-7777 _ 인사부
문길수 - 016-4444-5555 _ 자재부
채정희 - 011-5125-5511 _ 개발부
양미옥 - 016-8548-6547 _ 영업부
지수환 - 011-5555-7548 _ 영업부
홍원신 - 011-7777-7777 _ 영업부
허경운 - 017-3333-3333 _ 총무부
산마루 - 018-0505-0505 _ 영업부
이기상 -  _ 개발부
이미성 - 010-6654-8854 _ 개발부
이미인 - 011-8585-5252 _ 홍보부
권영미 - 011-5555-7548 _ 영업부
권옥경 - 010-3644-5577 _ 기획부
김싱식 - 011-7585-7474 _ 자재부
정상호 - 016-1919-4242 _ 홍보부
정한나 - 016-2424-4242 _ 영업부
전용재 - 010-7549-8654 _ 영업부
이미경 - 016-6542-7546 _ 자재부
김신제 - 010-2415-5444 _ 기획부
임수봉 - 011-4151-4154 _ 개발부
김신애 - 011-4151-4444 _ 개발부


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


-- ■■■ FUNCTION(STORED FUNCTION, 함수, 사용자 함수, 사용자 정의 함수) ■■■ --

--○ 개요
--  - 함수란 하나 이상의 PL/SQL 구문으로 구성된 서브 루틴으로
--    코드를 다시 사용할 수 있도록 캡슐화하는데 사용된다.
--  - 오라클에서는 오라클에 정의된 기본 제공 함수를 사용하거나
--    직접 스토어드 함수를 만들 수 있다.(→ 사용자 정의 함수)
--  - 이 사용자 정의 함수는 시스템 함수(내장 함수, 빌트인 함수)처럼
--    쿼리에서 호출하거나, 저장 프로시저처럼 EXECUTE문을 통해 실행할 수 있다.

--○ 형식 및 구조 (→ 함수 정의)
CREATE [OR REPLACE] FUNCTION 함수명
[(
   매개변수1 자료형
 , 매개변수2 자료형
 [, ...]
)]
RETURN 데이터타입
IS
    -- 주요 변수 선언(지역 변수)
BEGIN
    -- 실행문
    ...
    RETURN 값;
    
    [EXCEPTION]
        -- 예외 처리 구문;
END;

--※ 사용자 정의 함수(스토어드 함수)는
--   IN 파라미터(입력 매개변수)만 사용할 수 있으며
--   반드시 반환될 값의 데이터 타입을 RETURN문에 선언해야 하고,
--   FUNCTION은 반드시 단일 값만 반환한다.

--※ 인수(입력 매개변수)나 RETURN에서는 
--   자료형의 크기(길이)를 명시하지 않는다.

--○ 형식 및 구조(→ 함수 호출)

-- ① EXECUTE를 활용한 함수 호출(실행) 형식 및 구조
EXECUTE :바인딩변수 := 함수명([인수,인수,...]);
PRINT :바인딩변수;

-- ② EXEC를 활용한 함수 호출(실행) 형식 및 구조
EXEC :바인딩변수 := 함수명([인수,인수,...]);
PRINT :바인딩변수;

-- ③ CALL를 활용한 함수 호출(실행) 형식 및 구조
CALL 함수명([인수, 인수,...]) INTO :바인딩변수;
PRINT :바인딩변수;



--○ TBL_INSA 테이블을 대상으로
--   주민번호를 가지고 성별을 조회하는 함수를 정의한다.
-- 함수명: FN_GENDER()
--                  ↑ SSN(주민등록번호) → 형태 → 'YYMMDD-NNNNNNN'
CREATE OR REPLACE FUNCTION FN_GENDER
(
)
RETURN VARCHAR2
IS
BEGIN
END;

CREATE OR REPLACE FUNCTION FN_GENDER
( VSSN VARCHAR2 
)
RETURN VARCHAR2
IS
    -- 주요 변수 선언
    VRESULT   VARCHAR2(20);
BEGIN
    -- 연산 및 처리
    IF (SUBSTR(VSSN,8,1) IN ('1','3'))
        THEN VRESULT := '남자';
    ELSIF (SUBSTR(VSSN,8,1) IN ('2','4')) 
        THEN VRESULT := '여자';
    ELSE 
        VRESULT := '성별확인불가';
    END IF;
    
    -- 최종 결과값 반환
    RETURN VRESULT;
END;
--==>> Function FN_GENDER이(가) 컴파일되었습니다.

--○ 임의의 정수 두 개를 매개변수(입력 파라미터)로 넘겨받아
--   A(→ 첫 번째 매개변수)의 B(→ 두 번째 매개변수)승의 값을 반환하는
--   사용자 정의 함수를 만든다.
-- 함수명: FN_POW()
-- 사용 예)
SELECT FN_POW(10, 3) "결과확인"
FROM DUAL;
--==>> 1000

/*
    FN_POW(10, 3)
          -------
             10 * 10 * 10 = 1000
         1 * 10 * 10 * 10 = 1000    
         0 * 10 * 10 * 10 = 0
*/

CREATE OR REPLACE FUNCTION FN_POW   
( P_NUM1    NUMBER                      -- 10
, P_NUM2    NUMBER                      -- 3
)
RETURN NUMBER
IS
    V_RESULT NUMBER := 1;               -- 누적 곱
    V_NUM    NUMBER;
BEGIN
    FOR V_NUM IN 1 .. P_NUM2 LOOP       -- 1 ~ 3
        V_RESULT := V_RESULT * P_NUM1;  -- 1 * 10 * 10 * 10
    END LOOP;
    
    RETURN V_RESULT;
END;
--==>> Function FN_POW이(가) 컴파일되었습니다.


--○ TBL_INSA 테이블의 급여 계산 전용 함수를 정의한다.
--   급여는 (기본급*12)+수당 기반으로 연산을 수행한다.
-- 함수명: FN_INSAPAY(기본급, 수당)

CREATE OR REPLACE FUNCTION FN_INSAPAY
( P_BASICPAY    NUMBER
, P_SUDANG      NUMBER
)
RETURN NUMBER
IS
    V_RESULT    NUMBER;
BEGIN
    V_RESULT := (P_BASICPAY * 12) + P_SUDANG;
    
    RETURN V_RESULT;
END;
--==>> Function FN_INSAPAY이(가) 컴파일되었습니다.


--○ TBL_INSA 테이블의 입사일을 기준으로
--   현재까지의 근무년수를 반환하는 함수를 정의한다.
--   단, 근무년수는 소숫점 이하 한자리까지 계산하여 반환한다.
-- 함수명: FN_INSAWORKYEAR(입사일)
CREATE OR REPLACE FUNCTION FN_INSAWORKYEAR
( P_IBSADATE    DATE
)
RETURN NUMBER
IS
    V_RESULT    NUMBER;
BEGIN
    V_RESULT := ROUND((MONTHS_BETWEEN(SYSDATE, P_IBSADATE)/12),1);
    
    RETURN V_RESULT;
END;
--==>> Function FN_INSAWORKYEAR이(가) 컴파일되었습니다.



--○ 주민번호(SSN)로 생년월일을 확인하는 함수 정의
-- 함수명: FN_BIRTH() → 'YYMMDD-NNNNNNN' DATE타입으로 반환
CREATE OR REPLACE FUNCTION FN_BIRTH
(P_SSN IN   VARCHAR2
)
RETURN DATE
IS
    V_YEAR    VARCHAR2(10);
    V_RESULT    DATE;
BEGIN
    V_YEAR := SUBSTR(P_SSN,1,2);
    IF SUBSTR(P_SSN,8,1) IN ('1','2')
       THEN V_RESULT := TO_DATE(('19'|| V_YEAR || '-' || SUBSTR(P_SSN,3,2) || '-' || SUBSTR(P_SSN,5,2)), 'YYYY-MM-DD');
    ELSIF SUBSTR(P_SSN,8,1) IN ('3','4')
       THEN V_RESULT := TO_DATE(('20'|| V_YEAR || '-' || SUBSTR(P_SSN,3,2) || '-' || SUBSTR(P_SSN,5,2)), 'YYYY-MM-DD');
    ELSE
        V_RESULT := TO_DATE('1-1-1', 'YYYY-MM-DD');
    END IF;
    
    RETURN V_RESULT;
END;
--==>> Function FN_BIRTH이(가) 컴파일되었습니다.


/*
EXEC :바인딩변수 := 함수명([인수,인수,...]);
PRINT :바인딩변수;

CALL 함수명([인수, 인수,...]) INTO :바인딩변수;
PRINT :바인딩변수;
*/

-- EXEC로 실행
VARIABLE RESULT NUMBER;
EXEC :RESULT := FN_POW(10,5);
PRINT :RESULT;
--==>>
/*
    RESULT
----------
    100000
*/


-- CALL로 실행
VARIABLE RESULT NUMBER;
CALL FN_POW(10,5) INTO :RESULT;
PRINT :RESULT;
--==>>
/*
    RESULT
----------
    100000
*/

-- EXEC로 실행
VARIABLE RESULT DATE;
EXEC :RESULT := FN_BIRTH('770922-2315406');
PRINT :RESULT;
--==>>
/*
RESULT
-------------
1977-09-22
*/

-- CALL로 실행
VARIABLE RESULT DATE;
CALL FN_BIRTH('770922-2315406') INTO :RESULT;
PRINT :RESULT;
--==>>
/*
RESULT
-------------
1977-09-22
*/


--○ 함수 정의
-- 함수 기능: 주민번호로 나이(→ 한국 나이)를 확인하는 함수 만들기
-- 함수명: FN_AGE()

CREATE OR REPLACE FUNCTION FN_AGE
( P_SSN VARCHAR2
)
RETURN NUMBER
IS
    V_YEAR  NUMBER;
    V_AGE   NUMBER;
BEGIN
    V_YEAR :=TO_NUMBER(SUBSTR(P_SSN,1,2));
    IF SUBSTR(P_SSN,8,1) IN ('1','2')
        THEN V_YEAR := V_YEAR + 1899;
    ELSIF SUBSTR(P_SSN,8,1) IN ('3','4')
        THEN V_YEAR := V_YEAR + 1999;
    ELSE V_YEAR := 0;
    END IF;
    
    V_AGE := EXTRACT(YEAR FROM SYSDATE) - V_YEAR;
    RETURN V_AGE;
END;
--==>> Function FN_AGE이(가) 컴파일되었습니다.

VARIABLE RESULT NUMBER;
EXECU :RESULT := FN_AGE('770922-2315406');
PRINT :RESULT;
--==>>
/*
    RESULT
----------
        50
*/

VARIABLE RESULT NUMBER;
CALL FN_AGE('770922-2315406') INTO :RESULT;
PRINT :RESULT;
--==>>
/*
    RESULT
----------
        50
*/
CREATE OR REPLACE FUNCTION FN_AGE2
(P_SSN  VARCHAR2
)
RETURN NUMBER
IS
    V_YEAR      NUMBER;
    V_BIRTH     VARCHAR2(4);
    V_RESULT    NUMBER;
BEGIN
    V_YEAR := TO_NUMBER(SUBSTR(P_SSN,1,2));
    IF (SUBSTR(P_SSN,8,1) IN ('1','2'))
        THEN V_YEAR := V_YEAR + 1900;
    ELSIF (SUBSTR(P_SSN,8,1) IN ('3','4'))
        THEN V_YEAR := V_YEAR + 2000;
    ELSE V_YEAR := 0;
    END IF;
    
    V_BIRTH := SUBSTR(P_SSN,3,4);
    
    IF(TO_CHAR(SYSDATE,'MMDD') >= V_BIRTH)
        THEN V_RESULT :=(EXTRACT(YEAR FROM SYSDATE) - V_YEAR) ;
    ELSIF(TO_CHAR(SYSDATE,'MMDD') < V_BIRTH)
        THEN V_RESULT := (EXTRACT(YEAR FROM SYSDATE) - V_YEAR) - 1;
    ELSE
        V_RESULT := 0;
    END IF;
    
    RETURN V_RESULT;
    
END;


VARIABLE RESULT NUMBER;
EXEC :RESULT := FN_AGE2('010905-4345121');
PRINT :RESULT;

VARIABLE RESULT NUMBER;
CALL FN_AGE2('010104-4345121') INTO :RESULT;
PRINT :RESULT;

-- 모범 풀이

CREATE OR REPLACE FUNCTION FN_AGE
(P_SSN VARCHAR2
)
RETURN NUMBER
IS
    V_AGE   NUMBER;
BEGIN
    CASE
        WHEN SUBSTR(P_SSN,8,1) IN ('1','2')
        THEN V_AGE := EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(P_SSN,1,2))+ 1899);
        WHEN SUBSTR(P_SSN,8,1) IN ('3','4')
        THEN V_AGE := EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(P_SSN,1,2))+ 1999);
        ELSE V_AGE := -1;
    END CASE;
    
    RETURN V_AGE;
END;
--==>> Function FN_AGE이(가) 컴파일되었습니다.

-- EXEC로 실행
VARIABLE RESULT NUMBER;
EXECU :RESULT := FN_AGE('790116-2315406');
PRINT :RESULT;
--==>>
/*
    RESULT
----------
        48
*/
VARIABLE RESULT NUMBER;
CALL FN_AGE('790116-2315406') INTO :RESULT;
PRINT :RESULT;
--==>>
/*
    RESULT
----------
        48
*/


--○ 함수 정의
-- 함수 기능: 주민번호로 나이(→ 한국 나이)를 확인하는 함수 만들기
-- 함수명: FN_AGE()
CREATE OR REPLACE FUNCTION FN_AGE
(P_SSN VARCHAR2
)
RETURN NUMBER
IS
    V_DATE  DATE;
    V_AGE   NUMBER;
BEGIN
    IF SUBSTR(P_SSN,8,1) IN ('1','2')
       THEN V_DATE := TO_DATE(('19'|| SUBSTR(P_SSN,1,2) || '-' || SUBSTR(P_SSN,3,2) || '-' || SUBSTR(P_SSN,5,2)), 'YYYY-MM-DD');
    ELSIF SUBSTR(P_SSN,8,1) IN ('3','4')
       THEN V_DATE := TO_DATE(('20'|| SUBSTR(P_SSN,1,2) || '-' || SUBSTR(P_SSN,3,2) || '-' || SUBSTR(P_SSN,5,2)), 'YYYY-MM-DD');
    ELSE
        V_DATE := TO_DATE('1-1-1', 'YYYY-MM-DD');
    END IF;
    
    V_AGE := TRUNC(MONTHS_BETWEEN(SYSDATE, V_DATE) / 12);
    
    RETURN V_AGE;
END;
--==>>Function FN_AGE이(가) 컴파일되었습니다.

-- EXEC로 실행
VARIABLE RESULT NUMBER;
EXECU :RESULT := FN_AGE('790116-2315406');
PRINT :RESULT;
--==>>
/*
    RESULT
----------
        46
*/
VARIABLE RESULT NUMBER;
CALL FN_AGE('790116-2315406') INTO :RESULT;
PRINT :RESULT;
--==>>
/*
    RESULT
----------
        46
*/


--○ 함수 정의
-- 함수 기능: 평점을 구하는 함수 정의하기
-- 95 ~ 100 : 4.5   90 ~ 94 : 4.0
-- 85 ~  89 : 3.5   80 ~ 84 : 3.0
-- 75 ~  79 : 2.5   70 ~ 74 : 2.0
-- 65 ~  69 : 1.5   60 ~ 64 : 1.0
-- 60 미만 : 0
-- 함수명: FN_GRADE()

-- IF
CREATE OR REPLACE FUNCTION FN_GRADE
(JUMSU  NUMBER)
RETURN NUMBER
IS
    V_GRADE NUMBER;
BEGIN
    IF(JUMSU < 100)
        THEN V_GRADE := -1;
    ELSIF(JUMSU >=95 AND JUMSU <= 100)
        THEN V_GRADE := 4.5;
    ELSIF(JUMSU >=90)
        THEN V_GRADE := 4.0;
    ELSIF(JUMSU >=85)
        THEN V_GRADE := 3.5;
    ELSIF(JUMSU >=80)
        THEN V_GRADE := 3.0;
    ELSIF(JUMSU >=75)
        THEN V_GRADE := 2.5;
    ELSIF(JUMSU >=70)
        THEN V_GRADE := 2.0;
    ELSIF(JUMSU >=65)
        THEN V_GRADE := 1.5;
    ELSIF(JUMSU >=60)
        THEN V_GRADE := 1.0;
    ELSIF(JUMSU < 60)
        THEN V_GRADE := 0;
    ELSE V_GRADE := -1;
    END IF;
    
    RETURN V_GRADE;
END;

-- 모범 풀이
CREATE OR REPLACE FUNCTION FN_GRADE
(P_SCORE  NUMBER)
RETURN NUMBER
IS
    V_GRADE NUMBER(5, 1);
BEGIN
    IF(P_SCORE >=95 AND P_SCORE <= 100)
        THEN V_GRADE := 4.5;
    ELSIF(P_SCORE >=90)
        THEN V_GRADE := 4.0;
    ELSIF(P_SCORE >=85)
        THEN V_GRADE := 3.5;
    ELSIF(P_SCORE >=80)
        THEN V_GRADE := 3.0;
    ELSIF(P_SCORE >=75)
        THEN V_GRADE := 2.5;
    ELSIF(P_SCORE >=70)
        THEN V_GRADE := 2.0;
    ELSIF(P_SCORE >=65)
        THEN V_GRADE := 1.5;
    ELSIF(P_SCORE >=60)
        THEN V_GRADE := 1.0;
    ELSE
        V_GRADE := 0.0;
    END IF;
    
    RETURN V_GRADE;
END;


VARIABLE RESULT NUMBER;
EXECU :RESULT := FN_GRADE(150);
PRINT :RESULT;

VARIABLE RESULT NUMBER;
CALL FN_GRADE(75) INTO :RESULT;
PRINT :RESULT;

-- CASE
CREATE OR REPLACE FUNCTION FN_GRADE
(JUMSU  NUMBER)
RETURN NUMBER
IS
    V_GRADE NUMBER (5, 1);
BEGIN
    CASE
        WHEN JUMSU > 100
        THEN V_GRADE := -1;
        WHEN JUMSU >= 95 AND JUMSU <= 100
        THEN V_GRADE := 4.5; 
        WHEN JUMSU >= 90
        THEN V_GRADE := 4.0; 
        WHEN JUMSU >= 85 
        THEN V_GRADE := 3.5; 
        WHEN JUMSU >= 80
        THEN V_GRADE := 3.0; 
        WHEN JUMSU >= 75
        THEN V_GRADE := 2.5; 
        WHEN JUMSU >= 70
        THEN V_GRADE := 2.0; 
        WHEN JUMSU >= 65
        THEN V_GRADE := 1.5; 
        WHEN JUMSU >= 60
        THEN V_GRADE := 1.0; 
        WHEN JUMSU < 60
        THEN V_GRADE := 0;
        ELSE V_GRADE := -1;
    END CASE;
    
    RETURN V_GRADE;
END;

VARIABLE RESULT NUMBER;
EXECU :RESULT := FN_GRADE(97);
PRINT :RESULT;

VARIABLE RESULT NUMBER;
CALL FN_GRADE(74) INTO :RESULT;
PRINT :RESULT;



--------------------------------------------------------------------------------

-- ※ 참고

-- 1. INSERT, UPDATE, DELETE, (MERGE)
--     → DML(Data Manipulation Language)
--     → COMMIT / ROLLBACK이 필요하다.

-- 2. CREATE, DROP, ALTER, (TRANCATE)
--     → DDL(Data Definition Language)
--     → 실행하면 자동으로 COMMIT 된다.

-- 3. GRANT, REVOKE
--     → DCL(Data Control Language)
--     → 실행하면 자동으로 COMMIT 된다.

-- 4. COMMIT, ROLLBACK
--     → TCL(Transaction Control Language)


-- 정적 PL/SQL 구문 → DML문, TCL문만 사용 가능하다.
-- 동적 PL/SQL 구문 → DML문, DDL문, TCL문 사용 가능하다.

--※ 정적 SQL(정적 PL/SQL)
--> 기본적으로 사용하는 SQL 구문과
-- PL/SQL 구문 안에 SQL 구문을 직접 삽입하는 방법
--> 작성이 쉽고 성능이 좋다.

--※ 동적 SQL(동적 PL/SQL) → 『EXECUTE IMMEDIATE』
--> 완성되지 않은 SQL 구문을 기반으로
-- 실행 중 변경 가능한 문자열 변수 또는 문자열 상수를 통해
-- SQL 구문을 동적으로 완성하여 실행하는 방법
--> 사전에 정의되지 않은 SQL을 실행할 때(런타임 시)완성 및 확정하여 실행할 수 있다.
-- DML, TCL 외에도 DDL, DCL 사용이 가능하다.


--------------------------------------------------------------------------------


-- ■■■ PROCEDURE(프로시저, STORED PROCEDURE, 스토어드 프로시저, 사용자 정의 프로시저) ■■■ --

--○ 개요
--  - PL/SQL에서 가장 대표적인 구조인 스토어드 프로시저는
--    개발자가 자주 작성해야하는 업무의 흐름을
--    미리 작성하여 데이터베이스 내에 저장해 두었다가
--    필요할 때 마다 호출하여 실행할 수 있도록 처리해주는 구문이다.
--  - 사용자에게 프로시저를 만들 수 있는 권한이 없는 경우
--    권한 설정 후 사용할 수 있다.
--    ·RESOURCE 롤에 기본적으로 프로시저 생성 권한 있음
--    ·CREATE PROCEDURE 권한을 별도로 부여할 수 있음

--○ 형식 및 구조 (→ 프로시저 정의)
CREATE [OR REPLACE] PROCEDURE 프로시저명
[( 매개변수 IN 데이터타입        -- 입력용
 , 매개변수 OUT 데이터타입       -- 출력용
 , 매개변수 IN OUT 데이터타입    -- 입/출력용
)]
IS
    [-- 주요 변수 선언;]
BEGIN
    -- 실행 구문;
    ...
    [EXCEPTION]
        -- 예외 처리 구문;
END;

-- - IN 파라미터
--   : 호출자에 의해 프로시저로 전달되는 파라미터이며,
--   『읽기』 전용의 값으로 프로시저는 이 파라미터의 값을 변경할 수 없다.(디폴트 모드)

-- - OUT 파라미터
--   : 프로시저에서 값을 변경할 수 있고,
--    『쓰기』기능으로 프로시저가 정보를 호출자에게 돌려주는 기능이다.
--     OUT 파라미터는 디폴트값을 지정할 수 없다.

-- - IN OUT 파라미터
--   : 프로시저가 읽고 쓰는 작업을 동시에 할 수 있는 파라미터이다.


--※ FUNCTION과 비교했을 때
-- 『RETURN 반환자료형』 부분이 존재하지 않으며,
-- 『RETURN』문 자체도 존재하지 않으며,
-- 프로시저 실행 시 넘겨주게 되는 매개변수의 종류는
-- IN, OUT, IN OUT으로 구분된다.

--※ 프로시저 안에서는
-- INSERT, UPDATE, DELETE문을 사용하는 경우
-- 자동 커밋되지 않으므로  『COMMIT;』구문을 추가해야 한다.


--○ 형식 및 구조 (→ 프로시저 호출)
EXEC[UTE] 프로시저명[(인수, 인수, ...)];


--※ 실습 테이블 생성
-- 『20260114_03_scott』에서 생성한 『TBL_STUDENTS』테이블
-- 『20260114_03_scott』에서 생성한 『TBL_IDPW』테이블

--○ 프로시저 생성
-- 프로시저명: PRC_STUDENT_INSERT(아이디, 패스워드, 이름, 전화번호, 주소)
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( P_ID      IN  TBL_IDPW.ID%TYPE
, P_PW      IN  TBL_IDPW.PW%TYPE
, P_NAME    IN  TBL_STUDENTS.NAME%TYPE
, P_TEL     IN  TBL_STUDENTS.TEL%TYPE
, P_ADDR    IN  TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- TBL_IDPW 테이블에 데이터 입력
    INSERT INTO TBL_IDPW(ID,PW)
    VALUES(P_ID,P_PW);
    
    -- TBL_STUDENTS 테이블에 데이터 입력
    INSERT INTO TBL_STUDENTS(ID,NAME,TEL,ADDR)
    VALUES(P_ID,P_NAME,P_TEL,P_ADDR);
    
    -- 커밋
    COMMIT;
    
END;
--==>> Procedure PRC_STUDENT_INSERT이(가) 컴파일되었습니다.




































