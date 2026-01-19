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


