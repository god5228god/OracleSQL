SELECT USER
FROM DUAL;
--==>> SCOTT

-- ■■■ 세 개의 테이블로 프로시저 실습 ■■■ --

-- ※ 관련 프로시저 생성은 『20260116_04_scott(plsql).sql』 파일 참조


SELECT *
FROM TAB;

--○ 휴지통 비우기
PURGE RECYCLEBIN;
--==>>RECYCLEBIN이(가) 비워졌습니다.

--○ 테이블 생성
-- 테이블명: TEST1
CREATE TABLE TEST1
( NUM   NUMBER          PRIMARY KEY                 -- 번호
, NAME  VARCHAR2(20)    NOT NULL                    -- 이름
);
--==>> Table TEST1이(가) 생성되었습니다.

--○ 테이블 생성
-- 테이블명: TEST2
CREATE TABLE TEST2                                  -- 번호
( NUM   NUMBER  NOT NULL                            -- 생년월일
, BIRTH DATE    NOT NULL 
, CONSTRAINT TEST2_NUM_PK   PRIMARY KEY(NUM)
, CONSTRAINT TEST2_BIRTH_FK FOREIGN KEY(NUM)
        REFERENCES TEST1(NUM)
);
--===>> Table TEST2이(가) 생성되었습니다.


--○ 테이블 생성
-- 테이블명: TEST3
CREATE TABLE TEST3
( NUM   NUMBER         NOT NULL                     -- 번호
, SCORE NUMBER(3)      NOT NULL                     -- 점수
, PAN  VARCHAR2(10)                                 -- 판정
, CONSTRAINT TEST3_NUM_PK PRIMARY KEY(NUM)
, CONSTRAINT TEST3_NUM_FK FOREIGN KEY(NUM)
        REFERENCES TEST1(NUM)
);
--==>> Table TEST3이(가) 생성되었습니다.

SELECT *
FROM SEQ;

DROP SEQUENCE SEQ_BOARD;
--==>> Sequence SEQ_BOARD이(가) 삭제되었습니다.


--○ 시퀀스 생성
-- 시퀀스명: TEST_SEQ
CREATE SEQUENCE TEST_SEQ
NOCACHE;
--==>> Sequence TEST_SEQ이(가) 생성되었습니다.

SELECT *
FROM TAB;

SELECT *
FROM SEQ;



--○ 제약조건 확인
SELECT UC.TABLE_NAME, UCC.COLUMN_NAME
     , UC.CONSTRAINT_NAME, UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
  ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
WHERE UC.TABLE_NAME IN ('TEST1', 'TEST2', 'TEST3');
--==>>
/*
TEST1	NAME	SYS_C007176	    C
TEST1	NUM	    SYS_C007177	    P
TEST2	NUM	    SYS_C007178	    C
TEST2	BIRTH	SYS_C007179	    C
TEST2	NUM	    TEST2_NUM_PK	P
TEST2	NUM	    TEST2_BIRTH_FK	R
TEST3	NUM	    SYS_C007182	    C
TEST3	SCORE	SYS_C007183	    C
TEST3	NUM	    TEST3_NUM_PK	P
TEST3	NUM	    TEST3_NUM_FK	R
*/


--○ 생성한 프로시저가 제대로 작동하는지의 여부 확인
--   『20260116_04_scott(plsql)』에서 생성한 『PRC_TEST_INSERT()』 프로시저
--    → 프로시저 호출
-- EXEC PRC_TEST_INSERT(이름, 생년월일, 점수)
EXEC PRC_TEST_INSERT('고길동', '1975-02-05', 88);
EXEC PRC_TEST_INSERT('도우너', '2000-10-10', 92);
EXEC PRC_TEST_INSERT('마이콜', '2000-11-11', 45);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다. * 3


SELECT *
FROM TEST1;
--==>>
/*
1	고길동
2	도우너
3	마이콜
*/

SELECT *
FROM TEST2;
--==>>
/*
1	1975-02-05
2	2000-10-10
3	2000-11-11
*/

SELECT *
FROM TEST3;
--==>>
/*
1	88	우수
2	92	우수
3	45	노력
*/

