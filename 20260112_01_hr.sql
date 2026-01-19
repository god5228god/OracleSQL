

SELECT USER
FROM DUAL;


--○ CK 지정 실습(② 테이블 레벨의 형식)
-- 테이블 생성
-- 테이블명: TBL_TEST9
CREATE TABLE TBL_TEST9
( COL1  NUMBER(5)       
, COL2  VARCHAR2(30)    
, COL3  NUMBER(3)
, CONSTRAINT TEST9_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST9_COL3_CK CHECK(COL3 BETWEEN 0 AND 100)
);
--==>> Table TBL_TEST9이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(1, '현선', 100);
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '주열', 101);       --> 에러 발생
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(3, '수빈', -56);       --> 에러 발생
 INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(4, '유원', 80);
 

-- 확인
SELECT *
FROM TBL_TEST9;
--==>>
/*
1	현선	100
4	유원	80
*/

-- 커밋
COMMIT;
--==>> 커밋 완료.

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST9';
--==>>
/*
HR	TEST9_COL3_CK	TBL_TEST9	C	COL3	COL3 BETWEEN 0 AND 100	
HR	TEST9_COL1_PK	TBL_TEST9	P	COL1		
*/


--○ CK 지정 실습(③ 테이블 생성 이후 제약조건 추가)
-- 테이블 생성
-- 테이블명: TBL_TEST10

CREATE TABLE TBL_TEST10
( COL1     NUMBER(5)
, COL2     VARCHAR2(30)
, COL3     NUMBER(3)
);

--==>> Table TBL_TEST10이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>> 조회 결과 없음

-- 기존 테이블에 제약조건 추가
ALTER TABLE TBL_TEST10
ADD( CONSTRAINT TEST10_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST10_COL3_CK CHECK(COL3 BETWEEN 0 AND 100));
--==>> Table TBL_TEST10이(가) 변경되었습니다.

-- 추가 이후 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>>
/*
HR	TEST10_COL1_PK	TBL_TEST10	P	COL1		
HR	TEST10_COL3_CK	TBL_TEST10	C	COL3	COL3 BETWEEN 0 AND 100	
*/


--○ 실습을 위한 추가 테이블 생성
-- 테이블명: TBL_TESTMEMBER
CREATE TABLE TBL_TESTMEMBER
( SID  NUMBER
, NAME   VARCHAR2(30)
, SSN   CHAR(14)        -- 입력형태 → 'YYMMDD-NNNNNNN'
, TEL VARCHAR2(40)
);
--==>> Table TBL_TESTMEMBER이(가) 생성되었습니다.


--○ TBL_TESTMEMBER 테이블의 SSN(주민번호) 컬럼에서
-- 데이터 입력 및 수정 시 성별이 유효한 데이터만 처리될 수 있도록
-- 체크 제약조건을 추가할 수 있도록 한다.
-- → 성별 유효 데이터 → 특정 자리 1, 2, 3, 4 허용
-- 또한 SID 컬럼에는 PRIMARY KEY 제약조건을 설정할 수 있도록 한다.

-- ※ 제약조건 이름
--   - 제약조건의 이름은 최대 30자까지 지정할 수 있지만
--      인코딩 방식을 확인하여 가급적 너무 길지 않도록 설정한다.

ALTER TABLE TBL_TESTMEMBER
ADD ( CONSTRAINT TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TESTMEMBER_SSN_CK CHECK(SUBSTR(SSN,8,1) IN ('1','2','3','4')));
--==>> Table TBL_TESTMEMBER이(가) 변경되었습니다.

-- 추가 이후 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TESTMEMBER';

-- 데이터 입력 테스트
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES (1, '강명철', '990222-1234567', '010-1111-1111');
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES (2, '조세빈', '981219-2234567', '010-2222-2222');
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES (3, '윤주열', '170923-3234567', '010-3333-3333');
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES (4, '임유원', '110905-4234567', '010-4444-4444');
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES (5, '양호열', '920914-5234567', '010-5555-5555');       --> 에러 발생
--==>> ORA-02290: check constraint (HR.TESTMEMBER_SSN_CK) violated

