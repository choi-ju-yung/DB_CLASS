-- join���� ���������� ���� �͵��� �ӵ����� �� ����

-- ���� ���� : SELECT�� �ȿ� SELECT���� �ϳ� �� �ִ� �������� ����
-- ���������� �ݵ�� ()�ȿ� �ۼ��� �ؾ��Ѵ�.

-- ������ ����� ������ �޿��� �ް� �ִ� ����� ��ȸ�ϱ�
SELECT * 
FROM EMPLOYEE
WHERE SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '������');

-- D5�μ��� ��ձ޿����� ���� �޴� ������ϱ�
SELECT * 
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = 'D5');

-- 1. ������ ��������
-- �������� SELECT ���� ����� 1����, 1������ ��
-- �� ���� 2����ó�� (����� �ϳ� ������) ���� ������ ����������� �Ѵ�
-- �÷�, WHERE���� �񱳴�� ��


-- ������� �޿� ��պ��� ���� �޿��� �޴� ����� �̸�, �޿�, �μ��ڵ带 ����ϱ�
-- �÷������� ���������� ���� ���� 
SELECT EMP_NAME, SALARY, DEPT_CODE, (SELECT AVG(SALARY) FROM EMPLOYEE) AS AVG
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE);


-- �μ��� �ѹ����� ����� ��ȸ�ϱ�
SELECT * 
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '�ѹ���');

SELECT *
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '�ѹ���';


-- ��å�� ������ ����� ��ȸ�ϱ�
SELECT * 
FROM EMPLOYEE
    WHERE JOB_CODE = (SELECT JOB_CODE FROM JOB WHERE JOB_NAME = '����');


-- ������ ����������
-- ���������� ����� �Ѱ��� �ټ� ��(ROW)�� ���°�
-- IN �����ڸ� Ȱ���Ѵ�

-- ��å�� ����, ������ ����� ��ȸ
SELECT * 
FROM EMPLOYEE
WHERE JOB_CODE IN(SELECT JOB_CODE FROM JOB WHERE JOB_NAME IN('����','����'));


-- �����࿡ ���� ��Һ��ϱ�
-- >=, >, <, <=
-- ANY : OR�� ROW�� ����
-- ALL : AND�� ROW�� ����
-- �÷� >(=) ANY(��������) : ������ ���������� ��� �� �ϳ��� ũ�� �� -> ������ ���������� ��� �� �ּҰ����� ũ�� 
-- �÷� <(=) ANY(��������) : ������ ���������� ��� �� �ϳ��� ������ �� -> ������ ���������� ��� �� �ִ밪���� ������ 


SELECT * 
FROM EMPLOYEE
WHERE SALARY >= ANY(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN('D5','D6'));
-- ANY(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN('D5','D6'); �� ����� �ּҰ��� 180������ ũ�� �� ����

SELECT * 
FROM EMPLOYEE
WHERE SALARY >= (SELECT MIN(SALARY) FROM EMPLOYEE WHERE DEPT_CODE IN('D5','D6'));
-- �� �ᰡ�� ���� ������


-- �÷� >(=) ALL(��������) : ������ ���������� ����� ��� Ŭ �� �� -> ������ ���������� ��� �� �ִ밪���� ũ�� ��
-- �÷� <(=) ALL(��������) : ������ ���������� ����� ��� ���� �� �� -> ������ ���������� ��� �� �ּҰ����� ������ ��


SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY < ALL(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN('D5','D6'));
-- WHERE SALARY < (SELECT MIN(SALARY) FROM EMPLOYEE WHERE DEPT_CODE IN('D5','D6'));

-- 2000�� 1�� 1�� ���� �Ի��� �� 2000�� 1�� 1�� ���� �Ի��� ��� �� ���� ���� �޴� ������� �޿��� ���� �޴�
-- ����� �����, �޿�, ��ȸ

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE HIRE_DATE < '00/01/01'   
    AND SALARY > ALL(SELECT SALARY FROM EMPLOYEE WHERE HIRE_DATE > '00/01/01');
    -- AND SALARY > (SELECT MAX(SALARY) FROM EMPLOYEE WHERE HIRE_DATE > '00/01/01);

-- ���߿� �������� : ���� �ټ�, ���� 1���� ������
-- ������ ������� �����μ�, ���� ���޿� �ش��ϴ� ��� ��ȸ�ϱ�



SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE ENT_YN='Y' AND SUBSTR(EMP_NO,8,1) = '2')
    AND JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE WHERE ENT_YN='Y' AND SUBSTR(EMP_NO,8,1) = '2')
    AND ENT_YN = 'N';
