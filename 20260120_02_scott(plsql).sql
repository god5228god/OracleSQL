SELECT USER
FROM DUAL;
--==>> SCOTT

--○ TRIGGER(트리거) 생성
-- 트리거명: TRG_SCORE_INSERT
-- 트리거 기능: INSERT 액션 처리 행 트리거(AFTER)
-- SCORE1 테이블에 데이터 입력시
-- SCORE2 테이블(총점, 평균)에 데이터 입력
CREATE OR REPLACE TRIGGER TRG_SCORE_INSERT
    AFTER               -- AFTER TRIGGER
    INSERT ON SCORE1    
    FOR EACH ROW        -- ROW TRIGGER
DECLARE 
    V_TOT   NUMBER(3);
    V_AVG   NUMBER(5, 1);
BEGIN

    V_TOT := :NEW.KOR + :NEW.ENG + :NEW.MAT;    -- 『:NEW』 → 새로 추가되는 레코드
    V_AVG := V_TOT/3;

    INSERT INTO SCORE2(HAK, TOT, AVG)
    VALUES(:NEW.HAK, V_TOT, V_AVG);
END;
--==>> Trigger TRG_SCORE_INSERT이(가) 컴파일되었습니다.


--○ 함수 정의
-- 함수명: FN_GRADE()
-- 함수 기능 : 과목 점수를 통해 환산 점수를 산출하는 함수
--  - 95 이상: 4.5
--  - 90 이상 95 미만: 4.0
--  - 85 이상 90 미만: 3.5
--  - 80 이상 85 미만: 3.0
--  - 75 이상 80 미만: 2.5
--  - 70 이상 75 미만: 2.0
--  - 65 이상 70 미만: 1.5
--  - 60 이상 65 미만: 1.0
--  - 60 미만        :   0

CREATE OR REPLACE FUNCTION FN_GRADE
( P_SCORE   NUMBER
)
RETURN NUMBER
IS
    V_RESULT    NUMBER(5, 1);
BEGIN
    IF (P_SCORE >= 95) THEN
        V_RESULT := 4.5;
    ELSIF (P_SCORE >= 90) THEN
        V_RESULT := 4.0;
    ELSIF (P_SCORE >= 85) THEN
        V_RESULT := 3.5;
    ELSIF (P_SCORE >= 80) THEN
        V_RESULT := 3.0;
    ELSIF (P_SCORE >= 75) THEN
        V_RESULT := 2.5;
    ELSIF (P_SCORE >= 70) THEN
        V_RESULT := 2.0;
    ELSIF (P_SCORE >= 65) THEN
        V_RESULT := 1.5;
    ELSIF (P_SCORE >= 60) THEN
        V_RESULT := 1.0;
    ELSE
        V_RESULT := 0.0;
    END IF;
    
    RETURN V_RESULT;
END;
--==>> Function FN_GRADE이(가) 컴파일되었습니다.


--○ TRIGGER(트리거) 수정
-- 트리거명: TRG_SCORE_INSERT
-- SCORE1 테이블에 데이터 입력시
-- SCORE2 테이블(총점, 평균)과 SCORE3 테이블(환산점수)에 데이터 입력
CREATE OR REPLACE TRIGGER TRG_SCORE_INSERT
    AFTER
    INSERT ON SCORE1
    FOR EACH ROW
DECLARE
    V_TOT   NUMBER(3);
    V_AVG   NUMBER(5, 1);
BEGIN
    V_TOT := :NEW.KOR + :NEW.ENG + :NEW.MAT;
    V_AVG := V_TOT/3;
    
    INSERT INTO SCORE2(HAK, TOT, AVG)
    VALUES(:NEW.HAK, V_TOT, V_AVG);
    
    INSERT INTO SCORE3(HAK, KOR, ENG, MAT)
    VALUES(:NEW.HAK, FN_GRADE(:NEW.KOR), FN_GRADE(:NEW.ENG), FN_GRADE(:NEW.MAT));
END;
--==>> Trigger TRG_SCORE_INSERT이(가) 컴파일되었습니다.



--○ TRIGGER(트리거) 생성
-- 트리거명: TRG_SCORE_UPDATE
-- SCORE1 테이블에 데이터 수정 시
-- SCORE2 테이블(총점, 평균)과 SCORE3 테이블(환산점수)에 데이터 수정
CREATE OR REPLACE TRIGGER TRG_SCORE_UPDATE
    AFTER
    UPDATE ON SCORE1
    FOR EACH ROW
DECLARE
    V_TOT   NUMBER(3);
    V_AVG   NUMBER(5, 1);
BEGIN

    V_TOT := :NEW.KOR + :NEW.ENG + :NEW.MAT;
    V_AVG := V_TOT/3;

    UPDATE SCORE2
    SET TOT = V_TOT, AVG = V_AVG
    WHERE HAK = :NEW.HAK;
    
    UPDATE SCORE3
    SET KOR = FN_GRADE(:NEW.KOR), ENG = FN_GRADE(:NEW.ENG), MAT = FN_GRADE(:NEW.MAT)
    WHERE HAK = :NEW.HAK;