-- 커밋
COMMIT;
--==>> 커밋 완료.

-- 확인
SELECT *
FROM TBL_TESTMEMBER;
--==>>
/*
1	강명철	990222-1234567	010-1111-1111
2	조세빈	981219-2234567	010-2222-2222
3	윤주열	170923-3234567	010-3333-3333
4	임유원	110905-4234567	010-4444-4444
*/

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TESTMEMBER';
--==>>
/*
HR	TESTMEMBER_SID_PK	TBL_TESTMEMBER	P	SID		
HR	TESTMEMBER_SSN_CK	TBL_TESTMEMBER	C	SSN	SUBSTR(SSN,8,1) IN ('1','2','3','4')	
*/

-- ■■■ FOREIGN KEY(FK:F:R) ■■■ --

-- 1. 참조 키, 외래 키로 두 테이블의 데이터 간 연결을 설정하고
--    강제 적용하는데 사용되는 열이다.
-- 2. 한 테이블의 기본 키 값이 있는 열을
--    다른 테이블에 추가하면 테이블 간 연결을 설정할 수 있다.
--    이때, 두 번째 테이블에 추가되는 열이 외래 키가 된다.
-- 3. 부모 테이블이 먼저 생성된 후 자식테이블(FOREIGN KEY를 포함하는 테이블)이
--    생성되어야 한다.
-- 4. FOREIGN KEY는 부모 테이블의 PRIMARY KEY, UNIQUE만 참조할 수 있고,
--    컬럼의 값과 일치하거나 NULL을 허용하는 경우 NULL이어야 한다.
-- 5. 부모 테이블의 컬럼명과 자식 테이블의 컬럼명은 일치하지 않아도 되지만
--    두 테이블의 자료형은 일치해야 한다.
-- 6. 참조 무결성 제약조건에서 부모 테이블의 참조 키 컬럼에 존재하지 않는 값을
--    자식 테이블에 입력하면 오류 발생한다.
-- 7.『ON DELETE SET NULL』은
--    자식 테이블이 참조하는 부모 테이블의 값이 삭제되면 자식 테이블의 값을
--    NULL로 변경시키게 된다.
-- 8. 『ON DELETE CASCADE』 옵션을 지정하면
--    부모 테이블의 데이터가 삭제되면 이를 참조하는 자식 테이블의 데이터도 삭제된다.
-- 9. 자식 테이블이 존재하는 경우 부모 테이블은 제거가 불가능 하다.
-- 10. 테이블을 제거하는 과정에서 (→ DROP TABLE)
--    『CASCADE CONSTRAINTS』 옵션을 부여하면
--    자식 테이블이 존재해도 부모 테이블을 제거할 수 있다.

-- 11. 형식 및 구조
-- ① 컬럼 레벨의 형식
--, 컬럼명 데이터타입  [CONSTRAINT CONSTRAINT명]
--                      REFERENCES 참조테이블명(참조컬럼명)
--                      [ON DELETE CASCADE | ON DELETE SET NULL]

-- ② 테이블 레벨의 형식
-- , 컬럼명 데이터타입
-- , 컬럼명 데이터타입
-- , CONSTRAINT CONSTRAINT명 FOREIGN KEY(컬럼명)
--              REFERENCES 참조테이블명(참조컬럼명)
--              [ON DELETE CASCADE | ON DELETE SET NULL]


-- 부모 테이블 생성
-- 테이블명: TBL_JOBS
CREATE TABLE TBL_JOBS
( JIKWI_ID      NUMBER
, JIKWI_NAME    VARCHAR2(30)
, CONSTRAINT JOBS_ID_PK PRIMARY KEY(JIKWI_ID)
);
--==>> Table TBL_JOBS이(가) 생성되었습니다.