--WHERE (DEPT_CODE, JOB_CODE)
--    IN (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO,8,1)='2')
--    AND ENT_YN ='N';


-- ����������̸鼭 �޿��� 200������ ����� �ִٰ� �Ѵ�
-- �� ����� �̸�, �μ���, �޿� ����ϱ�
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, SALARY
                            FROM EMPLOYEE 
                               JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                            WHERE DEPT_TITLE = '���������' AND SALARY = 2000000);
    
    
    
-- ��� �� �ѹ����̰� 300���� �̻� ������ �޴� ���

SELECT DEPT_CODE, SALARY
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '�ѹ���' AND SALARY > 3000000;  -- ���ι��

SELECT *
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, SALARY
                                FROM EMPLOYEE
                                    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                                WHERE DEPT_TITLE='�ѹ���' AND SALARY > 3000000); -- �����������
                                

-- ������, ��������߿� ���������� �÷����� ������� ����
-- WHERE, FROM ���� ���(INLINE VIEW)
SELECT EMP_NAME, (SELECT DEPT_CODE
                        FROM EMPLOYEE
                                JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                                WHERE DEPT_TITLE ='�ѹ���' AND SALARY > 3000000) AS TEST
                                FROM EMPLOYEE;


-- ��� ��������
-- ���������� ������ �� ���������� ���� ������ ����ϰ� ����
-- ���������� ���� ���������� ����� ������ �ְ�, ���������� ����� ���������� ����� ������ �ִ� ������


SELECT * FROM EMPLOYEE;
-- ������ ���� �μ��� ������� ��ȸ�� �ϱ�
-- �����, �μ��ڵ�, �����
-- ���������� ���� �ٲ�����
SELECT EMP_NAME, DEPT_CODE, (SELECT COUNT(*) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE) AS �����
FROM EMPLOYEE E;


-- WHERE�� ����������� �̿��ϱ�
-- EXISTS(��������) : ���������� ����� 1�� �̻��̸� TRUE, 0�� FALSE
-- �� �Խñ��� ��ۼ� ���� �� �̿���
SELECT *
FROM EMPLOYEE E
--WHERE EXISTS(SELECT 1 FROM EMPLOYEE WHERE DEPT_CODE = 'D9');
WHERE EXISTS(SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID = E.EMP_ID);


-- �ּұ޿��� �޴� ��� ��ȸ�ϱ�
SELECT * -- �����������
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

SELECT * -- �������������� 
FROM EMPLOYEE E    -- ���� �ϳ��� ���ؼ� ���� �������� �ᱹ ���Ұ��� ��� 0�� ������ NOT�ٿ��� TRUE�� ��
WHERE NOT EXISTS(SELECT SALARY FROM EMPLOYEE WHERE SALARY < E.SALARY); 


-- ��� ����� �����ȣ, �̸�, �Ŵ������̵�, �Ŵ��� �̸� ��ȸ�ϱ�
-- ���������� Ǯ���

SELECT EMP_ID, EMP_NAME, MANAGER_ID, (SELECT EMP_NAME FROM EMPLOYEE WHERE E.MANAGER_ID = EMP_ID) AS MANAGER_NAME
FROM EMPLOYEE E;


SELECT EMP_NAME, DEPT_CODE, (SELECT COUNT(*) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE) AS �����
FROM EMPLOYEE E;

-- ����� �̸�, �޿�, �μ���, �ҼӺμ��޿���� ��ȸ�ϱ�
SELECT EMP_NAME,SALARY, DEPT_TITLE,(SELECT AVG(SALARY) FROM EMPLOYEE WHERE E.DEPT_CODE = DEPT_CODE)
FROM EMPLOYEE E
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
    

-- ������ J1�� �ƴ� ����߿��� �ڽ��� �μ��� ��� �޿����� �޿��� ���� �޴� ��� ��ȸ�ϱ�
SELECT * 
FROM EMPLOYEE E
WHERE JOB_CODE != 'J1' 
AND SALARY <(SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE);


-- �ڽ��� ���� ������ ��ձ޿����� ���� �޴� ������ �̸�, ��å��, �޿��� ��ȸ�ϱ�
-- USING�� ��Ī�� ����ؾ���
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE E.JOB_CODE = JOB_CODE);


