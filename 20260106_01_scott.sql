SELECT USER
FROM DUAL;
--==>> SCOTT

--○ 현재 날짜 및 시간을 기준으로
--   수료일(2026-06-15 18:00:00)까지 남은 기간을
--   다음과 같은 형태로 조회할 수 있도록 쿼리문을 구성한다.

/*
---------------------------------------------------------------------
현재 시각            |  수료일             | 일  | 시간 | 분 | 초
---------------------------------------------------------------------
2026-01-05 17:33:54  | 2026-06-15 18:00:00  |  150 |  0  | 15 | 5
---------------------------------------------------------------------
*/

SELECT SYSDATE "현재 시각"
    , TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
    , TRUNC((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE) "일"
    , TRUNC((((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE) - TRUNC((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE)) * 24 ) "시"
    ,TRUNC((((((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE) - TRUNC((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE)) * 24 )
    -  TRUNC((((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE) - TRUNC((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE)) * 24 ))*60 ) "분"
    ,TRUNC((((((((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE) - TRUNC((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE)) * 24 )
    -  TRUNC((((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE) - TRUNC((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE)) * 24 ))*60 )
    - TRUNC((((((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE) - TRUNC((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE)) * 24 )
    -  TRUNC((((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE) - TRUNC((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE)) * 24 ))*60 )) * 60 ) "초"
FROM DUAL;

SELECT SYSDATE "현재 시각"
    , TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
    , TRUNC((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE) "일"
    , TRUNC(MOD((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE, 1) * 24 ) "시"
    , TRUNC((MOD(MOD((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE, 1) * 24, 1))*60) "분"
    , TRUNC(MOD((MOD(MOD((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE, 1) * 24, 1))*60,1)*60) "초"
FROM DUAL;

SELECT SYSDATE "현재 시각"
    , TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
    , TRUNC((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE) "일"
    , TRUNC(MOD((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE, 1) * 24 ) "시"
    , TRUNC((MOD((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE, 1/24) * 24 ) * 60 ) "분"
    , TRUNC(((MOD((TO_DATE('2026-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) - SYSDATE, 1/24/60) * 24) * 60) * 60) "초"
FROM DUAL;

-- 『1일 2시간 3분 4초』를 『초』로 환산하면
SELECT (1일) + (2시간) + (3분) + (4초)
FROM DUAL;

SELECT (1*24*60*60) + (2*60*60) + (3*60) + (4) "결과확인"
FROM DUAL;
--==>> 93784


--『93784초』를 다시 『1일 2시간 3분 4초』로 환산하면
SELECT TRUNC(TRUNC(TRUNC(93784/60)/60)/24)  "일"
     , MOD(TRUNC(TRUNC(93784/60)/60),24) "시간"
     , MOD(TRUNC(93784/60), 60) "분"
     , MOD(93784, 60) "초"
FROM DUAL;
--=>> 
/*
일 | 시간 | 분 |  초
----------------------
 1 |  2   | 3  |  4
----------------------
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session이(가) 변경되었습니다.

-- 수료일까지 남은 기간 확인(날짜 기준) → 단위: 일수
SELECT 수료일자 - 현재일자
FROM DUAL;

SELECT TO_DATE('2026-06-15 18:00:00','YYYY-MM-DD HH24:MI:SS') "수료일자"
FROM DUAL;
--==>> 2026-06-15 18:00:00

SELECT TO_DATE('2026-06-15 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE
FROM DUAL;
--==>> 160.318993055555555555555555555555555556

-- 수료일까지 남은 기간 확인(날짜 기준) → 단위: 초
SELECT (수료일까지 남은 일수) * (24*60*60)
FROM DUAL;
--> 수료일까지 남은 전체 초

SELECT (TO_DATE('2026-06-15 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)
FROM DUAL;
--==>> 13851405

SELECT TRUNC(TRUNC(TRUNC(13851405/60)/60)/24)  "일"
     , MOD(TRUNC(TRUNC(13851405/60)/60),24) "시간"
     , MOD(TRUNC(13851405/60), 60) "분"
     , MOD(13851405, 60) "초"
FROM DUAL;
--=>> 
/*
  일 | 시간 | 분 |  초
-------------------------
 160 |  7   | 36  |  45
-------------------------
*/

SELECT TRUNC(TRUNC(TRUNC((TO_DATE('2026-06-15 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60)/60)/24)  "일"
     , MOD(TRUNC(TRUNC((TO_DATE('2026-06-15 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60)/60),24) "시간"
     , MOD(TRUNC((TO_DATE('2026-06-15 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60), 60) "분"
     , TRUNC(MOD((TO_DATE('2026-06-15 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60), 60)) "초"
FROM DUAL;
/*
  일 | 시간 | 분 |  초
-------------------------
 160 |  7   | 34  |  25
-------------------------
*/

SELECT SYSDATE "현재시각", TO_DATE('2026-06-15 18:00:00','YYYY-MM-DD HH24:MI:SS') "수료일자"
     , TRUNC(TRUNC(TRUNC((TO_DATE('2026-06-15 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60)/60)/24)  "일"
     , MOD(TRUNC(TRUNC((TO_DATE('2026-06-15 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60)/60),24) "시간"
     , MOD(TRUNC((TO_DATE('2026-06-15 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60), 60) "분"
     , TRUNC(MOD((TO_DATE('2026-06-15 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60), 60)) "초"
FROM DUAL;
--==>> 
/*
---------------------------------------------------------------------
현재 시각            |  수료일             | 일  | 시간 | 분 | 초
---------------------------------------------------------------------
2026-01-06 10:27:5   | 2026-06-15 18:00:00  |  160 |  7  | 32 | 2
---------------------------------------------------------------------
*/






--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--○ 과제
-- 본인이 태어나서 현재까지
-- 얼마만큼의 일, 시간, 분, 초를 살고 있는지
-- 조회하는 쿼리문을 구성한다.
/*
---------------------------------------------------------------------
현재 시각            |  태어난일시         | 일  | 시간 | 분 | 초
---------------------------------------------------------------------
2026-01-06 10:27:5   | 1991-09-05 08:45:00  | XXXX | XX  | XX | XX
---------------------------------------------------------------------
*/

SELECT SYSDATE "현재시각"
     , TO_DATE('1991-09-05 08:45:00', 'YYYY-MM-DD HH24:MI:SS') "태어난일시"
     , TRUNC(SYSDATE -  TO_DATE('1991-09-05 08:45:00', 'YYYY-MM-DD HH24:MI:SS')) "일"
     , TRUNC(MOD((SYSDATE -  TO_DATE('1991-09-05 08:45:00', 'YYYY-MM-DD HH24:MI:SS')) * 24, 24)) "시간"
     , TRUNC(MOD((SYSDATE -  TO_DATE('1991-09-05 08:45:00', 'YYYY-MM-DD HH24:MI:SS'))* (24*60),60)) "분"
     , TRUNC(MOD((SYSDATE -  TO_DATE('1991-09-05 08:45:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60), 60)) "초"
FROM DUAL;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------






--○ 날짜 형식 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

--※ 날짜 데이터를 대상으로 반올림, 절삭을 수행할 수 있다.

--○ 날짜 반올림
SELECT SYSDATE "COL1"                   -- 2026-01-06   → 기본 현재 날짜
    , ROUND(SYSDATE, 'YEAR') "COL2"     -- 2026-01-01   → 연도까지 유효한 데이터(상반기, 하반기 기준)
    , ROUND(SYSDATE, 'MONTH') "COL3"    -- 2026-01-01   → 월까지 유효한 데이터(15일 기준)
    , ROUND(SYSDATE, 'DD') "COL4"       -- 2026-01-06   → 날짜까지 유효한 데이터(정오 기준)
    , ROUND(SYSDATE, 'DAY') "COL5"      -- 2026-01-04   → 날짜까지 유효한 데이터(수요일 기준)
FROM DUAL;

--○ 날짜 절삭
SELECT SYSDATE "COL1"                   -- 2026-01-06   → 기본 현재 날짜
    , TRUNC(SYSDATE, 'YEAR') "COL2"     -- 2026-01-01   → 연도까지 유효한 데이터
    , TRUNC(SYSDATE, 'MONTH') "COL3"    -- 2026-01-01   → 월까지 유효한 데이터
    , TRUNC(SYSDATE, 'DD') "COL4"       -- 2026-01-06   → 날짜까지 유효한 데이터 
    , TRUNC(SYSDATE, 'DAY') "COL5"      -- 2026-01-04   → 날짜까지 유효한 데이터 → 지난주 일요일
FROM DUAL;

--------------------------------------------------------------------------------

-- ■■■ 변환 함수 ■■■ --

-- TO_CHAR()   : 숫자나 날짜 데이터를 문자 타입으로 변환시켜주는 함수
-- TO_DATE()   : 문자 데이터(날짜 형식)를 날짜 타입으로 변환시켜주는 함수
-- TO_NUMBER() : 문자 데이터(숫자 형식)를 숫자 타입으로 변환시켜주는 함수


--※ 날짜나 통화 형식이 맞지 않을 경우
--   세션 설정값을 통해 설정할 수 있도록 한다.

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
--==>> Session이(가) 변경되었습니다.

ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session이(가) 변경되었습니다.

ALTER SESSION SET NLS_CURRENCY ='\';        -- 화폐 단위 : 원(￦)
--==>> Session이(가) 변경되었습니다.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

SELECT 10 "COL1" 
     , TO_CHAR(10) "COL2"
FROM DUAL;
--==>> 10 10

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD')    -- 2026-01-06
    , TO_CHAR(SYSDATE,'YYYY')           -- 2026
    , TO_CHAR(SYSDATE,'YEAR')           -- TWENTY TWENTY-SIX
    , TO_CHAR(SYSDATE,'MM')             -- 01
    , TO_CHAR(SYSDATE,'MONTH')          -- 1월
    , TO_CHAR(SYSDATE,'MON')            -- 1월
    , TO_CHAR(SYSDATE,'DD')             -- 06
    , TO_CHAR(SYSDATE,'DAY')            -- 화요일
    , TO_CHAR(SYSDATE,'DY')             -- 화
    , TO_CHAR(SYSDATE,'HH24')           -- 11
    , TO_CHAR(SYSDATE,'HH')             -- 11
    , TO_CHAR(SYSDATE,'HH AM')          -- 11 오전
    , TO_CHAR(SYSDATE,'HH PM')          -- 11 오전
    , TO_CHAR(SYSDATE,'MI')             -- 07
    , TO_CHAR(SYSDATE,'SS')             -- 47     
    , TO_CHAR(SYSDATE,'SSSSS')          -- 40067        → 금일 흘러온 초
    , TO_CHAR(SYSDATE,'Q')              -- 1            → 분기
FROM DUAL;


SELECT '05' "COL1"
      , TO_NUMBER('05') "COL2"
FROM DUAL;
--==>> 05   5


--○ EXTRACT()
SELECT TO_CHAR(SYSDATE, 'YYYY') "COL1"          -- 2026     → 날짜로부터 연도를 추출해서 문자 타입으로    ┐
    , TO_CHAR(SYSDATE, 'MM') "COL2"             -- 01       → 날짜로부터 월을 추출해서 문자 타입으로      │ 문자 타입
    , TO_CHAR(SYSDATE, 'DD') "COL3"             -- 06       → 날짜로부터 일을 추출해서 문자 타입으로      ┘
    , EXTRACT(YEAR FROM SYSDATE) "COL4"         -- 2026     → 날짜로부터 연도를 추출해서 숫자 타입으로    ┐
    , EXTRACT(MONTH FROM SYSDATE) "COL5"        -- 1        → 날짜로부터 월을 추출해서 숫자 타입으로      │ 숫자 타입
    , EXTRACT(DAY FROM SYSDATE) "COL6"          -- 6        → 날짜로부터 일을 추출해서 숫자 타입으로      ┘
FROM DUAL;  
--> 년, 월, 일 이외의 다른 것은 불가


--○ TO_CHAR() 활용 추가 → 형식 맞춤 표기 결과값 반환
SELECT 80000 "COL1"                            -- 80000
    , TO_CHAR(80000) "COL2"                    -- 80000
    , TO_CHAR(80000, '99,999') "COL3"          -- 80,000
    , TO_CHAR(80000, '$99,999') "COL4"         -- $80,000
    , TO_CHAR(80000, 'L99,999') "COL5"         --         \80,000 (우측 정렬아님, 왼쪽 통화 기호에 대한 공간 확보)
    , LTRIM(TO_CHAR(80000, 'L99,999')) "COL6"  -- \80,000
FROM DUAL;


--※ 날짜 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

--○ 현재 일시를 기준으로 1일 2시간 3분 4초 후를 조회한다.
SELECT  SYSDATE "현재일시" 
        , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "1일2시간3분4초후" 
FROM DUAL;

--○ 현재 일시를 기준으로 1년 2개월 3일 4시간 5분 6초 후를 조회한다.
--  TO_YMINTERVAL(), TO_DSINTERVAL()

SELECT SYSDATE "현재일시"
    , SYSDATE + TO_YMINTERVAL('01-02') + TO_DSINTERVAL('003 04:05:06') "연산결과"
FROM DUAL;
--==>>
/*
2026-01-06 11:32:28	
2027-03-09 15:37:34
*/



--------------------------------------------------------------------------------

-- ■■■ CASE 구문(조건문, 분기문) ■■■ --

/*
CASE
WHEN
THEN
ELSE
END
*/


SELECT CASE 5+2 WHEN 7 THEN '5+2=7' ELSE '5+2는몰라요' END "결과확인"
FROM DUAL;
--==>> 5+2=7

SELECT CASE 5+2 WHEN 3 THEN '5+2=3' ELSE '5+2는몰라요' END "결과확인"
FROM DUAL;
--==>> 5+2는몰라요

SELECT CASE 1+1 WHEN 1 THEN '1+1=1' 
                WHEN 2 THEN '1+1=2'
                WHEN 3 THEN '1+1=3'
                WHEN 4 THEN '1+1=4'
                ELSE '몰라요'  
       END "결과확인"
FROM DUAL;
--==>> 1+1=2


--○ DECODE()
SELECT DECODE(5-2, 1, '5-2=1', 2, '5-2=2', 3, '5-2=3', '5-2는몰라요') "결과확인"
FROM DUAL;
--==>> 5-2=3


SELECT CASE WHEN 1+1=2 THEN '1+1=2' 
            WHEN 1+2=4 THEN '1+2=4'
            WHEN 1+3=5 THEN '1+3=5'
            ELSE '몰라요' 
        END "결과확인"
FROM DUAL;
--==>> 1+1=2


--○ CASE WHEN THEN ELSE END 구문 활용
SELECT CASE WHEN 5<2 THEN '5<2'
            WHEN 5>2 THEN '5>2'
            ELSE '5와2는 비교불가'
        END "결과확인"
FROM DUAL;
--==>> 5>2

SELECT CASE WHEN 5<2 OR 3>1 THEN '현선만세' 
            WHEN 5>2 OR 2=3 THEN '주열만세'
            ELSE '진모만세'
        END "결과확인"
FROM DUAL;
--==>> 현선만세

SELECT CASE WHEN 3<1 AND 5<2 OR 3>1 AND 2=2 THEN '현선만세' 
            WHEN 5<2 AND 2=2 THEN '주열만세'
            ELSE '진모만세'
        END "결과확인"
FROM DUAL;
--==>> 현선만세
/*
SELECT CASE WHEN F AND F OR T AND T THEN '현선만세' 
            WHEN 5<2 AND 2=2 THEN '주열만세'
            ELSE '진모만세'
        END "결과확인"
FROM DUAL;

*/

SELECT CASE WHEN 3<1 AND (5<2 OR 3>1) AND 2=2 THEN '현선만세' 
            WHEN 5<2 AND 2=2 THEN '주열만세'
            ELSE '진모만세'
        END "결과확인"
FROM DUAL;
--==>> 진모만세
/*
SELECT CASE WHEN F THEN '현선만세' 
            WHEN F THEN '주열만세'
            ELSE '진모만세'
        END "결과확인"
FROM DUAL;
*/

SELECT *
FROM TBL_SAWON;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>>Session이(가) 변경되었습니다.

SELECT *
FROM TBL_SAWON;

--○ TBL_SAWON 테이블을 활용하여 다음과 같은 항목을 조회한다.
--  사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
--  , 정년퇴직일, 근무일수, 남은일수, 급여, 보너스

-- 단, 현재나이는 기존의 한국 나이 계산법에 따라 연산을 수행한다.
-- 또한, 정년퇴직일은 해당 직원의 나이가 한국나이로 65세가 되는 해(연도)의
-- 그 직원의 입사 월, 일로 연산을 수행한다.
-- 그리고, 보너스는 근무일수에 따라 책정하며
-- 근무일수가 5000일 이상 6000일 미만 근무한 사원은 그 사원의 급여 기준 30% 지급,
-- 근무일수가 6000일 이상인 사원은 해당 사원의 급여 기준 50% 지급 할 수 있도록 처리한다.

SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
    , CASE WHEN SUBSTR(JUBUN, 7, 1) = '1' OR SUBSTR(JUBUN, 7, 1) = '3' THEN '남자'
           WHEN SUBSTR(JUBUN, 7, 1) = '2' OR SUBSTR(JUBUN, 7, 1) = '4' THEN '여자'
           ELSE '알수없음'
       END "성별"
    ,  EXTRACT(YEAR FROM SYSDATE)
        - (TO_NUMBER(CASE WHEN SUBSTR(JUBUN,7,1) = '3' OR SUBSTR(JUBUN,7,1) = '4' THEN '20' || SUBSTR(JUBUN,1,2)
            ELSE '19' || SUBSTR(JUBUN,1,2)
        END))+ 1 "현재나이"
    , HIREDATE "입사일"
    ,TO_DATE((EXTRACT(YEAR FROM SYSDATE) + (65 - (TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')
        - (CASE WHEN SUBSTR(JUBUN,7,1) = '3' OR SUBSTR(JUBUN,7,1) = '4' THEN '20' || SUBSTR(JUBUN,1,2)
                ELSE '19' || SUBSTR(JUBUN,1,2)
            END ) + 1))))
        ||'-'|| TO_CHAR(HIREDATE, 'MM') || '-' ||TO_CHAR(HIREDATE, 'DD'),'YYYY-MM-DD') 
    "정년퇴직일"
    , TRUNC(SYSDATE - (HIREDATE)+1)  "근무일수"
    , TRUNC((TO_DATE((EXTRACT(YEAR FROM SYSDATE) + (65 - (TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')
        - (CASE WHEN SUBSTR(JUBUN,7,1) = '3' OR SUBSTR(JUBUN,7,1) = '4' THEN '20' || SUBSTR(JUBUN,1,2)
            ELSE '19' || SUBSTR(JUBUN,1,2)
        END ) + 1))))||'-'|| TO_CHAR(HIREDATE, 'MM') || '-' ||TO_CHAR(HIREDATE, 'DD'),'YYYY-MM-DD'))-SYSDATE) "남은일수"
    , SAL "급여"
    ,CASE WHEN TRUNC(SYSDATE - (HIREDATE)+1) >= 5000 AND TRUNC(SYSDATE - (HIREDATE)+1) <6000 THEN SAL*0.3 
          WHEN TRUNC(SYSDATE - (HIREDATE)+1) >= 6000 THEN SAL * 0.5
          ELSE 0
      END "보너스"
FROM TBL_SAWON;

SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
    , CASE WHEN SUBSTR(JUBUN, 7, 1) = '1' OR SUBSTR(JUBUN, 7, 1) = '3' THEN '남자'
           WHEN SUBSTR(JUBUN, 7, 1) = '2' OR SUBSTR(JUBUN, 7, 1) = '4' THEN '여자'
           ELSE '알수없음'
       END "성별"
    ,  EXTRACT(YEAR FROM SYSDATE)
        - (TO_NUMBER(CASE WHEN SUBSTR(JUBUN,7,1) = '3' OR SUBSTR(JUBUN,7,1) = '4' THEN '20' || SUBSTR(JUBUN,1,2)
            ELSE '19' || SUBSTR(JUBUN,1,2)
        END))+ 1 "현재나이"
    , HIREDATE "입사일"
    ,TO_DATE(TO_CHAR((TO_NUMBER(CASE WHEN SUBSTR(JUBUN,7,1) = '3' OR SUBSTR(JUBUN,7,1) = '4' THEN '20' || SUBSTR(JUBUN,1,2)
            ELSE '19' || SUBSTR(JUBUN,1,2) END))+ 64)
            ||'-'|| TO_CHAR(HIREDATE, 'MM') || '-' ||TO_CHAR(HIREDATE, 'DD'),'YYYY-MM-DD') 
    "정년퇴직일"
    , TRUNC(SYSDATE - (HIREDATE))+1  "근무일수"
    , TRUNC((TO_DATE(TO_CHAR((TO_NUMBER(CASE WHEN SUBSTR(JUBUN,7,1) = '3' OR SUBSTR(JUBUN,7,1) = '4' THEN '20' || SUBSTR(JUBUN,1,2)
            ELSE '19' || SUBSTR(JUBUN,1,2) END))+ 64)
            ||'-'|| TO_CHAR(HIREDATE, 'MM') || '-' ||TO_CHAR(HIREDATE, 'DD'),'YYYY-MM-DD') - SYSDATE))
    "남은일수"
    , SAL "급여"
    ,CASE WHEN TRUNC(SYSDATE - (HIREDATE)+1) >= 5000 AND TRUNC(SYSDATE - (HIREDATE)+1) <6000 THEN SAL*0.3 
          WHEN TRUNC(SYSDATE - (HIREDATE)+1) >= 6000 THEN SAL * 0.5
          ELSE 0
      END "보너스"
FROM TBL_SAWON;


-------------------------------------------------------------------------------- 모범풀이(서브쿼리형식)
--TBL_SAWON 테이블에 존재하는 사원들의
-- 입사일(HIREDATE) 컬럼에서 월, 일만 조회하기
SELECT SANAME, HIREDATE, TO_CHAR(HIREDATE, 'MM') "월", TO_CHAR(HIREDATE, 'DD') "일"
FROM TBL_SAWON;
--==>>
/*
조세빈	    2011-01-03	01	03
강명철	    2017-01-05	01	05
이수빈	    2005-08-16	08	16
정세찬	    1998-02-10	02	10
이재용	    1990-10-10	10	10
이이영	    2009-06-05	06	05
아이유	    2012-07-13	07	13
이상이	    1999-08-16	08	16
남궁민	    2010-07-01	07	01
윤주열	    2015-10-20	10	20
선동열	    1990-10-10	10	10
선우용녀	1998-08-08	08	08
남희석	    2002-05-15	05	15
선우선	    2012-05-13	05	13
남궁민	    2015-07-13	07	13
남진	    1999-07-13	07	13
정우	    1999-10-10	10	10
*/
SELECT SANAME, HIREDATE, TO_CHAR(HIREDATE, 'MM') || '-' || TO_CHAR(HIREDATE, 'DD') "월일"
FROM TBL_SAWON;
--==>>
/*
조세빈	    2011-01-03	01-03
강명철	    2017-01-05	01-05
이수빈	    2005-08-16	08-16
정세찬	    1998-02-10	02-10
이재용	    1990-10-10	10-10
이이영	    2009-06-05	06-05
아이유	    2012-07-13	07-13
이상이	    1999-08-16	08-16
남궁민	    2010-07-01	07-01
윤주열	    2015-10-20	10-20
선동열	    1990-10-10	10-10
선우용녀	1998-08-08	08-08
남희석	    2002-05-15	05-15
선우선	    2012-05-13	05-13
남궁민	    2015-07-13	07-13
남진	    1999-07-13	07-13
정우	    1999-10-10	10-10
*/

SELECT SANAME, HIREDATE, TO_CHAR(HIREDATE, 'MM-DD') "월일"
FROM TBL_SAWON;
--==>>
/*
조세빈	    2011-01-03	01-03
강명철	    2017-01-05	01-05
이수빈	    2005-08-16	08-16
정세찬	    1998-02-10	02-10
이재용	    1990-10-10	10-10
이이영	    2009-06-05	06-05
아이유	    2012-07-13	07-13
이상이	    1999-08-16	08-16
남궁민	    2010-07-01	07-01
윤주열	    2015-10-20	10-20
선동열	    1990-10-10	10-10
선우용녀	1998-08-08	08-08
남희석	    2002-05-15	05-15
선우선	    2012-05-13	05-13
남궁민	    2015-07-13	07-13
남진	    1999-07-13	07-13
정우	    1999-10-10	10-10
*/

--  사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
--  , 정년퇴직일, 근무일수, 남은일수, 급여, 보너스

-- 사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일, 급여
SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN 주민번호 7번째자리 1개가 '1' 또는 '3' THEN '남자'
            WHEN 주민번호 7번째자리 1개가 '2' 또는 '4' THEN '여자'
            ELSE '성별확인불가' 
        END "성별"
FROM TBL_SAWON;

SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN,7,1) IN('1','3') THEN '남자'
            WHEN SUBSTR(JUBUN,7,1) IN('2','4') THEN '여자'
            ELSE '성별확인불가' 
        END "성별"
FROM TBL_SAWON;

SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN,7,1) IN('1','3') THEN '남자'
            WHEN SUBSTR(JUBUN,7,1) IN('2','4') THEN '여자'
            ELSE -1
        END "성별"
FROM TBL_SAWON;
--==>> 에러발생 반환하는 데이터타입이 모두 일치해야함

SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
    -- 성별
     , CASE WHEN SUBSTR(JUBUN,7,1) IN('1','3') THEN '남자'
            WHEN SUBSTR(JUBUN,7,1) IN('2','4') THEN '여자'
            ELSE '성별확인불가' 
        END "성별"
    -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대생/ 2000년대 생)
     , CASE WHEN 1900년대 생이라면 THEN 현재년도 -(주민번호 앞 두자리 + 1899) 
            WHEN 2000년대 생이라면 THEN 현재년도 - (주민번호 앞 두자리 + 1999)
            ELSE -1
        END "현재나이"
FROM TBL_SAWON;

SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
    -- 성별
     , CASE WHEN SUBSTR(JUBUN,7,1) IN('1','3') THEN '남자'
            WHEN SUBSTR(JUBUN,7,1) IN('2','4') THEN '여자'
            ELSE '성별확인불가' 
        END "성별"
    -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대생/ 2000년대 생)
     , CASE WHEN SUBSTR(JUBUN,7,1) IN('1','2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
            WHEN SUBSTR(JUBUN,7,1) IN('3','4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
            ELSE -1
        END "현재나이"
FROM TBL_SAWON;

SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
    -- 성별
     , CASE WHEN SUBSTR(JUBUN,7,1) IN('1','3') THEN '남자'
            WHEN SUBSTR(JUBUN,7,1) IN('2','4') THEN '여자'
            ELSE '성별확인불가' 
        END "성별"
    -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대생/ 2000년대 생)
     , CASE WHEN SUBSTR(JUBUN,7,1) IN('1','2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
            WHEN SUBSTR(JUBUN,7,1) IN('3','4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
            ELSE -1
        END "현재나이"
     , HIREDATE "입사일" , SAL "급여"
FROM TBL_SAWON;

-----------------------------------------------------------
SELECT SANO "사원번호", SANAME "사원명", SAL "급여"
    , SAL * 12 "연봉", 연봉*2 "두배연봉", 연봉*3 "세배연봉"
FROM TBL_SAWON;
--==>> 에러 발생
/*
ORA-00904: "연봉": invalid identifier
00904. 00000 -  "%s: invalid identifier"
*Cause:    
*Action:
596행, 103열에서 오류 발생
*/

-- 서브쿼리(인라인뷰)
SELECT T.사원번호, T.사원명, T.급여, T.연봉, T.연봉*2 "두배연봉", T.연봉*3 "세배연봉"
FROM
(
    SELECT SANO "사원번호", SANAME "사원명", SAL "급여", SAL * 12 "연봉"
    FROM TBL_SAWON
) T;
-----------------------------------------------------------

--  사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
--  , 정년퇴직일, 근무일수, 남은일수, 급여, 보너스

SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
    -- 정년퇴직일
    -- 정년퇴직연도 → 해당 직원의 나이가 한국나이로 65세가 되는 해
    -- 현재 나이가 62세라면 3년후  → 2026 + 3 → 2029(남은 년 수 3년)
    -- 현재 나이가 35세라면 30년후 → 2026 + 30 → 2056(남은 년 수 30년)
    -- 현재일자 + 남은 년 수 → 정년퇴직연도
    -- ADD_MONTHS(SYSDATE, 남은 년수 * 12)
    --                     ---------
    --                   65 - 현재나이
    -- ADD_MONTHS(SYSDATE, (65 - 현재나이) * 12)
   --  , TO_CHAR(ADD_MONTHS(SYSDATE, (65 - T.현재나이) * 12), 'YYYY') "정년퇴직연도"
   --  , TO_CHAR(T.입사일, 'MM-DD') "입사월일"
     , TO_CHAR(ADD_MONTHS(SYSDATE, (65 - T.현재나이) * 12), 'YYYY')
        || '-' || TO_CHAR(T.입사일, 'MM-DD') "정년퇴직일"
    -- 근무일수
    -- 근무일수 = 현재일 - 입사일
    , TRUNC(SYSDATE - T.입사일) "근무일수"
    -- 남은일수
    -- 남은일수 = 정년퇴직일 - 현재일
    , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (65 - T.현재나이) * 12), 'YYYY')
        || '-' || TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "남은일수"
    , T.급여
    -- 보너스
    -- 근무일수가 5000일 이상 6000일 미만 → 해당 사원 급여기준 30%
    -- 근무일수가 6000일 이상             → 해당 사원 급여기준 50%
    -- 나머지                             → 0
    -- CASE WHEN 근무일수가 6000일 이상 THEN 급여의 50% 
    --      WHEN 근무일수가 5000일 이상 THEN 급여의 30% 
    --      ELSE 0 
    --   END"보너스"
    , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 6000 THEN T.급여 * 0.5 
           WHEN TRUNC(SYSDATE - T.입사일) >= 5000 THEN T.급여 * 0.3 
           ELSE 0 
       END"보너스"
FROM
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
        -- 성별
         , CASE WHEN SUBSTR(JUBUN,7,1) IN('1','3') THEN '남자'
                WHEN SUBSTR(JUBUN,7,1) IN('2','4') THEN '여자'
                ELSE '성별확인불가' 
            END "성별"
        -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대생/ 2000년대 생)
         , CASE WHEN SUBSTR(JUBUN,7,1) IN('1','2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                WHEN SUBSTR(JUBUN,7,1) IN('3','4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                ELSE -1
            END "현재나이"
         , HIREDATE "입사일" , SAL "급여"
    FROM TBL_SAWON
) T;

--==>>
/*
사원번호    사원명     주민번호        성별  현재나이    입사일     정년퇴직일  근무일수 남은일수  급여    보너스
-------- ------------ --------------- ------ -------    ----------  ----------  ------- ------      -----  ------
    1001    	조세빈	    9804112234567	여자	  29	2011-01-03	2062-01-03	5482	13145	    3000	    900
    1002	    강명철	    0002113234567	남자	  27	2017-01-05	2064-01-05	3288	13877	    2000	    0
    1003    	이수빈	    9709061234567	남자	  30    	2005-08-16	2061-08-16	7448	13005	    5000	    2500
    1004	    정세찬	    9104281234567	남자	  36	1998-02-10	2055-02-10	10192	10626	    6000	    3000
    1005	    이재용	    7512121234567	남자	  52	1990-10-10	2039-10-10	12872	5024	        2000	    1000
    1006    	이이영	    8904051234567	남자	  38	2009-06-05	2053-06-05	6059    	10011	    1000	    500
    1007    	아이유	    9304022234567	여자	  34	2012-07-13	2057-07-13	4925	11510	    3000    	0
    1008	    이상이	    8512161234567	남자	  42	1999-08-16	2049-08-16	9640	    8622	    2000	    1000
    1009	    남궁민	    0102033234567	남자	  26	2010-07-01	2065-07-01	5668	14420	    1000	    300
    1010	    윤주열	    0502203234567	남자	  22	2015-10-20	2069-10-20	3731	15992	    3000	    0
    1011	    선동열	    7012181234567	남자	  57	1990-10-10	2034-10-10	12872	3198	    3000	    1500
    1012	    선우용녀	7205062234567	여자	  55	1998-08-08	2036-08-08	10013	3866	    2000	    1000
    1013	    남희석	    7509231234567	남자	  52	2002-05-15	2039-05-15	8637	4876	    1000	    500
    1014    	선우선	    0203044234567	여자	  25	2012-05-13	2066-05-13	4986	14736	    2000	    0
    1015	    남궁민	    0512123234567	남자	  22	2015-07-13	2069-07-13	3830	    15893	    1000	    0
    1016	    남진	    7108051234567	남자	  56	1999-07-13	2035-07-13	9674	3474	    2000	    1000
    1017	    정우	    8502031234567	남자	  42	1999-10-10	2049-10-10	9585	8677	    2000	    1000
*/

--○ 최종 쿼리문 구성
SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
     , TO_CHAR(ADD_MONTHS(SYSDATE, (65 - T.현재나이) * 12), 'YYYY')
        || '-' || TO_CHAR(T.입사일, 'MM-DD') "정년퇴직일"
    , TRUNC(SYSDATE - T.입사일) "근무일수"
    , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (65 - T.현재나이) * 12), 'YYYY')
        || '-' || TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "남은일수"
    , T.급여
    , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 6000 THEN T.급여 * 0.5 
           WHEN TRUNC(SYSDATE - T.입사일) >= 5000 THEN T.급여 * 0.3 
           ELSE 0 
       END"보너스"
FROM
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"

         , CASE WHEN SUBSTR(JUBUN,7,1) IN('1','3') THEN '남자'
                WHEN SUBSTR(JUBUN,7,1) IN('2','4') THEN '여자'
                ELSE '성별확인불가' 
            END "성별"
         , CASE WHEN SUBSTR(JUBUN,7,1) IN('1','2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                WHEN SUBSTR(JUBUN,7,1) IN('3','4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                ELSE -1
            END "현재나이"
         , HIREDATE "입사일" , SAL "급여"
    FROM TBL_SAWON
) T;


--※ 상기 내용에서
-- 특정 근무일수의 사원을 확인해야 한다거나
-- 특정 보너스 금액을 받는 사원을 확인해야할 경우가 생겼다거나 할 수 있다.
-- 이와 같은 겨우
-- 해당 쿼리문을 처음부터 다시 구성해야하는 번거로움을 줄일 수 있도록
-- 뷰(VIEW)를 만들어 저장해 둘 수 있다.

SELECT *
FROM TBL_EMP;

SELECT EMPNO, ENAME, JOB, SAL*12+NVL(COMM,0) "YEARPAY"
FROM TBL_EMP;

--○ 뷰 생성
-- 뷰명: VIEW_TEST
CREATE VIEW VIEW_TEST
AS 
SELECT EMPNO, ENAME, JOB, SAL*12+NVL(COMM,0) "YEARPAY"
FROM TBL_EMP;
--==>> 에러발생
/*
ORA-01031: insufficient privileges
01031. 00000 -  "insufficient privileges"
*Cause:    An attempt was made to perform a database operation without
           the necessary privileges.
*Action:   Ask your database administrator or designated security
           administrator to grant you the necessary privileges
*/
--> SCOTT 계정이 뷰(VIEW)를 생성할 수 있는 권한(→ CREATE VIEW)이 없기 때문에 발생하는 에러


--※ 『20260106_02_sys.sql』에서 
-- SYS계정으로 해당 권한 부여 이후 다시 시도

--○ 뷰 생성
-- 뷰명: VIEW_TEST
CREATE VIEW VIEW_TEST
AS 
SELECT EMPNO, ENAME, JOB, SAL*12+NVL(COMM,0) "YEARPAY"
FROM TBL_EMP;
--==>> View VIEW_TEST이(가) 생성되었습니다.

SELECT *
FROM VIEW_TEST;
--==>>
/*
7369	SMITH	CLERK	     9600
7499	ALLEN	SALESMAN	19500
7521	WARD	SALESMAN	15500
7566	JONES	MANAGER	    35700
7654	MARTIN	SALESMAN	16400
7698	BLAKE	MANAGER	    34200
7782	CLARK	MANAGER	    29400
7788	SCOTT	ANALYST	    36000
7839	KING	PRESIDENT	60000
7844	TURNER	SALESMAN	18000
7876	ADAMS	CLERK	    13200
7900    	JAMES	CLERK	    11400
7902    	FORD	ANALYST	    36000
7934	MILLER	CLERK	    15600
*/

--○ 뷰 생성 이후 대상 테이블에 데이터 추가
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, HIREDATE, SAL, COMM, DEPTNO)
VALUES(9000, '정세찬', 'SALESMAN', SYSDATE, 5000, 500, 20);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_EMP;
--==>>
/*
            :
  9000	정세찬	SALESMAN		2026-01-06	5000	500	20      
*/

--○ 커밋
COMMIT;
커밋 완료.

--○ 해당 뷰 다시 조회
SELECT *
FROM VIEW_TEST;
--==>>
/*
        :
  9000	정세찬	SALESMAN	60500      
*/


CREATE VIEW VIEW_TEST
AS 
SELECT EMPNO, ENAME, JOB, SAL*12+NVL(COMM,0) "YEARPAY"
    ,DEPTNO, HIREDATE
FROM TBL_EMP;
--==>> 에러발생
/*
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:
*/

CREATE OR REPLACE VIEW VIEW_TEST
AS 
SELECT EMPNO, ENAME, JOB, SAL*12+NVL(COMM,0) "YEARPAY"
    ,DEPTNO, HIREDATE
FROM TBL_EMP;
--==>> View VIEW_TEST이(가) 생성되었습니다.

SELECT *
FROM VIEW_TEST;


--○ 뷰 생성
-- 뷰명: VIEW_SAWON
CREATE OR REPLACE VIEW VIEW_SAWON
AS
SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
     , TO_CHAR(ADD_MONTHS(SYSDATE, (65 - T.현재나이) * 12), 'YYYY')
        || '-' || TO_CHAR(T.입사일, 'MM-DD') "정년퇴직일"
    , TRUNC(SYSDATE - T.입사일) "근무일수"
    , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (65 - T.현재나이) * 12), 'YYYY')
        || '-' || TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "남은일수"
    , T.급여
    , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 6000 THEN T.급여 * 0.5 
           WHEN TRUNC(SYSDATE - T.입사일) >= 5000 THEN T.급여 * 0.3 
           ELSE 0 
       END"보너스"
FROM
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"

         , CASE WHEN SUBSTR(JUBUN,7,1) IN('1','3') THEN '남자'
                WHEN SUBSTR(JUBUN,7,1) IN('2','4') THEN '여자'
                ELSE '성별확인불가' 
            END "성별"
         , CASE WHEN SUBSTR(JUBUN,7,1) IN('1','2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                WHEN SUBSTR(JUBUN,7,1) IN('3','4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                ELSE -1
            END "현재나이"
         , HIREDATE "입사일" , SAL "급여"
    FROM TBL_SAWON
) T;
--==>> View VIEW_SAWON이(가) 생성되었습니다.

SELECT *
FROM VIEW_SAWON;

--○ 뷰(VIEW) 생성 이후 데이터 변경
UPDATE TBL_SAWON
SET HIREDATE = SYSDATE, SAL = 100
WHERE SANO = 1001;
--==>> 1 행 이(가) 업데이트되었습니다.

--○ 확인
SELECT *
FROM TBL_SAWON;
--==>>
/*
1001	조세빈	9804112234567	2026-01-06	100
                    :
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.

SELECT *
FROM VIEW_SAWON;
--==>>
/*
변경 전 T → 1001	조세빈	9804112234567	여자	29	2011-01-03	2062-01-03	5482	13148	3000    900
변경 후 T → 1001	조세빈	9804112234567	여자	29	2026-01-06	2062-01-06	   0    	13148	 100	     0                                        :
*/

--○ 서브 쿼리를 활용하여 TBL_SAWON 테이블을 다음과 같이 조회할 수 있도록 쿼리문을 구성한다.
/*
---------------------------------------------------------------
사원명     성별      현재나이       급여       나이보너스
---------------------------------------------------------------
*/
-- 단, 나이보너스는 현재 나이가 40세 이상이면 급여의 70%
--  30세 이상 40세 미만이면 급여의 50%
--  20세 이상 30세 미만이면 급여의 30%로 한다.

-- 또한, 완성된 조회 구문을 기반으로
-- VIEW_SAWON2라는 이름의 뷰(VIEW)를 생성한다.


SELECT T.사원명, T.성별, T.현재나이, T.급여
    , CASE WHEN(T.현재나이 >= 40) THEN T.급여 * 0.7
           WHEN(T.현재나이 >= 30) THEN T.급여 * 0.5
           WHEN(T.현재나이 >= 20) THEN T.급여 * 0.3
           ELSE -1
       END "나이보너스"
FROM 
(
    SELECT SANAME "사원명"
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남자'
               WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여자'
               ELSE '성별확인불가'
           END "성별"
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') 
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
               WHEN SUBSTR(JUBUN,7,1) IN ('3','4') 
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
               ELSE -1
           END "현재나이"
           , SAL "급여"
    FROM TBL_SAWON
) T;



CREATE OR REPLACE VIEW VIEW_SAWON2
AS
SELECT T.사원명, T.성별, T.현재나이, T.급여
    , CASE WHEN(T.현재나이 >= 40) THEN T.급여 * 0.7
           WHEN(T.현재나이 >= 30) THEN T.급여 * 0.5
           WHEN(T.현재나이 >= 20) THEN T.급여 * 0.3
           ELSE -1
       END "나이보너스"
FROM 
(
    SELECT SANAME "사원명"
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남자'
               WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여자'
               ELSE '성별확인불가'
           END "성별"
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') 
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
               WHEN SUBSTR(JUBUN,7,1) IN ('3','4') 
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
               ELSE -1
           END "현재나이"
           , SAL "급여"
    FROM TBL_SAWON
) T;
--==>> View VIEW_SAWON2이(가) 생성되었습니다.

SELECT *
FROM VIEW_SAWON2;


----- 모범 풀이
SELECT SANAME "사원명"
    , CASE WHEN THEN ELSE END "성별"
    , CASE WHEN THEN ELSE END "현재나이"
    , SAL "급여"
FROM TBL_SAWON;

SELECT SANAME "사원명"
    , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '3')
           THEN '남성'
           WHEN SUBSTR(JUBUN,7,1) IN ('2', '4')
           THEN '여성'
           ELSE '성별확인불가'
       END "성별"
    , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
           WHEN SUBSTR(JUBUN,7,1) IN ('3', '4')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
           ELSE -1
       END "현재나이"
    , SAL "급여"
FROM TBL_SAWON;

SELECT T.*
    , CASE WHEN T.현재나이 >= 40 THEN T.급여 * 0.7
           WHEN T.현재나이 >= 30 THEN T.급여 * 0.5
           WHEN T.현재나이 >= 20 THEN T.급여 * 0.3
           ELSE 0
       END "나이보너스"
FROM
(
    SELECT SANAME "사원명"
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '3')
               THEN '남성'
               WHEN SUBSTR(JUBUN,7,1) IN ('2', '4')
               THEN '여성'
               ELSE '성별확인불가'
           END "성별"
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
               WHEN SUBSTR(JUBUN,7,1) IN ('3', '4')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
               ELSE -1
           END "현재나이"
        , SAL "급여"
    FROM TBL_SAWON
)T;
--==>>
/*
조세빈	    여성	29	100	    30
강명철	    남성	27	2000	    600
이수빈	    남성	30	5000    	2500
정세찬	    남성	36	6000	    3000
이재용	    남성	52	2000	    1400
이이영	    남성	38	1000	    500
아이유	    여성	34	3000	    1500
이상이	    남성	42	2000	    1400
남궁민	    남성	26	1000	    300
윤주열	    남성	22	3000	    900
선동열	    남성	57	3000	    2100
선우용녀	여성	55	2000	    1400
남희석	    남성	52	1000	    700
*/

CREATE OR REPLACE VIEW VIEW_SAWON2
AS
SELECT T.*
    , CASE WHEN T.현재나이 >= 40 THEN T.급여 * 0.7
           WHEN T.현재나이 >= 30 THEN T.급여 * 0.5
           WHEN T.현재나이 >= 20 THEN T.급여 * 0.3
           ELSE 0
       END "나이보너스"
FROM
(
    SELECT SANAME "사원명"
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '3')
               THEN '남성'
               WHEN SUBSTR(JUBUN,7,1) IN ('2', '4')
               THEN '여성'
               ELSE '성별확인불가'
           END "성별"
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
               WHEN SUBSTR(JUBUN,7,1) IN ('3', '4')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
               ELSE -1
           END "현재나이"
        , SAL "급여"
    FROM TBL_SAWON
)T;
--==>> View VIEW_SAWON2이(가) 생성되었습니다.

--○ 생성된 뷰(VIEW) 확인
SELECT *
FROM VIEW_SAWON2;
--==>>
/*
조세빈	    여성	29	100	    30
강명철	    남성	27	2000	    600
이수빈	    남성	30	5000    	2500
정세찬	    남성	36	6000	    3000
이재용	    남성	52	2000	    1400
이이영	    남성	38	1000	    500
아이유	    여성	34	3000	    1500
이상이	    남성	42	2000	    1400
남궁민	    남성	26	1000	    300
윤주열	    남성	22	3000	    900
선동열	    남성	57	3000	    2100
선우용녀	여성	55	2000	    1400
남희석	    남성	52	1000	    700
*/

--------------------------------------------------------------------------------

--○ RANK() → 등수(순위)를 반환하는 함수
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
    , RANK() OVER(ORDER BY SAL DESC) "전체급여등수"
FROM EMP;
--==>>
/*
7839	KING	10	5000    	1
7902    	FORD	20	3000    	2
7788	SCOTT	20	3000	    2
7566	JONES	20	2975	4
7698	BLAKE	30	2850    	5
7782	CLARK	10	2450    	6
7499	ALLEN	30	1600	    7
7844	TURNER	30	1500	    8
7934	MILLER	10	1300	    9
7521	WARD	30	1250	    10
7654	MARTIN	30	1250	    10
7876	ADAMS	20	1100	    12
7900	    JAMES	30	950	    13
7369	SMITH	20	800	    14
*/

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
    , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서내급여등수"
FROM EMP;
--==>>
/*
7839	KING	10	5000    	1
7782	CLARK	10	2450    	2
7934	MILLER	10	1300    	3
7788	SCOTT	20	3000	    1
7902	    FORD	20	3000	    1
7566	JONES	20	2975	3
7876	ADAMS	20	1100	    4
7369	SMITH	20	800	    5
7698	BLAKE	30	2850    	1
7499	ALLEN	30	1600    	2
7844	TURNER	30	1500	    3
7654	MARTIN	30	1250    	4
7521	WARD	30	1250    	4
7900	    JAMES	30	950	    6
*/

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
    , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서내급여등수"
FROM EMP
ORDER BY 1;
--==>>
/*

*/

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
    , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서내급여등수"
    , RANK() OVER(ORDER BY SAL DESC) "전체급여등수"
FROM EMP;
--==>>
/*
7839	KING	10	5000    	1	1
7902    	FORD	20	3000    	1	2
7788	SCOTT	20	3000    	1	2
7566	JONES	20	2975	3	4
7698	BLAKE	30	2850    	1	5
7782	CLARK	10	2450    	2	6
7499	ALLEN	30	1600    	2	7
7844	TURNER	30	1500    	3	8
7934	MILLER	10	1300    	3	9
7521	WARD	30	1250    	4	10
7654	MARTIN	30	1250	    4	10
7876	ADAMS	20	1100    	4	12
7900    	JAMES	30	950     	6	13
7369	SMITH	20	800	    5	14
*/

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
    , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서내급여등수"
    , RANK() OVER(ORDER BY SAL DESC) "전체급여등수"
FROM EMP
ORDER BY 3, 4 DESC;
--==>>
/*
7839	KING	10	5000	    1	1
7782	CLARK	10	2450	    2	6
7934	MILLER	10	1300	    3	9
7902	    FORD	20	3000	    1	2
7788	SCOTT	20	3000	    1	2
7566	JONES	20	2975	3	4
7876	ADAMS	20	1100	    4	12
7369	SMITH	20	800	    5	14
7698	BLAKE	30	2850	    1	5
7499	ALLEN	30	1600	    2	7
7844	TURNER	30	1500	    3	8
7654	MARTIN	30	1250    	4	10
7521	WARD	30	1250	    4	10
7900    	JAMES	30	950	    6	13
*/

--○ DENSE_RANK() → 서열을 반환하는 함수
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
    , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서내급여등수"
    , DENSE_RANK() OVER(ORDER BY SAL DESC) "전체급여등수"
FROM EMP
ORDER BY 3, 4 DESC;
--==>>
/*
7839	KING	10	5000	    1	1
7782	CLARK	10	2450	    2	5
7934	MILLER	10	1300	    3	8
7902    	FORD	20	3000	    1	2
7788	SCOTT	20	3000	    1	2
7566	JONES	20	2975	2	3
7876	ADAMS	20	1100    	3   10
7369	SMITH	20	800	    4	12
7698	BLAKE	30	2850	    1	4
7499	ALLEN	30	1600	    2	6
7844	TURNER	30	1500	    3	7
7654	MARTIN	30	1250	    4	9
7521	WARD	30	1250    	4	9
7900	    JAMES	30	950	    5	11
*/

--○ EMP 테이블의 사원 정보를 대상으로
--   사원명, 부서번호, 연봉, 부서내연봉순위, 전체연봉순위 항목을 조회하는 쿼리문을 구성한다.

SELECT *
FROM EMP;

SELECT T.*
    , RANK() OVER(PARTITION BY T.부서번호 ORDER BY T.연봉 DESC) "부서내연봉순위"
    , RANK() OVER(ORDER BY T.연봉 DESC) "전체연봉순위"
FROM 
(
    SELECT ENAME "사원명", DEPTNO "부서번호" 
        , SAL*12 + NVL(COMM, 0) "연봉"
    FROM EMP
)T;

SELECT  ENAME "사원명", DEPTNO "부서번호" 
        , SAL*12 + NVL(COMM, 0) "연봉"
        , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12 + NVL(COMM, 0) DESC) "부서내연봉순위"
        , RANK() OVER(ORDER BY SAL*12 + NVL(COMM, 0) DESC) "전체연봉순위" 
FROM EMP;
--==>>
/*
KING	10	60000	1	1
FORD	20	36000	1	2
SCOTT	20	36000	1	2
JONES	20	35700	3	4
BLAKE	30	34200	1	5
CLARK	10	29400	2	6
ALLEN	30	19500	2	7
TURNER	30	18000	3	8
MARTIN	30	16400	4	9
MILLER	10	15600	3	10
WARD	30	15500	5	11
ADAMS	20	13200	4	12
JAMES	30	11400	6	13
SMITH	20	9600	    5	14
*/

--○ EMP 테이블에서 전체연봉순위가 1등부터 5등까지만
--   사원명, 부서번호, 연봉, 전체연봉순위 항목으로 조회한다.

SELECT S.사원명, S.부서번호, S.연봉, S.전체연봉순위
FROM
(
    SELECT T.*
    , RANK() OVER(PARTITION BY T.부서번호 ORDER BY T.연봉 DESC) "부서내연봉순위"
    , RANK() OVER(ORDER BY T.연봉 DESC) "전체연봉순위"
    FROM 
    (
        SELECT ENAME "사원명", DEPTNO "부서번호" 
            , SAL*12 + NVL(COMM, 0) "연봉"
        FROM EMP
    )T
)S
WHERE S.전체연봉순위 <= 5;

------- 모범 풀이

SELECT 사원명, 부서번호, 연봉, 전체연봉순위
FROM EMP
WHERE 전체연봉순위가 1등부터 5등;

SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM,0) "연봉",
       RANK() OVER(ORDER BY SAL*12+NVL(COMM,0)) "전체연봉순위"
FROM EMP
WHERE 전체연봉순위가 1등부터 5등;

SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM,0) "연봉",
       RANK() OVER(ORDER BY SAL*12+NVL(COMM,0)) "전체연봉순위"
FROM EMP
WHERE RANK() OVER(ORDER BY SAL*12+NVL(COMM,0)) <= 5;
--==>> 에러발생 (윈도우함수는 WHERE에서 사용 불가)
/*
ORA-30483: window  functions are not allowed here
30483. 00000 -  "window  functions are not allowed here"
*Cause:    Window functions are allowed only in the SELECT list of a query.
           And, window function cannot be an argument to another window or group
           function.
*Action:
1,278행, 37열에서 오류 발생
*/

--※ 위의 내용은  RANK() OVER()함수를 WHERE 조건절에서 사용한 경우에며
--   이 함수는 WHERE 조건절에서 사용할 수 없기 때문에 발생하는 에러이다.
--   이 경우, 우리는 INLINE VIEW를 활용하여 문제를 해결해야 한다.

SELECT T.*
FROM
(
    SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM,0) "연봉",
           RANK() OVER(ORDER BY SAL*12+NVL(COMM,0)) "전체연봉순위"
    FROM EMP
)T
WHERE T.전체연봉순위 <= 5;
--==>>
/*
SMITH	20	9600	    1
JAMES	30	11400	2
ADAMS	20	13200	3
WARD	30	15500	4
MILLER	10	15600	5
*/



--○ EMP 테이블에서 각 부서별로 연봉 서열이 1위부터 2위까지만 조회한다.
--   사원번호, 사원명, 부서번호, 연봉, 부서내연봉서열, 전체연봉서열

SELECT T.*
FROM
(
    SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호"
         , SAL*12+NVL(COMM,0) "연봉"
         , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC) "부서내연봉서열"
         , DENSE_RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) "전체연봉서열"
    FROM EMP
)T
WHERE T.부서내연봉서열 <= 2;
--==>>
/*
7839	KING	10	60000	1	1
7782	CLARK	10	29400	2	5
7902	    FORD	20	36000	1	2
7788	SCOTT	20	36000	1	2
7566	JONES	20	35700	2	3
7698	BLAKE	30	34200	1	4
7499	ALLEN	30	19500	2	6
*/




