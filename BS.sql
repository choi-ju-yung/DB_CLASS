-- 2���� ����
-- ����Ŭ���� �����ϴ� �Լ��� ���� �˾ƺ���
-- ������ �Լ� : ���̺��� ��� �࿡ ����� ��ȯ�Ǵ� �Լ�
--              ����, ����, ��¥, ����ȯ, �����Լ�(����Ȱ��)
-- �׷��Լ� : ���̺� �Ѱ��� ����� ��ȯ�Ǵ� �Լ�
--          �հ�, ���, ����, �ִ밪, �ּҰ� 

-- ������ �Լ� Ȱ���ϱ�
-- ����ϴ� ��ġ
-- SELECT���� �÷��� �ۼ��ϴ� �κ�, WHERE��
-- INSERT, UPDATE, DELETE������ ����� ����


-- ���ڿ� �Լ��� ���� �˾ƺ���
-- ���ڿ��� ó���ϴ� ���
-- LENGTH : ������ �÷��̳�, ���ͷ����� ���� ���̸� ������ִ� �Լ�
-- LENGTH('���ڿ�' �Ǵ� �÷���) -> ���ڿ��� ������ ���
SELECT LENGTH('���� ������ ������!')
FROM DUAL;

SELECT EMAIL,LENGTH(EMAIL)
FROM EMPLOYEE;

-- �̸����� 16���� �̻��� ����� ��ȸ�ϱ�
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE
WHERE LENGTH(EMAIL) >= 16;

-- LENGTHB : �����ϴ� (B)YTE�� ��� 
-- EXPRESS�������� �ѱ��� 3BYTE�� ������. ENTERPRISE���������� 2BYTE
 SELECT LENGTHB('ABCD'), LENGTHB('������') FROM EMPLOYEE;


-- INSTR : JAVA�� INDEXOF�� ������ �����
-- INSTR('���ڿ�' �Ǵ� �÷�, 'ã�� ����'[,������ġ, ã����°(Ƚ��)])
-- ����Ŭ������ �ε����� 1���� ������, ���ڰ� �������� ������ 0���� ������
SELECT INSTR('GD��ī����','GD'), INSTR('GD��ī����','��'), INSTR('GD��ī����','��')
FROM DUAL;

SELECT EMAIL, INSTR(EMAIL,'j') -- �� �̸��Ͽ��� j�� �����ϴ� ��ġ �ε��� �� ����
FROM EMPLOYEE;

-- EMAIL �ּҿ� j�� ���ԵǾ��ִ� ��� ã��
-- LIKE�� ã�Ƶ������� INSTR�ε� ������
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE INSTR(EMAIL,'j')>0;  