-- 생성된 부모 테이블에 데이터 입력
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES (1, '사원');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES (2, '대리');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES (3, '과장');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES (4, '부장');
--==>> 1 행 이(가) 삽입되었습니다. * 4

-- 확인
SELECT *
FROM TBL_JOBS;
--==>> 
/*
1	사원
2	대리
3	과장
4	부장
*/

-- 커밋
COMMIT;
--==>> 커밋 완료.

--○ FK 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
-- 테이블명: TBL_EMP1
CREATE TABLE TBL_EMP1
( SID       NUMBER              PRIMARY KEY 
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER              REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP1이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007031	TBL_EMP1	P	SID		
HR	SYS_C007032	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/


-- 자식 테이블에 데이터 입력
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(1, '조세빈', 1);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(2, '정세찬', 2);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(3, '임유원', 3);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(4, '이수빈', 4);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5, '윤주열', 5);  --> 에러발생
--==>> ORA-02291: integrity constraint (HR.SYS_C007032) violated - parent key not found
INSERT INTO TBL_EMP1(SID, NAME) VALUES(6, '유현선');
INSERT INTO TBL_EMP1(SID, NAME, jikwi_id) VALUES(7, '양호열', NULL);

-- 확인
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	조세빈	1
2	정세찬	2
3	임유원	3
4	이수빈	4
6	유현선	(null)
7	양호열	(null)
*/

-- 커밋
COMMIT;
--==>> 커밋 완료.


--○ FK 지정 실습(② 테이블 레벨의 형식)
-- 테이블 생성
-- 테이블명: TBL_EMP2
CREATE TABLE TBL_EMP2
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
, CONSTRAINT EMP2_SID_PK PRIMARY KEY(SID)
, CONSTRAINT EMP2_JIKWI_ID_FK   FOREIGN KEY(JIKWI_ID)
             REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP2이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP2';
--==>>
/*
HR	EMP2_SID_PK	        TBL_EMP2	P	SID		
HR	EMP2_JIKWI_ID_FK	TBL_EMP2	R	JIKWI_ID		NO ACTION
*/


--○ FK 지정 실습(③ 테이블 생성 이후 제약조건 추가)
-- 테이블 생성
-- 테이블명: TBL_EMP3
CREATE TABLE TBL_EMP3
(SID        NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
);
--==>> Table TBL_EMP3이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>> 조회 결과 없음

-- 제약 조건 추가
ALTER TABLE TBL_EMP3
ADD (CONSTRAINT EMP3_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                REFERENCES TBL_JOBS(JIKWI_ID));
--==>> Table TBL_EMP3이(가) 변경되었습니다.

-- 다시 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>>
/*
HR	EMP3_SID_PK	        TBL_EMP3	P	SID		
HR	EMP3_JIKWI_ID_FK	TBL_EMP3	R	JIKWI_ID		NO ACTION
*/

-- ※ FOREIGN KEY 생성 시 주의사항
--  - 참조하고자 하는 부모 테이블을 먼저 생성해야 한다.
--  - 참조하고자 하는 컬럼이 PRIMARY KEY나 UNIQUE 제약조건이 있어야 한다.
--  - 테이블 간에 PRIMARY KEY와 FOREIGN KEY가 정의되어 있으면
--    PRIMARY KEY 제약조건이 설정된 컬럼의 데이터 삭제 시
--    FOREIGN KEY 컬럼에 그 값이 입력되어 있는 경우 삭제 되지 않는다.
--    (단, FK 설정 과정에서 『ON DELETE CASCADE』 나 
--    『ON DELETE SET NULL』 옵션을 사용하여 설정한 경우에는 삭제가 가능하다.)
--  - 부모 테이블을 제거하기 위해서는 자식 테이블을 먼저 제거해야 한다.