EXEC PRC_TEST_INSERT('희동이', '2020-11-11', 1000);
--==>> 에러 발생
/*
ORA-01438: value larger than specified precision allowed for this column
*/

--※ 점수가 세 자리이기 때문에 TEST3 테이블에 데이터를 추가하는 과정에서
--   문제가 발생하게 되어 이 데이터는 입력되지 않음.
--   따라서 TEST1, TEST2는 자동으로 ROLLBACK 처리된다.

SELECT *
FROM TEST1;
SELECT *
FROM TEST2;
SELECT *
FROM TEST3;

EXEC PRC_TEST_INSERT('희동이', '2020-11-11', 100);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT *
FROM TEST1;
SELECT *
FROM TEST2;
SELECT *
FROM TEST3;



--○ 생성한 프로시저가 제대로 작동하는지의 여부 확인
--   『20260116_04_scott(plsql)』에서 생성한 『PRC_TEST_UPDATE()』 프로시저
--    → 프로시저 호출
-- EXEC PRC_TEST_UPDATE(번호, 이름, 생년월일, 점수)
EXEC PRC_TEST_UPDATE(1, '둘리', '2025-12-20', 90);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
SELECT *
FROM TEST1;
SELECT *
FROM TEST2;
SELECT *
FROM TEST3;

EXEC PRC_TEST_UPDATE(2, '도우너', '2000-10-10', 62);

--○ 생성한 프로시저가 제대로 작동하는지의 여부 확인
--   『20260116_04_scott(plsql)』에서 생성한 『PRC_TEST_DELETE()』 프로시저
--    → 프로시저 호출
-- EXEC PRC_TEST_DELETE(번호)
EXEC PRC_TEST_DELETE(1);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT *
FROM TEST1;
SELECT *
FROM TEST2;
SELECT *
FROM TEST3;


--○ 생성한 프로시저가 제대로 작동하는지의 여부 확인
--   『20260116_04_scott(plsql)』에서 생성한 『PRC_NUM_SELECT()』 프로시저
--    → 프로시저 호출
-- EXEC PRC_NUM_SELECT(번호)
EXEC PRC_NUM_SELECT(2);
--==>>도우너   2000-10-10   62   보통

EXEC PRC_NUM_SELECT(3);
--==>> 마이콜   2000-11-11   45   노력

EXEC PRC_NUM_SELECT(5);
--==>> 희동이   2020-11-11   100   우수


--○ 생성한 프로시저가 제대로 작동하는지의 여부 확인
--   『20260116_04_scott(plsql)』에서 생성한 『PRC_TEST_ALL』 프로시저
--    → 프로시저 호출
-- EXEC PRC_TEST_ALL;
EXEC PRC_TEST_ALL;
--==>>
/*
도우너   2000-10-10    62   보통
마이콜   2000-11-11    45   노력
희동이   2020-11-11   100   우수
*/


--------------------------------------------------------------------------------



--○ 테이블 생성
-- 테이블명: EXAM1
CREATE TABLE EXAM1
( ID    NUMBER      NOT NULL
, NAME  VARCHAR2(20)
, SCORE NUMBER
, CONSTRAINT EXAM1_ID_PK    PRIMARY KEY(ID)
);
--==>> Table EXAM1이(가) 생성되었습니다.

--○ 데이터 입력
INSERT INTO EXAM1(ID, NAME, SCORE)
VALUES(1, '이순신', 100);
INSERT INTO EXAM1(ID, NAME, SCORE)
VALUES(2, '홍길동', 82);
INSERT INTO EXAM1(ID, NAME, SCORE)
VALUES(3, '김유신', 96);
INSERT INTO EXAM1(ID, NAME, SCORE)
VALUES(4, '강감찬', 88);
INSERT INTO EXAM1(ID, NAME, SCORE)
VALUES(5, '장보고', 97);
--==>> 1 행 이(가) 삽입되었습니다. * 5

--○ 확인
SELECT *
FROM EXAM1;
--==>>
/*
1	이순신	100
2	홍길동	 82
3	김유신	 96
4	강감찬	 88
5	장보고	 97
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.




