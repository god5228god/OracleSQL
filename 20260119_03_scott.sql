SELECT USER
FROM DUAL;
--==>> SCOTT


--※ 트리거 관련 실습

-- ○ 실습 테이블 생성
-- 테이블명: TBL_TEST1

CREATE TABLE TBL_TEST1
( ID    NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
);
--==>> Table TBL_TEST1이(가) 생성되었습니다.

-- 생성된 테이블에 제약조건 추가
-- ID 컬럼에 PK 제약조건 설정
ALTER TABLE TBL_TEST1
ADD CONSTRAINT TEST1_ID_PK PRIMARY KEY(ID);
--==>> Table TBL_TEST1이(가) 변경되었습니다.

-- ○ 실습 테이블 생성
-- 테이블명: TBL_EVENTLOG
CREATE TABLE TBL_EVENTLOG
( MEMO  VARCHAR2(200)
, ILJA  DATE    DEFAULT SYSDATE
);
--==>> Table TBL_EVENTLOG이(가) 생성되었습니다.

SELECT *
FROM TBL_TEST1;
--==>> 조회 결과 없음

SELECT *
FROM TBL_EVENTLOG;
--==>> 조회 결과 없음

--※ 날짜 세션 정보 설정
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

--○ TBL_TEST1 테이블에 데이터 입력
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(1, '강명철', '010-1111-1111');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(2, '안진모', '010-2222-2222');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(3, '양호열', '010-3333-3333');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(4, '윤주열', '010-4444-4444');
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_TEST1;
--==>>
/*
1	강명철	010-1111-1111
2	안진모	010-2222-2222
3	양호열	010-3333-3333
4	윤주열	010-4444-4444
*/


COMMIT;
--==>> 커밋 완료.

--○ TBL_TEST1 테이블의 데이터 수정
UPDATE TBL_TEST1
SET NAME = '이수빈', TEL = '010-5555-5555'
WHERE ID = 2;
--==>> 1 행 이(가) 업데이트되었습니다.

UPDATE TBL_TEST1
SET NAME = '임유원', TEL = '010-6666-6666'
WHERE ID = 3;
--==>> 1 행 이(가) 업데이트되었습니다.


SELECT *
FROM TBL_TEST1;
--==>>
/*
1	강명철	010-1111-1111
2	이수빈	010-5555-5555
3	임유원	010-6666-6666
4	윤주열	010-4444-4444
*/

COMMIT;
--==>> 커밋 완료.

--○ TBL_TEST1 테이블의 데이터 삭제
DELETE
FROM TBL_TEST1
WHERE ID = 4;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 3;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 2;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 1;
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_TEST1;
--==>> 조회 결과 없음

SELECT *
FROM TBL_EVENTLOG;
--==>>
/*
INSERT 쿼리문이 수행되었습니다.	2026-01-19 15:27:44
INSERT 쿼리문이 수행되었습니다.	2026-01-19 15:28:32
INSERT 쿼리문이 수행되었습니다.	2026-01-19 15:28:50
INSERT 쿼리문이 수행되었습니다.	2026-01-19 15:29:17
UPDATE 쿼리문이 수행되었습니다.	2026-01-19 15:31:11
UPDATE 쿼리문이 수행되었습니다.	2026-01-19 15:31:43
DELETE 쿼리문이 수행되었습니다.	2026-01-19 15:33:09
DELETE 쿼리문이 수행되었습니다.	2026-01-19 15:33:38
DELETE 쿼리문이 수행되었습니다.	2026-01-19 15:33:49
DELETE 쿼리문이 수행되었습니다.	2026-01-19 15:34:09
*/



--○ TBL_TEST1 테이블에 데이터 입력(→ 15:49 인 상태로 테스트)
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(1, '강명철', '010-1111-1111');
--==>> 1 행 이(가) 삽입되었습니다. 


--○ TBL_TEST1 테이블에 데이터 입력(→ 18:00 인 상태로 테스트)
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(2, '안진모', '010-2222-2222');
--==>> 에러 발생
/*
ORA-20003: 작업은 08:00 ~ 18:00 까지만 가능합니다.
*/

UPDATE TBL_TEST1
SET NAME = '양호열'
WHERE ID = 1;
--==>> 에러 발생
/*
ORA-20003: 작업은 08:00 ~ 18:00 까지만 가능합니다.
*/

DELETE
FROM TBL_TEST1
WHERE ID = 1;
--==>> 에러 발생
/*
ORA-20003: 작업은 08:00 ~ 18:00 까지만 가능합니다.
*/

COMMIT;
--==>> 커밋 완료.

DROP TABLE TBL_TEST1 PURGE;
--==>> Table TBL_TEST1이(가) 삭제되었습니다.



