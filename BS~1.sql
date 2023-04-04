
-- �� �׷캰 ����� �� ���踦 �ѹ��� ������ִ� �Լ�
-- ROLLUP(), CUBE()
-- ���� ���̴� �հ谡 ���� ��������, �������� �������� ������
-- GROUP BY ROLLUP(�÷���)
-- GROUP BY CUBE(�÷���)
-- �μ��� �޿��հ�� ���հ踦 ��ȸ�ϴ� ����

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE;


SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY ROLLUP(DEPT_CODE);  -- �׷캰�� �������ְ� ��ü �հ���� ������ (�հ踦��������)


SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE);  -- �հ踦 ó����


SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE);

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE);


-- ROLLUP, CUBE �Լ��� �μ��� �Ѱ��̻��� �÷��� ���� �� �ִ�
-- ROLLUP : �ΰ� �̻��� �μ��� �������� �� �ΰ� �÷��� ����, ù��° �μ��÷��� �Ұ�, ��ü �Ѱ�
-- CUBE : �ΰ� �̻� �μ��� �������� �� �ΰ� �÷��� ����, ù��° �μ��÷��� �Ұ�, �ι�° �μ��÷��� �Ұ�, ��ü �Ѱ�
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL  
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE); 

SELECT * FROM EMPLOYEE;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)  -- ť��� ��� ������ �� �հ谡 ����
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE, JOB_CODE);



-- �μ���, ��å��, �ѻ���� �ѹ��� ��ȸ�ϱ�
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE, JOB_CODE);


-- GROUPING �Լ��� �̿��ϸ� ������ ����� ���� �б�ó���� �� �� �ִ�.
-- ROLLUP, CUBE�� ����� ROW�� ���� �б�ó��
-- GROUPING �Լ��� �����ϸ�, ROLLUP, CUBE�� ����� ROW 1�� ��ȯ �ƴϸ� 0�� ��ȯ
-- 1�϶� null�� , 0�϶� null �ƴ�
SELECT COUNT(*),
    CASE
        WHEN GROUPING(DEPT_CODE)=0 AND GROUPING(JOB_CODE)=1 THEN '�μ����ο�'
        WHEN GROUPING(DEPT_CODE)=1 AND GROUPING(JOB_CODE)=0 THEN '��å���ο�'
        WHEN GROUPING(DEPT_CODE)=0 AND GROUPING(JOB_CODE)=0 THEN '�μ�_��å�ο�'
        WHEN GROUPING(DEPT_CODE)=1 AND GROUPING(JOB_CODE)=1 THEN '���ο�'
    END AS ���
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE, JOB_CODE);

-- ���̺��� ��ȸ�� ������ �����ϱ�
-- ORDER BY ������ �����
-- SELECT �÷���....
-- FROM ���̺��
-- [WHERE ���ǽ�]
-- [GROUP BY �÷���]
-- [HAVING ���ǽ�]
-- [ORDER BY �÷��� ���Ĺ��(DESC,ASC)]  - DESC (��������), ASC(��������) ,������ ASC�� �⺻����

-- �̸��� �������� �����ϱ�
SELECT * FROM EMPLOYEE
ORDER BY EMP_NAME DESC; -- ��������


-- ������ ���� ������� ����������� �����ϱ�
-- �̸�, �޿�, ���ʽ�
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
ORDER BY SALARY DESC; -- ��������


-- �μ� �ڵ带 �������� �������� �����ϰ� ���� ������ ������ ������������ �����ϱ�
-- ������� ������ ��
SELECT * FROM EMPLOYEE   
ORDER BY DEPT_CODE ASC, SALARY DESC; 

-- �������� �� NULL���� ���� ó��
-- BONUS�� ���� �޴� ������� ����ϱ�
SELECT * FROM EMPLOYEE
-- ORDER BY BONUS DESC; -- NULL �ΰ��� ���� ����Ѵ�
-- ORDER BY BONUS ASC; -- NULL �ΰ��� ���߿� ����Ѵ�
-- �ɼ��� �����ؼ� NULL �� �����ġ�� ������ �� �ִ�.
-- ORDER BY BONUS DESC NULLS LAST;  -- NULL���� ���������� ó���� �� �ִ�.
-- ORDER BY BONUS ASC NULLS FIRST;  -- NULL���� ó������ ó���� �� �ִ�.
;

-- ORDER BY �������� ��Ī�� ����� �� �ִ�
SELECT EMP_NAME, SALARY AS ����, BONUS
FROM EMPLOYEE
ORDER BY ����;