SELECT INSTR('GD��ī���� GD������ GD���ǻ� GDȭ����','GD',3), -- 3�� ������ġ��(
       INSTR('GD��ī���� GD������ GD���ǻ� GDȭ����','GD',-1), --  -1�� ������������ ã�� (��: 20)    
       INSTR('GD��ī���� GD������ GD���ǻ� GDȭ����','GD',1,3) -- 1��°���� �����ϴµ�,3���� GD�ִ� �� ã�� (��: 14)
FROM DUAL; 


    -- ������̺��� @�� ��ġ�� ã��
SELECT EMP_NAME,EMAIL,INSTR(EMAIL,'@') FROM EMPLOYEE;


-- LPAD / RPAD : ���ڿ��� ���̰� ������ ���̸�ŭ �����ʾ��� �� �� ������ ä���ִ� �Լ�
-- LPAD / RPAD(���ڿ� �Ǵ� �÷�, �ִ����, ��ü����)
SELECT LPAD('������',10,'*'), -- ������(3�������� 2BYTE�� ����ϹǷ�) �� 6����Ʈ �� -> *�� �տ� 4���� ����
       RPAD('������',10,'@'), -- ���������� ������ ĭ�� @�� ��ü
       LPAD('������',10) -- ���� ������ ������ ��ü
FROM DUAL;


SELECT EMAIL, RPAD(EMAIL,20,'#')  -- �̸��� �����ʺκ� �������κ��� #���� ��ü
FROM EMPLOYEE;

-- LTRIM/ RTRIM : ������ �����ϴ� �Լ�, Ư�����ڸ� �����ؼ� ����
-- LTRIM/RTRIM('���ڿ�'�Ǵ� �÷�[,'Ư������']) 
SELECT '     ����',LTRIM('     ����'),   -- ���ڿ� �������� ���� ���鰪�� �� ����
                  RTRIM('   ����   '),  -- ���ڿ� �������� ������ ���鰪�� �� ����
                  RTRIM('   ��  �� ')
FROM DUAL;

-- Ư�����ڸ� �����ؼ� ������ �� �ִ�
SELECT '����2222', RTRIM('����2222','2'),  -- �����ʿ� 2�� �����ϴ� �κ� �� ����
                 RTRIM('����22122','2'),  -- 2�ƴ� �ٸ� ���ڷ� ������ �κб����� ���� -> ����221 ��µ�
                 RTRIM('����22122','12')  -- '12' -> (1�Ǵ� 2) �� ���� (OR��������)              
FROM DUAL;


-- TRIM : ���ʿ� �ִ� ���� �����ϴ� �Լ�, �⺻ : ����, �����ϸ� �������� ����(������ ������ �ѱ��ڸ� ����)
-- TRIM('���ڿ�'||�÷�)
-- TRIM(LEADING||TRALLING||BOTH '�����ҹ���' FROM ���ڿ�||�÷���)

SELECT '     ������    ', TRIM('     ������    '),  -- ���ʿ� �ִ� ���鰪�� ��������
                    'ZZZZZZ��¡��ZZZZZZ', TRIM('Z' FROM 'ZZZZZZ��¡��ZZZZZZ'), -- ���ʿ� �ִ� Z ������
                    TRIM(LEADING 'Z' FROM 'ZZZZZ��¡��ZZZZZZ'),  -- ���ڿ� ���� �κ� Z�� ����
                    TRIM(TRAILING 'Z' FROM 'ZZZZZ��¡��ZZZZZZ'),  -- ���ڿ� ������ �κ� Z�� ����
                    TRIM(BOTH 'Z' FROM 'ZZZZZ��¡��ZZZZZZ')  -- ���ڿ� ���� �κ� Z�� ����
FROM EMPLOYEE;  


-- SUBSTR : ���ڿ��� �߶󳻴� ��� =  JAVA SUBSTRING�޼ҵ�� ����
-- SUBSTR('���ڿ�' �Ǵ� �÷���, �����ε�����ȣ[,����])  -- �ε�����ȣ�� 1������ ����
SELECT SUBSTR('SHOWMETHEMONEY',5), -- 5��°���� ������ �߶󳻼� ������ (METHEMONEY)���
      SUBSTR('SHOWMETHEMONEY',5,2), -- 5��°���� �߶� �����ִµ� 2���ڸ� ������ (ME) ���
      SUBSTR('SHOWMETHEMONEY',INSTR('SHOWMETHEMONEY','MONEY')),
      SUBSTR('SHOWMETHEMONEY',-5,2) -- (-)�� ������ �ǹ̷� �������� 5��°�� M���� 2�� ���� ��� (MO)���
FROM DUAL;


-- ����� �̸��Ͽ��� ���̵� ���� ����ϱ�
-- ���̵� 7������ ����� ��ȸ
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1)
FROM EMPLOYEE
WHERE LENGTH(SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1)) >=7;


-- ����� ������ ǥ���ϴ� ��ȣ������ϱ�
-- ���ڻ���� ��ȸ
-- 2 �Ǵ� 4 -> ����
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN(2,4); 


-- �����ڸ� ó���ϴ� �Լ� : UPPER, LOWER, INITCAP
SELECT UPPER('welcome TO OrACLE worLd'),  -- ��� �빮�ڷ�
       LOWER('welcome TO OrACLE worLd'),  -- ��� �ҹ��ڷ�
       INITCAP('welcome TO OrACLE worLd') -- ù���ڸ� �빮��
FROM DUAL;


-- CONCAT : ���ڿ� �������ִ� �Լ�
-- || �����ڿ� ������
SELECT EMP_NAME||EMAIL, CONCAT(EMP_NAME, EMAIL), -- EMP_NAME, EMAIL ��ħ
                        CONCAT(CONCAT(EMP_NAME, EMAIL),SALARY) -- EMP_NAME, EMAIL, SALARY �� ��ħ
FROM EMPLOYEE;



