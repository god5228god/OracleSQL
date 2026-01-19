SELECT USER
FROM DUAL;
--==>> SCOTT

--※ 실습 테이블 생성
-- 『20260115_01_scott』에서 생성한 『TBL_SUNGJUK』테이블


--○ 데이터 입력 시 특정 항목의 데이터만 입력하면
--   내부적으로 다른 항목이 함께 입력 처리될 수 있는 프로시저 생성
-- 프로시저명: PRC_SUNGJUK_INSERT
/*
실행 예)
EXEC PRC_SUNGJUK_INSERT(2511570, '조세빈', 90, 80, 70);

→ 프로시저 호출로 처리된 결과
학번      이름  국어점수    영어점수    수학점수    총점  평균  등급
2511570 조세빈     90           80         70        240    80    B
*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( P_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, P_NAME    IN TBL_SUNGJUK.NAME%TYPE
, P_KOR     IN TBL_SUNGJUK.KOR%TYPE
, P_ENG     IN TBL_SUNGJUK.ENG%TYPE
, P_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    -- INSERT 쿼리문을 수행하는 데 필요한 주요 변수 선언
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- 아래의 쿼리문을 수행하기 위해서는
    -- 위에서 선언한 변수들에 값을 담아내야 한다.(→ V_TOT, V_AVG, V_GRADE)
    V_TOT := P_KOR + P_ENG + P_MAT;  --  총점 계산
    V_AVG := V_TOT / 3;              -- 평균 계산
    -- 등급 계산
    CASE
        WHEN V_AVG >=90 AND V_AVG <=100
        THEN V_GRADE := 'A';
        WHEN V_AVG >=80
        THEN V_GRADE := 'B';
        WHEN V_AVG >=70
        THEN V_GRADE := 'C';
        WHEN V_AVG >=60
        THEN V_GRADE := 'D';
        ELSE V_GRADE := 'F';
    END CASE;
    
    -- TBL_SUNGJUK 테이블에 데이터 삽입
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(P_HAKBUN, P_NAME, P_KOR, P_ENG, P_MAT, V_TOT, V_AVG, V_GRADE);
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_INSERT이(가) 컴파일되었습니다.


--○ TBL_SUNGJUK 테이블에서
--   특정 학생의 점수(학번, 국어점수, 영어점수, 수학점수)
--   데이터 수정 시 총점, 평균, 등급까지 수정하는 프로시저를 작성한다.
-- 프로시저명: PRC_SUNGJUK_UPDATE
/*
실행 예)
EXEC PRC_SUNGJUK_UPDATE(2511325,50,50,50);

→ 프로시저 호출로 처리된 결과
학번      이름  국어점수  영어점수  수학점수  총점  평균  등급
2511570 조세빈   90         80         70      240   80      B
2511325 정세찬   50         50         50      150   50      F

*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( P_HAKBUN IN  TBL_SUNGJUK.HAKBUN%TYPE
, P_KOR    IN  TBL_SUNGJUK.KOR%TYPE
, P_ENG    IN  TBL_SUNGJUK.ENG%TYPE
, P_MAT    IN  TBL_SUNGJUK.MAT%TYPE
)
IS
    -- UPDATE 쿼리문을 수행하는 데 필요한 주요 변수 선언
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- 아래의 쿼리문을 수행하기 위해서는
    -- 위에서 선언한 변수들에 값을 담아내야 한다.(→ V_TOT, V_AVG, V_GRADE)
    
    V_TOT := P_KOR + P_ENG + P_MAT;  
    V_AVG := V_TOT / 3;              
    CASE
        WHEN V_AVG >=90 AND V_AVG <=100
        THEN V_GRADE := 'A';
        WHEN V_AVG >=80
        THEN V_GRADE := 'B';
        WHEN V_AVG >=70
        THEN V_GRADE := 'C';
        WHEN V_AVG >=60
        THEN V_GRADE := 'D';
        ELSE V_GRADE := 'F';
    END CASE;
    
    -- UPDATE 쿼리문 구성(→ TBL_SUNGJUK)
    UPDATE TBL_SUNGJUK
    SET KOR = P_KOR, ENG = P_ENG, MAT = P_MAT, TOT = V_TOT, AVG = V_AVG, GRADE = V_GRADE
    WHERE HAKBUN = P_HAKBUN;
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_UPDATE이(가) 컴파일되었습니다.



--○ TBL_STUDENTS 테이블에서
--   전화번호와 주소 데이터를 수정하는(변경하는) 프로시저를 작성한다.
--   단, ID와 PW가 일치하는 경우에만 수정을 진행할 수 있도록 처리한다.
-- 프로시저명: PRC_STUDENTS_UPDATE
/*
실행 예)
EXEC PRC_STUDENTS_UPDATE('superman','java000','010-1212-3434', '인천 서구');

→ 프로시저 호출 결과
ID         NAME                                     TEL                  ADDR                                                                                                
---------- ---------------------------------------- -------------------- ------------------
superman   윤주열                                   010-1111-1111        제주도 서귀포시                                                                                     
batman     정세찬                                   010-2222-2222        서울 마포구                   

EXEC PRC_STUDENTS_UPDATE('superman','java004$','010-1212-3434', '인천 서구');
ID         NAME                                     TEL                  ADDR                                                                                                
---------- ---------------------------------------- -------------------- -----------------
superman   윤주열                                   010-1212-3434        인천 서구                                                                                     
batman     정세찬                                   010-2222-2222        서울 마포구                   

*/

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( P_ID      IN  TBL_IDPW.ID%TYPE
, P_PW      IN  TBL_IDPW.PW%TYPE
, P_TEL     IN  TBL_STUDENTS.TEL%TYPE
, P_ADDR    IN  TBL_STUDENTS.ADDR%TYPE
)
IS
    V_PW    TBL_IDPW.PW%TYPE; 