-- SELECT ���� �̿��ؼ� �����͸� ��ȸ�ϸ� RESULT SET�� ��µǴµ�
-- RESULT SET�� ��µǴ� �÷����� �ڵ����� INDEX��ȣ�� 1���� �ο��� ��
SELECT *
FROM EMPLOYEE
ORDER BY 1;  -- 2�� ���̺��� 2�����ִ� EMP_NAME���� ��������

-- ���տ�����
-- �������� SELECT���� �Ѱ��� ���(RESULT SET)���� ������ִ� ��
-- ù��° SELECT���� �÷����� ���� SELECT ���� �÷����� ���ƾ��Ѵ�.
-- �� �÷��� ������ Ÿ�Ե� �����ؾ� �Ѵ�.
-- �ߺ����� �ϳ��� ��µ�

-- UNION : �ΰ� �̻��� SELECT ���� ��ġ�� ������
-- SELECT �� UNION SELECT ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- �÷��� 4��
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION   -- �ߺ����� �ϳ��� �������
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- �÷��� 4��
FROM EMPLOYEE
WHERE SALARY >= 3000000;


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL  -- �ߺ����� �� �������
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE SALARY >= 3000000;



SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- �÷��� 4��
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS   -- ������ ����Ȱ� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- �÷��� 4��
FROM EMPLOYEE
WHERE SALARY >= 3000000;


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- �÷��� 4��
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT   --  ����� �κи� ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- �÷��� 4��
FROM EMPLOYEE
WHERE SALARY >= 3000000;


-- �� SELECT���� �÷��� ���� �ٸ��� �ȵȴ�.
-- �÷��� ����(Ÿ��)�� ���ƾ���
SELECT EMP_ID, EMP_NAME, SALARY -- �÷��� 3��
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- �÷��� 4��
FROM EMPLOYEE
WHERE SALARY >= 3000000;


-- �ٸ� ���̺� �ִ� ������ ��ġ��
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
UNION
SELECT DEPT_ID, DEPT_TITLE, NULL  -- ���°����� NULL�� ������
FROM DEPARTMENT;


-- 3�� ���̺� ��ģ�Ŀ� �ϳ� ���̺� ����
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
UNION
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
UNION
SELECT JOB_CODE, JOB_NAME
FROM JOB
MINUS
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D6','D7');


-- GROUPING SET
-- GROUP BY ���� �ִ� ������ �ϳ��� �ۼ��ϰ� ���ִ� ���

-- �μ�, ��å��, �Ŵ����� �޿� ���
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE, MANAGER_ID;
-- �μ�, ��å�� �޿����
SELECT DEPT_CODE, JOB_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;
-- �μ�, �Ŵ����� �޿����
SELECT DEPT_CODE, MANAGER_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, MANAGER_ID;

-- �� 3������ �ϳ��� ��� ǥ��
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY GROUPING
        SETS((DEPT_CODE, JOB_CODE, MANAGER_ID),(DEPT_CODE, JOB_CODE), (DEPT_CODE,MANAGER_ID));
        
        


-- join�� ���� �˾ƺ���
-- �ΰ��̻��� ���̺��� Ư���÷��� �������� �������ִ� ���
-- JOIN �� ���� 2����
-- 1. INNER JOIN : ���صǴ� ���� ��ġ�ϴ� ROW�� �������� JOIN
-- 2. OUTER JOIN : ���صǴ� ���� ��ġ���� ���� ROW�� �������� JOIN * ������ �ʿ�

-- JOIN�� �ۼ��ϴ� ��� : 2����
-- 1. ����Ŭ ���ι�� : ,�� WHERE�� �ۼ�
-- 2. ANSI ǥ�� ���ι�� : JOIN, ON||USING ���� ����ؼ� �ۼ�

-- EMPLOYEE ���̺�� DEPARTMENT ���̺� JOIN�ϱ�
-- �� ���̺� ��ġ�Ǵ°��� ���� ã��
-- EMPLOYEE �� DEPARTMENT �������� �÷��� DEPT_ID��
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

-- ����Ŭ ������� JOIN �ϱ�
SELECT * 
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID; -- DEPT_CODE�� DEPT_ID�� ��ġ�ϴ� �ͳ��� JOIN


-- ANSI ǥ������ JOIN�ϱ�
-- JOIN ����� �ڿ��� JOIN�� �÷��� ����, ������ ������
SELECT *
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; 


-- ����� ���� �����, �̸���, ��ȭ��ȣ, �μ����� ��ȸ�ϱ�
SELECT EMP_NAME, EMAIL, PHONE, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; 

