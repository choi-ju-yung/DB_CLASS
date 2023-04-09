
-- �⺻���̺� �ۼ��ϱ�
-- CREATE TABLE ���̺�� ��(BOARD_COMMENT)(�÷��� �ڷ���(����), �÷���2 �ڷ���....);
-- ȸ���� �����ϴ� ���̺����
-- �̸� : ����, ȸ����ȣ : ����||����, ���̵�:����, �н�����:����, �̸���:����, ����:����, ����� : ��¥


CREATE TABLE MEMBER(
    MEMBER_NAME VARCHAR2(20), -- �ѱ� �ѱ��ڴ� 3����Ʈ�� 
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR(15),
    MEMBER_PWD VARCHAR(20),
    EMAIL VARCHAR(30),
    AGE NUMBER,
    ENROLL_DATE DATE
);

-- ������ ���̺��� �÷��� ����(COMMENT) �ۼ��ϱ�
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸� �ּ�2�����̻� ����';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵� �ּ�4�����̻�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ����й�ȣ �ּ�8�����̻�';

SELECT *
FROM USER_COL_COMMENTS -- �ּ�ó���� �÷����� ������ ���̺� ����
WHERE TABLE_NAME = 'MEMBER'; -- �ش� ������̺��� ����

-- ���̺� Ŀ��Ʈ �ۼ��ϱ�
COMMENT ON TABLE MEMBER IS 'ȸ����������';  -- ������̺� Ŀ��Ʈ �ۼ�
SELECT * FROM USER_TAB_COMMENTS;  -- �ּ�ó���� ���̺���� ������ ���̺� ����


-- ���̺��� �� �÷��� ����Ǵ� �������� Ư���� ���� ���������� ������ �� �ִ�
-- ����Ŭ�� �����ϴ� �������� 5����
-- NOT NULL(C) : ������ �÷��� NULL���� ������� �ʴ� ��  * (DEFAULT [�⺻��]) : NULLABLE (�ΰ� �Է°���)
-- UNIQUE(U) : ������ �÷��� �ߺ����� ������� �ʴ� ��
-- PRIMARY KEY(P)/PK : ������(ROW) �����ϴ� �÷��� �����ϴ� �������� -> NOT NULL�� UNIQUE ���� ������ �ڵ����� ������
        -- �Ϲ������� �Ѱ����̺� �Ѱ� PK�� ����
        -- �ټ� �÷��� ������ ���� �ִ�(����Ű)
-- FOREGIN KEY(R) : ������ �÷��� ���� �ٸ� ���̺��� ������ �÷��� �ִ� ���� �����ϰ� �ϴ� �������� 
        -- �����������ͺ��̽������� ������
        -- �ٸ����̺� ������ �÷��� �ߺ��� ������ �ȵ�!(UNIQUE ���������̳� PK ���������� ������ �÷�)
-- CHECK(C) : ������ �÷��� ������ ���� �����ϱ� ���� �������� * ���, ������ ����


-- ���̺� ������ �������� Ȯ���ϴ� ��ɾ�
SELECT *  -- ���̺��� ���������� �� �� ����
FROM USER_CONSTRAINTS;
SELECT *  -- �÷��� ���������� �� �� ����
FROM USER_CONS_COLUMNS;

-- �� �ΰ��� �����ؼ� �ѹ��� ����
SELECT C.CONSTRAINT_NAME, CONSTRAINT_TYPE, C.TABLE_NAME, SEARCH_CONDITION, COLUMN_NAME 
FROM USER_CONSTRAINTS C
    JOIN USER_CONS_COLUMNS CC ON C.CONSTRAINT_NAME = CC.CONSTRAINT_NAME;
    
-- ���̺� �������� �����ϱ�
-- �������� �����ϴ� ��� 2����
-- 1. ���̺� ������ ���ÿ� �����ϱ�
--    1) �÷��������� ����
--        ��) CREATE TABLE ���̺��(�÷��� �ڷ��� ��������, �÷���2 �ڷ��� ��������,.....)
--    2) ���̺������� ����
--        ��) CREATE TABLE ���̺��(�÷��� �ڷ���, �÷���2 �ڷ���, �������� ����....)