BEGIN
    SELECT PW INTO V_PW
    FROM TBL_IDPW
    WHERE ID = P_ID;
            
    IF(P_PW = V_PW)
        THEN
            UPDATE TBL_STUDENTS
            SET TEL = P_TEL, ADDR = P_ADDR
            WHERE ID = P_ID;
    ELSE 
        NULL; 
    END IF;
    
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.

-- 모범 풀이

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( P_ID      IN  TBL_IDPW.ID%TYPE
, P_PW      IN  TBL_IDPW.PW%TYPE
, P_TEL     IN  TBL_STUDENTS.TEL%TYPE
, P_ADDR    IN  TBL_STUDENTS.ADDR%TYPE
)
IS
    V_PW    TBL_IDPW.PW%TYPE; 
BEGIN
    -- UPDATE 쿼리문 구성
    UPDATE (SELECT I.ID, I.PW, S.TEL, S.ADDR
            FROM TBL_STUDENTS S JOIN TBL_IDPW I
            ON  S.ID = I.ID) T
    SET T.TEL = P_TEL, T.ADDR = P_ADDR
    WHERE T.ID = P_ID AND T.PW = P_PW;
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.


DESC TBL_INSABACKUP;
--==>>
/*
이름       널?       유형           
-------- -------- ------------ 
NUM      NOT NULL NUMBER(5)    
NAME     NOT NULL VARCHAR2(20) 
SSN      NOT NULL VARCHAR2(14) 
IBSADATE NOT NULL DATE         
CITY              VARCHAR2(10) 
TEL               VARCHAR2(15) 
BUSEO    NOT NULL VARCHAR2(15) 
JIKWI    NOT NULL VARCHAR2(15) 
BASICPAY NOT NULL NUMBER(10)   
SUDANG   NOT NULL NUMBER(10)   
*/

SELECT *
FROM TAB;

