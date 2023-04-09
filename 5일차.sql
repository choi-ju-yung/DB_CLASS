
-- 기본테이블 작성하기
-- CREATE TABLE 테이블명 예(BOARD_COMMENT)(컬럼명 자료형(길이), 컬럼명2 자료형....);
-- 회원을 저장하는 테이블만들기
-- 이름 : 문자, 회원번호 : 숫자||문자, 아이디:문자, 패스워드:문자, 이메일:문자, 나이:숫자, 등록일 : 날짜


CREATE TABLE MEMBER(
    MEMBER_NAME VARCHAR2(20), -- 한글 한글자는 3바이트임 
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR(15),
    MEMBER_PWD VARCHAR(20),
    EMAIL VARCHAR(30),
    AGE NUMBER,
    ENROLL_DATE DATE
);

-- 생성된 테이블의 컬럼에 설명(COMMENT) 작성하기
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름 최소2글자이상 저장';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디 최소4글자이상';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호 최소8글자이상';

SELECT *
FROM USER_COL_COMMENTS -- 주석처리한 컬럼들을 저장한 테이블에 접근
WHERE TABLE_NAME = 'MEMBER'; -- 해당 멤버테이블에만 접근

-- 테이블에 커멘트 작성하기
COMMENT ON TABLE MEMBER IS '회원정보저장';  -- 멤버테이블에 커멘트 작성
SELECT * FROM USER_TAB_COMMENTS;  -- 주석처리한 테이블들을 저장한 테이블에 접근


-- 테이블의 각 컬럼에 저장되는 데이터의 특성에 따라 제약조건을 설정할 수 있다
-- 오라클이 제공하는 제약조건 5가지
-- NOT NULL(C) : 지정된 컬럼에 NULL값을 허용하지 않는 것  * (DEFAULT [기본값]) : NULLABLE (널값 입력가능)
-- UNIQUE(U) : 지정된 컬럼에 중복값을 허용하지 않는 것
-- PRIMARY KEY(P)/PK : 데이터(ROW) 구분하는 컬럼에 설정하는 제약조건 -> NOT NULL과 UNIQUE 제약 조건이 자동으로 설정됨
        -- 일반적으로 한개테이블에 한개 PK를 설정
        -- 다수 컬럼에 설정할 수도 있다(복합키)
-- FOREGIN KEY(R) : 지정된 컬럼의 값을 다른 테이블의 지정된 컬럼에 있는 값만 저장하게 하는 제약조건 
        -- 관계형데이터베이스에서는 참조임
        -- 다른테이블 지정된 컬럼은 중복이 있으면 안됨!(UNIQUE 제약조건이나 PK 제약조건이 설정된 컬럼)
-- CHECK(C) : 지정된 컬럼에 지정된 값을 저장하기 위한 제약조건 * 동등값, 범위값 지정


-- 테이블에 설정된 제약조건 확인하는 명령어
SELECT *  -- 테이블의 제약조건을 볼 수 있음
FROM USER_CONSTRAINTS;
SELECT *  -- 컬럼의 제약조건을 볼 수 있음
FROM USER_CONS_COLUMNS;

-- 위 두개를 조인해서 한번에 보기
SELECT C.CONSTRAINT_NAME, CONSTRAINT_TYPE, C.TABLE_NAME, SEARCH_CONDITION, COLUMN_NAME 
FROM USER_CONSTRAINTS C
    JOIN USER_CONS_COLUMNS CC ON C.CONSTRAINT_NAME = CC.CONSTRAINT_NAME;
    
-- 테이블에 제약조건 설정하기
-- 제약조건 설정하는 방법 2가지
-- 1. 테이블 생성과 동시에 설정하기
--    1) 컬럼레벨에서 설정
--        예) CREATE TABLE 테이블명(컬럼명 자료형 제약조건, 컬럼명2 자료형 제약조건,.....)
--    2) 테이블레벨에서 설정
--        예) CREATE TABLE 테이블명(컬럼명 자료형, 컬럼명2 자료형, 제약조건 설정....)

