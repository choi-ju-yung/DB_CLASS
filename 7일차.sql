

-- view�� ���� �˾ƺ���
-- SELECT���� ��� RESULT SET�� �ϳ��� ���̺�ó�� Ȱ���ϰ� �ϴ°�

-- STORED VIEW �����ϱ�
-- CREATE [�ɼ�] VIEW VIEW��Ī AS SELECT��
CREATE VIEW V_EMP
AS SELECT * FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
-- BS������ CREATE �����̾�� ������

-- VIEW ������ ������ �ο��ؾ���
-- SYSTEM / SYS AS SYSDBA �������� �ο��� �Ѵ�
GRANT CREATE VIEW TO BS;


-- �ٽ� BS ��������
CREATE VIEW V_EMP
AS SELECT * FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- ������ VIEW ���̺� �̿��ϱ�
SELECT * FROM V_EMP;


-- �μ��� ��å�� �޿��� ����� ���ϴ� SELECT ��
SELECT DEPT_CODE, AVG(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE;
SELECT JOB_CODE, AVG(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE;

-- �� �ΰ��� ������ UNION���� ��ħ
SELECT DEPT_CODE, AVG(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE
UNION
SELECT JOB_CODE, AVG(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE;

-- �� ��ģ ������ VIEW ���̺�� �����
CREATE VIEW V_AVG_DEPTJOB
AS
SELECT DEPT_CODE, AVG(SALARY) AS AVG_SALARY FROM EMPLOYEE GROUP BY ROLLUP(DEPT_CODE)
UNION
SELECT JOB_CODE, AVG(SALARY) FROM EMPLOYEE GROUP BY ROLLUP(JOB_CODE);

SELECT * FROM V_AVG_DEPTJOB
WHERE AVG_SALARY >= 3000000 AND DEPT_CODE IS NOT NULL;

-- VIEW�� WITH ������
-- VIEW�� �����س��� ��� ����ϴ°��̰�, WITH�� ������ ������ ����� �Ұ�����

-- VIEW ���̺� ��ȸ
SELECT * FROM USER_VIEWS;

-- VIEW�� Ư¡
-- DML ������ ����� �����ϴ�??
-- �������̺�� ����Ǿ��ִ� �÷��� ������ ���� ����, �����÷��� ������ �Ұ����ϴ�

SELECT * FROM V_EMP;
UPDATE V_EMP SET DEPT_T`ITLE='�λ�' WHERE DEPT_CODE='D1';
UPDATE V_EMP SET EMP_NAME = '������' WHERE EMP_NAME = '���ֿ�'; -- �����̺� �������̺�� ����Ǿ��ִ� �÷��� ����
SELECT * FROM EMPLOYEE;  -- ���� ���̺� ������
UPDATE V_AVG_DEPTJOB SET AVG_SALARY = 10000000; -- ���� �÷��� ���� �Ұ�����


-- ���� ���̺�� ������� VIEW�� INSERT�� ������  
-- -> VIEW���� ���� ������ �̿ܿ� �÷����� NULL ���� ������ -> NOT NULL ���������� �����Ǹ� �ȵȴ�
CREATE VIEW V_EMPTEST
AS SELECT EMP_ID, EMP_NO, EMP_NAME, EMAIL, PHONE, JOB_CODE, SAL_LEVEL FROM EMPLOYEE;


INSERT INTO V_EMPTEST VALUES('997','981011-1234123','ȫ�浿','HONG@HONG.COM','12341234','J1','S1');
SELECT * FROM EMPLOYEE;

SELECT * FROM V_EMPTEST;
INSERT INTO V_EMP VALUES('996','ȫ�浿','980110-1234567','HONG@HONG.COM','12345','D5','J1','S1',100
                        ,0.2,206,SYSDATE,NULL,'N','D0','�Ǵ�','L3');

-- DELETE �� �����غ��� (VIEW���̺���)
DELETE FROM V_EMPTEST WHERE EMP_ID = '997';
SELECT * FROM EMPLOYEE;
DELETE FROM V_EMP WHERE EMP_NAME = '�����';
-- JOIN, UNION���� ����� VIEW�� �Է��� �Ұ�����


-- 1. OR REPLACE = �ߺ��Ǵ� VIEW �̸��� ������ ����⸦ ���ִ� �ɼ�
-- * OBJECT ��Ī�� �ߺ��� �Ұ����ϴ�
CREATE OR REPLACE VIEW V_EMP  -- ���̺��� �������̰Ե� (�����ؼ� ����ؾ���)
AS SELECT * FROM EMPLOYEE;

-- FORCE / NOFORCE : ���� ���̺��� �������� �ʾƵ� VIEW ������ �� �ְ� ���ִ� �ɼ�

-- ���� VIEW ���̺� ����
CREATE FORCE VIEW V_TT
AS SELECT * FROM TT;

-- �� ����
DROP VIEW V_TT;

-- VIEW ���̺�� ������ ����ִ� TT ���̺� ����
CREATE TABLE TT(
    TTNO NUMBER,
    TTNAME VARCHAR2(200)
);
SELECT * FROM V_TT;

-- WITH CHECK OPTION : SELECT ���� WHERE���� ����� �÷��� �������� ���ϰ� ����� �ɼ�
CREATE OR REPLACE VIEW V_CHECK
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' WITH CHECK OPTION;  -- DEPT_CODE �÷��� �������� ����
SELECT * FROM V_CHECK;
UPDATE V_CHECK SET DEPT_CODE = 'D6' WHERE EMP_NAME = '������';

ROLLBACK;

-- WITH READ ONLY : VIEW ���̺��� ������ �Ұ����ϰ� �ϴ� �ɼ� -> �б�����
-- ��� �÷� ���� �Ұ��� 
CREATE OR REPLACE VIEW V_CHECK
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' WITH READ ONLY;


-- SEQUENCE�� ���� �˾ƺ���
-- �ڵ���ȣ �߱����ִ� ��ü
-- �⺻ SEQUENCE �����ϱ�
-- CREATE SEQUENCE ������ �̸� [�ɼǵ�];
-- �⺻���� �����ϸ� ��ȣ�� 1���� 1�� �����ؼ� �߱�����
-- 1. SEQUENCE ��ȣ�� �߱��Ϸ��� ��������.NEXTVAL�� �����Ѵ�
CREATE SEQUENCE SEQ_BASIC;
SELECT SEQ_BASIC.NEXTVAL FROM DUAL;

-- SEQEUNCE�� �ߺ����� �ʴ� ���ڸ� �߱����ֱ� ������ ���̺��� PK�÷��� ������ ���� ����Ѵ�
SELECT * FROM BOARD;

INSERT INTO BOARD VALUES(SEQ_BASIC.NEXTVAL,'ù��°�Խñ�','ù��°','������',SYSDATE);

-- ���� SEQUENCE ���� Ȯ���ϱ�
-- ������.CURRVAL�� �̿��Ѵ�
SELECT SEQ_BASIC.CURRVAL FROM DUAL;

SELECT * FROM BOARD;

CREATE TABLE ATTACHMENT(
    ATTACH_NO NUMBER PRIMARY KEY,
    BOARD_REF NUMBER REFERENCES BOARD(BOARD_NO),
    FILENAME VARCHAR2(200) NOT NULL
);

-- �Խù� ���̺�� ÷������ ���̺��� ���� ���� CURRVAL�� ������ �޴� ����
INSERT INTO BOARD VALUES(SEQ_BASIC.NEXTVAL,'÷�����ϰԽñ�','÷�������ִ�','������',SYSDATE);
INSERT INTO ATTACHMENT VALUES(1,SEQ_BASIC.CURRVAL,'������.PNG');
INSERT INTO ATTACHMENT VALUES(2,SEQ_BASIC.CURRVAL,'������2.PNG');

SELECT * FROM BOARD;
SELECT * FROM ATTACHMENT;

SELECT * FROM BOARD
JOIN ATTACHMENT ON BOARD_NO = BOARD_REF;


-- SEQUENCE �ɼǰ� Ȱ���ϱ�
-- START WITH ���� : ������ ���ں��� ���� (DEFAULT ���� 1��)
-- INCREMENT BY ���� : �����ϴ� ������ �ǹ� (DEFAULT ���� 1��)
-- MAXVALUE ���� : �ִ밪�� ����
-- MINVALUE ���� : �ּҰ��� ����
-- CYCLE / NOCYCLE : ��ȣ�� ��ȯ���� ���� �����ϴ� ��  * (MAXVALUE, MINVALUE)�� �����Ǿ��־�� �Ѵ�.
-- CACHE : �̸���ȣ�� �����ϴ� ��� (DEFAULT 20)
SELECT * FROM U
SER_SEQUENCES;

CREATE SEQUENCE SEQ_01
START WITH 100; -- 100���� ����
SELECT SEQ_01.NEXTVAL FROM DUAL;

CREATE SEQUENCE SEQ_02
START WITH 100
INCREMENT BY 10;
SELECT SEQ_02.NEXTVAL FROM DUAL;

CREATE SEQUENCE SEQ_03
START WITH 100
INCREMENT BY -50
MAXVALUE 200
MINVALUE 0;
SELECT SEQ_03.NEXTVAL FROM DUAL;

CREATE SEQUENCE SEQ_04
START WITH 100
INCREMENT BY 50
MAXVALUE 200
MINVALUE 0
CYCLE
NOCACHE;  -- 20���� �̸� ������ ������ �ȵǱ⶧���� NOCACHE�� ����
SELECT SEQ_04.NEXTVAL FROM DUAL;

-- 1. CURRVAL�� ȣ���Ϸ��� ���� SESSION�ȿ��� NEXTVAL�� �ѹ��̶� ȣ���ϰ� ȣ���ؾ��Ѵ�
CREATE SEQUENCE SEQ_05;
SELECT SEQ_05.CURRVAL FROM DUAL; -- ���� NEXTVAL�� ȣ������ �ʾұ� ������ ������

-- 2. SEQUENCE�� ���� �߰��ؼ� PK������ �� �� �ִ�.
-- ���ڿ��ٿ��� �����ϱ�
-- P_001, M_001
SELECT 'P_'||TO_CHAR(SEQ_05.NEXTVAL,'0000') FROM DUAL;  -- �ؿ��� ���������
SELECT 'P_'||LPAD(SEQ_05.NEXTVAL,4,'0') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||'_'||SEQ_05.NEXTVAL FROM DUAL;


-- ����Ŭ���� �����ϴ� SELECT ��
-- ����������, �� ���̺��� �����ִ� ROW�� ��� ����� �� �ְ� ���ִ� ������ -> ROW ������ �����ִ� �ڷ�� �����ؼ� ���
-- �Խù� - ��� - ����
-- �Ŵ����� �����ؼ� ����ϱ�
SELECT LEVEL, EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE 
    START WITH EMP_ID = 200
    CONNECT BY PRIOR EMP_ID=MANAGER_ID; 

SELECT LEVEL||' '||LPAD(' ',(LEVEL-1)*5,' ')||EMP_NAME||NVL2(MANAGER_ID,('('||MANAGER_ID||')'),'') AS ������
FROM EMPLOYEE
    START WITH EMP_ID = 200
    CONNECT BY PRIOR EMP_ID = MANAGER_ID;
    
-- PL//SQL ����ϴ� ���
--1.  �͸��Ϸ��� �̿��ϱ� -> BEGIN~ END : /������ ����ϴ� �� *(������ �Ұ���)
--2 PROCEDUREM , FUNCTION��ü�� �����ؼ� �̿� -> OBJECT�ȿ� �ۼ��� PL/SQL * ������ OBJECT ������ ������ ����

-- �͸���
-- PL/SQL ������ ũ�� 3������ ����
-- [�����] : DECLARE ��3\�� ��� ����, ��� ����
--              ���������� : ������Ÿ��(�⺻Ÿ��,����Ÿ��, ROWTYPE, TALBE, RECODE);
-- [�����] : BEGIN �����ۼ�  END : ���ǹ�, �ݺ��� �� ������ ���뿡 ���� �ۼ��ϴ� ����
-- [����ó����] = ó���� ���ܰ� ������ �ۼ��ϴ� ����

SET SERVEROUTPUT ON;
BEGIN 
    DBMS_OUTPUT.PUT_LINE('�ȳ� ���� ù PL/SQL');
END;
/
-- ���� Ȱ���ϱ�
-- ������ DECLAR�κп� ������ �ڷ��� �������� ����
-- �ڷ����� ���� 
-- �⺻�ڷ��� : ����Ŭ���� �����ϴ� TYPE�� (NUMBER, VARCHAR2, CHAR, DATE....)
-- �������ڷ��� : ���̺��� Ư���÷��� ������ Ÿ���� �ҷ��� ���
-- ROWTYPE : ���̺��� �Ѱ� ROW�� ������ �� �ִ� Ÿ��, Ÿ���� �����ؼ� ���
-- TABLETYPE : �ڹ��� �迭�� ����� Ÿ�� -> �ε��� ��ȣ�� �ְ�, �Ѱ� Ÿ�Ը� ������ ����
-- RECORDE : �ڹ��� Ŭ������ ����� Ÿ�� -> ��Ӻ����� �ְ�, �ټ� Ÿ���� ���尡��


--�⺻�ڷ��� ����� �̿��ϱ�
  --- := ���Կ�����
DECLARE
    V_EMPNO VARCHAR2(20);
    V_EMPNAME VARCHAR2(15);
    V_AGE NUMBER := 19;         
BEGIN    
    V_EMPNO := '010224-1234567';
    V_EMPNAME := '������';
    DBMS_OUTPUT.PUT_LINE(V_EMPNO);
    DBMS_OUTPUT.PUT_LINE(V_EMPNAME);
    DBMS_OUTPUT.PUT_LINE(V_AGE);
END;
/ 
-- ������ / ǥ�� �־����

-- ������ �ڷ��� �̿��ϱ�
DECLARE
    V_EMPID EMPLOYEE.EMP_ID%TYPE;
    V_SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    V_EMPID := '200';
    V_SALARY := 1000000;
    DBMS_OUTPUT.PUT_LINE(V_EMPID||' : '||V_SALARY);
    --SQL���� �����Ͽ� ó���ϱ�  (�ݵ�� INTO�� �־������)
    SELECT EMP_ID, SALARY
    INTO V_EMPID, V_SALARY  
    FROM EMPLOYEE
    WHERE EMP_ID = '201';
    DBMS_OUTPUT.PUT_LINE(V_EMPID||' '||V_SALARY);
    
END;
/

-- ROWTYPE
DECLARE
    V_EMP EMPLOYEE%ROWTYPE;
    V_DEPT DEPARTMENT%ROWTYPE;
BEGIN
    SELECT *
    INTO V_EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&�����ȣ';
    -- ROWTYPE�� �� �÷��� ����Ϸ��� .�����ڸ� �̿��ؼ� �÷������� �����Ѵ�.
    -- �÷������� ���ؼ� �ٸ� SELECT���� ������ �ִ�
    DBMS_OUTPUT.PUT_LINE(V_EMP.EMP_ID||' '||V_EMP.EMP_NAME||' '||V_EMP.SALARY||' '||V_EMP.BONUS);
    SELECT *
    INTO V_DEPT
    FROM DEPARTMENT
    WHERE DEPT_ID= V_EMP.DEPT_CODE;  
    DBMS_OUTPUT.PUT_LINE(V_DEPT.DEPT_ID||' '||V_DEPT.DEPT_TITLE||' '||V_DEPT.LOCATION_ID);
END;
/

-- �����ؼ� ����ϴ� Ÿ��
-- ���̺� Ÿ��
DECLARE
    TYPE EMP_ID_TABLE IS TABLE OF EMPLOYEE.EMP_ID%TYPE
    INDEX BY BINARY_INTEGER;
    -- ������ Ÿ��
    MYTABLE_ID EMP_ID_TABLE;
    I BINARY_INTEGER := 0;
BEGIN
    MYTABLE_ID(1) := '100';
    MYTABLE_ID(2) := '200';
    MYTABLE_ID(3) := '300';
    DBMS_OUTPUT.PUT_LINE(MYTABLE_ID(1));
    DBMS_OUTPUT.PUT_LINE(MYTABLE_ID(2));
    DBMS_OUTPUT.PUT_LINE(MYTABLE_ID(3));
    
    FOR K IN (SELECT EMP_ID FROM EMPLOYEE) LOOP
        I:=I+1;
        MYTABLE_ID(I):=K.EMP_ID;
    END LOOP;
    FOR J IN 1..I LOOP
        DBMS_OUTPUT.PUT_LINE(MYTABLE_ID(J));
    END LOOP;
END;
/


-- RECODE Ÿ�� Ȱ���ϱ�
-- Ŭ������ ����
DECLARE
    TYPE MYRECORD IS RECORD(
        ID EMPLOYEE.EMP_ID%TYPE,
        NAME EMPLOYEE.EMP_NAME%TYPE,
        DEPTTITLE DEPARTMENT.DEPT_TITLE%TYPE,
        JOBNAME JOB.JOB_NAME%TYPE
    );

    MYDATA MYRECORD;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
    INTO MYDATA
    FROM EMPLOYEE 
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN JOB USING(JOB_CODE)
    WHERE EMP_NAME = '&�����';
    DBMS_OUTPUT.PUT_LINE(MYDATA.ID||MYDATA.NAME||MYDATA.DEPTTITLE||MYDATA.JOBNAME);
END;
/

-- PL/SQL �������� ���ǹ� Ȱ���ϱ�
-- IF�� Ȱ��
-- IF ���ǽ� 
--  THEN : ���ǽ��� TRUE�϶� THEN�� �ִ� ������ �����. 
-- END IF; 

DECLARE
    V_SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT SALARY
    INTO V_SALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&�����ȣ';
    
    IF V_SALARY > 3000000
        THEN DBMS_OUTPUT.PUT_LINE('���� �����ó׿�!');
    END IF;    
END;
/

-- IF 
--  THEN ���౸��
--  ELSE ���౸��
-- END IF;

DECLARE
    V_SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT SALARY
    INTO V_SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME = '&�����';
    IF V_SALARY > 3000000
        THEN DBMS_OUTPUT.PUT_LINE('���� �����ó׿�!');
        ELSE DBMS_OUTPUT.PUT_LINE('�����̽ó׿�!');
        END IF;    
END;
/

CREATE TABLE HIGH_SAL(
    EMP_ID VARCHAR2(20) REFERENCES EMPLOYEE(EMP_ID),
    SALARY NUMBER 
);

CREATE TABLE LOW_SAL(
    EMP_ID VARCHAR2(20) REFERENCES EMPLOYEE(EMP_ID),
    SALARY NUMBER 
);

DECLARE
    EMPID EMPLOYEE.EMP_ID%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, SALARY
    INTO EMPID, SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME='&�����';
    
    IF SALARY > 3000000
        THEN INSERT INTO HIGH_SAL VALUES(EMPID, SALARY);
    ELSE INSERT INTO LOW_SAL VALUES(EMPID, SALARY);
    END IF;
    COMMIT;
END;
/

SELECT * FROM HIGH_SAL;
SELECT * FROM LOW_SAL;


-- IF ���ǽ� THEN ELSIF ���ǽ� 
CREATE TABLE MSGTEST(
    EMP_ID VARCHAR2(20) REFERENCES EMPLOYEE(EMP_ID),
    MSG VARCHAR2(100)
);

DECLARE 
    V_EMP_ID EMPLOYEE.EMP_ID%TYPE;
    V_JOBCODE EMPLOYEE.JOB_CODE%TYPE;
    MSG VARCHAR2(100);
BEGIN
    SELECT EMP_ID, JOB_CODE
    INTO V_EMP_ID, V_JOBCODE
    FROM EMPLOYEE
    WHERE EMP_ID = '&�����ȣ';
    
    IF V_JOBCODE = 'J1'
        THEN MSG:='��ǥ�̻�';
    ELSIF V_JOBCODE IN ('J2','J3','J4')
        THEN MSG:='�ӿ�';
    ELSE MSG:='���';
    END IF;
    INSERT INTO MSGTEST VALUES(V_EMP_ID, MSG);
    COMMIT;
    
END;
/

SELECT * FROM MSGTEST JOIN EMPLOYEE USING(EMP_ID);


-- CASE�� �̿��ϱ�
DECLARE
    NUM NUMBER;
BEGIN
    NUM:='&��';
    CASE 
        WHEN NUM >10
            THEN DBMS_OUTPUT.PUT_LINE('10�ʰ�');
        WHEN NUM > 5
            THEN DBMS_OUTPUT.PUT_LINE('10~5���� ��');
        ELSE DBMS_OUTPUT.PUT_LINE('5�̸�');
    END CASE;
END;
/

-- �ݺ��� ����ϱ�
-- �⺻�ݺ��� LOOP���� �̿�
-- FOR, WHILE���� ����
DECLARE
    NUM NUMBER := 1;
    RNDNUM NUMBER;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
        -- ����Ŭ���� ������ ����ϱ�
        RNDNUM := FLOOR(DBMS_RANDOM.VALUE(1,10));
        DBMS_OUTPUT.PUT_LINE(RNDNUM);
        INSERT INTO BOARD VALUES(SEQ_BASIC.NEXTVAL,'����'||RNDNUM,'CONTENT'||RNDNUM,'�ۼ���'||RNDNUM,SYSDATE);
        NUM:=NUM+1;
        IF NUM>100
            THEN EXIT;  -- BREAK���� ����
        END IF;
    END LOOP;
    COMMIT;
END;
/
SELECT * FROM BOARD;

-- WHILE��
-- WHILE ���ǹ� LOOP
-- ���౸��
-- END LOOP;
-- /

DECLARE 
    NUM NUMBER := 1;
BEGIN
    WHILE NUM <= 10 LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
        NUM:=NUM+1;
    END LOOP;
END;
/


-- FOR ���� IN ����(����..��) LOOP
-- END LOOP;

BEGIN 
    FOR N IN 1..10 LOOP
    DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

-- FOR ���� IN (SELECT��) LOOP
-- END LOOP;
BEGIN
    FOR EMP IN (SELECT * FROM EMPLOYEE) LOOP
        DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID||EMP.EMP_NAME||EMP.SALARY||EMP.DEPT_CODE||EMP.JOB_CODE);
        IF EMP.SALARY > 3000000
            THEN INSERT INTO HIGH_SAL VALUES(EMP.EMP_ID,EMP.SALARY);
        ELSE INSERT INTO LOW_SAL VALUES(EMP.EMP_ID,EMP.SALARY); 
        END IF;
        COMMIT;
    END LOOP;
END;
/

SELECT * FROM HIGH_SAL;
SELECT * FROM LOW_SAL;


-- PL/SQL ���� �����ϰ� ����ϱ�
-- PROCEDURE, FUNCTION
-- PROCEDURE
-- CREATE PROCEDURE ���ν�����
-- IS
-- ��������(�ʿ��ϴٸ�...)
-- BEGIN
--  ������ ����
-- END;
-- /

-- ����� ���ν��� �����ϱ�
-- EXEC ���ν�����
CREATE TABLE EMP_DEL
AS SELECT * FROM EMPLOYEE;
SELECT * FROM EMP_DEL;
CREATE OR REPLACE PROCEDURE EMP_DEL_PRO
IS
BEGIN
    DELETE FROM EMP_DEL;
    COMMIT;
END;
/
EXEC EMP_DEL_PRO;
SELECT * FROM EMP_DEL;

CREATE OR REPLACE PROCEDURE EMP_INSERT
IS
BEGIN
    FOR EMP IN (SELECT * FROM EMPLOYEE) LOOP
        INSERT INTO EMP_DEL 
        VALUES(EMP.EMP_ID, EMP.EMP_NAME, EMP.EMP_NO, EMP.EMAIL, EMP.PHONE,
                EMP.DEPT_CODE, EMP.JOB_CODE, EMP.SAL_LEVEL, EMP.SALARY, EMP.BONUS,
                EMP.MANAGER_ID, EMP.HIRE_DATE,EMP.ENT_DATE, EMP.ENT_YN); 
    END LOOP;
    COMMIT;
END;
/
EXEC EMP_INSERT;
SELECT * FROM EMP_DEL;
EXEC EMP_DEL_PRO;


-- ���ν����� �Ű����� Ȱ���ϱ�
-- IN �Ű����� : ���ν��� ����ÿ� �ʿ��� �����͸� �޴� �Ű����� * �Ϲ����� �Ű�����
-- OUT �Ű����� : ȣ���Ѱ����� ������ ������ �����͸� �������ִ� �Ű������� �ǹ�
CREATE OR REPLACE PROCEDURE PRO_SELECT_EMP(V_EMPID IN EMPLOYEE.EMP_ID%TYPE, V_EMPNAME OUT EMPLOYEE.EMP_NAME%TYPE)
IS
    TEST VARCHAR2(20);
BEGIN
    SELECT EMP_NAME
    INTO V_EMPNAME
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMPID;
END;
/

-- ������������
VAR EMP_NAME VARCHAR2(20);
PRINT EMP_NAME;
EXEC PRO_SELECT_EMP(201,:EMP_NAME);
PRINT EMP_NAME;


-- FUNCTION ������Ʈ
-- �Լ� : �Ű�����, ���ϰ��� ���´�
-- SELECT �� ���ο��� ������
-- CREATE FUNCTION �Լ���([�Ű���������])
-- RETURN ����Ÿ��
-- IS
-- [��������]
-- BEGIN
-- ������ ����
-- END;
-- /

-- �Ű������� ���� ���ڿ��� ���̸� ��ȯ���ִ� �Լ�
CREATE OR REPLACE FUNCTION MYFUNC(V_STR VARCHAR2)
RETURN NUMBER
IS
    V_RESULT NUMBER;
BEGIN
    SELECT LENGTH(V_STR)
    INTO V_RESULT
    FROM DUAL;
    RETURN V_RESULT;
END;
/

SELECT MYFUNC('������')
FROM DUAL;
SELECT MYFUNC(EMAIL)
FROM EMPLOYEE;


-- �Ű������� EMP_ID�� �޾Ƽ� ������ ������ִ� �Լ� �����
CREATE OR REPLACE FUNCTION SAL_YEAR(V_EMPID EMPLOYEE.EMP_ID%TYPE)
RETURN NUMBER
IS
    V_RESULT NUMBER;
BEGIN
    SELECT SALARY * 12
    INTO V_RESULT
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMPID;
    RETURN V_RESULT;
END;
/

SELECT SAL_YEAR(200) FROM DUAL;
SELECT EMP_NAME, SALARY, BONUS, SAL_YEAR(EMP_ID)
FROM EMPLOYEE;


-- ���� ����� �߰��Ǹ� ���Ի���� �Ի��Ͽ����ϴ� ����ϴ� Ʈ����
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    -- Ʈ���� ����� ���� �Է��� ��, ���� ���� ���� ����� �� ����
    -- INSERT -> ���ο� ��(0), ���� ��(X)
    -- UPDATE -> ���ο� ��(0), ������(O)
    -- DELETE -> ���ο� ��(X), ������(O)
    -- ���ο -> :NEW.�÷���
    -- ������ -> :OLD.�÷���
    DBMS_OUTPUT.PUT_LINE('���Ի�� '||:OLD.EMP_NAME||'���� ����Ͽ����ϴ�');
    DBMS_OUTPUT.PUT_LINE('���Ի�� '||:NEW.EMP_NAME||'���� ����Ͽ����ϴ�');
END;
/



INSERT INTO EMPLOYEE VALUES('899','�ֿ�����','970105-1234567','CHOI@CHOIK.COM','01012341234','D3','J1',
    'S1',10,0.5,200,SYSDATE,NULL,DEFAULT);
    
    