-- 2. ������ ���̺� �������� �߰��ϱ� -> ALTER ��ɾ� �̿�

-- NOT NULL �������� �����ϱ�
-- �÷����������� ������ ����
CREATE TABLE BASIC_MEMBER(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
);

-- ���������� �������� ������ ��� �÷����� NULL���� ����Ѵ� = NULLABLE �̱� ������
INSERT INTO BASIC_MEMBER VALUES(NULL, NULL, NULL, NULL, NULL);
SELECT * FROM BASIC_MEMBER;


-- ID, PASSWORD�� NULL�� ����ϸ� �ȵǴ� �÷�
-- �� ���̺��� �������� �ɱ�
CREATE TABLE NN_MEMBER(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
--    NOT NULL(MEMBER_NO) ���̺������� ���� �Ұ����ϴ�
);

INSERT INTO NN_MEMBER VALUES(NULL,NULL,NULL,NULL,NULL); -- �������� �� ������ �ΰ��� ���� �� ����
INSERT INTO NN_MEMBER VALUES(NULL,'ADMIN','1234',NULL,NULL); -- �ݵ�� ���� �ʿ��Ѱ����� NOT NULL �������� �־���� 
SELECT * FROM NN_MEMBER;


-- UNIQUE ��������
-- �÷��� ������ ���� �����ؾ��� �� ���
SELECT * FROM BASIC_MEMBER;
INSERT INTO BASIC_MEMBER VALUES(1,'ADMIN','1234','������',48);
INSERT INTO BASIC_MEMBER VALUES(2,'ADMIN','3333','����1',31); -- ���̵� �ߺ��Ǹ� �ȵȴ�!


CREATE TABLE NQ_MEMBER(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
);

SELECT * FROM NQ_MEMBER;
INSERT INTO NQ_MEMBER VALUES('1','ADMIN','1234','������',44);
INSERT INTO NQ_MEMBER VALUES('2','ADMIN','1234','����1',3); -- MEMBER_ID�� UNIQUE���������� �ɾ���⶧���� �ߺ��� ���� �Ұ���

-- NULL ���� ���� ó���� ���???
INSERT INTO NQ_MEMBER VALUES(3,NULL,'1234','����2',22); -- UNIQUE�������Ǹ� �ɾ��� ������ NULL���� ��
INSERT INTO NQ_MEMBER VALUES(4,NULL,'4444','����3',11); -- NULL���� ����񱳰� �ȵǱ⶧���� NULL�� �߰��� ��


-- NULL���� UNIQUE �Ѵ� ������� ��������
CREATE TABLE NQ_MEMBER2(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
);

SELECT * FROM NQ_MEMBER2;
INSERT INTO NQ_MEMBER2 VALUES(1,NULL,'1234','������',44); -- NOT NULL ������������ ���� ���� ����
INSERT INTO NQ_MEMBER2 VALUES(1,'ADMIN','1234','������',44); -- �� ���԰��� (�������� ����)
INSERT INTO NQ_MEMBER2 VALUES(2,'ADMIN','2222','����2',22); -- UNIQUE ������������ ADMIN�� �ߺ��Ǽ� ���� ���� ����


-- UNIQUE ���������� ���̺��������� ������ ����
CREATE TABLE NQ_MEMBER3(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER,
    UNIQUE(MEMBER_ID) -- UNIQUE�� ���̺������� ���� ����  = �ټ��� �÷��� UNIQUE ���������� ������ �� ���
);

INSERT INTO NQ_MEMBER3 VALUES(1,'ADMIN','1234','������',45);
INSERT INTO NQ_MEMBER3 VALUES(2,'ADMIN','2222','������',45);  -- UNIQUE ������������ ���� �Ұ���


-- �ټ� �÷��� UNIQUE �������� �����ϱ�
-- �ټ� �÷��� ���� ��ġ�ؾ� �ߺ������� �ν� -> �����÷��� �ϳ��� �׷����� ����
CREATE TABLE NQ_MEMBER4(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER,
    UNIQUE(MEMBER_ID, MEMBER_NAME) -- ���̵�� �̸� �Ѵ� ���ƾ� ����ũ �������� �ɸ�! 
    -- ���̵� �ٸ��ų� �̸��� �ٸ��� �ٸ������� �νĵ�
);

SELECT * FROM NQ_MEMBER4;
INSERT INTO NQ_MEMBER4 VALUES(1,'ADMIN','1234','������',44);
INSERT INTO NQ_MEMBER4 VALUES(2,'ADMIN','3333','����1',33); -- ���̵�� ������ �̸��� �ٸ��⶧���� �ٸ����̹Ƿ� �� ���� ����
INSERT INTO NQ_MEMBER4 VALUES(3,'ADMIN','4444','������',24); -- ���̵�� �̸��� �� �� �ߺ��Ǳ⶧���� �� ���� �Ұ���


-- PRIMARY KEY �����ϱ�
-- ������ ���̺��� �÷� �� �������� �ߺ����� ����, NULL���� ������� ���� �� �� �÷��� ����
-- PK�� �÷��� �����ؼ� Ȱ�� -> IDX, PRODUCTNO, BOARDNO => �ַ� Ư������ ���� �� �÷��� PK�� ����
-- ����Ǵ� ������ �� �ϳ��� ���� ����
-- PK�� �����ϸ� �ڵ����� UNIQUE, NOT NULL ��������, INDEX�� �ο���.
CREATE TABLE PK_MEMBER
(
    MEMBER_NO NUMBER PRIMARY KEY, -- �⺻Ű ����
    MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
);

INSERT INTO PK_MEMBER VALUES(NULL,'ADMIN','1234','������',44); -- �⺻Ű�� �ڵ����� NOT NULL ���������� �־ ������ �Ұ���
INSERT INTO PK_MEMBER VALUES(1,'ADMIN','1234','������',44);
INSERT INTO PK_MEMBER VALUES(1,'USER01','2222','����1',2); -- �⺻Ű�� �ڵ����� UNIQUE ���������� �־ 1�� �ߺ��� 
SELECT * FROM PK_MEMBER;

-- PK ���̺� �������� ������ �����ϴ�
CREATE TABLE PK_MEMBER1(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER,
    PRIMARY KEY(MEMBER_NO)  -- PK���̺� �������� �⺻Ű ����
);
INSERT INTO PK_MEMBER1 VALUES(1,'ADMIN','1234','������',44);


-- PRIMARY KEY�� �ټ��÷��� ������ �� �ִ�. -> ����Ű
-- ���̺� �������� ����
CREATE TABLE PK_MEMBER2(
    MEMBER_NO NUMBER, 
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER,
    PRIMARY KEY(MEMBER_NO, MEMBER_ID)  -- �ΰ��� �÷��� �⺻Ű�� ���� ���� 
);

DROP TABLE PK_MEMBER2;
SELECT * FROM PK_MEMBER2;
INSERT INTO PK_MEMBER2 VALUES(1,'USER01','1111','����1',33); -- �� ��� ����
INSERT INTO PK_MEMBER2 VALUES(2,'USER01','2222','����2',22); -- �� ���� ���� (NO�� ID �Ѵ� �����ؾ� ����ũ���ǿ� �ɸ�)
INSERT INTO PK_MEMBER2 VALUES(1,'USER01','2222','����2',22); -- �� ���� �Ұ���  (NO�̳� ID ���� �ϳ� �ٸ��� �ٸ������� �ν�)
INSERT INTO PK_MEMBER2 VALUES(NULL,'USER01','2222','����2',22); -- NOT NULL ���������� ���� �ϳ��� NULL�̸� �� ���� �Ұ���
INSERT INTO PK_MEMBER2 VALUES(1,NULL,'2222','����2',22); -- NOT NULL ���������� ���� �ϳ��� NULL�̸� �� ���� �Ұ���
-- ���̺����� NOT NULL�� ��� �Ұ����� ���� NOT NULL�� ���� OR �����̱⶧���� �ϳ��� NULL�̸� ����Ǳ� ������


-- �������̺�, ��ٱ��� ���̺� � ����Ű�� ������ �� �ִ�.
CREATE TABLE CART(
    MEMBER_ID VARCHAR2(20),
    PRODUCT_NO NUMBER,
    BUY_DATE DATE,
    STOCK NUMBER,
    PRIMARY KEY(MEMBER_ID, PRODUCT_NO, BUY_DATE)  -- 3���� ���� ���ÿ� �ߺ��Ǹ� �� �߰� �Ұ���
);


-- FOREIGN KEY �������� �����ϱ�
-- �ٸ� ���̺� �ִ� �����͸� ������ ����ϴ� �� (����)
-- ���� ���踦 �����ϸ� �θ�(���� �Ǵ� ���̺�)-�ڽ� ����(���� �ϴ� ���̺�) ���谡 ������ ��
-- �л��� ���� ���̿� ������û���̺��� ���� �� ������û���̺��� �ڽ����̺�, �л��� �������̺��� �θ����̺��� ��
-- FK���������� �ڽ����̺� ����
-- FK���������� �����ϴ� �÷��� UNIQUE ���������̳� PK���������� �����Ǿ��־�� �Ѵ�.

CREATE TABLE BOARD( -- �Խù� ���̺�
    BOARD_NO NUMBER PRIMARY KEY,
    BOART_TITLE VARCHAR2(200) NOT NULL,
    BOART_CONTENT VARCHAR2(3000),
    BOART_WRITER VARCHAR2(10) NOT NULL,
    BOART_DATE DATE
);

CREATE TABLE BOARD_COMMENT( -- ������̺�
    COMMENT_NO NUMBER PRIMARY KEY,
    COMMENT_CONTENT VARCHAR2(800),
    COMMENT_WRITER VARCHAR2(10),
    COMMENT_DATE DATE,
    BOARD_REF NUMBER REFERENCES BOARD(BOARD_NO) -- �Խù��� �����ϴ� ��������
);


SELECT * FROM BOARD;
INSERT INTO BOARD VALUES(1,'�ù�','����','������',SYSDATE);
INSERT INTO BOARD VALUES(2,'���̾�....','�ʹ��ϼ���!!!','���α�',SYSDATE);
INSERT INTO BOARD VALUES(3,'������ ���� �ݿ���','�ݿ��׸��� ������ �ð�...����','���ֿ�',SYSDATE);
INSERT INTO BOARD VALUES(4,'������ ���� �ݿ���','�ݿ��׸��� ������ �ð�...����','���ֿ�',SYSDATE);


INSERT INTO BOARD_COMMENT VALUES(1,'�� �����!!!','������',SYSDATE,3);
INSERT INTO BOARD_COMMENT VALUES(2,'�� �׷��ǵ��� �������','�ּ�',SYSDATE,2);
INSERT INTO BOARD_COMMENT VALUES(3,'���׷��ǵ��� �������','�ּ�',SYSDATE,1); -- �θ�Ű�� 4���� ���� ������ ������

SELECT *
FROM BOARD
    JOIN BOARD_COMMENT ON BOARD_NO = BOARD_REF;

SELECT * FROM BOARD;
SELECT * FROM BOARD_COMMENT;


-- FK�� ������ �÷��� NULL??? ����ȴ�. �������� ��������
-- BOARD_COMMENT�� NOT NULL ���� ������ �־������
INSERT INTO BOARD_COMMENT VALUES(5,'NULL����?','�ּ�',SYSDATE,NULL); 

-- FOREIGN KEY ���������� �ʼ��� �������� ������

-- FK�� �����ؼ� ���̺� ���谡 �����̵Ǹ� �����ǰ� �ִ� �θ����̺���
-- ROW�� �Ժη� ������ �� ����.
DELETE FROM BOARD WHERE BOARD_NO = 4;   -- BOARD_NO = 4�� ���� �����ǰ� ���� �ʰ� �ֱ⶧���� ���� ����


-- FK ������ �� ������ ���� �ɼ��� ������ �� �ִ�.
-- ON DELETE SET NULL : �����÷��� NULL ������ ���� * �����÷��� NOT NULL ���������� ������ �ȵȴ�.  
--EX) ���� �����͸� ��𼭵� ����Ҷ� ����(ȸ�� ���̺��),(�������̺�) ����
-- ON DELETE CASCADE : �����Ǵ� �θ����Ͱ� �����Ǹ� ���� �������� EX) ������̺��, �Խù����̺� ����


CREATE TABLE BOARD_COMMENT2( -- ������̺�
    COMMENT_NO NUMBER PRIMARY KEY,
    COMMENT_CONTENT VARCHAR2(800),
    COMMENT_WRITER VARCHAR2(10),
    COMMENT_DATE DATE,
    BOARD_REF NUMBER REFERENCES BOARD(BOARD_NO) ON DELETE SET NULL -- �Խù��� �����ϴ� ��������
);

INSERT INTO BOARD VALUES(5,'�ù�',NULL,'������',SYSDATE);
INSERT INTO BOARD_COMMENT2 VALUES(7,'SET NULL','������',SYSDATE,5);
SELECT * FROM BOARD_COMMENT2;
DELETE FROM BOARD WHERE BOARD_NO = 7;
SELECT * FROM BOARD;


CREATE TABLE BOARD_COMMENT3( -- ������̺�
    COMMENT_NO NUMBER PRIMARY KEY,
    COMMENT_CONTENT VARCHAR2(800),
    COMMENT_WRITER VARCHAR2(10),
    COMMENT_DATE DATE,
    BOARD_REF NUMBER REFERENCES BOARD(BOARD_NO) ON DELETE CASCADE -- ���̻�����
);

INSERT INTO BOARD VALUES(6,'�ù�',NULL,'������',SYSDATE);
INSERT INTO BOARD_COMMENT3 VALUES(8,'SET NULL','������',SYSDATE,6);
SELECT * FROM BOARD_COMMENT3;
DELETE FROM BOARD WHERE BOARD_NO = 6;
SELECT * FROM BOARD;


-- �������踦 �����Ҷ� ����� �Ǵ� �÷����� �ݵ�� UNIQUE �Ǵ� PK ���������� �����Ǿ� �־���Ѵ�.
-- MEMBER_ID�� ���������� �ȵ�����
CREATE TABLE FK_TEST(
    FK_NO NUMBER,
    PARENT_NAME VARCHAR2(20), -- REFERENCES BASIC_MEMBER(MEMBER_ID)
    FOREIGN KEY(PARENT_NAME) REFERENCES NQ_MEMBER2(MEMBER_ID)
);

-- FK�� �Ѱ��� ���̺� ���� �ټ� �÷��� ������ �� ����.
-- FK�����ϴ� �÷��� �����ϴ� �÷��� Ÿ��, ����(��Ŀ�� �������)�� ��ġ�ؾ� �Ѵ�.


-- CHECK ��������
-- �÷��� ������ ���� ������ �� �ְ� �ϴ� ��������
-- �÷� �������� ����
CREATE TABLE PERSON(
    NAME VARCHAR2(20),
    AGE NUMBER CHECK(AGE > 0) NOT NULL, -- ��ȣ���� ������ ���̸� ���� ����
    GENDER VARCHAR2(5) CHECK(GENDER IN('��','��')) -- ���� ���� �Է¹ް���
);

INSERT INTO PERSON VALUES('������',-10,'��');  -- ���̰� 0���� �۾Ƽ� (�� �߰� �Ұ�)
INSERT INTO PERSON VALUES('������',19,'��');  -- ��,�� ���� �ϳ� �Է��� ������ �ƴ϶� (�� �߰� �Ұ�)


-- ���̺� ������ ����Ʈ���� ������ �� ����
-- DEFAULT ����� ���
CREATE TABLE DEFAULT_TEST(
    TEST_NO NUMBER PRIMARY KEY,
    TEST_DATE DATE DEFAULT SYSDATE,
    TEST_DATA VARCHAR2(20) DEFAULT '�⺻��'
);
INSERT INTO DEFAULT_TEST VALUES(1,DEFAULT,DEFAULT); -- �߰��� ���� ������ DEFAULT ���� ����ؼ� �⺻���� ���� �� ����
INSERT INTO DEFAULT_TEST VALUES(2,'23/02/04','������');
INSERT INTO DEFAULT_TEST(TEST_NO) VALUES(3); 