-- 2. 생성된 테이블에 제약조건 추가하기 -> ALTER 명령어 이용

-- NOT NULL 제약조건 설정하기
-- 컬럼레벨에서만 설정이 가능
CREATE TABLE BASIC_MEMBER(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
);

-- 제약조건이 설정되지 않으면 모든 컬럼에는 NULL값을 허용한다 = NULLABLE 이기 때문에
INSERT INTO BASIC_MEMBER VALUES(NULL, NULL, NULL, NULL, NULL);
SELECT * FROM BASIC_MEMBER;


-- ID, PASSWORD는 NULL을 허용하면 안되는 컬럼
-- 밑 테이블은 제약조건 걸기
CREATE TABLE NN_MEMBER(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
--    NOT NULL(MEMBER_NO) 테이블레벨에서 설정 불가능하다
);

INSERT INTO NN_MEMBER VALUES(NULL,NULL,NULL,NULL,NULL); -- 제약조건 건 곳에는 널값을 넣을 수 있음
INSERT INTO NN_MEMBER VALUES(NULL,'ADMIN','1234',NULL,NULL); -- 반드시 값이 필요한곳에는 NOT NULL 제약조건 넣어야함 
SELECT * FROM NN_MEMBER;


-- UNIQUE 제약조건
-- 컬럼이 유일한 값을 유지해야할 때 사용
SELECT * FROM BASIC_MEMBER;
INSERT INTO BASIC_MEMBER VALUES(1,'ADMIN','1234','관리자',48);
INSERT INTO BASIC_MEMBER VALUES(2,'ADMIN','3333','유저1',31); -- 아이디가 중복되면 안된다!


CREATE TABLE NQ_MEMBER(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
);

SELECT * FROM NQ_MEMBER;
INSERT INTO NQ_MEMBER VALUES('1','ADMIN','1234','관리자',44);
INSERT INTO NQ_MEMBER VALUES('2','ADMIN','1234','유저1',3); -- MEMBER_ID에 UNIQUE제약조건을 걸어놨기때문에 중복값 삽입 불가능

-- NULL 값에 대한 처리는 어떻게???
INSERT INTO NQ_MEMBER VALUES(3,NULL,'1234','유저2',22); -- UNIQUE제약조건만 걸었기 때문에 NULL값은 들어감
INSERT INTO NQ_MEMBER VALUES(4,NULL,'4444','유저3',11); -- NULL값은 동등비교가 안되기때문에 NULL값 추가로 들어감


-- NULL값과 UNIQUE 둘다 허용하지 않으려면
CREATE TABLE NQ_MEMBER2(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
);

SELECT * FROM NQ_MEMBER2;
INSERT INTO NQ_MEMBER2 VALUES(1,NULL,'1234','관리자',44); -- NOT NULL 제약조건으로 값이 들어가지 않음
INSERT INTO NQ_MEMBER2 VALUES(1,'ADMIN','1234','관리자',44); -- 값 삽입가능 (위배조건 없음)
INSERT INTO NQ_MEMBER2 VALUES(2,'ADMIN','2222','유저2',22); -- UNIQUE 제약조건으로 ADMIN이 중복되서 값이 들어가지 않음


-- UNIQUE 제약조건을 테이블레벨에서도 설정이 가능
CREATE TABLE NQ_MEMBER3(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER,
    UNIQUE(MEMBER_ID) -- UNIQUE는 테이블레벨에서 설정 가능  = 다수의 컬럼에 UNIQUE 제약조건을 설정할 때 사용
);

INSERT INTO NQ_MEMBER3 VALUES(1,'ADMIN','1234','관리자',45);
INSERT INTO NQ_MEMBER3 VALUES(2,'ADMIN','2222','관리자',45);  -- UNIQUE 제약조건으로 삽입 불가능