-- 부모 테이블
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	사원
2	대리
3	과장
4	부장
*/

-- 자식 테이블
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	조세빈	1
2	정세찬	2
3	임유원	3
4	이수빈	4
6	유현선	(null)
7	양호열	(null)
*/

-- 이수빈 부장의 직위를 사원으로 변경
UPDATE TBL_EMP1
SET JIKWI_ID = 1
WHERE SID=4;
--==>> 1 행 이(가) 업데이트되었습니다.

-- 확인
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	조세빈	1
2	정세찬	2
3	임유원	3
4	이수빈	1
6	유현선	(null)
7	양호열	(null)
*/

-- 커밋
COMMIT;
--==>> 커밋 완료.

-- 부모 테이블(TBL_JOBS)의 『사원』 데이터를 참조하는
-- 자식 테이블(TBL_EMP1)의 데이터가 2건 존재하는 상황

-- 이와 같은 상황에서 부모 테이블(TBL_JOBS)의
-- 『사원』 데이터 삭제
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> 에러 발생
/*
ORA-02292: integrity constraint (HR.SYS_C007032) violated - child record found
*/

-- 부모 테이블(TBL_JOBS) 제거
DROP TABLE TBL_JOBS;
--==>> 에러 발생
/*
ORA-02449: unique/primary keys in table referenced by foreign keys
02449. 00000 -  "unique/primary keys in table referenced by foreign keys"
*Cause:    An attempt was made to drop a table with unique or
           primary keys referenced by foreign keys in another table.
*Action:   Before performing the above operations the table, drop the
           foreign key constraints in other tables. You can see what
           constraints are referencing a table by issuing the following
           command:
           SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "tabnam";

*/

-- ※ 참조하고 있는 자식 테이블의 레코드가 존재하는 상황임에도 불구하고
--    부모 테이블의 데이터를 자유롭게 삭제하기 위해서는
--    『ON DELETE CASCADE』 옵션 지정이 필요하다.

-- TBL_EMP1 테이블(→ 자식 테이블)에서 FK 제약조건을 제거한 후
-- CASCADE 옵션을 포함한 상태로 다시 FK 제약조건을 설정한다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007031	TBL_EMP1	P	SID		
HR	SYS_C007032	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/

-- SYS_C007032

-- 제약조건 제거
ALTER TABLE TBL_EMP1
DROP CONSTRAINT SYS_C007032;
--==>> Table TBL_EMP1이(가) 변경되었습니다.

-- 제약조건 제거 이후 다시 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';

-- 『ON DELETE CASCADE』 옵션이 포함된 내용으로 제약조건 다시 지정
ALTER TABLE TBL_EMP1
ADD CONSTRAINT EMP1_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
               REFERENCES TBL_JOBS(JIKWI_ID)
               ON DELETE CASCADE;
--==>> Table TBL_EMP1이(가) 변경되었습니다.

-- 제약조건 다시 지정한 이후에 다시 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*

OWNER    CONSTRAINT_NAME        TABLE_NAME            C COLUMN_NAME     SEARCH_CONDITION    DELETE_RULE
-------- ---------------------- --------------------- - --------------- ------------------- ------------
HR       SYS_C007031            TBL_EMP1              P  SID                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
HR       EMP1_JIKWI_ID_FK       TBL_EMP1              R JIKWI_ID                            CASCADE ← CHECK!

*/

-- ※ CASCADE 옵션을 지정한 이후에는
--     참조 받고 있는 부모 테이블의 데이터를
--     언제든지 자유롭게 삭제하는 것이 가능하다.
--     단, 부모 테이블의 데이터가 삭제될 경우
--     이를 참조하는 자식 테이블의 데이터도 모두 함께 삭제된다. CHECK!

-- 부모 테이블
SELECT *
FROM TBL_JOBS;
--==>
/*
1	사원
2	대리
3	과장
4	부장
*/