-- REPLACE : �����(�÷�)���� �������ڸ� ã�Ƽ� Ư�����ڷ� �����ϴ� ��
-- REPLACE('���ڿ�'||�÷���,'ã������','��ü����')
SELECT EMAIL, REPLACE(EMAIL,'BS','GD')  -- �̸����� BS���ڸ� GD�� �ٲ���
FROM EMPLOYEE;

-- UPDATE EMPLOYEE SET EMAIL=REPLACE(EMAIL,'BS','GD'); -- EMAIL�� �ִ� BS�� GS�� �ٲ�
-- ROLLBACK  -- �ǵ����°�















-- REVERSE : ���ڿ��� �Ųٷ� ������ִ� ���
SELECT EMAIL, REVERSE(EMAIL), EMP_NAME, REVERSE(EMP_NAME)  -- �ѱ۰�����쿡�� �������� ����
FROM EMPLOYEE;


-- TRANSLATE : ��Ī�Ǵ� ���ڷ� �������ִ� �Լ�
SELECT TRANSLATE('010-3644-6259','0123456789','�����̻�����ĥ�ȱ�') -- �ι�°�� ����° ���ڰ� ��Ī�����̸� ù��° ���ڴ� �������̴�
FROM DUAL;


-- ���� ó���Լ�
-- ABS : ���밪�� ó���ϴ� �Լ�
SELECT ABS(-10), ABS(10)
FROM DUAL;

-- MOD : �������� ���ϴ� �Լ� (�ڹ��� %�����ڿ� ����)
SELECT MOD(3,2)   
FROM DUAL;  -- 1���
SELECT E.*, MOD(SALARY,3)  -- *�� �÷��� ���� ����ϰ� ���������� �տ� E.���� ����  
FROM EMPLOYEE E; -- 0,1,2 �� ���

-- �Ҽ����� ó���ϴ� �Լ�
-- ROUND : �Ҽ����� �ݿø��ϴ� �Լ�
-- ROUND(���� || �÷���[,�ڸ���])
SELECT 126.567,ROUND(126.567), -- 127�� ��µ� (�Ҽ����ݿø��ؼ� ����)
               ROUND(126.467), -- 126�� ��µ�
               ROUND(126.567,2) -- �Ҽ��� ��°�ڸ����� �ݿø��� -> 126.57 ��µ�
FROM DUAL;

-- ���ʽ��� ������ ���ޱ��ϱ�
SELECT EMP_NAME, SALARY, ROUND(SALARY+SALARY*NVL(BONUS,0)-(SALARY*0.03))
FROM EMPLOYEE;

-- FLOOR : �Ҽ����ڸ� ����
SELECT 126.567, FLOOR(126.567)  -- �Ҽ����� ������� ���� �� ���
FROM DUAL;  -- 126���� ���

-- TRUNC : �Ҽ����ڸ� ���� (�ڸ����� ����)
SELECT 126.567, TRUNC(126.567,2), -- �Ҽ��� ���ڸ������� ǥ���ϰ� �������� ����   (126.56)
                TRUNC(126.567,-2), -- �Ҽ����ڸ����� �������� ���ڸ����� ǥ���ϰ� ���������� (100)
                TRUNC(2123456.32,-2) -- (2123400)
FROM DUAL;


-- CEIL : �Ҽ��� �ø�
SELECT 126.567, CEIL(126.567), CEIL(126.111)  -- 127�� ���
FROM EMPLOYEE;


-- ��¥ó���Լ� �̿��ϱ�
-- ����Ŭ���� ��¥�� ����� ���� 2���� ����� ����
-- 1. SYSDATE ����� -> ��¥ ��/��/�� ���� ��¥(����Ŭ�� ��ġ�Ǿ� �ִ� ��ǻ���� ��¥)�� �������.
-- 2. SYSTIMESTAMP����� -> ��¥ + �ð����� �������
SELECT SYSDATE, SYSTIMESTAMP
FROM DUAL;

-- ��ǻ�Ϳ����� ��¥�� ǥ���� �� long���� ǥ����
-- ��¥�� �������ó���� ������ (+,-) ���갡�� -> �ϼ��� ����, �߰���
SELECT SYSDATE-2,  -- 4/3 �������� 4/1���
       SYSDATE+30   -- 4/3 �������� 5/3���
FROM DUAL;