-- 다수 컬럼에 UNIQUE 제약조건 설정하기
-- 다수 컬럼의 값이 일치해야 중복값으로 인식 -> 선언컬럼이 하나의 그룹으로 묶임
CREATE TABLE NQ_MEMBER4(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER,
    UNIQUE(MEMBER_ID, MEMBER_NAME) -- 아이디와 이름 둘다 같아야 유니크 제약조건 걸림! 
    -- 아이디만 다르거나 이름만 다르면 다른값으로 인식됨
);

SELECT * FROM NQ_MEMBER4;
INSERT INTO NQ_MEMBER4 VALUES(1,'ADMIN','1234','관리자',44);
INSERT INTO NQ_MEMBER4 VALUES(2,'ADMIN','3333','유저1',33); -- 아이디는 같지만 이름이 다르기때문에 다른값이므로 값 삽입 가능
INSERT INTO NQ_MEMBER4 VALUES(3,'ADMIN','4444','관리자',24); -- 아이디와 이름이 둘 다 중복되기때문에 값 삽입 불가능


-- PRIMARY KEY 설정하기
-- 생성한 테이블의 컬럼 중 도메인이 중복값이 없고, NULL값을 허용하지 않을 때 그 컬럼에 설정
-- PK용 컬럼을 생성해서 활용 -> IDX, PRODUCTNO, BOARDNO => 주로 특정명을 만들어서 그 컬럼을 PK로 만듬
-- 저장되는 데이터 중 하나를 선택 설정
-- PK를 설정하면 자동으로 UNIQUE, NOT NULL 제약조건, INDEX가 부여됨.
CREATE TABLE PK_MEMBER
(
    MEMBER_NO NUMBER PRIMARY KEY, -- 기본키 설정
    MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
);

INSERT INTO PK_MEMBER VALUES(NULL,'ADMIN','1234','관리자',44); -- 기본키는 자동으로 NOT NULL 제약조건이 있어서 값삽입 불가능
INSERT INTO PK_MEMBER VALUES(1,'ADMIN','1234','관리자',44);
INSERT INTO PK_MEMBER VALUES(1,'USER01','2222','유저1',2); -- 기본키는 자동으로 UNIQUE 제약조건이 있어서 1이 중복됨 
SELECT * FROM PK_MEMBER;

-- PK 테이블 레벨에서 설정이 가능하다
CREATE TABLE PK_MEMBER1(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER,
    PRIMARY KEY(MEMBER_NO)  -- PK테이블 레벨에서 기본키 지정
);
INSERT INTO PK_MEMBER1 VALUES(1,'ADMIN','1234','관리자',44);


-- PRIMARY KEY를 다수컬럼에 설정할 수 있다. -> 복합키
-- 테이블 레벨에서 설정
CREATE TABLE PK_MEMBER2(
    MEMBER_NO NUMBER, 
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER,
    PRIMARY KEY(MEMBER_NO, MEMBER_ID)  -- 두개의 컬럼을 기본키로 설정 가능 
);

DROP TABLE PK_MEMBER2;
SELECT * FROM PK_MEMBER2;
INSERT INTO PK_MEMBER2 VALUES(1,'USER01','1111','유저1',33); -- 갑 삽잆 가능
INSERT INTO PK_MEMBER2 VALUES(2,'USER01','2222','유저2',22); -- 값 삽입 가능 (NO와 ID 둘다 동일해야 유니크조건에 걸림)
INSERT INTO PK_MEMBER2 VALUES(1,'USER01','2222','유저2',22); -- 값 삽입 불가능  (NO이나 ID 둘중 하나 다르면 다른값으로 인식)
INSERT INTO PK_MEMBER2 VALUES(NULL,'USER01','2222','유저2',22); -- NOT NULL 제약조건은 둘중 하나라도 NULL이면 값 삽입 불가능
INSERT INTO PK_MEMBER2 VALUES(1,NULL,'2222','유저2',22); -- NOT NULL 제약조건은 둘중 하나라도 NULL이면 값 삽입 불가능
-- 테이블에서는 NOT NULL은 사용 불가능한 이유 NOT NULL은 각각 OR 조건이기때문에 하나라도 NULL이면 위배되기 때문에