-- 자식 테이블
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	조세빈	1       ←
2	정세찬	2
3	임유원	3
4	이수빈	1       ←
6	유현선	(null)
7	양호열	(null)
*/

--○ TBL_JOBS(→ 부모 테이블)의 사원 데이터 삭제
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID=1;
--==>> 1 행 이(가) 삭제되었습니다.

-- 부모 테이블
SELECT *
FROM TBL_JOBS;
--==>
/*
2	대리
3	과장
4	부장
*/

-- 자식 테이블
SELECT *
FROM TBL_EMP1;
--==>>
/*
2	정세찬	2
3	임유원	3
6	유현선	(null)
7	양호열	(null)
*/


-- ■■■ NOT NULL(NN:CK:C) ■■■ --

-- 1. 테이블에서 지정한 컬럼의 데이터가 NULL인 상태를 갖지 못하도록 하는 제약조건

-- 2. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- , 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명] NOT NULL

-- ② 테이블 레벨의 형식
-- , 컬럼명 데이터타입
-- , 컬럼명 데이터타입
-- , CONSTRAINT CONSTRAINT명 CHECK(컬렴명 IS NOT NULL)

-- 3. 기존에 생성되어 있는 테이블에 NOT NULL 제약조건을 추가할 경우
--    ADD 보다 MODIFY절이 더 많이 사용된다.
--    → ALTER TABLE 테이블명
--       MODIFY 컬럼명 데이터타입 NOT NULL;

-- 4. 기존 테이블에 데이터가 이미 들어있지 않은 컬럼(→ NULL인 상태)에
--    NOT NULL 제약조건을 부여하려는 경우에는 에러 발생

-- ※ 『' '』와 같이 공백이 있는 경우는 NULL이 아니다.