-- NEXT_DAY : �Ű������� ���޹��� ���� �� ���� ����� ���� ��¥ ���
SELECT SYSDATE, NEXT_DAY(SYSDATE,'��')  -- �������� ���尡��� ���� ��¥ -> 4�� 10��
FROM DUAL;

-- LOCALE�� ���� ������ ����
SELECT * FROM V$NLS_PARAMETERS;
ALTER SESSION SET NLS_LANGUAGE = 'AMERICAN';  -- SESSION �� �̱����� �ٲ㼭
SELECT SYSDATE, NEXT_DAY(SYSDATE,'MON'),NEXT_DAY(SYSDATE,'TUESDAY') -- �ܱ��� ���缭 �����
FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN'; -- �ٽ� �ѱ����� �ٲ���

-- LAST_DAY : �״��� ���������� ���
SELECT SYSDATE, LAST_DAY(SYSDATE),  -- 4���� 30�� ���� ����
                LAST_DAY(SYSDATE+30) -- 5���� 31�� ���� ����
FROM DUAL;


-- ADD_MONTHS : �������� ���ϴ� �Լ�
SELECT SYSDATE, ADD_MONTHS(SYSDATE,4) -- 4��3�� �������� 8�� 3���� ����
FROM DUAL;


-- MONTHS_BETWEEN : �ΰ��� ��¥�� �޾Ƽ� �� ��¥�� �������� ������ִ� �Լ�
SELECT FLOOR(ABS(MONTHS_BETWEEN(SYSDATE,'23/08/17'))) -- �Ҽ������� �����ֱ�
FROM DUAL;

-- ��¥�� �⵵, ��, ���ڸ� ���� ����� �� �ִ� �Լ�
-- EXTRACT(YEAR || MONTH || DAY FROM ��¥) : ���ڷ� �������
-- ���糯¥�� ��, ��, �� ����ϱ�
SELECT EXTRACT(YEAR FROM SYSDATE) AS ��, EXTRACT(MONTH FROM SYSDATE) AS ��,
       EXTRACT(DAY FROM SYSDATE) AS ��
       FROM DUAL;


-- ��� �� 12���� �Ի��� ������� ���Ͻÿ�
SELECT EMP_NAME, HIRE_DATE 
FROM EMPLOYEE
WHERE EXTRACT(MONTH FROM HIRE_DATE) = 12;

SELECT EXTRACT(DAY FROM HIRE_DATE) +100  -- ��¥ó���Լ������� ��Ģ���� ������
FROM EMPLOYEE;

-- ���� ���뺹�αⰣ�� 1�� 6���� ����ؼ�
-- �������ڸ� ���ϰ�, ���������� �Դ� «���(�Ϸ缼��)�� ���ϱ�
SELECT ADD_MONTHS(SYSDATE,18) AS ��������, (ADD_MONTHS(SYSDATE,18)-SYSDATE)*3 AS «��� 
FROM DUAL;


-- ����ȯ �Լ�
-- ����Ŭ������ �ڵ�����ȯ�� �� �۵��� ��
-- ����Ŭ������ �����͸� �����ϴ� Ÿ���� ����
-- ���� : CHAR, VARCHAR2, NCHAR, NVARCHAR2  -> JAVA String�� ����
-- ���� : NUMBER 
-- ��¥ : DATE, TIMESTAMP

-- TO_CHAR : ����, ��¥�� ���������� �������ִ� �Լ�
-- ��¥�� ���������� �����ϱ�
-- ��¥���� ��ȣ�� ǥ���ؼ� ���������� ������ �Ѵ�.
-- Y > ��, M : ��, D : ��, H : ��, MI : ��, SS : ��

SELECT SYSDATE, TO_CHAR(SYSDATE,'YYYY-MM-DD'), -- ���ó�¥�� 'YYYY-MM-DD' �������� ���
                TO_CHAR(SYSDATE,'YYYY-MM-DD HH:MI:SS') -- ���ó�¥�� 'YYYY-MM-DD HH:MI:SS' �������� ���
FROM DUAL;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE,'YYYY.MM.DD') -- ������� ��볯¥�� 'YYYY.MM.DD' �������� ���
FROM EMPLOYEE;