-- JOIN �������� WHERE�� ����ϱ�
-- �μ��� �ѹ����� ����� (�����, ����, ���ʽ�, �μ���) ��ȸ�ϱ�
SELECT EMP_NAME, SALARY, BONUS, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID  -- ������� �����ϸ� �̹� �������� ������ WHERE ������ TITLE ��밡��
WHERE DEPT_TITLE = '�ѹ���';
        
        
-- JOIN������ GROUP BY�� ����ϱ�
-- �μ��� ��ձ޿��� ����ϱ� (�μ���, ��ձ޿�)
SELECT DEPT_TITLE, AVG(SALARY)
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_TITLE
HAVING AVG(SALARY) >= 3000000;



-- JOIN�� �� �����̵Ǵ� �÷����� [�ߺ�]�ȴٸ� �ݵ�� ��Ī�� �ۼ��ؾ� �Ѵ�
-- �����, �޿�, ���ʽ�, ��å���� ��ȸ�ϱ�
SELECT *
FROM EMPLOYEE E
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE; -- USING�� ������ ��µɶ� ���صǴ� �÷� �ΰ� �� ���
                                        -- USING���� �ϸ� ���صǴ� �÷� �ϳ��� ���


-- ������ ������ �÷������� ������ ���� USING �̿��� �� �ִ�.
SELECT EMP_NAME, SALARY, BONUS, JOB_NAME
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);
    
    
-- ��å�� ������ ����� �̸�, ��å��, ��å�ڵ�, ������ ��ȸ
SELECT EMP_NAME, JOB_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE) -- EMPLOYEE�� JOB ���̺��� ���صǴ� �÷��� JOB_CODE�� ����
WHERE JOB_NAME = '����';


-- INNER �����϶��� �񱳵Ǵ� �÷��� null�̸� �񱳴�� x
SELECT COUNT(*)
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; 

    
-- OUTER JOIN ����ϱ�
-- �÷��� ���� ���Ϻ񱳸� ���� �� ���� ROW�� ������ִ� JOIN
-- ������ �Ǵ� ���̺�(��� �����͸�) ����������Ѵ�.
-- LEFT OUTER JOIN : JOIN�� �������� ���ʿ� �ִ� ���̺��� �������� ����
-- RIGHT OUTER JOIN : JOIN�� �������� �����ʿ� �ִ� ���̺��� �������� ����
-- ��ġ�Ǵ� ROW�� ���� ��� ��� �÷��� null�� ǥ����
SELECT *
FROM EMPLOYEE LEFT OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

SELECT *
FROM EMPLOYEE RIGHT OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;


-- CROSS JOIN -- ��� ROW�� �������ִ� JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE CROSS JOIN DEPARTMENT
ORDER BY 1;

-- SELF JOIN : �Ѱ��� ���̺� �ٸ� �÷��� ���� ������ �ִ� �÷��� �ִ� ���
-- �� �ΰ� �÷��� �̿��ؼ� JOIN
SELECT * FROM EMPLOYEE;
-- �Ŵ����� �ִ� ����� �̸�, �Ŵ��� ���̵�, �Ŵ��� ��й�ȣ, �Ŵ��� �̸� ��ȸ
SELECT E.EMP_NAME, E.MANAGER_ID, M.EMP_ID, M.EMP_NAME
FROM EMPLOYEE E
    JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;
    
    SELECT * FROM EMPLOYEE;
-- ����̸�, �Ŵ��� ���̵�, �Ŵ��� �����ȣ, �Ŵ��� �̸� ��ȸ
-- �Ŵ����� ������ ���� ����ϱ�


SELECT E.EMP_NAME, NVL(E.MANAGER_ID,'����'), NVL(M.EMP_ID,'����'), NVL(M.EMP_NAME,'����')
FROM EMPLOYEE E
    RIGHT OUTER JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;  


--  �������� ����񱳸� �ؼ� ó����. ON �÷��� = �÷���
--  �񵿵� ���ο� ���� �˾ƺ���
--  ������ ���̺��� �������� �������Ѵ�
SELECT * FROM SAL_GRADE;
SELECT *
FROM EMPLOYEE
   JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- ȸ����� ����Ʈ����, ��ǰ���(����), ��� ���� ���� ȸ�� ���

-- ���������� �� �� �ִ�.
-- 3�� �̻��� ���̺��� �����ؼ� ����ϱ�
-- �����, ��å��, �μ��� ��ȸ�ϱ�
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING(JOB_CODE);
    

-- ����� �����, �μ���, ��å��, �ٹ����� ��ȸ�ϱ�

SELECT EMP_NAME, JOB_NAME,  DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE  -- EMPLOYEE�� �������� �ؿ� JOIN�� ���̺��� ���� �������� �÷��� �����ؾ��Ѵ�
    LEFT JOIN JOB USING(JOB_CODE)
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    LEFT JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;


