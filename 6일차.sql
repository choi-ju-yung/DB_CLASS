
-- DML
-- UPDATE문 활용하기
-- UPDATE 테이블명 SET 수정할컬럼명 = 수정할값, 수정할컬럼명 = 수정할 값...[WHERE 조건]

CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY, BONUS
FROM EMPLOYEE;

SELECT * FROM EMP_SALARY;

-- 정형돈의 급여를 300만원으로 수정하기
UPDATE EMP_SALARY SET SALARY = 3000000
WHERE EMP_NAME = '전형돈';

-- 다수 컬럼값을 수정할 때는 , 로 구분해서 대입한다.
UPDATE EMP_SALARY SET SALARY = 2500000, BONUS = 0.5
WHERE EMP_NAME = '전형돈';

-- 다수의 ROW와 컬럼을 수정하기


-- 부서가 D5인 사원의 급여을 십만원씩 추가하기
UPDATE EMP_SALARY SET SALARY = SALARY + 100000 WHERE DEPT_CODE = 'D5';
SELECT * FROM EMP_SALARY WHERE DEPT_CODE = 'D5';

-- 유씨성을 가진 사원의 급여를 50만원 올리고 보너스는 0.4 수정하기
UPDATE EMP_SALARY SET SALARY = SALARY + 500000, BONUS = 0.4
WHERE EMP_NAME LIKE '유%';

-- 수정할 때 주의할점!! 반드시 WHERE을 작성해서 타겟을 정확하게 설정
-- WHERE을 작성하지 않으면 전체 ROW가 수정되니 주의해야함
-- 잘못 변경됬을시에 ROLLBACK 함수 호출하면 전 단계로 돌아감


-- UPDATE문에서 SELECT문 활용하기
-- 박명수의 부서, 보너스를 심봉선과 동일하게 수정하자
UPDATE EMP_SALARY 
SET DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '심봉선'),
    BONUS = (SELECT BONUS FROM EMPLOYEE WHERE EMP_NAME = '심봉선')
WHERE EMP_NAME = '방명수';


UPDATE EMP_SALARY
SET (DEPT_CODE, BONUS) = (SELECT DEPT_CODE, BONUS FROM EMPLOYEE WHERE EMP_NAME = '심봉선')
WHERE EMP_NAME = '방명수';


-- DML
-- DELETE 활용하기
-- 테이블의 ROW를 삭제하는 명령어
-- DELETE FROM 테이블명 [WHERE 조건식]
-- D9인 부서원들 삭제하기
DELETE FROM EMP_SALARY WHERE DEPT_CODE = 'D9';
SELECT * FROM EMP_SALARY;
ROLLBACK;
-- 전체 다 삭제
DELETE FROM EMP_SALARY;


-- TRUNCATE 삭제 -> ROLLBACK 이 안됨 (속도는 DELETE보다 빠른편임)
TRUNCATE TABLE EMP_SALARY; 




-- DDL (ALTER, ,DROP)
-- ALTER : ,오라클에 정의되어있는 OBJECT를 수정할 때 사용하는 명령어
-- ALTER TABLE : 테이블에 정의되어있는 컬럼, 제약조건을 수정할 때 사용

CREATE TABLE TBL_USERALTER(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20)
);

SELECT * FROM TBL_USERALTER;
-- 생성된 TBL_USERALTER 테이블에 컬럼을 추가하기
-- ALTER TABLE 테이블명ADD (컬럼명 자료형 [제약조건])
ALTER TABLE TBL_USERALTER ADD (USER_NAME VARCHAR2(20));
DESC TBL_USERALTER;

INSERT INTO TBL_USERALTER VALUES(1,'ADMIN','1234','관리자');

-- 테이블에 데이터가 있는 상태에서 컬럼을 추가하면?
ALTER TABLE TBL_USERALTER ADD(NICKNAME VARCHAR2(30));
SELECT * FROM TBL_USERALTER;  -- 널값으로 들어감

-- 이메일 주소 추가할 때 NOT NULL 제약조건 설정
ALTER TABLE TBL_USERALTER ADD(EMAIL VARCHAR2(40) DEFAULT '미설정' NOT NULL);  -- NOTNULL로 못할때는 디폴트값으로 
ALTER TABLE TBL_USERALTER ADD(GENDER VARCHAR2(10) CONSTRAINT GENDER_CK CHECK(GENDER IN('남','여')));
INSERT INTO TBL_USERALTER VALUES(2,'USER01','USER01','유저1','유저','USER01@USER01.COM','여');