-- ���ڸ� ���������� �����ϱ�
-- ���Ͽ� ���缭 ��ȯ -> �ڸ����� ��� ǥ������ ����
-- 0 : ��ȯ����� �ڸ����� ������ �ڸ����� ��ġ���� ������, ���� ���� �ڸ��� 0�� ǥ���ϴ� ����
-- 9 : ��ȯ����� �ڸ����� ������ �ڸ����� ��ġ���� ������, ���� ���� �ڸ��� �����ϴ� ���� (�տ� ����� ������ FM���� �����ؾ���)
-- ��ȭ�� ǥ���ϰ� �������� L�� ǥ��
SELECT 1234567, TO_CHAR(1234567,'000,000,000'), -- 001,234,567 �� ��µ�
                TO_CHAR(1234567,'999,999,999'), -- 1,234,567 ��µ� (�� ���ڸ� ������)
                TO_CHAR(500,'L999,999,999') -- �տ� L ������ �޷� ǥ�õ�
FROM DUAL;

SELECT 180.5, TO_CHAR(180.5,'000,000.00'), -- 000,180.50���� ��µ�
          TO_CHAR(180.5,'FM999,999.00') AS Ű -- 180.50�� ��µ� (FM��� �������ŵ�)
FROM DUAL;


-- ������ ��ȭǥ���ϰ� ,�� �����ؼ� ����ϰ� �Ի����� 0000.00.00���� ����ϱ�
SELECT EMP_NAME, TO_CHAR(SALARY,'FML999,999,999') AS �޿�,
                 TO_CHAR(HIRE_DATE,'YYYY.MM.DD') AS �Ի���
FROM EMPLOYEE;


-- ���������� �����ϱ�
-- TO_NUMBER�Լ��� �̿�
-- ���ڸ� ���������� �����ϱ�
SELECT 1000000+1000000, TO_NUMBER('1,000,000','999,999,999')+1000000,  -- ���ڿ� 1,000,000�� ���Ͽ����ļ� ���ڷ� ��ȯ��
    TO_CHAR(TO_NUMBER('1,000,000','999,999,999')+1000000,'FML999,999,999') -- ���ڷ� ��ȯ�� ���� �ٽ� ���Ͽ����缭 ǥ��
FROM DUAL;

-- ��¥������ �����ϱ�
-- ���ڸ� ��¥�� ����
-- ���ڿ��� ��¥�� ����
SELECT TO_DATE('23/12/25','YY/MM/DD')-SYSDATE, -- ���ڿ��� ��¥�� ������
        TO_DATE('241225','YYMMDD'), -- ���ڿ��� ��¥�� ������
        TO_DATE('25-12-25','YY-MM-DD') -- ���ڿ��� ��¥�� ������
FROM DUAL;


SELECT TO_DATE(20230405,'YYYYMMDD'), 
        TO_DATE(230505,'YYMMDD'),
        TO_DATE(TO_CHAR(000224,'000000'),'YYMMDD') -- ���ھտ� 000�� �������°��̶� ���ڿ��� �ٲ��Ŀ� �� ���� ��¥�� �ٲ�
FROM DUAL;

-- NULL���� ó�����ִ� �Լ�
-- NVL �Լ� : NVL(�÷�,��ü��)
-- NVL2 �Լ� : NVL2(�÷�,NULL�� �ƴҶ�, NULL�϶�)
SELECT EMP_NAME, DEPT_CODE, NVL(DEPT_CODE,'����'), 
                NVL2(DEPT_CODE,'����','����') 
FROM EMPLOYEE;



-- ���ǿ� ���� ����� ���� �������ִ� �Լ�
-- 1. DECODE
-- DECODE(�÷���||���ڿ�,'����','��ü��','����2',.....) -- ������ ������ ��ü������ ����ض�
-- �ֹι�ȣ���� 8��°�ڸ��� ���� 1�̸� ����, 2�̸� ���� ����ϴ� �÷��߰��ϱ�
SELECT EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO,8,1),'1','����','2','����') AS GENDER
FROM EMPLOYEE;


-- �� ��å�ڵ��� ��Ī�� ����ϱ�
-- J1 ��ǥ, J2 �λ���, J3 ����, J4 ����
-- ������ ���� �̷�� IF ���ǹ��̸�, ������ �ϳ��� �� ����� ELSE���̶�� �����ϸ�ȴ�.
SELECT EMP_NAME, JOB_CODE, DECODE(JOB_CODE,'J4','����','J3','����','J2','�λ���','J1','��ǥ','���') 
FROM EMPLOYEE;