--○ NOT NULL 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
-- 테이블명: TBL_TEST11
CREATE TABLE TBL_TEST11
( COL1    NUMBER(5)     PRIMARY KEY
, COL2    VARCHAR2(30)  NOT NULL
);
--==>> Table TBL_TEST11이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST11(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST11(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST11(COL1, COL2) VALUES(3, 'NULL');
INSERT INTO TBL_TEST11(COL1, COL2) VALUES(4, NULL);     --> 에러 발생
INSERT INTO TBL_TEST11(COL1) VALUES(4);                 --> 에러 발생

-- 확인
SELECT *
FROM TBL_TEST11;
--==>>
/*
1	TEST
2	ABCD
3	NULL        → 문자 타입
*/

-- 커밋
COMMIT;
--==>> 커밋 완료.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST11';
--==>>
/*
HR	SYS_C007038	TBL_TEST11	C	COL2	"COL2" IS NOT NULL	
HR	SYS_C007039	TBL_TEST11	P	COL1		
*/


--○ NOT NULL 지정 실습(② 테이블 레벨의 형식)
-- 테이블 생성
-- 테이블명: TBL_TEST12
CREATE TABLE TBL_TEST12
(COL1   NUMBER(5)
,COL2   VARCHAR2(30)
, CONSTRAINT TEST12_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST12_COL2_NN CHECK(COL2 IS NOT NULL)
);
--==>> Table TBL_TEST12이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST12';
--==>>
/*
HR	TEST12_COL2_NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	
HR	TEST12_COL1_PK	TBL_TEST12	P	COL1		
*/


--○ NOT NULL 지정 실습(③ 테이블 생성 이후 제약조건 추가)
-- 테이블 생성
-- 테이블명: TBL_TEST13
CREATE TABLE TBL_TEST13
(COL1 NUMBER(5)
,COL2 VARCHAR2(30)
);
--==>> Table TBL_TEST13이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>> 조회 결과 없음

-- 제약조건 추가
ALTER TABLE TBL_TEST13
ADD ( CONSTRAINT TEST13_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST13_COL2_NN CHECK(COL2 IS NOT NULL));
--==>> Table TBL_TEST13이(가) 변경되었습니다.

-- 제약조건 추가 후 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>>
/*
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
*/


--※ 위의 실습에서는 PRIMARY KEY와 NOT NULL 제약조건을 함께 추가했는데
--   NOT NULL 제약조건만 추가하는 경우
--   다음과 같은 형태로 처리하는 것도 가능하다.
-- 테이블 생성
-- 테이블명: TBL_TEST14

CREATE TABLE TBL_TEST14
( COL1   NUMBER(5)
, COL2   VARCHAR2(30)
, CONSTRAINT TEST14_COL1_PK PRIMARY KEY(COL1)
);
--==>> Table TBL_TEST14이(가) 생성되었습니다.

-- 생성된 테이블에 NOT NULL 제약조건 추가
ALTER TABLE TBL_TEST14
MODIFY COL2 NOT NULL;
--==>> Table TBL_TEST14이(가) 변경되었습니다.


-- ※ 컬럼 레벨에서 NOT NULL 제약조건을 지정한 테이블
DESC TBL_TEST11;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/
--> DESC 명령을 통해 COL2 컬럼이 NOT NULL인 상태가 확인되는 상황

--※ 테이블 레벨에서 NOT NULL 제약조건을 지정한 테이블
DESC TBL_TEST12;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/
--> DESC 명령을 통해 COL2 컬럼이 NOT NULL인 상태가 확인되지 않는 상황


--※ 테이블 생성 이후 MODIFY 절을 통해 NOT NULL 제약 조건을 지정한 테이블
DESC TBL_TEST14;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/
--> DESC 명령을 통해 COL2 컬럼이 NOT NULL인 상태가 확인되는 상황


-- ■■■ DEFAULT 표현식 ■■■ --

-- 1. INSERT와 UPDATE 구문에서
--    사용자가 전달하는 특정 값이 아닌
--    기본적으로 설정된 값을 입력하거나
--    그 값으로 수정될 수 있도록 처리할 수 있다.

-- 2. 형식 및 구조
-- 컬럼명 데이터타입 DEFAULT 기본값;

-- 3. INSERT 명령 시 해당 컬럼에 입력될 값을 할당하지 않거나
--    DEFAULT 키워드를 활용하여 기본적으로 설정된 값을 입력하도록 할 수 있다.

-- 4. DEFAULT 키워드와 다른 제약(NOT NULL 등) 표기가 같이 오는 경우
--    DEFAULT 키워드를 먼저 표기(작성)할 것을 권장한다.


-- ○ DEFAULT 표현식 실습
-- 테이블 생성
-- 테이블명: TBL_BOARD
CREATE TABLE TBL_BOARD                              -- 게시판 실습 테이블 생성
( SID       NUMBER          PRIMARY KEY             -- 게시물 번호 → 식별자 → 자동 증가 처리
, NAME      VARCHAR2(30)                            -- 게시물 작성자
, CONTENTS  VARCHAR2(2000)                          -- 게시물 내용
, WRITEDAY  DATE            DEFAULT SYSDATE         -- 게시물 작성일 → 현재 날짜 자동 입력 처리
, COMMENTS  NUMBER          DEFAULT 0               -- 게시물의 댓글 갯수 → 기본값 0 처리
, COUNTS    NUMBER          DEFAULT 0               -- 게시물의 조회수 → 기본값 0 처리
);
--==>> Table TBL_BOARD이(가) 생성되었습니다.

--※ SID(게시물 번호)를 자동 증가 값으로 운영하려면 시퀀스 객체가 필요하다.
--   자동으로 입력되는 컬럼은 사용자가 입력해야 하는 항목에서
--   제외시킬 수 있다.

-- 시퀀스 생성
-- 시퀀스명: SEQ_BOARD
CREATE SEQUENCE SEQ_BOARD
NOCACHE;
--==>> Sequence SEQ_BOARD이(가) 생성되었습니다.

-- 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

-- 게시물 작성
INSERT INTO TBL_BOARD(SID, NAME, CONTENTS, WRITEDAY, COMMENTS, COUNTS)
VALUES(SEQ_BOARD.NEXTVAL, '강명철','오라클에서 DEFAULT 표현식을 실습 중입니다.'
      , TO_DATE('2025-11-28 15:04:20', 'YYYY-MM-DD HH24:MI:SS'), 0 , 0);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD(SID, NAME, CONTENTS, WRITEDAY, COMMENTS, COUNTS)
VALUES(SEQ_BOARD.NEXTVAL, '안진모','계속 실습 중입니다.'
      , SYSDATE, 0 , 0);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD(SID, NAME, CONTENTS, WRITEDAY, COMMENTS, COUNTS)
VALUES(SEQ_BOARD.NEXTVAL, '안진모','계속 실습 중입니다.', DEFAULT, DEFAULT , DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD(SID, NAME, CONTENTS, WRITEDAY, COMMENTS, COUNTS)
VALUES(SEQ_BOARD.NEXTVAL, '양호열','힘껏 실습 중입니다.'); 
--==>> 에러 발생
/*
SQL 오류: ORA-00947: not enough values
*/

INSERT INTO TBL_BOARD(SID, NAME, CONTENTS)
VALUES(SEQ_BOARD.NEXTVAL, '양호열','힘껏 실습 중입니다.'); 
--==>> 1 행 이(가) 삽입되었습니다.

-- 확인
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	강명철	오라클에서 DEFAULT 표현식을 실습 중입니다.	2025-11-28 15:04:20	0	0
2	안진모	계속 실습 중입니다.	                        2026-01-12 12:22:02	0	0
3	안진모	계속 실습 중입니다.	                        2026-01-12 12:22:47	0	0
4	양호열	힘껏 실습 중입니다.	                        2026-01-12 12:24:14	0	0
*/


--○ DEFAULT 표현식 조회(확인)
SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME='TBL_BOARD';
--==>>
/*
TBL_BOARD	SID	NUMBER			22			N	1													NO	NO		0		NO	YES	NONE
TBL_BOARD	NAME	VARCHAR2			30			Y	2											CHAR_CS	30	NO	NO		30	B	NO	YES	NONE
TBL_BOARD	CONTENTS	VARCHAR2			2000			Y	3											CHAR_CS	2000	NO	NO		2000	B	NO	YES	NONE
TBL_BOARD	WRITEDAY	DATE			7			Y	4	8	"SYSDATE
"											NO	NO		0		NO	YES	NONE
TBL_BOARD	COMMENTS	NUMBER			22			Y	5	2	"0
"											NO	NO		0		NO	YES	NONE
TBL_BOARD	COUNTS	NUMBER			22			Y	6	2	"0
"											NO	NO		0		NO	YES	NONE
*/


SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, DATA_DEFAULT
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME='TBL_BOARD';
--==>>
/*
TABLE_NAME      COLUMN_NAME     DATA_TYPE      DATA_DEFAULT                                                                    
-------------- --------------- -------------- ------------------
TBL_BOARD       SID             NUMBER                                                                                                                                                                                     
TBL_BOARD       NAME            VARCHAR2                                                                                            
TBL_BOARD       CONTENTS        VARCHAR2                                                                                            
TBL_BOARD       WRITEDAY        DATE           SYSDATE                                                                         
TBL_BOARD       COMMENTS        NUMBER         0                                                                               
TBL_BOARD       COUNTS          NUMBER         0        
*/


--○ 테이블 생성 이후 DEFAULT 표현식 추가/변경
ALTER TABLE 테이블명
MODIFY 컬럼명 [자료형] DEFAULT 기본값;


--○ 생성된 DEFAULT 표현식 제거(삭제)
ALTER TABLE 테이블명
MODIFY 컬럼명 [자료형] DEFAULT NULL;

