-- FROM ���� �������� �̿��ϱ�
-- INLINE VIEW
-- FROM���� ����ϴ� ���������� ��κ� ��������߿��������� ���
-- RESULT SET�� �ϳ��� ���̺�ó�� ����ϰ� �ϴ� ��
-- RESULT�� ��µ� ����̸�, ���̺��� ���� ����̴�
-- �����÷��� �����ϰ� �ְų�, JOIN�� ����� SELECT���� ���
-- VIEW : INLINE VIEW, STORED VIEW
-- EMPLOYEE ���̺� ������ �߰��ؼ� ����ϱ�
SELECT E.*, DECODE(SUBSTR(EMP_NO,8,1),1,'��',2,'��',3,'��',4,'��')AS GENDER
FROM EMPLOYEE E
WHERE DECODE(SUBSTR(EMP_NO,8,1),1,'��',2,'��',3,'��',4,'��') = '��';

-- ���� ����� INLINE VIEW �� �����
SELECT *
FROM (
    SELECT E.*, DECODE(SUBSTR(EMP_NO,8,1),1,'��',2,'��',3,'��',4,'��')AS GENDER
    FROM EMPLOYEE E
)WHERE GENDER = '��';
    

-- JOIN, ���տ����� Ȱ������ ��
SELECT * 
FROM (
    SELECT * FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN JOB USING(JOB_CODE)
)
WHERE DEPT_TITLE = '�ѹ���';

SELECT T.*, T.SALARY*12 AS ���� 
FROM (SELECT E.*, D.*, (SELECT TRUNC(AVG(SALARY),-1) FROM EMPLOYEE 
WHERE DEPT_CODE = E.DEPT_CODE) AS DEPT_SAL_AVG
    FROM EMPLOYEE E
    LEFT JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID) T
WHERE DEPT_SAL_AVG > 3000000;

-- ���տ����� �̿��ϱ�  -- ����ٽú���
SELECT *
FROM (SELECT EMP_ID AS CODE, EMP_NAME AS TITLE
     FROM EMPLOYEE
     UNION
     SELECT DEPT_ID, DEPT_TITLE
     FROM DEPARTMENT
     UNION
     SELECT JOB_CODE, JOB_NAME
     FROM JOB
)
WHERE CODE LIKE '%1%';
     

SELECT *
    FROM(SELECT ROWNUM AS RNUM, E.*
        FROM(SELECT * FROM EMPLOYEE)E);



-- ROW�� ������ ���ϰ� ����ϱ�
-- TOP-N ����ϱ�
--�޿��� ���� �޴� ��� 1~3������ ����ϱ�
SELECT ROWNUM, E.* FROM EMPLOYEE E
WHERE ROWNUM BETWEEN 1 AND 3
ORDER BY SALARY DESC;



-- 1. ����Ŭ�� �����ϴ� �����÷� ROWNUM�� �̿��ϱ�
SELECT ROWNUM, E.* FROM EMPLOYEE E
WHERE ROWNUM BETWEEN 1 AND 3;

-- SELECT���� �����Ҷ����� ROWNUM�� �����̵�
SELECT ROWNUM, T.*
FROM(
    SELECT ROWNUM AS INNERNUM, E.*
    FROM EMPLOYEE E
    ORDER BY SALARY DESC
)T
WHERE ROWNUM <= 5;


-- ROWNUM �� ������ �ݵ�� 1���� �����ؾ� ������ ���� �� �ִ�
-- ������ ó���Ҷ� ���̴��߿�!
SELECT *
FROM(
    SELECT ROWNUM AS RNUM, T.*
    FROM(SELECT *
        FROM EMPLOYEE 
        ORDER BY SALARY DESC) T)
WHERE RNUM BETWEEN 5 AND 10;


--2. RANK_OVER() �Լ� �̿��ϱ�
-- DENSE_RANK�� ���� ����� �־, �ߺ��ؼ� ��ũ�� �����ʰ�, �� ������ �������
SELECT *
   FROM(SELECT EMP_NAME, SALARY, 
        RANK() OVER(ORDER BY SALARY DESC) AS NUM,
        DENSE_RANK() OVER(ORDER BY SALARY DESC) AS NUM2
         FROM EMPLOYEE
        )
WHERE NUM BETWEEN 1 AND 23;




-- ��ձ޿��� ���� �޴� �μ� 3�� ���
SELECT *
FROM(
    SELECT RANK() OVER(ORDER BY SAL_AVG DESC) AS SAL_ORDER, D.*
    FROM (    
        SELECT DEPT_TITLE, AVG(SALARY) AS SAL_AVG
        FROM DEPARTMENT 
            JOIN EMPLOYEE ON DEPT_CODE = DEPT_ID
            GROUP BY DEPT_TITLE
        ORDER BY 2 DESC
    )D
)
WHERE SAL_ORDER > 3;