-- 2. CASE WHEN THEN ELSE
-- CASE
--      WHEN ���ǽ� THEN ���೻��
--      WHEN ���ǽ� THEN ���೻��
--      WHEN ���ǽ� THEN ���೻��
--      ELSE ����
-- END

SELECT EMP_NAME, JOB_CODE,
        CASE
            WHEN JOB_CODE = 'J1' THEN '��ǥ'
            WHEN JOB_CODE = 'J2' THEN '�λ���'
            WHEN JOB_CODE = 'J3' THEN '����'
            WHEN JOB_CODE = 'J4' THEN '����'
            ELSE '���'                     
        END AS ��å,
        CASE JOB_CODE
            WHEN 'J1' THEN '��ǥ'
            WHEN 'J2' THEN '�λ���'
        END
FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;

--������ �������� ��׿����ڿ� �߰������� �׿ܸ� ������ ����ϱ�
-- ������ 400���� �̻� : ��׿�����,   ���� : 400���� �̸��̸� 300���̻��̸� �߰�������
-- �������� �׿ܸ� ����ϴ� �����÷� �����
-- �̸� ���� ���

SELECT EMP_NAME, SALARY, 
        CASE
            WHEN SALARY >= 4000000 THEN '��׿�����'
            WHEN SALARY >= 3000000 THEN '�߰�������'
            ELSE '�׿�'
        END AS ���
FROM EMPLOYEE;


-- ������̺��� ���糪�� ���ϱ�     -- YY�� ���������� ���ڸ� ���ڸ��� 20���� �ٿ���  -- RR�ΰ��������� ���ڸ� ���ڸ��� 19�� �ٿ��� 
SELECT EMP_NAME, EMP_NO,EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'YY'))||'��' AS YY��,
EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR'))||'��' AS RR��,
    EXTRACT(YEAR FROM SYSDATE)-(
    TO_NUMBER(SUBSTR(EMP_NO,1,2))+
    CASE
        WHEN SUBSTR(EMP_NO,8,1) IN (1,2) THEN 1900
        WHEN SUBSTR(EMP_NO,8,1) IN (3,4) THEN 2000
    END
    ) AS �� 
FROM EMPLOYEE;

-- RR�� �⵵�� ����� ��
-- ����⵵   �Է³⵵   ���⵵
-- 00~49    00~49       ������     �Է³⵵�� 62�⵵ �ϰ�� ������ΰ� ex) 2023 - 1962  
-- 00~49    50~99       ������
-- 50~99    00~49       ��������        
-- 50~99    50~99       ������

insert into EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,BONUS,MANAGER_ID,HIRE_DATE, ENT_DATE,ENT_YN) 
values ('251','������','320808-4123341','go_dm@kh.or.kr',null,'D2','J2','S5',4480000,null,null,to_date('94/01/20','RR/MM/DD'),null,'N');
SELECT * FROM EMPLOYEE;

UPDATE EMPLOYEE SET EMP_NO='320808-1123341' WHERE EMP_ID ='252';
COMMIT;


-- �׷��Լ� Ȱ���ϱ�
-- ���̺��� �����Ϳ� ���� �����ϴ� �Լ����� �հ�, ���, ����, �ִ밪, �ּҰ��� ���ϴ� �Լ�
-- �׷��Լ��� ����� �⺻������ �Ѱ��� ���� ������
-- ����
-- SUM : Ư�� �÷��� ���� ���� -> SUM(�÷�(NUMBER))
-- AVG : ���̺��� Ư���÷��� ���� ��� -> AVG(�÷�(NUMBEER)))
-- COUNT : ���̺��� �����ͼ�(ROW��) -> COUNT(* Ȥ�� �÷�)
-- MIN : ���̺��� Ư�� �÷��� ���� �ּҰ� -> MIN(�÷���)
-- MAX : ���̺��� Ư�� �÷��� ���� �ִ밪 -> MAX(�÷���)

-- ����� ������ �� �հ踦 ���غ���
SELECT TO_CHAR(SUM(SALARY),'FML999,999,999') AS ���հ� FROM EMPLOYEE;

-- D5 �μ��� ������ �� �հ踦 ���غ���
SELECT TO_CHAR(SUM(SALARY),'FML999,999,999') AS "D5�� �� ���� " FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';


-- J3����� �޿� �հ踦 ���Ͻÿ�
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE JOB_CODE = 'J3';


