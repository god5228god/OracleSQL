SELECT USER
FROM DUAL;
--==>> SCOTT

--○ TBL_출고 테이블에서 출고수량을 변경(수정)하는 프로시저를 작성한다.
-- 프로시저명: PRC_출고_UPDATE(출고번호, 변경할수량);
CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
( 
  -- ① 매개변수 구성 
  P_출고번호    IN   TBL_출고.출고번호%TYPE
, P_변경할수량  IN   TBL_출고.출고수량%TYPE
)
IS
    -- ③ 아래의 쿼리문을 수행하기 위해 필요한 변수 추가 선언
    V_상품코드        TBL_상품.상품코드%TYPE;
    
    -- ⑤ 아래의 쿼리문을 수행하기 위해 필요한 변수 추가 선언
    V_기존출고수량    TBL_출고.출고수량%TYPE;
    
    -- ⑧ 아래의 쿼리문을 수행하기 위해 필요한 변수 추가 선언
    V_기존재고수량    TBL_상품.재고수량%TYPE;
    
    -- ⑪ 아래의 쿼리문을 수행하기 위해 필요한 변수 추가 선언 → 사용자 정의 예외
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- 출고수량이 10일 경우 변경을 20으로 하겠다라고한다면
    -- 일단 지금 재고수량에서 10을 더해주고 다시 20을 빼줘야한다
    -- 그 후 출고수량을 20으로 바꿈
    -- 만약 출고수량이 10이고 재고가 10개라는 상황이면
    -- 재고 10 + 10 이후에 10을 빼주면 재고는 0이 되지만
    -- 출고 수량이 30이고 재고가 10이라면
    -- 재고 10 + 10 이후에 30을 빼줘야하는데 마이너스가 되니까 불가능하게 처리해야함
    -- 재고수량+기존출고수량 < 변경할 수량 이 상황이면 예외처리가 되어야함
    
    -- ④ 상품코드 파악 / ⑥ 기존출고수량 파악
    SELECT 상품코드, 출고수량 INTO V_상품코드, V_기존출고수량
    FROM TBL_출고
    WHERE 출고번호 = P_출고번호;
    
    -- ⑨ 출고를 정상적으로 수행해야 하는지의 여부 판단 필요
    --    → 상품코드, 재고수량, 기존출고수량, 변경할수량
    SELECT 재고수량 INTO V_기존재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- ⑩ 파악한 상품코드, 기존재고수량, 기존출고수량, 변경할수량에 따라
    --    데이터 변경 실시 여부 판단
    --    → 『재고수량 + 기존출고수량 < 변경할수량』인 상황이라면 예외 발생
    IF (V_기존재고수량 + V_기존출고수량 < P_변경할수량)  THEN
        -- 예외 발생
        RAISE USER_DEFINE_ERROR;
    END IF;

    -- ② 수행 쿼리문 구성
    -- UPDATE 액션 처리 → TBL_출고
    UPDATE TBL_출고
    SET 출고수량 = P_변경할수량
    WHERE 출고번호 = P_출고번호;
    
    -- UPDATE 액션 처리 → TBL_상품
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_기존출고수량 - P_변경할수량 
    WHERE 상품코드 = V_상품코드;    
    
    -- ⑦ 커밋
    COMMIT;
    
    -- ⑫ 예외처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
             THEN RAISE_APPLICATION_ERROR(-20002,'재고수량이 부족합니다.');
                 ROLLBACK;
        WHEN OTHERS
             THEN ROLLBACK;    
END;
--==>> Procedure PRC_출고_UPDATE이(가) 컴파일되었습니다.



--○ TBL_입고 테이블에서 입고수량을 수정(변경)하는 프로시저를 작성한다.
-- 프로시저명 PRC_입고_UPDATE(입고번호, 변경한입고수량);
-- TBL_상품(상품코드, 상품명, 소비자가격, 재고수량(DEFAULT 0))
-- TBL_입고(입고번호, 상품코드, 입고일자(DEFAULT SYSDATE), 입고수량, 입고단가 )

CREATE OR REPLACE PROCEDURE PRC_입고_UPDATE
( P_입고번호 IN  TBL_입고.입고번호%TYPE
, P_변경입고수량 IN TBL_입고.입고수량%TYPE
)
IS
    V_상품코드    TBL_상품.상품코드%TYPE;
    V_입고수량    TBL_입고.입고수량%TYPE;
    V_재고수량    TBL_상품.재고수량%TYPE;
    
    USER_DEFINE_ERROR  EXCEPTION;