-- ○ 실습 테이블 생성(BEFOR ROW TRIGGER 실습 진행을 위한 테이블)
-- 테이블명:TBL_TEST1 → 부모 테이블
CREATE TABLE TBL_TEST1
( CODE  NUMBER      NOT NULL
, NAME  VARCHAR2(40)
, CONSTRAINT TEST1_CODE_PK PRIMARY KEY(CODE)
);
--==>> Table TBL_TEST1이(가) 생성되었습니다.


-- ○ 실습 테이블 생성(BEFOR ROW TRIGGER 실습 진행을 위한 테이블)
-- 테이블명:TBL_TEST2 → 자식 테이블
CREATE TABLE TBL_TEST2
( SID   NUMBER  NOT NULL
, CODE  NUMBER
, SU    NUMBER
, CONSTRAINT TEST2_SID_PK   PRIMARY KEY(SID)
, CONSTRAINT TEST2_CODE_FK  FOREIGN KEY(CODE)
        REFERENCES TBL_TEST1(CODE)
);
--==>> Table TBL_TEST2이(가) 생성되었습니다.


--○ 부모 테이블에 데이터 입력
INSERT INTO TBL_TEST1(CODE, NAME) VALUES(1, '냉장고');
INSERT INTO TBL_TEST1(CODE, NAME) VALUES(2, '세탁기');
INSERT INTO TBL_TEST1(CODE, NAME) VALUES(3, '건조기');
--==>> 1 행 이(가) 삽입되었습니다. * 3

SELECT *
FROM TBL_TEST1;
--==>>
/*
1	냉장고
2	세탁기
3	건조기
*/

--○ 자식 테이블에 데이터 입력
INSERT INTO TBL_TEST2(SID, CODE, SU) VALUES(1, 1, 20);
INSERT INTO TBL_TEST2(SID, CODE, SU) VALUES(2, 1, 20);
INSERT INTO TBL_TEST2(SID, CODE, SU) VALUES(3, 1, 20);
INSERT INTO TBL_TEST2(SID, CODE, SU) VALUES(4, 2, 20);
INSERT INTO TBL_TEST2(SID, CODE, SU) VALUES(5, 2, 20);
INSERT INTO TBL_TEST2(SID, CODE, SU) VALUES(6, 2, 20);
INSERT INTO TBL_TEST2(SID, CODE, SU) VALUES(7, 3, 20);
INSERT INTO TBL_TEST2(SID, CODE, SU) VALUES(8, 3, 20);
INSERT INTO TBL_TEST2(SID, CODE, SU) VALUES(9, 3, 20);
INSERT INTO TBL_TEST2(SID, CODE, SU) VALUES(10, 1, 20);
INSERT INTO TBL_TEST2(SID, CODE, SU) VALUES(11, 2, 20);
INSERT INTO TBL_TEST2(SID, CODE, SU) VALUES(12, 3, 20);
INSERT INTO TBL_TEST2(SID, CODE, SU) VALUES(13, 1, 20);
INSERT INTO TBL_TEST2(SID, CODE, SU) VALUES(14, 2, 20);
INSERT INTO TBL_TEST2(SID, CODE, SU) VALUES(15, 3, 20);
--==>> 1 행 이(가) 삽입되었습니다. * 15


SELECT *
FROM TBL_TEST2;
--==>>
/*
1	1	20
2	1	20
3	1	20
4	2	20
5	2	20
6	2	20
7	3	20
8	3	20
9	3	20
10	1	20
11	2	20
12	3	20
13	1	20
14	2	20
15	3	20
*/

SELECT C.SID, P.CODE, P.NAME, C.SU
FROM TBL_TEST1 P JOIN TBL_TEST2 C
ON P.CODE = C.CODE;
--==>>
/*
1	1	냉장고	20
2	1	냉장고	20
3	1	냉장고	20
4	2	세탁기	20
5	2	세탁기	20
6	2	세탁기	20
7	3	건조기	20
8	3	건조기	20
9	3	건조기	20
10	1	냉장고	20
11	2	세탁기	20
12	3	건조기	20
13	1	냉장고	20
14	2	세탁기	20
15	3	건조기	20
*/

COMMIT;
--==>> 커밋 완료.

DELETE
FROM TBL_TEST1
WHERE CODE = 1;
--==>> 에러발생
/*
ORA-02292: integrity constraint (SCOTT.TEST2_CODE_FK) violated - child record found
*/

DELETE
FROM TBL_TEST1
WHERE CODE = 2;
--==>> 에러발생
/*
ORA-02292: integrity constraint (SCOTT.TEST2_CODE_FK) violated - child record found
*/

DELETE
FROM TBL_TEST1
WHERE CODE = 3;
--==>> 에러발생
/*
ORA-02292: integrity constraint (SCOTT.TEST2_CODE_FK) violated - child record found
*/


