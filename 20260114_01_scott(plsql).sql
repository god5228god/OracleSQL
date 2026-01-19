SELECT USER
FROM DUAL;
--==>> SCOTT

SET SERVEROUTPUT ON;
--==>> 작업이 완료되었습니다.(0.048초)


--○ 기본 반복문
-- LOOP ~ END LOOP;

-- 1. 조건과 상관없이 무조건 반복하는 구문.

-- 2. 형식 및 구조
LOOP
    -- 실행문;
    EXIT WHEN 조건;       -- 조건이 참(TRUE)인 경우 반복문을 빠져나간다.
END LOOP;


--○ 1부터 10까지의 수 출력(LOOP 문 활용)
DECLARE
    -- 선언부
    -- → 실행부에서 참조할 모든 변수, 상수, 커서, EXCEPTION 등을 선언
    N   NUMBER;
BEGIN
    -- 실행부
    -- → 데이터베이스의 데이터를 처리할 SQL문과 PL/SQL 블럭을 기술
    N := 1;
    
    LOOP 
        DBMS_OUTPUT.PUT_LINE(N);
        EXIT WHEN N >=10;
        N := N + 1;                 -- N++;  N+=1;
    END LOOP;
    
    -- [EXCEPTION]
    -- → 실행부에서 예외가 발생하게 되었을 때 수행될 문장을 기술
END;-- PL/SQL 블럭의 끝
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/



--○ WHILE 반복문
-- WHILE LOOP ~ END LOOP;

-- 1. 제어 조건이 참(TRUE)인 동안 일련의 문장을 반복하기 위해
--    WHILE LOOP 문장을 사용한다.
--    조건은 반복이 시작될 때 체크하게 되어
--    LOOP 내의 문장이 한 번도 수행되지 않을 경우도 있다.
--    LOOP 시작할 때 조건이 거짓(FALSE)이면 반복 문장을 탈출하게 된다.

-- 2. 형식 및 구조
WHILE 조건 LOOP       -- 조건이 참(TRUE)인 경우 반복 수행
    -- 실행문;
END LOOP;


--○ 1부터 10까지의 수 출력(WHILE LOOP 문 활용)
DECLARE
    N   NUMBER;
BEGIN
    N := 0;
    
    WHILE N<10 LOOP
        N := N + 1;
        DBMS_OUTPUT.PUT_LINE(N);    -- 1 ~ 10
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/



--○ FOR 반복문
-- FOR LOOP ~ END LOOP;

-- 1. 『시작 수』에서 1씩 증가하여
--    『끝냄 수』가 될 때 까지 반복 수행한다.

-- 2. 형식 및 구조
FOR 카운터 IN [REVERSE] 시작수 .. 끝냄수 LOOP
    -- 실행문;
END LOOP;


--○ 1부터 10까지의 수 출력(FOR LOOP 문 활용)
DECLARE
    N   NUMBER;     -- 별도로 선언하지 않아도 FOR에서 쓸 수 있다. 하지만 여기서 선언한건 FOR 밖에서도 사용가능함
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/



--○ 사용자로부터 임의의 단(구구단)을 입력받아
--   해당 단수의 구구단을 출력하는 PL/SQL 구문을 작성한다.
--   LOOP, WHILE LOOP, FOR LOOP를 통해 해결한다.

-- LOOP 사용
ACCEPT NUM PROMPT '단 입력';

DECLARE
    N1 NUMBER := & NUM;
    N2 NUMBER := 1;
    NRESULT NUMBER := 0; 
BEGIN
    LOOP
        NRESULT := N1 * N2;
        DBMS_OUTPUT.PUT_LINE(N1 ||' * ' || N2 || ' = ' || NRESULT);
        EXIT WHEN N2 >= 9 ;
        N2 := N2 + 1;
    END LOOP;
END;
--==>>
/*
6 * 1 = 6
6 * 2 = 12
6 * 3 = 18
6 * 4 = 24
6 * 5 = 30
6 * 6 = 36
6 * 7 = 42
6 * 8 = 48
6 * 9 = 54


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


-- WHILE LOOP 사용
ACCEPT NUM PROMPT '단 입력';

DECLARE
    N1 NUMBER := &NUM;
    N2 NUMBER := 0;
    NRESULT NUMBER := 0;
BEGIN
    WHILE N2<9 LOOP
        N2 := N2 + 1;
        NRESULT := N1 * N2;
        DBMS_OUTPUT.PUT_LINE(N1 ||' * ' || N2 || ' = ' || NRESULT);
    END LOOP;

END;
--==>>
/*
7 * 1 = 7
7 * 2 = 14
7 * 3 = 21
7 * 4 = 28
7 * 5 = 35
7 * 6 = 42
7 * 7 = 49
7 * 8 = 56
7 * 9 = 63


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


-- FOR LOOP 사용
ACCEPT NUM PROMPT '단 입력';

DECLARE
    N1 NUMBER := &NUM;
    NRESULT NUMBER := 0;
BEGIN
    FOR N2 IN 1 .. 9 LOOP
        NRESULT := N1 * N2;
        DBMS_OUTPUT.PUT_LINE(N1 ||' * ' || N2 || ' = ' || NRESULT);
    END LOOP;
END;
--==>>
/*
8 * 1 = 8
8 * 2 = 16
8 * 3 = 24
8 * 4 = 32
8 * 5 = 40
8 * 6 = 48
8 * 7 = 56
8 * 8 = 64
8 * 9 = 72


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- FOR REVERSE


ACCEPT NUM PROMPT '단 입력';

DECLARE
    N1 NUMBER := &NUM;
    NRESULT NUMBER := 0;
BEGIN
    FOR N2 IN 9 .. 1 LOOP
        NRESULT := N1 * N2;
        DBMS_OUTPUT.PUT_LINE(N1 ||' * ' || N2 || ' = ' || NRESULT);
    END LOOP;
END;
--==>> 출력 결과 없음


ACCEPT NUM PROMPT '단 입력';

DECLARE
    N1 NUMBER := &NUM;
    NRESULT NUMBER := 0;
BEGIN
    FOR N2 IN REVERSE 9 .. 1 LOOP
        NRESULT := N1 * N2;
        DBMS_OUTPUT.PUT_LINE(N1 ||' * ' || N2 || ' = ' || NRESULT);
    END LOOP;
END;
--==>> 출력 결과 없음


ACCEPT NUM PROMPT '단 입력';

DECLARE
    N1 NUMBER := &NUM;
    NRESULT NUMBER := 0;
BEGIN
    FOR N2 IN REVERSE 1 .. 9 LOOP
        NRESULT := N1 * N2;
        DBMS_OUTPUT.PUT_LINE(N1 ||' * ' || N2 || ' = ' || NRESULT);
    END LOOP;
END;
--==>>
/*
5 * 9 = 45
5 * 8 = 40
5 * 7 = 35
5 * 6 = 30
5 * 5 = 25
5 * 4 = 20
5 * 3 = 15
5 * 2 = 10
5 * 1 = 5


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/
--> 『REVERSE』: 『끝냄수』에서 『시작수』까지 반복하며 인덱스가 1씩 감소되도록 처리




















