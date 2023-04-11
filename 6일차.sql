
-- DML
-- UPDATE�� Ȱ���ϱ�
-- UPDATE ���̺�� SET �������÷��� = �����Ұ�, �������÷��� = ������ ��...[WHERE ����]

CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY, BONUS
FROM EMPLOYEE;

SELECT * FROM EMP_SALARY;

-- �������� �޿��� 300�������� �����ϱ�
UPDATE EMP_SALARY SET SALARY = 3000000
WHERE EMP_NAME = '������';

-- �ټ� �÷����� ������ ���� , �� �����ؼ� �����Ѵ�.
UPDATE EMP_SALARY SET SALARY = 2500000, BONUS = 0.5
WHERE EMP_NAME = '������';

-- �ټ��� ROW�� �÷��� �����ϱ�


-- �μ��� D5�� ����� �޿��� �ʸ����� �߰��ϱ�
UPDATE EMP_SALARY SET SALARY = SALARY + 100000 WHERE DEPT_CODE = 'D5';
SELECT * FROM EMP_SALARY WHERE DEPT_CODE = 'D5';

-- �������� ���� ����� �޿��� 50���� �ø��� ���ʽ��� 0.4 �����ϱ�
UPDATE EMP_SALARY SET SALARY = SALARY + 500000, BONUS = 0.4
WHERE EMP_NAME LIKE '��%';

-- ������ �� ��������!! �ݵ�� WHERE�� �ۼ��ؼ� Ÿ���� ��Ȯ�ϰ� ����
-- WHERE�� �ۼ����� ������ ��ü ROW�� �����Ǵ� �����ؾ���
-- �߸� ��������ÿ� ROLLBACK �Լ� ȣ���ϸ� �� �ܰ�� ���ư�


-- UPDATE������ SELECT�� Ȱ���ϱ�
-- �ڸ���� �μ�, ���ʽ��� �ɺ����� �����ϰ� ��������
UPDATE EMP_SALARY 
SET DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '�ɺ���'),
    BONUS = (SELECT BONUS FROM EMPLOYEE WHERE EMP_NAME = '�ɺ���')
WHERE EMP_NAME = '����';


UPDATE EMP_SALARY
SET (DEPT_CODE, BONUS) = (SELECT DEPT_CODE, BONUS FROM EMPLOYEE WHERE EMP_NAME = '�ɺ���')
WHERE EMP_NAME = '����';


-- DML
-- DELETE Ȱ���ϱ�
-- ���̺��� ROW�� �����ϴ� ��ɾ�
-- DELETE FROM ���̺�� [WHERE ���ǽ�]
-- D9�� �μ����� �����ϱ�
DELETE FROM EMP_SALARY WHERE DEPT_CODE = 'D9';
SELECT * FROM EMP_SALARY;
ROLLBACK;
-- ��ü �� ����
DELETE FROM EMP_SALARY;


-- TRUNCATE ���� -> ROLLBACK �� �ȵ� (�ӵ��� DELETE���� ��������)
TRUNCATE TABLE EMP_SALARY; 




-- DDL (ALTER, ,DROP)
-- ALTER : ,����Ŭ�� ���ǵǾ��ִ� OBJECT�� ������ �� ����ϴ� ��ɾ�
-- ALTER TABLE : ���̺� ���ǵǾ��ִ� �÷�, ���������� ������ �� ���

CREATE TABLE TBL_USERALTER(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20)
);

SELECT * FROM TBL_USERALTER;
-- ������ TBL_USERALTER ���̺� �÷��� �߰��ϱ�
-- ALTER TABLE ���̺��ADD (�÷��� �ڷ��� [��������])
ALTER TABLE TBL_USERALTER ADD (USER_NAME VARCHAR2(20));
DESC TBL_USERALTER;

INSERT INTO TBL_USERALTER VALUES(1,'ADMIN','1234','������');

-- ���̺� �����Ͱ� �ִ� ���¿��� �÷��� �߰��ϸ�?
ALTER TABLE TBL_USERALTER ADD(NICKNAME VARCHAR2(30));
SELECT * FROM TBL_USERALTER;  -- �ΰ����� ��

-- �̸��� �ּ� �߰��� �� NOT NULL �������� ����
ALTER TABLE TBL_USERALTER ADD(EMAIL VARCHAR2(40) DEFAULT '�̼���' NOT NULL);  -- NOTNULL�� ���Ҷ��� ����Ʈ������ 
ALTER TABLE TBL_USERALTER ADD(GENDER VARCHAR2(10) CONSTRAINT GENDER_CK CHECK(GENDER IN('��','��')));
INSERT INTO TBL_USERALTER VALUES(2,'USER01','USER01','����1','����','USER01@USER01.COM','��');

-- �������� �߰��ϱ�
-- ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� �������Ǽ���
-- ó���� ������� �� �������� �������� �÷��� �������� �߰��ϱ�
ALTER TABLE TBL_USERALTER ADD CONSTRAINT USERID_UQ UNIQUE(USER_ID);

-- ���� �Ұ����� (USER_ID�� UNIQUE �������� �߰��߱⶧����)
INSERT INTO TBL_USERALTER VALUES(3,'USER01','USER02','����2','����2','USER01@USER02.COM','��');

-- NOT NULL ���� ������ �̹� �÷��� NULLABLE�� ������ �Ǿ��ֱ� ������ ADD�� �ƴ� MODIFY �������� ������Ѵ�
INSERT INTO TBL_USERALTER VALUES(4,'USER01',NULL,'����2','����2','USER01@USER02.COM','��');
--ALTER TABLE TBL_USERALTER ADD CONSTRAINT PASSWORD_NN NOT NULL;
ALTER TABLE TBL_USERALTER MODIFY USER_PWD CONSTRAINT USER_PWD_NN NOT NULL;

-- �÷� �����ϱ� -> �÷��� Ÿ��, ũ�⸦ �����ϴ� ��
-- ALTER TABLE ���̺�� MODIFY �÷��� �ڷ���
DESC TBL_USERALTER;
ALTER TABLE TBL_USERALTER MODIFY GENDER CHAR(10);

-- �������� �����ϱ�
ALTER TABLE TBL_USERALTER
MODIFY USER_PWD CONSTRAINT USER_PWD_UQ UNIQUE;

-- �÷��� �����ϱ�
-- ALTER TABLE ���̺�� RENAME COLUMN �÷��� TO �� �÷���
ALTER TABLE TBL_USERALTER RENAME COLUMN USER_ID TO USERID;
DESC TBL_USERALTER;

-- �������Ǹ� �����ϱ�
-- ALTER TABLE ���̺�� RENAME CONSTRAINT �������Ǹ� TO ���������Ǹ�
ALTER TABLE TBL_USERALTER RENAME CONSTRAINT SYS_C007433 TO USERALTER_PK;


-- �÷� �����ϱ�
-- ALTER TABLE ���̺�� DROP �÷���;
ALTER TABLE TBL_USERALTER DROP COLUMN EMAIL;
DESC TBL_USERALTER;


-- �������� �����ϱ�
-- ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;
ALTER TABLE TBL_USERALTER DROP CONSTRAINT USERALTER_PK;


-- ���̺� �����ϱ�
DROP TABLE TBL_USERALTER;
-- ���̺� ������ �� FK ���������� �����Ǿ� �ִٸ� �⺻������ ������ �Ұ�����
ALTER TABLE EMP_COPY ADD CONSTRAINT EMP_ID_PK PRIMARY KEY(EMP_ID); -- �ܷ�Ű�� �����ϱ� ���ؼ� �⺻Ű�� ���� 
CREATE TABLE TBL_FKTEST( -- FK ���Ǹ���� ���� ���̺� �ϳ� ����
    EMP_ID VARCHAR2(20) CONSTRAINT FK_EMPID REFERENCES EMP_COPY(EMP_ID),
    CONTENT VARCHAR2(20)
);

DROP TABLE EMP_COPY; -- �ܷ�Ű�� ���� �����Ǵ� ����/�⺻ Ű�� ���̺� �ֽ��ϴ� ��� �������� 

-- �ɼ��� �����ؼ� ������ �� �ִ�. [CASCADE CONSTRAINTS]
DROP TABLE EMP_COPY CASCADE CONSTRAINTS;