--○ TBL_INSABACKUP 테이블을 대상으로 신규 데이터 입력 프로시저를 작성한다.
-- NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
-- 구조를 갖고 잇는 대상 테이블에 대해
-- 데이터 입력 시 NUM 항목(사원 번호)의 값은 
-- 기존 부여된 사원번호 마지막 번호의 그 다음 번호를 
-- 자동으로 입력 처리 할 수 있는 프로시저로 구성한다.
-- 프로시저명: PRC_INSA_INSERT
/*
실행 예)

EXEC PRC_INSA_INSERT('임유원','910905-2234567', SYSDATE, '서울', ' 010-5555-6666'
                   , '영업부', '대리', 50000000,1000000);
→ 프로시저 호출로 처리된 결과
1061 임유원 910905-22234567 2026-01-15 서울 010-5555-6666 영업부 대리 5000000 1000000
*/

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( P_NAME        TBL_INSABACKUP.NAME%TYPE
, P_SSN         TBL_INSABACKUP.SSN%TYPE
, P_IBSADATE    TBL_INSABACKUP.IBSADATE%TYPE
, P_CITY        TBL_INSABACKUP.CITY%TYPE
, P_TEL         TBL_INSABACKUP.TEL%TYPE
, P_BUSEO       TBL_INSABACKUP.BUSEO%TYPE
, P_JIKWI       TBL_INSABACKUP.JIKWI%TYPE
, P_BASICPAY    TBL_INSABACKUP.BASICPAY%TYPE
, P_SUDANG      TBL_INSABACKUP.SUDANG%TYPE
)
IS
    -- INSERT 쿼리문 수행에 필요한 변수 추가 선언
    V_NUM   TBL_INSABACKUP.NUM%TYPE;