UPDATE TBL_TEST2
SET CODE = 2
WHERE CODE = 3;
--==>> 5개 행 이(가) 업데이트되었습니다.

SELECT C.SID, P.CODE, P.NAME, C.SU
FROM TBL_TEST1 P JOIN TBL_TEST2 C
ON P.CODE = C.CODE;
--> 자식 테이블에 건조기 없는 상태

COMMIT;
--==>> 커밋 완료.



DELETE
FROM TBL_TEST1
WHERE CODE = 3;
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_TEST1;
--==>>
/*
1	냉장고
2	세탁기
*/



--※ 트리거 생성 이후 다시 테스트
SELECT *
FROM TBL_TEST1;
--==>>
/*
1	냉장고
2	세탁기
*/

SELECT *
FROM TBL_TEST2;

SELECT C.SID, P.CODE, P.NAME, C.SU
FROM TBL_TEST1 P JOIN TBL_TEST2 C
ON P.CODE = C.CODE;
--==>>
/*
1	1	냉장고	20
2	1	냉장고	20
3	1	냉장고	20
4	2	세탁기	20
5	2	세탁기	20
6	2	세탁기	20
7	2	세탁기	20
8	2	세탁기	20
9	2	세탁기	20
10	1	냉장고	20
11	2	세탁기	20
12	2	세탁기	20
13	1	냉장고	20
14	2	세탁기	20
15	2	세탁기	20
*/



DELETE
FROM TBL_TEST1
WHERE CODE = 1;
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_TEST1;
--==>> 2	세탁기

SELECT C.SID, P.CODE, P.NAME, C.SU
FROM TBL_TEST1 P JOIN TBL_TEST2 C
ON P.CODE = C.CODE;
--==>>
/*
4	2	세탁기	20
5	2	세탁기	20
6	2	세탁기	20
7	2	세탁기	20
8	2	세탁기	20
9	2	세탁기	20
11	2	세탁기	20
12	2	세탁기	20
14	2	세탁기	20
15	2	세탁기	20
*/

DELETE
FROM TBL_TEST1
WHERE CODE = 2;
--==>> 1 행 이(가) 삭제되었습니다.

SELECT C.SID, P.CODE, P.NAME, C.SU
FROM TBL_TEST1 P JOIN TBL_TEST2 C
ON P.CODE = C.CODE;
--==>> 조회 결과 없음

COMMIT;
--==>> 커밋 완료.


DROP TABLE TBL_TEST2 PURGE;
--==>> Table TBL_TEST2이(가) 삭제되었습니다.
DROP TABLE TBL_TEST1 PURGE;
--==>> Table TBL_TEST1이(가) 삭제되었습니다.


SELECT *
FROM TBL_상품;
--==>>
/*
H001	홈런볼	1500	    0
H002	새우깡	1200	0
H003	스윙칩	1000	50
H004	치토스	1100	0
H005	꼬북칩	1800	0
H006	오감자	2000	0
H007	양파링	1700	0
C001	초코칩	1800	0
C002	버터링	1900	0
C003	에이스	1700	    20
C004	오레오	2200	70
C005	다이제	2500	0
E001	마이쮸	1000	0
E002	엠엔엠	1100	10
E003	아이셔	1200	10
E004	비틀즈	1200	0
E005	아폴로	1000	0
*/


SELECT *
FROM TBL_입고;
--==>>
/*
1	H001	2026-01-15 15:19:18	20	1000
2	H001	2026-01-15 15:19:43	20	1000
3	H001	2026-01-15 15:19:45	20	1000
4	H003	2026-01-15 15:19:49	30	1000
5	C003	2026-01-15 15:19:51	10	1500
6	C004	2026-01-15 15:19:54	30	2000
7	H003	2026-01-15 15:19:56	20	1000
8	E002	2026-01-15 15:19:58	10	1000
9	E003	2026-01-15 15:20:00	40	1000
10	C004	2026-01-15 15:20:02	50	1800
11	C003	2026-01-15 15:20:05	30	1700
*/

INSERT INTO TBL_입고(입고번호, 상품코드, 입고수량, 입고단가)
VALUES(12, 'H001', 50, 1000);
--==>> 1 행 이(가) 삽입되었습니다

INSERT INTO TBL_입고(입고번호, 상품코드, 입고수량, 입고단가)
VALUES(13, 'C003', 10, 1000);
--==>> 1 행 이(가) 삽입되었습니다

SELECT *
FROM TBL_입고;
--==>>
/*
                :
                :
12	H001	2026-01-19 17:11:58	50	1000
13	C003	2026-01-19 17:12:59	10	1000
*/

COMMIT;


SELECT *
FROM TBL_상품;
--==>>
/*
H001	홈런볼	1500	    50
        :
C003	에이스	1700	    30
        :        
*/



