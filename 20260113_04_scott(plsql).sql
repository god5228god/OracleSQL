SELECT USER
FROM DUAL;
--==>> SCOTT


-- ■■■ PL/SQL ■■■ --

-- 1. PL/SQL(Procedural Language extension to SQL)은
--    프로그래밍 언어의 특징을 가지는 SQL의 확장이며,
--    데이터 조작과 질의 문장은 PL/SQL의 절차적 코드 안에 포함된다.
--    또한, PL/SQL을 사용하면 SQL로 할 수 없는 절차적 작업이 가능하다.
--    여기에 『절차적』이라는 단어가 가지는 의미는
--    어떤 것이 어떤 과정을 거쳐 어떻게 완료되는지
--    그 방법과 과정을 정확하게 코드에 기술한다는 것을 의미한다.

-- 2. PL/SQL은 절차적으로 표현하기 위해
--    변수를 선언할 수 있는 기능,
--    참과 거짓을 구별할 수 있는 기능,
--    실행 흐름을 컨트롤(제어)할 수 있는 기능 등을 제공하낟.

-- 3. PL/SQL은 블럭 구조로 되어 있으며
--    블럭은 선언 부분, 실행 부분, 예외 처리 부분의
--    세 부분으로 구성되어 있다.
--    또한, 반드시 실행 부분은 존재해야 하며, 구조는 다음과 같다.

-- 4. 형식 및 구조
[DECLARE]
    -- 선언문(delcarations)
BEGIN
    -- 실행문(statements)
    
    [EXCEPTION
        -- 예외 처리문(exception handlers)]
END;

-- 5. 변수 선언
DECLARE
    변수명 자료형;
    변수명 자료형 := 초기값;
BEGIN
    PL/SQL 구문;
END;

-- 『DBMS_OUTPUT.PUT_LINE()』을 통해
--  화면에 결과를 출력하기 위한 환경변수 설정 (세션에 의존적)
SET SERVEROUTPUT ON;
--==>> 작업이 완료되었습니다.(0.046초)



--○ 변수에 임의의 값을 대입하고 그 값을 출력하는 PL/SQL 구문 작성
DECLARE
    -- 선언부(주요 변수를 선언하는 영역)
    D1  NUMBER := 10;
    D2  VARCHAR2(30) := 'HELLO';
    D3  VARCHAR2(20) := 'ORACLE';
BEGIN
    -- 실행부
    --System.out.println(D1);
    DBMS_OUTPUT.PUT_LINE(D1);
    DBMS_OUTPUT.PUT_LINE(D2);
    DBMS_OUTPUT.PUT_LINE(D3);
END;
--==>>
/*
10
HELLO
ORACLE


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


-- 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
    -- 선언부
    V1 NUMBER := 20;
    V2 VARCHAR2(20) := 'HELLO';
    V3 VARCHAR2(20) := 'ORACLE';
BEGIN
    -- 실행부
    V1 := V1 + 10;          -- V1 += 10; (X)
    V2 := V2 || ' 명철이';
    V3 := V3 || ' World';
    
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
/
--==>>
/*
30
HELLO 명철이
ORACLE World


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ IF문(조건문)
-- IF 조건식 THEN 실행영역 END IF;
-- IF ~ END IF;
-- IF ~ THEN ~ END IF;
-- IF ~ THEN ~ ELSE ~ END IF;
-- IF ~ THEN ~ ELSIF ~ THEN ~ ELSE ~ END IF;
-- IF ~ THEN ~ ELSIF ~ THEN ~ ELSIF ~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL의 IF 문장은 다른 언어의 IF 조건문과 매우 유사하다.
--    일치하는 조건에 따라 선택적으로 작업을 수행할 수 있도록 한다.
--    TRUE이면 THEN과 ELSE 사이의 문장을 수행하고
--    FALSE나 NULL이면 ELSE와 END 사이의 문장을 수행하게 된다.

-- 2. 형식 및 구조(IF)
IF 조건
    THEN 처리구문;
END IF;

-- 3. 형식 및 구조(IF ~ ELSE)
IF 조건
    THEN 처리구문;
ELSE 
    처리구문;
END IF;

-- 4. 형식 및 구조(IF ~ ELSE 중첩)
IF 조건
    THEN 처리구문;
ELSIF 조건
    THEN 처리구문;
ELSIF 조건
    THEN 처리구문;
ELSE
    처리구문;
END IF;

-- 가독성을 위해 조건에 ()을 넣어서 작성하자

--○ 변수에 들어있는 값에 따라
--   Excellent, Good, Fail로 구분하여
--   결과를 출력하는 PL/SQL 구문을 작성한다.
DECLARE
    -- 선언부
    GRADE CHAR;   
BEGIN
    -- 실행부
    -- GRADE := 'A';
    -- GRADE := 'B';
    GRADE := 'C';
    
    IF (GRADE = 'A')
        THEN DBMS_OUTPUT.PUT_LINE('Excellent');
    ELSIF (GRADE = 'B')
        THEN DBMS_OUTPUT.PUT_LINE('Good');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Fail');
    END IF;
END;


--※ 외부 입력 처리
-- 1. ACCEPT 문
-- ACCEPT 변수명 PROMPT '메시지';
-- 외부 변수로부터 입력받은 데이터를 내부 변수에 전달할 때
-- 『&외부변수명』형태로 접근하게 된다.

--○ 정수 2개를 외부로부터(사용자로부터) 입력받아
--   이들의 덧셈 연산 결과를 출력하는 PL/SQL 구문을 작성한다.

ACCEPT N1 PROMPT '첫 번째 정수를 입력하세요';
ACCEPT N2 PROMPT '두 번째 정수를 입력하세요';

DECLARE
    -- 선언부
    VNUM1   NUMBER := &N1;
    VNUM2   NUMBER := &N2;
    VRESULT NUMBER := 0;
BEGIN
    -- 실행부
    -- - 연산 및 처리
    VRESULT := VNUM1 + VNUM2;
    
    -- - 결과 출력
    DBMS_OUTPUT.PUT_LINE(VRESULT);
END;
--==>>
/*
300


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/



--○ 사용자로부터 입력받은 금액을 화폐 단위로 출력하는 프로그램을 작성한다.
--   단, 반환 금액은 편의상 1천원 미만, 10원 이상만 가능하다고 가정한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 금액 입력 : 990

입력받은 금액 총액: 990원
화폐단위: 오백원 1, 백원 4, 오십원 1, 십원 4

*/