END;
--==>> Trigger TRG_SCORE_UPDATE이(가) 컴파일되었습니다.


--○ TRIGGER(트리거) 생성
-- 트리거명: TRG_SCORE_DELETE
-- SCORE1 테이블에 데이터 삭제 시
-- SCORE2 테이블(총점, 평균)과 SCORE3 테이블(환산점수)에 데이터도 함께 삭제
CREATE OR REPLACE TRIGGER TRG_SCORE_DELETE
    BEFORE
    DELETE ON SCORE1
    FOR EACH ROW
DECLARE
BEGIN
    DELETE
    FROM SCORE2
    WHERE HAK = :OLD.HAK;
    
    DELETE
    FROM SCORE3
    WHERE HAK = :OLD.HAK;
END;
--==>> Trigger TRG_SCORE_DELETE이(가) 컴파일되었습니다.

/*
CREATE OR REPLACE TRIGGER TRG_SCORE_INUP
    AFTER
    INSERT OR UPDATE ON SCORE1
    FOR EACH ROW
DECLARE
    V_TOT   NUMBER(3);
    V_AVG   NUMBER(5, 1);
BEGIN
    IF (INSERTING) THEN
    ELSIF (UPDATING) THEN
    END IF;
END;
*/



-- ■■■ PACKAGE(패키지) ■■■ --

--○ 개요
-- - PL/SQL의 패키지는 관계되는 타입, 프로그램 객체,
--   서브 프로그램(PROCEDURE, FUNCTION 등)을
--   논리적으로 묶어놓은 것으로
--   오라클에서 제공하는 패키지 중 하나가 바로 『DBMS_OUTPUT』이다.
-- - 패캐지는 서로 유사한 업무에 사용되는 여러 개의 프로시저와 함수를
--   하나의 패키지로 만들어 관리함으로써 향후 유지보수가 편리하고
--   전체 프로그램을 모듈화할 수 있는 장점이 있다.
-- - 패키지는 명세부(PACKAGE SPECIFICATION)와
--   몸체부(PACKAGE BODY)로 구성되어 있으며
--   명세 부분에는 TYPE, CONSTRAINT, VARIABLE, EXCEPTION
--   , CURSOR, SUBPROGRAM 등이 선언되고
--   몸체 부분에는 이들의 실제 내용이 존재하게 된다.
--   그리고 호출할 때는 패키지명.프로시저명 형식의 참조를 이용해야 한다.

--○ 형식 및 구조(명세부)
CREATE [OR REPLACE] PACKAGE 패키지명
IS
    전역변수 선언;
    커서 선언;
    예외 선언;
    함수 선언;
    프로시저 선언;
         :
END 패키지명;

--○ 형식 및 구조(몸체부)
CREATE [OR REPLACE] PACKAGE BODY 패키지명
IS
    FUNCTION 함수명[(인수,...)]
    RETURN 자료형
    IS
        변수 선언;
    BEGIN
        함수 몸체 구성코드;
        RETURN 값;
    END;
    
    PROCEDURE 프로시저명[(인수,...)]
    IS
        [변수 선언;]
    BEGIN
        프로시저 몸체 구성코드;
    END;
    
END 패키지명;




--○ 함수 준비(함수 독립적으로 정의)
-- 함수명: FN_GENDER()
-- 『771212-1022432』와 같은 주민번호 형식으로
-- 성별을 반환하는 형태의 함수 
CREATE OR REPLACE FUNCTION FN_GENDER
( P_SSN VARCHAR2
)
RETURN VARCHAR2
IS
    V_RESULT    VARCHAR2(20);
BEGIN
    IF(SUBSTR(P_SSN, 8, 1) IN ('1', '3')) THEN
        V_RESULT := '남자';
    ELSIF (SUBSTR(P_SSN, 8, 1) IN ('2', '4')) THEN
        V_RESULT := '여자';  
    ELSE
        V_RESULT := '성별확인불가';
    END IF;
    
    RETURN V_RESULT;
END;
--==>> Function FN_GENDER이(가) 컴파일되었습니다.


--○ 패키지 등록

-- 1. 명세부 작성
CREATE OR REPLACE PACKAGE PACK_INSA
IS
    FUNCTION FN_GENDER(P_SSN VARCHAR2)
    RETURN VARCHAR2;
    
END PACK_INSA;
--==>> Package PACK_INSA이(가) 컴파일되었습니다.