-- DCL -> SYSTEM ������ ������ (������ ����)
-- ������� ���Ѱ����ϴ� ��ɾ�
-- GRANT ����, ���� TO ����� ������
-- ���� : CREATE VIEW, CREATE TABLE, INSERT, SELECT, UPDATE ���
-- ����(ROLE) : ������ ����
-- ������ʹ� ������ �������� �ǽ��ؾ���
-- ������ �ϳ����ۿ� �ο����� (��ü ���� �ѹ��� ����)
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'RESOURCE';
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'CONNECT';

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER QWER IDENTIFIED BY QWER DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
GRANT CONNECT TO QWER;  -- ������ �� �� �ִ� ���Ѹ� ��

-- BS������ ���̺��� ��ȸ�� �� �ִ� ���� �ο��ϱ�
GRANT SELECT ON BS.EMPLOYEE TO QWER;
-- (BS������ EMPLOYEE ���̺���) ��ȸ�Ҽ� �ִ±����� QWER ������ ��

GRANT UPDATE ON BS.EMPLOYEE TO QWER;
-- (BS������ EMPLOYEE ���̺���) �����Ҽ� �ִ±����� QWER ������ ��


-- ��ȯȸ���ϱ�
-- REVOKE ���� || ROLE FROM ����ڰ�����
REVOKE UPDATE ON BS.EMPLOYEE FROM QWER;  -- QWER �������� UPDATE ���Ѻο��� �� �ٽ� ȸ���ϱ�


-- ROLE �����
CREATE ROLE MYROLE;  -- ���� ���� ROLE ����
GRANT CREATE TABLE, CREATE VIEW TO MYROLE; -- CREATE�� VIEW ������ MYROLE�� ����
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'MYROLE'; -- MYROLE�� ����� ���� ��ȸ
GRANT MYROLE TO QWER; -- QWER �������� MYROLE ���� ���� �ο�




SELECT * FROM BS.EMPLOYEE;
UPDATE BS.EMPLOYEE SET SALARY = 1000000;
ROLLBACK;

CREATE TABLE TEST(
    TESTNO NUMBER,
    TESTCONTENT VARCHAR2(200)
);


-- TCL : Ʈ�������� ��Ʈ���ϴ� ��ɾ�
-- COMMIT : ���ݱ��� ������ ��������(DML) ��ɾ ��� DB�� ����
-- ROLLBACK : ���ݱ��� ������ ��������(DML)��ɾ ��� ���
-- Ʈ������ : �ϳ��� �۾����� �Ѱ� ����
-- Ʈ�������� ���Ǵ� ��ɾ� : DML(INSERT, UPDATE, DELETE)
-- A���¿��� B���·� ���� ��ü�� ��  (1) A���� UPDATE  (2) B���� UPDATE �� �ι��� �Ǿ����Ѵ�
-- A���¿��� ���̺����� �������� ������ ������ ��   (1)�� ��
-- B���¿����� ���� ���� ���ѻ����̴� �� ������ ����Եȴ�
-- �� (1), (2) ������ �ϳ��� �۾������� ����
-- �� �� �ϳ��� ������ ����� ��ü ��ҵ�(ROLLBACK)
-- �� �����ϸ� ��� ����� (COMMIT)


INSERT INTO JOB VALUES('J0','����');
SELECT * FROM JOB;
-- �� �Ŀ� CMDâ���� BS �������� �α��� �� �� 
-- SELECT * FROM JOB; �ϸ� 
-- ���� �ȵ� �ִ� ���� �� �� �ִ�

COMMIT;
-- COMMIT ���Ŀ� �ٽ� CMDâ���� ��ü��ȸ�ϸ�
-- ���� �� �ִ� ���� �� �� �ִ�


-- ����Ŭ���� �����ϴ� OBJECT Ȱ���ϱ�
-- USER, TABLE, VIEW, SEQUENCE, INDEX, SYNONYM, FUNCTION, PROCEDURE, PACKAGE ���


CREATE TABLE EMP_M1
AS SELECT * FROM EMPLOYEE;
CREATE TABLE EMP_M2
AS SELECT * FROM EMPLOYEE WHERE JOB_CODE = 'J4';

INSERT INTO EMP_M2 VALUES(999,'���ο�','561014-123456','KWACK@DF.COM','01021314123','D5','J1','S1',90000,0.5,
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