-- 구매테이블, 장바구니 테이블 등에 복합키를 설정할 수 있다.
CREATE TABLE CART(
    MEMBER_ID VARCHAR2(20),
    PRODUCT_NO NUMBER,
    BUY_DATE DATE,
    STOCK NUMBER,
    PRIMARY KEY(MEMBER_ID, PRODUCT_NO, BUY_DATE)  -- 3개의 값이 동시에 중복되면 값 추가 불가능
);


-- FOREIGN KEY 제약조건 설정하기
-- 다른 테이블에 있는 데이터를 가져와 사용하는 것 (참조)
-- 참조 관계를 설정하면 부모(참조 되는 테이블)-자식 관계(참조 하는 테이블) 관계가 설정이 됨
-- 학생과 과목 사이에 수강신청테이블이 있을 때 수강신청테이블이 자식테이블, 학생과 과목테이블은 부모테이블이 됨
-- FK제약조건은 자식테이블에 설정
-- FK제약조건을 설정하는 컬럼은 UNIQUE 제약조건이나 PK제약조건이 설정되어있어야 한다.

CREATE TABLE BOARD( -- 게시물 테이블
    BOARD_NO NUMBER PRIMARY KEY,
    BOART_TITLE VARCHAR2(200) NOT NULL,
    BOART_CONTENT VARCHAR2(3000),
    BOART_WRITER VARCHAR2(10) NOT NULL,
    BOART_DATE DATE
);

CREATE TABLE BOARD_COMMENT( -- 댓글테이블
    COMMENT_NO NUMBER PRIMARY KEY,
    COMMENT_CONTENT VARCHAR2(800),
    COMMENT_WRITER VARCHAR2(10),
    COMMENT_DATE DATE,
    BOARD_REF NUMBER REFERENCES BOARD(BOARD_NO) -- 게시물을 연결하는 참조변수
);


SELECT * FROM BOARD;
INSERT INTO BOARD VALUES(1,'냉무','빨라','관리자',SYSDATE);
INSERT INTO BOARD VALUES(2,'솔이씨....','너무하세요!!!','강민기',SYSDATE);
INSERT INTO BOARD VALUES(3,'선생님 오늘 금요일','금요잉린데 정리할 시간...없다','최주영',SYSDATE);
INSERT INTO BOARD VALUES(4,'선생님 오늘 금요일','금요잉린데 정리할 시간...없다','최주영',SYSDATE);


INSERT INTO BOARD_COMMENT VALUES(1,'네 없어요!!!','유병승',SYSDATE,3);
INSERT INTO BOARD_COMMENT VALUES(2,'전 그럴의도가 없었어요','최솔',SYSDATE,2);
INSERT INTO BOARD_COMMENT VALUES(3,'전그럴의도가 없었어요','최솔',SYSDATE,1); -- 부모키에 4번이 없기 때문에 오류뜸

SELECT *
FROM BOARD
    JOIN BOARD_COMMENT ON BOARD_NO = BOARD_REF;

SELECT * FROM BOARD;
SELECT * FROM BOARD_COMMENT;


-- FK가 설정된 컬럼에 NULL??? 저장된다. 저장하지 않으려면
-- BOARD_COMMENT에 NOT NULL 제약 조건을 넣어줘야함
INSERT INTO BOARD_COMMENT VALUES(5,'NULL들어가니?','최솔',SYSDATE,NULL); 

-- FOREIGN KEY 제약조건은 필수와 선택으로 나눠짐

-- FK를 설정해서 테이블간 관계가 설정이되면 참조되고 있는 부모테이블의
-- ROW를 함부러 삭제할 수 없다.
DELETE FROM BOARD WHERE BOARD_NO = 4;   -- BOARD_NO = 4인 값은 참조되고 있지 않고 있기때문에 삭제 가능