BEGIN 
    -- 아래 쿼리문을 수행하기 위해
    -- 위에서 선언한 변수에 값 담아내기
    SELECT MAX(NUM) + 1 INTO V_NUM
    FROM TBL_INSABACKUP;

    INSERT INTO TBL_INSABACKUP(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(V_NUM, P_NAME, P_SSN, P_IBSADATE, P_CITY, P_TEL, P_BUSEO, P_JIKWI, P_BASICPAY, P_SUDANG);
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_INSA_INSERT이(가) 컴파일되었습니다.





--※ 실습 테이블 생성
-- 『20260115_01_scott』에서 생성한 『TBL_상품』테이블
-- 『20260115_01_scott』에서 생성한 『TBL_입고』테이블


--○ TBL_상품, TBL_입고 테이블을 대상으로
--   TBL_입고 테이블에 데이터 입력 시(즉, 입고 이벤트 발생 시)
--   TBL_상품 테이블 해당 상품의 재고수량이 함께 변동될 수 있는 기능을 가진
--   프로시저를 작성한다.
--   단, 이 과정에서 입고번호는 자동 증가 처리한다.(→ 시퀀스는 사용하지 않는다.)
--   TBL_입고 테이블 구성 컬럼인 입고번호, 상품코드, 입고일자, 입고수량, 입고단가 중
--   상품코드, 입고수량, 입고단가만 프로시저 파라미터로 전달
-- 프로시저명: PRC_입고_INSERT(상품코드, 입고수량, 입고단가)

--※ TBL_입고 테이블에 입고 이벤트 발생 시
-- 관련 테이블에서 수행되어야 하는 내용
-- ① INSERT 액션 처리 → TBL_입고
INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(1, 'H001', SYSDATE, 20, 1000);
-- ② UPDATE 액션 처리 → TBL_상품
UPDATE TBL_상품
SET 재고수량 = 기존재고수량 + 20(← 입고수량)
WHERE 상품코드 = 'H001';


-- 입고테이블(입고번호  상품코드 입고일자 입고수량 입고단가)
-- 상품테이블(상품코드 상품명 소비자가격  재고수량)

CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( P_상품코드  IN  TBL_상품.상품코드%TYPE
, P_입고수량  IN  TBL_입고.입고수량%TYPE
, P_입고단가  IN  TBL_입고.입고단가%TYPE
)
IS
    -- 아래의 쿼리문을 수행하는 데 필요한 주요 변수 선언
    V_입고번호  TBL_입고.입고번호%TYPE;
BEGIN
    -- 선언한 변수(→ V_입고번호)에 값 담아내기
    SELECT NVL(MAX(입고번호),0) +1 INTO V_입고번호
    FROM TBL_입고; 

    INSERT INTO TBL_입고(입고번호, 상품코드, 입고수량, 입고단가)
    VALUES(V_입고번호, P_상품코드, P_입고수량, P_입고단가);
    
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + P_입고수량
    WHERE 상품코드 = P_상품코드;
    
    COMMIT;
END;
--==>> Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.


-- ■■■ 프로시저 내에서의 예외 처리 ■■■ --

--※ 실습 테이블 생성
-- 『20260115_01_scott』에서 생성한 『TBL_MEMBER』테이블

--○ TBL_MEMBER 테이블에서 데이터를 입력하는 프로시저를 생성
--   단, 이 프로시저를 통해 데이터를 입력할 경우
--   CITY(→ 지역) 항목에 '서울','경기','인천'만 입력이 가능하도록 구성한다.
--   이 지역 이외의 다른 지역을 프로시저 호출을 통해 입력하려는 경우
--   예외 처리를 하려고 한다.
-- 프로시저명: PRC_MEMBER_INSERT(이름, 전화번호, 지역);
CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( P_NAME IN  TBL_MEMBER.NAME%TYPE
, P_TEL  IN  TBL_MEMBER.TEL%TYPE
, P_CITY IN  TBL_MEMBER.CITY%TYPE
)
IS
    -- 실행 영역의 쿼리문 수행을 위해 필요한 변수 추가 선언
    V_NUM   TBL_MEMBER.NUM%TYPE;
    
    -- 사용자 정의 예외에 대한 변수 선언 CHECK
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- 프로시저를 통해 입력 액션 처리를 수행하기 전에
    -- 정상적으로 진행해야 할 데이터인지 아닌지의 여부를
    -- 가장 먼저 확인할 수 있도록 해당 위치에 코드 구성
    IF (P_CITY NOT IN ('서울','경기','인천')) THEN -- P_CITY에 '서울','경기','인천' 중 하나가 들어있지 않다면
        -- 예외 발생 CHECK → 『RAISE』
        RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    
    -- 추가로 선언한 변수(→V_NUM)에 값 담아내기
    SELECT NVL(MAX(NUM), 0 ) INTO V_NUM
    FROM TBL_MEMBER;
    
    -- INSERT 액션 처리(→ TBL_MEMBER)
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES(( V_NUM + 1), P_NAME, P_TEL, P_CITY);
    
    -- 커밋
    COMMIT;
    
    -- 예외 처리
    /*
    EXCEPTION 
        WHEN 이런 예외 상황이면
            THEN 이렇게 처리하고
        WHEN 저런 예외 상황이면
            THEN 저렇게 처리해라
    */
    /*
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-에러코드, 에러내용기술);
        WHEN 저런 예외 상황이면
            THEN 저렇게 처리해라
                        ↓
     */   
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '서울, 경기, 인천만 입력 가능합니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;                
END;        
--==>> Procedure PRC_MEMBER_INSERT이(가) 컴파일되었습니다.


--※ 사용자 정의 예외 처리 절차
-- 1. 선언 섹션에서 사용자가 선언한다.
EXCEPTION_NAME EXCEPTION;
--> 『EXCEPTION_NAME』: 예외 이름을 정의

-- 2. 실행 섹션에서 명시적으로 예외를 발생시키기 위해 RAISE 구문을 사용한다.
RAISE EXCEPTION_NAME;
--> 『EXCEPTION_NAME』: 앞에서 선언한 예외 이름을 기술

-- 3. 예외 처리 영역 안에 선언된 예외를 참조한다.


--※ 『RAISE_APPLICATION_ERROR()』
--  - 형식 및 구조
--   ·RAISE_APPLICATION_ERROR(ERROR_NUMBER, ERROR_MESSAGE);
--   ·RAISE_APPLICATION_ERROR(ERROR_NUMBER, ERROR_MESSAGE, KEEP_ERRORS);
--  - 표준화되지 않은 에러 코드와 에러 메시지를 반환하기 위해
--    『RAISE_APPLICATION_ERROR()』 프로시저를 사용한다.
--    『RAISE_APPLICATION_ERROR()』를 만나게 되면 처리를 중단하며,
--     자바 등의 어플리케이션에서는 에러를 던져주어
--     SQLException을 이용하여 에러를 확인할 수 있다.
--  - 『ERROR_NUMBER』: 출력할 에러 번호로 사용자 정의 에러 번호는
--                      -20999 ~ 20000 사이의 수를 사용한다.
--  - 『ERROR_MESSAGE』: 출력한 에러 메시지
--  - 『KEEP_ERRORS』: TRUE로 설정하면 STACK처럼 에러 리스트를 보존할 수 있다.
--                     FALSE로 설정하면 덮어쓰기를 수행한다.
--                     (기본값은 FALSE)





--※ 실습 테이블 생성
-- 『20260115_01_scott』에서 생성한 『TBL_출고』테이블

--○ TBL_출고 테이블에 데이터 입력 시(즉, 출고 이벤트 발생 시)
--   TBL_상품 테이블의 해당 상품의 재고수량이 변동될 수 있는 프로시저를 작성한다.
--   단, 출고번호는 입고번호와 마찬가지로 자동 증가(→ 시퀀스 Ⅹ)
--   또한, 출고수량이 재고수량보다 많은 경우
--   출고 액션이 처리되지 않도록 구성한다.(출고가 이루어지지 않고 예외 처리)
-- 프로시저명: PRC_출고_INSERT()
-- EXEC PRC_출고_INSERT(상품코드, 출고수량, 출고단가);
-- TBL_출고 (출고번호, 상품코드, 출고일자, 출고수량, 출고단가)
CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
( P_상품코드    IN TBL_상품.상품코드%TYPE
, P_출고수량    IN TBL_출고.출고수량%TYPE
, P_출고단가    IN TBL_출고.출고단가%TYPE
)
IS
    -- 아래 액션 처리를 위해 필요한 변수 추가 선언
    V_출고번호  TBL_출고.출고번호%TYPE;
    V_재고수량  TBL_상품.재고수량%TYPE;
    -- 사용자 정의 예외 선언
    USER_DEFINE_EXCEPTION   EXCEPTION;
BEGIN
    -- 아래의 액션 처리를 수행하기 이전에 
    -- 출고 처리를 정상적으로 수행할지의 여부 확인
    -- → 출고를 수행하려는 해당 상품의 기존 재고수량 확인
    -- → 출고수량과 재고수량 비교
    
    -- 재고수량 파악
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = P_상품코드;
    
    -- 출고를 정상적으로 진행해 줄 것인지에 대한 여부 확인
    -- → 파악한 재고수량보다 출고수량이 많으면 예외 발생 CHECK
    IF(P_출고수량 > V_재고수량) THEN
        RAISE USER_DEFINE_EXCEPTION;
    END IF;
    
    -- 선언한 변수에 값 담아내기
    SELECT NVL(MAX(출고번호),0)+1 INTO V_출고번호
    FROM TBL_출고;
    
    -- INSERT 액션 처리 → TBL_출고
    INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
    VALUES(V_출고번호, P_상품코드, P_출고수량, P_출고단가);
    
    -- UPDATE 액션 처리 → TBL_상품
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - P_출고수량
    WHERE 상품코드 = P_상품코드;
    
    -- 커밋
    COMMIT;
    
    -- 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_EXCEPTION
            THEN RAISE_APPLICATION_ERROR(-20002,'재고수량이 부족합니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;      
END;
--==>> Procedure PRC_출고_INSERT이(가) 컴파일되었습니다.




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
    V_기존출고수량    TBL_출고.출고수량%TYPE;
    V_기존재고수량    TBL_상품.재고수량%TYPE;
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
    
    -- ④ 상품코드 파악
    SELECT 상품코드 INTO V_상품코드
    FROM TBL_출고
    WHERE 출고번호 = P_출고번호;
    
    SELECT 출고수량 INTO V_기존출고수량
    FROM TBL_출고
    WHERE 출고번호 = P_출고번호;
    
    SELECT 재고수량 INTO V_기존재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    IF (V_기존재고수량 + V_기존출고수량 < P_변경할수량)  THEN
        RAISE USER_DEFINE_ERROR;
    END IF;

    -- ② 수행 쿼리문 구성
    -- UPDATE 액션 처리 → TBL_출고
    UPDATE TBL_출고
    SET 출고수량 = P_변경할수량
    WHERE 출고번호 = P_출고번호;
    
    -- UPDATE 액션 처리 → TBL_상품
   /* UPDATE TBL_상품
    SET 재고수량 = 재고수량 + 기존출고수량 - 변경할수량 
    WHERE 상품코드 = TBL_출고가 가지고 있는 상품코드; */
    
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_기존출고수량 - P_변경할수량 
    WHERE 상품코드 = V_상품코드;    
    
    
    COMMIT;
    
    EXCEPTION
        WHEN  USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003,'재고수량이 부족합니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;    

END;

-- 모범풀이

--○ TBL_출고 테이블에서 출고수량을 변경(수정)하는 프로시저를 작성한다.
-- 프로시저명: PRC_출고_UPDATE(출고번호, 변경할수량);




