-- DDL (����� ����°�) = ���̺���°�
-- ������ ���� ���� ��ü�� �����(CREATE), �����ϰ�(ALTER), ����(DROP)�ϴ� ����
-- ���̺� = Ŭ����
-- �� = �������(�ʵ�)
-- �� = ��ü   

-- DDL�� ���� �˾ƺ���
-- ������ ���Ǿ��� ����Ŭ���� ����ϴ� ��ü�� ����, ����, �����ϴ� ��ɾ�
-- ���� : CREATE ������Ʈ��
-- ���� : ALTER ������Ʈ��
-- ���� : DROP ������Ʈ��

-- ���̺��� �����ϴ� ������� �˾ƺ���
-- ���̺���� : �����͸� ������ �� �ִ� ������ �����ϴ� ��
-- ���̺��� �����ϱ� ���ؼ��� ��������� Ȯ���ϴµ� Ȯ���� �� TYPE�� �ʿ�
-- ����Ŭ�� �����ϴ� Ÿ���� ���־��� Ÿ�Կ� ���� �˾ƺ���
-- ������ Ÿ�� : CHAR, VARCHAR2, NCHAR, NVARCHAR2, CLOB 
-- ������ Ÿ�� : NUMBER
-- ��¥�� Ÿ�� : DATE, TIMESTAMP

-- ������ Ÿ�Կ� ���� �˾ƺ���
 -- CHAR(����) : ������ ������ ����Ÿ������ ���̸�ŭ ������ Ȯ���ϰ� �����Ѵ� * �ִ� 2000����Ʈ ���� ����
 -- VARCHAR2(����) : ������ ���ڿ� ����Ÿ������ ����Ǵ� �����͸�ŭ ����Ȯ���ϰ� �����Ѵ�.
 -- CLOB -> �ִ� 4GB���� ó�� ����
 
 CREATE TABLE TBL_STR(
    A CHAR(6), 
    B VARCHAR2(6),
    C NCHAR(6),
    D NVARCHAR2(6)
);

SELECT * FROM TBL_STR;

INSERT INTO TBL_STR VALUES('ABC','ABC','ABC','ABC');
INSERT INTO TBL_STR VALUES('����','����','����','����');
INSERT INTO TBL_STR VALUES('����','����','����','�����ٶ󸶹ٻ�');
SELECT LENGTH(A), LENGTH(B), LENGTH(C), LENGTH(D)
FROM TBL_STR;


-- ������ �ڷ���
-- NUMBER : �Ǽ�, ���� ��� ������ ������
-- ������ 
-- NUMBER : �⺻��
-- NUMBER(PRECISION, SCALE) : ������ ��������
-- PRECISION : ǥ���� �� �ִ� ��ü �ڸ��� (1~38)
-- SCALE : �Ҽ��� ������ �ڸ��� (-84, 127)

CREATE TABLE TBL_NUM(
    A NUMBER,  -- ��ü������ �̷��Գ���
    B NUMBER(5),  -- ��ü�ڸ����� 5�ڸ������� �Ҽ����� �ݿø���
    C NUMBER(5,1), -- 5�ڸ������� �Ҽ����� ���ڸ��� ǥ��1
    D NUMBER(5,-2)  -- ��°�ڸ��������� ǥ��
);

SELECT * FROM TBL_NUM;

INSERT INTO TBL_NUM VALUES(1234.567, 1234.567, 1234.567, 1234.567);
-- INSERT INTO TBL_NUM VALUES(123456.123, 12345.123, 123456.123, 123456.123); -- ��ü�ڸ����� 5�ڸ��̹Ƿ� �ȵ�
INSERT INTO TBL_NUM VALUES(123456.123,12345.123,1234.123,0);
INSERT INTO TBL_NUM VALUES(123456.123, 12345.123, 1234.123, 123.1234567);
INSERT INTO TBL_NUM VALUES('1234.567', '1234.567', '1234.567', '1234.567');

-- ��¥
-- DAE, TIEMSTAMP
-- DROP TABLE TBL_TABLE;
CREATE TABLE TBL_DATE(
    BIRTHDAY DATE,
    TODAY TIMESTAMP
);

SELECT * FROM TBL_DATE; 
INSERT INTO TBL_DATE VALUES('98/08/03','98/01/26 15:30:30');

INSERT INTO TBL_DATE VALUES(TO_DATE('98/08/03','RR/MM/DD'),
            TO_TIMESTAMP('98/01/26 15:30:30', 'RR/MM/DD HH24:MI:SS'));

CREATE TABLE TBL_STR2(
    TESTSTR CLOB,
    TESTVARCHAR VARCHAR2(2000)
);

SELECT * FROM TBL_STR2;