-- FK 설정할 때 삭제에 대한 옵션을 설정할 수 있다.
-- ON DELETE SET NULL : 참조컬럼을 NULL 값으로 수정 * 참조컬럼에 NOT NULL 제약조건이 있으면 안된다.  
--EX) 남은 데이터를 어디서든 써야할때 남김(회원 테이블과),(구매테이블) 관계
-- ON DELETE CASCADE : 참조되는 부모데이터가 삭제되면 값이 삭제버림 EX) 댓글테이블과, 게시물테이블 관계


CREATE TABLE BOARD_COMMENT2( -- 댓글테이블
    COMMENT_NO NUMBER PRIMARY KEY,
    COMMENT_CONTENT VARCHAR2(800),
    COMMENT_WRITER VARCHAR2(10),
    COMMENT_DATE DATE,
    BOARD_REF NUMBER REFERENCES BOARD(BOARD_NO) ON DELETE SET NULL -- 게시물을 연결하는 참조변수
);

INSERT INTO BOARD VALUES(5,'냉무',NULL,'유병승',SYSDATE);
INSERT INTO BOARD_COMMENT2 VALUES(7,'SET NULL','유병승',SYSDATE,5);
SELECT * FROM BOARD_COMMENT2;
DELETE FROM BOARD WHERE BOARD_NO = 7;
SELECT * FROM BOARD;


CREATE TABLE BOARD_COMMENT3( -- 댓글테이블
    COMMENT_NO NUMBER PRIMARY KEY,
    COMMENT_CONTENT VARCHAR2(800),
    COMMENT_WRITER VARCHAR2(10),
    COMMENT_DATE DATE,
    BOARD_REF NUMBER REFERENCES BOARD(BOARD_NO) ON DELETE CASCADE -- 같이삭제됨
);

INSERT INTO BOARD VALUES(6,'냉무',NULL,'유병승',SYSDATE);
INSERT INTO BOARD_COMMENT3 VALUES(8,'SET NULL','유병승',SYSDATE,6);
SELECT * FROM BOARD_COMMENT3;
DELETE FROM BOARD WHERE BOARD_NO = 6;
SELECT * FROM BOARD;


-- 참조관계를 설정할때 대상이 되는 컬럼에는 반드시 UNIQUE 또는 PK 제약조건이 설정되어 있어야한다.
-- MEMBER_ID는 제약조건이 안되있음
CREATE TABLE FK_TEST(
    FK_NO NUMBER,
    PARENT_NAME VARCHAR2(20), -- REFERENCES BASIC_MEMBER(MEMBER_ID)
    FOREIGN KEY(PARENT_NAME) REFERENCES NQ_MEMBER2(MEMBER_ID)
);

-- FK는 한개의 테이블만 가능 다수 컬럼을 지정할 수 없다.
-- FK설정하는 컬럼은 참조하는 컬럼과 타입, 길이(더커도 상관없음)가 일치해야 한다.


-- CHECK 제약조건
-- 컬럼에 지정한 값만 저장할 수 있게 하는 제약조건
-- 컬럼 레벨에서 가능
CREATE TABLE PERSON(
    NAME VARCHAR2(20),
    AGE NUMBER CHECK(AGE > 0) NOT NULL, -- 괄호안의 조건이 참이면 저장 가능
    GENDER VARCHAR2(5) CHECK(GENDER IN('남','여')) -- 남과 여만 입력받게함
);

INSERT INTO PERSON VALUES('유병승',-10,'남');  -- 나이가 0보다 작아서 (값 추가 불가)
INSERT INTO PERSON VALUES('유병승',19,'유');  -- 남,여 둘중 하나 입력한 성별이 아니라서 (값 추가 불가)


-- 테이블 생성시 디폴트값을 설정할 수 있음
-- DEFAULT 예약어 사용
CREATE TABLE DEFAULT_TEST(
    TEST_NO NUMBER PRIMARY KEY,
    TEST_DATE DATE DEFAULT SYSDATE,
    TEST_DATA VARCHAR2(20) DEFAULT '기본값'
);
INSERT INTO DEFAULT_TEST VALUES(1,DEFAULT,DEFAULT); -- 추가할 값이 없을때 DEFAULT 예약어를 사용해서 기본값을 넣을 수 있음
INSERT INTO DEFAULT_TEST VALUES(2,'23/02/04','데이터');
INSERT INTO DEFAULT_TEST(TEST_NO) VALUES(3); 