ACCEPT M PROMPT '금액 입력';

DECLARE
    M1  NUMBER := &M;
    D1  NUMBER := 0;
    D2  NUMBER := 0;
    D3  NUMBER := 0;
    D4  NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액: ' || M1 || '원');
    
    D1 := TRUNC(M1/500);
    M1 := MOD(M1,500);
    D2 := TRUNC(M1/100);
    M1 := MOD(M1,100);
    D3 := TRUNC(M1/50);
    M1 := MOD(M1,50);
    D4 := TRUNC(M1/10);
    M1 := MOD(M1,10);
    DBMS_OUTPUT.PUT_LINE('화폐단위: 오백원 ' || D1 || ', 백원 ' || D2 || ', 오십원 ' || D3 || ', 십원 ' || D4);
END;

ACCEPT INPUT PROMPT '금액 입력';
DECLARE
    --○ 주요 변수 선언 및 초기화
    MONEY   NUMBER := &INPUT;   -- 연산을 위해 담아 둘 변수
    MONEY2  NUMBER := &INPUT;   -- 출력을 위해 담아 둘 변수(연산 과정에서 값이 변하기 때문에)
    M500    NUMBER;             -- 500원 짜리 갯수를 담아둘 변수
    M100    NUMBER;             -- 100원 짜리 갯수를 담아둘 변수
    M50     NUMBER;             -- 50원 짜리 갯수를 담아둘 변수
    M10     NUMBER;             -- 10원 짜리 갯수를 담아둘 변수
BEGIN
    --○ 연산 및 처리
    -- MONEY를 500으로 나눠서 몫을 취하고 나머지는 버린다.    → 500원의 갯수
    M500 := TRUNC(MONEY/500);
    -- MONEY를 500으로 나눠서 몫은 버리고 나머지는 취한다.    → 500원의 갯수를 뺀 나머지 → 다시 MONEY에 담기
    MONEY := MOD(MONEY, 500);
    -- MONEY를 100으로 나눠서 몫을 취하고 나머지는 버린다.    → 100원의 갯수
    M100 := TRUNC(MONEY/100);
    -- MONEY를 100으로 나눠서 몫은 버리고 나머지는 취한다.    → 100원의 갯수를 뺀 나머지 → 다시 MONEY에 담기
    MONEY := MOD(MONEY, 100);
    -- MONEY를  50으로 나눠서 몫을 취하고 나머지는 버린다.    → 50원의 갯수
    M50 := TRUNC(MONEY/50);
    -- MONEY를  50으로 나눠서 몫은 버리고 나머지는 취한다.    → 50원의 갯수를 뺀 나머지 → 다시 MONEY에 담기
    MONEY := MOD(MONEY, 50);
    -- MONEY를  10으로 나눠서 몫을 취하고 나머지는 버린다.    → 10원의 갯수
    M10 := TRUNC(MONEY/10);
    
    --○ 결과 출력
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액: ' || MONEY2 || '원');
    DBMS_OUTPUT.PUT_LINE('화폐 단위: 오백원 ' || M500 || ', 백원 ' || M100 || ', 오십원 ' || M50 || ', 십원 ' || M10);
END;
--==>>
/*
입력받은 금액 총액: 870원
화폐 단위: 오백원 1, 백원 3, 오십원 1, 십원 2


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


