BEGIN
--  기존 입고 수량이 10인데 변경을 20개로 할거임
-- 근데 재고 수량이 10개야 그렇다는거는 기존입고수량에서 출고가 안됐다는 의미니까 가능
-- 기존입고수량이 40개인데 변경을 20개로 할거임
-- 재고수량은 50개라는거는 기존10개에 기존입고 40개를 했다는거니까 변경 가능
-- 기존입고수량이 30개인데 변경을 40개로 하는건? 
-- 재고는 10개임 기존 입고에서 20개가 이미 출고된 상태
-- 입고수량 = 기존입고수량-기존입고수량+변경수량
-- 재고수량 = 기존재고수량 - 기존입고수량 + 변경수량 
-- 재고수량 = 10 - 30 + 40 = 20
-- 이걸 빼는게 불가능한상황까지 고려해야하는가? 
-- 재고수량 = 기존재고수량-기존입고수량+변경수량 < 0 예외발생
-- 기존입고수량 - 변경수량 > 기존 재고수량
-- 30 - 40 > 10
-- 10 - 20 > 10
-- 40 - 10 > 20 
-- 40 -  10 > 20
-- 기존입고수량이 20개고 재고가 0인데 입고를 50개로 변경할거야
-- 
    -- V_상품코드
    SELECT 상품코드, 입고수량 INTO V_상품코드, V_입고수량
    FROM TBL_입고
    WHERE 입고번호 = P_입고번호;
    
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    IF(V_입고수량 - P_변경입고수량 < V_재고수량) THEN
        RAISE  USER_DEFINE_ERROR;       
    END IF;

    -- UPDATE TBL_입고
    UPDATE TBL_입고
    SET 입고수량 = P_변경입고수량
    WHERE 입고번호 = P_입고번호;
    
    -- UPDATE TBL_상품
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_입고수량 + P_변경입고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 커밋
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR THEN 
             RAISE_APPLICATION_ERROR(-20002,'재고수량이 부족합니다.');
             ROLLBACK;
        WHEN OTHERS THEN
             ROLLBACK;
    
END;
--==>> Procedure PRC_입고_UPDATE이(가) 컴파일되었습니다.



--○ TBL_출고 테이블에서 출고내역을 삭제하는 프로시저를 작성한다.
-- 프로시저명 PRC_출고_DELETE(출고번호);
-- TBL_상품(상품코드, 상품명, 소비자가격, 재고수량(DEFAULT 0))
-- TBL_입고(입고번호, 상품코드, 입고일자(DEFAULT SYSDATE), 입고수량, 입고단가 )
-- TBL_출고(출고번호, 상품코드, 출고일자, 출고수량, 출고단가)

CREATE OR REPLACE PROCEDURE PRC_출고_DELETE
(P_출고번호 IN TBL_출고.출고번호%TYPE)
IS
    V_상품코드  TBL_상품.상품코드%TYPE;
    V_출고수량  TBL_출고.출고수량%TYPE;
    V_재고수량  TBL_상품.재고수량%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN

    -- 출고 내역을 취소할거라면
    -- 출고수량이 20이고 재고가 0인 경우
    -- 출고수량이 0으로 바뀌는 상황이고
    -- 그러면 재고가 20으로 늘어남 가능
    -- 출고수량이 10이고 재고가 10인 경우
    -- 출고수량이 0으로 바뀌면서
    -- 재고는 기존재고수량+출고수량이 20으로 늘어남 가능
    -- 무조건 가능한거 아닌가?
    

    SELECT 상품코드, 출고수량 INTO V_상품코드, V_출고수량
    FROM TBL_출고
    WHERE 출고번호 = P_출고번호;
    
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    IF(V_재고수량+V_출고수량 < 0)  THEN
        RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    
    -- UPDATE TBL_상품
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    -- DELETE TBL_출고
    DELETE 
    FROM TBL_출고
    WHERE 출고번호 = P_출고번호;

    -- 커밋
   COMMIT;

    -- 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003, '삭제불가');
            ROLLBACK;
        WHEN OTHERS THEN    
            ROLLBACK;
END;
--==>> Procedure PRC_출고_DELETE이(가) 컴파일되었습니다.



--○ TBL_입고 테이블에서 입고내역을 삭제하는 프로시저를 작성한다.
-- 프로시저명 PRC_입고_DELETE(입고번호);
-- TBL_상품(상품코드PK, 상품명, 소비자가격, 재고수량(DEFAULT 0))
-- TBL_입고(입고번호PK, 상품코드FK, 입고일자(DEFAULT SYSDATE), 입고수량, 입고단가 )
-- TBL_출고(출고번호PK, 상품코드FK, 출고일자, 출고수량, 출고단가)
CREATE OR REPLACE PROCEDURE PRC_입고_DELETE
( P_입고번호 IN TBL_입고.입고번호%TYPE)
IS
    V_상품코드  TBL_상품.상품코드%TYPE;
    V_입고수량  TBL_입고.입고수량%TYPE;
    V_재고수량  TBL_상품.재고수량%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- 입고를 취소하는 상황
    -- 기존 입고수량은 30개, 재고수량은 10개라면
    -- 입고를 취소하는 상황에서는 기존 입고수량은 0이 되는거나 마찬가지고
    -- 재고수량에서 기존 입고수량을 빼야하는데 10 - 30 은 음수임으로 불가능
    -- 재고수량은 적어도 기존 입고수량보단 커야 삭제가 가능함
    -- 입고 내역 전체를 삭제하는 거니깐...
    
    SELECT 상품코드, 입고수량 INTO V_상품코드, V_입고수량
    FROM TBL_입고
    WHERE 입고번호 = P_입고번호;
    
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    IF(V_입고수량 > V_재고수량) THEN
        RAISE USER_DEFINE_ERROR;
    END IF;
    
        
    -- UPDATE TBL_상품
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    -- DELETE TBL_입고
    DELETE 
    FROM TBL_입고
    WHERE 입고번호 = P_입고번호;

    
    -- 커밋
   COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20002, '재고 부족');
            ROLLBACK;
        WHEN OTHERS THEN
            ROLLBACK;
END;
--==>> Procedure PRC_입고_DELETE이(가) 컴파일되었습니다.