-- 제약조건 추가하기
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건설정
-- 처음에 만들었을 때 제약조건 설정못한 컬럼에 제약조건 추가하기
ALTER TABLE TBL_USERALTER ADD CONSTRAINT USERID_UQ UNIQUE(USER_ID);

-- 삽입 불가능함 (USER_ID에 UNIQUE 제약조건 추가했기때문에)
INSERT INTO TBL_USERALTER VALUES(3,'USER01','USER02','유저2','유저2','USER01@USER02.COM','남');

-- NOT NULL 제약 조건은 이미 컬럼에 NULLABLE로 설정이 되어있기 때문에 ADD가 아닌 MODIFY 변경으로 해줘야한다
INSERT INTO TBL_USERALTER VALUES(4,'USER01',NULL,'유저2','유저2','USER01@USER02.COM','남');
--ALTER TABLE TBL_USERALTER ADD CONSTRAINT PASSWORD_NN NOT NULL;
ALTER TABLE TBL_USERALTER MODIFY USER_PWD CONSTRAINT USER_PWD_NN NOT NULL;

-- 컬럼 수정하기 -> 컬럼의 타입, 크기를 변경하는 것
-- ALTER TABLE 테이블명 MODIFY 컬럼명 자료형
DESC TBL_USERALTER;
ALTER TABLE TBL_USERALTER MODIFY GENDER CHAR(10);

-- 제약조건 수정하기
ALTER TABLE TBL_USERALTER
MODIFY USER_PWD CONSTRAINT USER_PWD_UQ UNIQUE;

-- 컬럼명 변경하기
-- ALTER TABLE 테이블명 RENAME COLUMN 컬럼명 TO 새 컬럼명
ALTER TABLE TBL_USERALTER RENAME COLUMN USER_ID TO USERID;
DESC TBL_USERALTER;

-- 제약조건명 변경하기
-- ALTER TABLE 테이블명 RENAME CONSTRAINT 제약조건명 TO 새제약조건명
ALTER TABLE TBL_USERALTER RENAME CONSTRAINT SYS_C007433 TO USERALTER_PK;


-- 컬럼 삭제하기
-- ALTER TABLE 테이블명 DROP 컬럼명;
ALTER TABLE TBL_USERALTER DROP COLUMN EMAIL;
DESC TBL_USERALTER;


-- 제약조건 삭제하기
-- ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
ALTER TABLE TBL_USERALTER DROP CONSTRAINT USERALTER_PK;


-- 테이블 삭제하기
DROP TABLE TBL_USERALTER;
-- 테이블 삭제할 때 FK 제약조건이 설정되어 있다면 기본적으로 삭제가 불가능함
ALTER TABLE EMP_COPY ADD CONSTRAINT EMP_ID_PK PRIMARY KEY(EMP_ID); -- 외래키로 참조하기 위해서 기본키로 설정 
CREATE TABLE TBL_FKTEST( -- FK 조건만들기 위해 테이블 하나 생성
    EMP_ID VARCHAR2(20) CONSTRAINT FK_EMPID REFERENCES EMP_COPY(EMP_ID),
    CONTENT VARCHAR2(20)
);

DROP TABLE EMP_COPY; -- 외래키에 의해 참조되는 고유/기본 키가 테이블에 있습니다 라는 문구가뜸 

-- 옵션을 설정해서 삭제할 수 있다. [CASCADE CONSTRAINTS]
DROP TABLE EMP_COPY CASCADE CONSTRAINTS;



-- DCL -> SYSTEM 계정이 수행함 (관리자 계정)
-- 사용자의 권한관리하는 명령어
-- GRANT 권한, 역할 TO 사용자 계정명
-- 권한 : CREATE VIEW, CREATE TABLE, INSERT, SELECT, UPDATE 등등
-- 역할(ROLE) : 권한의 묶음
-- 여기부터는 관리자 계정으로 실습해야함
-- 권한은 하나씩밖에 부여못함 (전체 권한 한번에 못함)
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'RESOURCE';
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'CONNECT';

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER QWER IDENTIFIED BY QWER DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
GRANT CONNECT TO QWER;  -- 접속을 할 수 있는 권한만 줌

-- BS계정의 테이블을 조회할 수 있는 권한 부여하기
GRANT SELECT ON BS.EMPLOYEE TO QWER;
-- (BS계정의 EMPLOYEE 테이블을) 조회할수 있는권한을 QWER 계정에 줌