-- 2. 몸체부 작성
CREATE OR REPLACE PACKAGE BODY PACK_INSA
IS
    
    FUNCTION FN_GENDER(P_SSN VARCHAR2)
    RETURN VARCHAR2
    IS
        V_RESULT    VARCHAR2(20);
    BEGIN
        IF(SUBSTR(P_SSN, 8, 1) IN ('1', '3')) THEN
            V_RESULT := '남자';
        ELSIF (SUBSTR(P_SSN, 8, 1) IN ('2', '4')) THEN
            V_RESULT := '여자';  
        ELSE
            V_RESULT := '성별확인불가';
        END IF;
        
        RETURN V_RESULT;
    END;
    
END PACK_INSA;


SET SERVEROUTPUT ON;


--○ PACK_INSA 패키지 재구성
--   1. FN_GENDER()
--   2. PRC_INSA_LIST(사원번호)
--      → 사원명, 주민번호, 성별 항목으로 스크립트 출력
-- ex) 홍길동    771212-1022432     남자

-- 패키지 명세
CREATE OR REPLACE PACKAGE PACK_INSA
IS
    FUNCTION FN_GENDER(P_SSN VARCHAR2)
    RETURN VARCHAR2;
    PROCEDURE PRC_INSA_LIST(P_NUM IN NUMBER);
    
END PACK_INSA;
--==>> Package PACK_INSA이(가) 컴파일되었습니다.

-- 패키지 몸체
CREATE OR REPLACE PACKAGE BODY PACK_INSA
IS
    FUNCTION FN_GENDER(P_SSN VARCHAR2) 
    RETURN VARCHAR2
    IS
        V_RESULT   VARCHAR2(20);
    BEGIN
        IF(SUBSTR(P_SSN,8,1) IN ('1','3')) THEN
            V_RESULT := '남자';
        ELSIF(SUBSTR(P_SSN,8,1) IN ('2', '4')) THEN
            V_RESULT := '여자';
        ELSE
            V_RESULT := '성별확인불가';
        END IF;
        
        RETURN V_RESULT;
    END;
    
    PROCEDURE PRC_INSA_LIST
    (P_NUM IN NUMBER
    )
    IS
        V_NAME      TBL_INSA.NAME%TYPE;
        V_SSN       TBL_INSA.SSN%TYPE;
        V_GENDER    VARCHAR2(20);
    BEGIN
        SELECT NAME, SSN, FN_GENDER(SSN) INTO V_NAME, V_SSN, V_GENDER
        FROM TBL_INSA
        WHERE NUM = P_NUM;
        
        DBMS_OUTPUT.PUT_LINE(V_NAME || '   ' || V_SSN||'   ' || V_GENDER);
        
    END;
END PACK_INSA;


--※ 오버로딩
CREATE OR REPLACE PACKAGE PACK_INSA
IS
    FUNCTION FN_GENDER(P_SSN VARCHAR2)
    RETURN VARCHAR2;
    PROCEDURE PRC_INSA_LIST(P_NUM IN NUMBER);
    PROCEDURE PRC_INSA_LIST(P_NAME IN VARCHAR2);
END PACK_INSA;
--==>> Package PACK_INSA이(가) 컴파일되었습니다.

CREATE OR REPLACE PACKAGE BODY PACK_INSA
IS
    FUNCTION FN_GENDER(P_SSN VARCHAR2) 
    RETURN VARCHAR2
    IS
        V_RESULT   VARCHAR2(20);
    BEGIN
        IF(SUBSTR(P_SSN,8,1) IN ('1','3')) THEN
            V_RESULT := '남자';
        ELSIF(SUBSTR(P_SSN,8,1) IN ('2', '4')) THEN
            V_RESULT := '여자';
        ELSE
            V_RESULT := '성별확인불가';
        END IF;
        
        RETURN V_RESULT;
    END;
    
    PROCEDURE PRC_INSA_LIST
    (P_NUM IN NUMBER
    )
    IS
        V_NAME      TBL_INSA.NAME%TYPE;
        V_SSN       TBL_INSA.SSN%TYPE;
        V_GENDER    VARCHAR2(20);
    BEGIN
        SELECT NAME, SSN, FN_GENDER(SSN) GENDER INTO V_NAME, V_SSN, V_GENDER
        FROM TBL_INSA
        WHERE NUM = P_NUM;
        
        DBMS_OUTPUT.PUT_LINE(V_NAME || '   ' || V_SSN||'   ' || V_GENDER);
        
    END;
    
    PROCEDURE PRC_INSA_LIST
    (P_NAME IN VARCHAR2
    )
    IS
        CURSOR CUR_INSA
        IS
        SELECT NAME, SSN, FN_GENDER(SSN) GENDER
        FROM TBL_INSA
        WHERE NAME LIKE '%'|| P_NAME || '%';
    BEGIN        
        FOR REC IN CUR_INSA LOOP
            DBMS_OUTPUT.PUT_LINE(REC.NAME || '   ' || REC.SSN||'   ' || REC.GENDER);
        END LOOP;
    END;
    
END PACK_INSA;
--==>> Package Body PACK_INSA이(가) 컴파일되었습니다.


