-- ��ձ��ϱ� AVG�Լ�
-- ��ü����� ���� ��ձ��ϱ�
SELECT AVG(SALARY) FROM EMPLOYEE;

-- D5�� �޿� ����� ���ϱ�
SELECT AVG(SALARY) FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';


-- D5�μ��� �޿��հ�� ��ձ��ϱ�--
-- �׷��Լ� ����Ҷ��� SELECT �ڿ� �Ϲ� �Ӽ��� ����� �� ����
SELECT SUM(SALARY), AVG(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';


-- NULL���� ���ؼ��� ��� ó�����ɱ� -> �ΰ��� ������ �����ع���
SELECT SUM(BONUS),AVG(BONUS),AVG(NVL(BONUS,0)) --> ���ʽ� NULL���� ������� 0������ �ٲ�
FROM EMPLOYEE;


-- ���̺��� �����ͼ� Ȯ���ϱ�
-- ���ΰ����� ������
-- *�� ��ü ����(NULL���� ����)
SELECT COUNT(*),COUNT(DEPT_CODE), COUNT(BONUS)
FROM EMPLOYEE;

-- D6�μ��� �ο� ��ȸ
SELECT COUNT(*) FROM EMPLOYEE
WHERE DEPT_CODE = 'D6';


-- 400���� �̻� ������ �޴� ��� ��
SELECT COUNT(*) AS "400���� �̻� ���޹޴� ��� ��" FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- D5�μ����� ���ʽ��� �ް� �ִ� ����� ����?
SELECT COUNT(*) FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND BONUS IS NOT NULL;

SELECT COUNT(BONUS) FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';  -- ���� ���������


-- �μ��� D6, D5, D7�� ����� ��, �޿� �հ�, ����� ��ȸ�ϼ���
SELECT COUNT(*) AS �����,SUM(SALARY) AS �޿��հ�,AVG(SALARY) AS �޿���� FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D6','D7');

SELECT MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE;


-- GROUP BY �� Ȱ���ϱ�
-- �׷��Լ��� ������� �� Ư�� �������� �÷����� ��� ó���ϴ� �� -> ���� �׷캰 �׷��Լ��� ����� ��µ�
-- SELECT �÷�
-- FROM ���̺��
-- [WHERE ���ǽ�]
-- [GROUP BY �÷��� [,�÷���,�÷���,....]]
-- [ORDER BY �÷���]

-- �μ��� �޿� �հ踦 ���Ͻÿ�
SELECT DEPT_CODE,SUM(SALARY) -- �μ��� �ߺ��Ǵ°ͳ��� �հ豸�ϱ� 
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- ��å�� �޿��� �հ�, ����� ���Ͻÿ�
SELECT JOB_CODE,SUM(SALARY),AVG(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- �μ��� ����� ���ϱ�
SELECT DEPT_CODE,COUNT(*) FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- GROUP BY ������ �ټ��� �÷��� ���� �� �ִ�
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;  -- DEPT_CODE�� JOB_CODE �� �� ����Ǵ� �� ���� ����

-- GROUP BY�� ����� ������ WHERE�� ����� �����ϴ�
SELECT DEPT_CODE, SUM(SALARY) 
FROM EMPLOYEE
WHERE BONUS IS NOT NULL -- �������� ���� ������ �� �׷����� ����
GROUP BY DEPT_CODE;


-- �μ��� �ο��� 3�� �̻��� �μ��� ���
SELECT DEPT_CODE,COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) >= 3;


-- ��å�� �ο����� 3���̻��� ��å ���
SELECT JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING COUNT(*) >= 3;

-- ��ձ޿��� 300���� �̻��� �μ� ����ϱ�
SELECT DEPT_CODE,AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

-- �Ŵ����� �����ϴ� ����� 2���̻��� �Ŵ��� ���̵� ����ϱ�
SELECT MANAGER_ID, COUNT(*)
FROM EMPLOYEE 
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING COUNT(*) >=2;

-- ����, ������ �޿� ����� ���ϰ� �ο����� ���ϱ�
SELECT SUBSTR(EMP_NO,8,1), AVG(SALARY), COUNT(*) FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1); 

SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','��','3','��','2','��','4','��') AS ����, AVG(SALARY), COUNT(*)
FROM EMPLOYEE 
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','��','3','��','2','��','4','��');





SELECT * FROM EMPLOYEE;