SELECT * FROM DEFAULT_TEST;


-- ���༳���� �̸� �����ϱ�
-- �⺻������� ���������� �����ϸ� SYS00000���� �ڵ����� ������
CREATE TABLE MEMBER_TEST(
    MEMBER_NO NUMBER CONSTRAINT MEMBER_NO_PK PRIMARY KEY,  -- �������� �̸� ������ -> MEMBER_NO_PK
    MEMBER_ID VARCHAR2(20) CONSTRAINT MEMBER_ID_UQ UNIQUE NOT NULL,
    MEMBER_PWD VARCHAR2(20) CONSTRAINT MEMBER_PWD_NN NOT NULL,
    CONSTRAINT COMPOSE_UQ UNIQUE(MEMBER_NO, MEMBER_ID) -- ���̺���� �̸� �ٲٴ� ���
);

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'MEMBER_TEST';


-- ���̺��� ������ �� SELECT���� �̿��� �� �ִ�.
-- ���̺� ����
CREATE TABLE EMP_COPY
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_COPY;

CREATE TABLE EMP_SAL -- ���̺� �������
AS SELECT E.*, (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE) AS SAL_DEPT_AVG
FROM EMPLOYEE E JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE;

SELECT * FROM EMP_SAL;

CREATE TABLE EMP_SAL2 -- �����̺� ����
AS SELECT E.*, (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE) AS SAL_DEPT_AVG
FROM EMPLOYEE E JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE WHERE 1=2;

SELECT * FROM EMP_SAL2;



CREATE TABLE TEST_MEMBER(
    MEMBER_CODE NUMBER CONSTRAINT PK_MEMBER_CODE PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEMBER_PWD CHAR(20) NOT NULL,
    MEMBER_NAME NCHAR(10) DEFAULT '�ƹ���',
    MEMBER_ADDR CHAR(50) NOT NULL,
    GENDER VARCHAR2(5) CHECK(GENDER IN('��','��')),
    PHONE VARCHAR2(20) NOT NULL,
    HEIGHT NUMBER(5,2) CHECK(HEIGHT > 130)
);

COMMENT ON COLUMN TEST_MEMBER.MEMBER_CODE IS 'ȸ�� �����ڵ�';  -- Ŀ��Ʈ �ޱ�
COMMENT ON COLUMN TEST_MEMBER.MEMBER_ID IS 'ȸ�� ���̵�';
COMMENT ON COLUMN TEST_MEMBER.MEMBER_PWD IS 'ȸ�� ��й�ȣ';
COMMENT ON COLUMN TEST_MEMBER.MEMBER_NAME IS 'ȸ�� �̸�';
COMMENT ON COLUMN TEST_MEMBER.MEMBER_ADDR IS 'ȸ�� ������';
COMMENT ON COLUMN TEST_MEMBER.GENDER IS '����';
COMMENT ON COLUMN TEST_MEMBER.PHONE IS 'ȸ�� ����ó';
COMMENT ON COLUMN TEST_MEMBER.HEIGHT IS 'ȸ�� Ű';



-- INSERT : ������ �߰��ϴ� ��
-- DML ������ ���� �˾ƺ���
-- ������ ���� ���� ���̺� ���� ����(INSERT), ����(UPDATE), ����(DELETE)�ϴ� ����
-- INSERT : ���̺� ������(ROW)�߰��ϴ� ��ɾ�
-- UPDATE : ���̺� �ִ� �������� Ư���÷��� �����ϴ� ��ɾ�
-- DELETE : ���̺� �ִ� Ư�� ROW�� �����ϴ� ��ɾ�

-- 1. ��ü�÷��� ���� �����ϱ�
-- INSERT INTO ���̺�� VALUES(�÷��� ������ ��, �÷��� ������ ��, �÷��� ������ ��....)
-- *���̺� ����� �÷����� �����ؾ��Ѵ�

-- 2. Ư���÷��� ��� ���� �����ϱ�
-- INSERT INTO ���̺��(Ư���÷�, Ư���÷�...) VALUES(Ư���÷��� �����Ұ�, Ư���÷��� ������ ��......)
-- * ������ �÷��� ���� VALUES�� �ִ� ���� ���ƾ���
-- * �������� ���� �÷��� ���� NULL�� ���Ե�. ����! ������ �÷��� NOT NULL ���� ������ ������ �ȵȴ�.


CREATE TABLE TEMP_DEPT
AS SELECT  * FROM DEPARTMENT WHERE 1 = 0;  -- ������ ������ �� ���̺� ������

SELECT * FROM TEMP_DEPT;

INSERT INTO TEMP_DEPT VALUES('D0','�ڹ�','L1');
INSERT INTO TEMP_DEPT VALUES('D1','����Ŭ',TO_NUMBER('10'));

-- �÷��� �����ؼ� ���� �����ϱ�
DESC TEMP_DEPT;
INSERT INTO TEMP_DEPT(DEPT_ID,LOCATION_ID) VALUES('D2','L3');
INSERT INTO TEMP_DEPT(DEPT_ID) VALUES('D3');  -- �� ���ԺҰ��� -> LOCATION_ID�� NOT NULL���������� �ɷ��ֱ⶧���� NULL�����θ���

CREATE TABLE TESTINSERT(
    TESTNO NUMBER PRIMARY KEY,
    TESTCONTENT VARCHAR2(200) DEFAULT 'TEST' NOT NULL -- �⺻���� �������� ���� ������� �⺻���� �켱������
);

INSERT INTO TESTINSERT(TESTNO) VALUES(1);
SELECT * FROM TESTINSERT;


-- SELECT���� �̿��ؼ� �� �����ϱ�
-- ���� �����ؼ� �־��ִ� ���� (���� �����ϴ°��� �ƴ�)
-- NOT NULL ���� ���Ǹ� ������

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


-- EMPLOYE ���̺��� �μ��� D6�� ������� INSERT_SUB�� �����ϱ�
-- UNIUQ ���������� �������� �ʱ� ������ EMP_ID�� �⺻Ű�� �������� ����
INSERT INTO INSERT_SUB(
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE DEPT_CODE = 'D6'
);

-- ������ �÷��� SELECT������ ������ �����ϱ�
INSERT INTO INSERT_SUB(EMP_ID, EMP_NAME)(SELECT EMP_ID, EMP_NAME FROM EMPLOYEE);


-- INSERT ALL
-- SELECT���� �̿��ؼ� �ΰ� �̻��� ���̺� ���� ���� �� ���
CREATE TABLE EMP_HIRE_DATE
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE FROM EMPLOYEE WHERE 1=0;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID FROM EMPLOYEE WHERE 1=0;

INSERT ALL
INTO EMP_HIRE_DATE VALUES(EMP_ID, EMP_NAME, HIRE_DATE) -- 24�� ����
INTO EMP_MANAGER VALUES(EMP_ID,EMP_NAME,MANAGER_ID)  -- 24�� ����
SELECT EMP_ID, EMP_NAME, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE;

SELECT * FROM EMP_HIRE_DATE;
SELECT * FROM EMP_MANAGER;

-- INSERT ALL �� ���Ǹ��缭 �����Ű��
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE FROM EMPLOYEE WHERE 1=0;

CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE FROM EMPLOYEE WHERE 1=0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

-- EMPLOYEE ���̺��� 00�� ���� �Ի��ڴ� EMP_OLD�� ����, ���� �Ի��ڴ� EMP_NEW�� �����ϱ�
INSERT ALL 
WHEN HIRE_DATE < '00/01/01' THEN INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE) 
WHEN HIRE_DATE >= '00/01/01' THEN INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE)
SELECT EMP_ID, EMP_NAME, HIRE_DATE FROM EMPLOYEE;