SELECT * FROM DEFAULT_TEST;


-- 제약설정시 이름 설정하기
-- 기본방식으로 제약조건을 설정하면 SYS00000으로 자동으로 설정됨
CREATE TABLE MEMBER_TEST(
    MEMBER_NO NUMBER CONSTRAINT MEMBER_NO_PK PRIMARY KEY,  -- 제약조건 이름 변경함 -> MEMBER_NO_PK
    MEMBER_ID VARCHAR2(20) CONSTRAINT MEMBER_ID_UQ UNIQUE NOT NULL,
    MEMBER_PWD VARCHAR2(20) CONSTRAINT MEMBER_PWD_NN NOT NULL,
    CONSTRAINT COMPOSE_UQ UNIQUE(MEMBER_NO, MEMBER_ID) -- 테이블명에서 이름 바꾸는 방법
);

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'MEMBER_TEST';


-- 테이블을 생성할 때 SELECT문을 이용할 수 있다.
-- 테이블 복사
CREATE TABLE EMP_COPY
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_COPY;

CREATE TABLE EMP_SAL -- 테이블 복사생성
AS SELECT E.*, (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE) AS SAL_DEPT_AVG
FROM EMPLOYEE E JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE;

SELECT * FROM EMP_SAL;

CREATE TABLE EMP_SAL2 -- 빈테이블만 생성
AS SELECT E.*, (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE) AS SAL_DEPT_AVG
FROM EMPLOYEE E JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE WHERE 1=2;

SELECT * FROM EMP_SAL2;



CREATE TABLE TEST_MEMBER(
    MEMBER_CODE NUMBER CONSTRAINT PK_MEMBER_CODE PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEMBER_PWD CHAR(20) NOT NULL,
    MEMBER_NAME NCHAR(10) DEFAULT '아무개',
    MEMBER_ADDR CHAR(50) NOT NULL,
    GENDER VARCHAR2(5) CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(20) NOT NULL,
    HEIGHT NUMBER(5,2) CHECK(HEIGHT > 130)
);

COMMENT ON COLUMN TEST_MEMBER.MEMBER_CODE IS '회원 전용코드';  -- 커멘트 달기
COMMENT ON COLUMN TEST_MEMBER.MEMBER_ID IS '회원 아이디';
COMMENT ON COLUMN TEST_MEMBER.MEMBER_PWD IS '회원 비밀번호';
COMMENT ON COLUMN TEST_MEMBER.MEMBER_NAME IS '회원 이름';
COMMENT ON COLUMN TEST_MEMBER.MEMBER_ADDR IS '회원 거주지';
COMMENT ON COLUMN TEST_MEMBER.GENDER IS '성별';
COMMENT ON COLUMN TEST_MEMBER.PHONE IS '회원 연락처';
COMMENT ON COLUMN TEST_MEMBER.HEIGHT IS '회원 키';



-- INSERT : 한행을 추가하는 것
-- DML 구문에 대해 알아보자
-- 데이터 조작 언어로 테이블에 값을 삽입(INSERT), 수정(UPDATE), 삭제(DELETE)하는 구문
-- INSERT : 테이블에 데이터(ROW)추가하는 명령어
-- UPDATE : 테이블에 있는 데이터의 특정컬럼을 수정하는 명령어
-- DELETE : 테이블에 있는 특정 ROW를 삭제하는 명령어

-- 1. 전체컬럼에 값을 대입하기
-- INSERT INTO 테이블명 VALUES(컬럼에 대입할 값, 컬럼에 대입할 값, 컬럼에 대입할 값....)
-- *테이블에 선언된 컬럼수와 동일해야한다