GRANT UPDATE ON BS.EMPLOYEE TO QWER;
-- (BS계정의 EMPLOYEE 테이블을) 수정할수 있는권한을 QWER 계정에 줌


-- 권환회수하기
-- REVOKE 권한 || ROLE FROM 사용자계정명
REVOKE UPDATE ON BS.EMPLOYEE FROM QWER;  -- QWER 계정에게 UPDATE 권한부여한 것 다시 회수하기


-- ROLE 만들기
CREATE ROLE MYROLE;  -- 권한 묶음 ROLE 만들어서
GRANT CREATE TABLE, CREATE VIEW TO MYROLE; -- CREATE와 VIEW 권한을 MYROLE에 저장
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'MYROLE'; -- MYROLE에 저장된 권한 조회
GRANT MYROLE TO QWER; -- QWER 계정에게 MYROLE 묶음 권한 부여




SELECT * FROM BS.EMPLOYEE;
UPDATE BS.EMPLOYEE SET SALARY = 1000000;
ROLLBACK;

CREATE TABLE TEST(
    TESTNO NUMBER,
    TESTCONTENT VARCHAR2(200)
);


-- TCL : 트렌젝션을 컨트롤하느 명령어
-- COMMIT : 지금까지 실행한 수정구문(DML) 명령어를 모두 DB에 저장
-- ROLLBACK : 지금까지 실행한 수정구문(DML)명령어를 모두 취소
-- 트렌젝션 : 하나의 작업단위 한개 서비스
-- 트렌젝션의 대상되는 명령어 : DML(INSERT, UPDATE, DELETE)
-- A계좌에서 B계좌로 돈을 이체할 때  (1) A계좌 UPDATE  (2) B계좌 UPDATE 총 두번이 되어어ㅑ한다
-- A계좌에서 돈이빠지는 과정에서 문제가 생겼을 시   (1)만 됨
-- B계좌에서는 돈을 받지 못한상태이다 즉 문제가 생기게된다
-- 즉 (1), (2) 과정을 하나의 작업단위로 묶음
-- 둘 중 하나라도 문제가 생기면 전체 취소됨(ROLLBACK)
-- 다 만족하면 모두 실행됨 (COMMIT)


INSERT INTO JOB VALUES('J0','강사');
SELECT * FROM JOB;
-- 이 후에 CMD창에서 BS 계정으로 로그인 한 후 
-- SELECT * FROM JOB; 하면 
-- 값이 안들어가 있는 것을 볼 수 있다

COMMIT;
-- COMMIT 이후에 다시 CMD창에서 전체조회하면
-- 값이 들어가 있는 것을 볼 수 있다


-- 오라클에서 제공하는 OBJECT 활용하기
-- USER, TABLE, VIEW, SEQUENCE, INDEX, SYNONYM, FUNCTION, PROCEDURE, PACKAGE 등등


CREATE TABLE EMP_M1
AS SELECT * FROM EMPLOYEE;
CREATE TABLE EMP_M2
AS SELECT * FROM EMPLOYEE WHERE JOB_CODE = 'J4';

INSERT INTO EMP_M2 VALUES(999,'곽두원','561014-123456','KWACK@DF.COM','01021314123','D5','J1','S1',90000,0.5,
        NULL,SYSDATE,DEFAULT,DEFAULT);

UPDATE EMP_M2 SET SALARY = 0;
COMMIT;
SELECT * FROM EMP_M1;
SELECT * FROM EMP_M2;

MERGE INTO EMP_M1 USING EMP_M2 ON(EMP_M1.EMP_ID=EMP_M2.EMP_ID)
WHEN MATCHED THEN
    UPDATE SET
        EMP_M1.SALARY=EMP_M2.SALARY
WHEN NOT MATCHED THEN
    INSERT VALUES(EMP_M2.EMP_ID,EMP_M2.EMP_NAME,EMP_M2.EMP_NO,EMP_M2.EMAIL,EMP_M2.PHONE,
        EMP_M2.DEPT_CODE,EMP_M2.JOB_CODE,EMP_M2.SAL_LEVEL,EMP_M2.SALARY,EMP_M2.BONUS,
        EMP_M2.MANAGER_ID,
        EMP_M2.HIRE_DATE,EMP_M2.ENT_DATE,EMP_M2.ENT_YN);