-- 2. 특정컬럼을 골라서 값을 대입하기
-- INSERT INTO 테이블명(특정컬럼, 특정컬럼...) VALUES(특정컬럼에 대입할값, 특정컬럼에 대입할 값......)
-- * 지정된 컬럼의 수와 VALUES에 있는 수와 같아야함
-- * 지정되지 않은 컬럼의 값을 NULL로 대입됨. 주의! 나머지 컬럼에 NOT NULL 제약 조건이 있으면 안된다.


CREATE TABLE TEMP_DEPT
AS SELECT  * FROM DEPARTMENT WHERE 1 = 0;  -- 뒤조건 때문에 빈 테이블 생성됨

SELECT * FROM TEMP_DEPT;

INSERT INTO TEMP_DEPT VALUES('D0','자바','L1');
INSERT INTO TEMP_DEPT VALUES('D1','오라클',TO_NUMBER('10'));

-- 컬럼을 지정해서 값을 대입하기
DESC TEMP_DEPT;
INSERT INTO TEMP_DEPT(DEPT_ID,LOCATION_ID) VALUES('D2','L3');
INSERT INTO TEMP_DEPT(DEPT_ID) VALUES('D3');  -- 값 삽입불가능 -> LOCATION_ID는 NOT NULL제약조건이 걸려있기때문에 NULL값으로못들어감

CREATE TABLE TESTINSERT(
    TESTNO NUMBER PRIMARY KEY,
    TESTCONTENT VARCHAR2(200) DEFAULT 'TEST' NOT NULL -- 기본값과 제약조건 같이 있을경우 기본값이 우선순위임
);

INSERT INTO TESTINSERT(TESTNO) VALUES(1);
SELECT * FROM TESTINSERT;


-- SELECT문을 이용해서 값 대입하기
-- 값을 복사해서 넣어주는 것임 (새로 생성하는것이 아님)
-- NOT NULL 제약 조건만 가져옴

CREATE TABLE INSERT_SUB
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID WHERE 1=2;
    
SELECT * FROM INSERT_SUB;
INSERT INTO INSERT_SUB(
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE SALARY > 3000000
);
SELECT * FROM INSERT_SUB;


-- EMPLOYE 테이블에서 부서가 D6인 사원들을 INSERT_SUB에 저장하기
-- UNIUQ 제약조건은 가져오지 않기 때문에 EMP_ID는 기본키로 가져오지 않음
INSERT INTO INSERT_SUB(
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE DEPT_CODE = 'D6'
);

-- 지정한 컬럼에 SELECT문으로 데이터 저장하기
INSERT INTO INSERT_SUB(EMP_ID, EMP_NAME)(SELECT EMP_ID, EMP_NAME FROM EMPLOYEE);


-- INSERT ALL
-- SELECT문을 이용해서 두개 이상의 테이블에 값을 넣을 때 사용
CREATE TABLE EMP_HIRE_DATE
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE FROM EMPLOYEE WHERE 1=0;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID FROM EMPLOYEE WHERE 1=0;

INSERT ALL
INTO EMP_HIRE_DATE VALUES(EMP_ID, EMP_NAME, HIRE_DATE) -- 24개 삽입
INTO EMP_MANAGER VALUES(EMP_ID,EMP_NAME,MANAGER_ID)  -- 24개 삽입
SELECT EMP_ID, EMP_NAME, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE;

SELECT * FROM EMP_HIRE_DATE;
SELECT * FROM EMP_MANAGER;

-- INSERT ALL 을 조건맞춰서 저장시키기
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE FROM EMPLOYEE WHERE 1=0;

CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE FROM EMPLOYEE WHERE 1=0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

-- EMPLOYEE 테이블에서 00년 이전 입사자는 EMP_OLD에 저장, 이후 입사자는 EMP_NEW에 저장하기
INSERT ALL 
WHEN HIRE_DATE < '00/01/01' THEN INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE) 
WHEN HIRE_DATE >= '00/01/01' THEN INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE)
SELECT EMP_ID, EMP_NAME, HIRE_DATE FROM EMPLOYEE;

