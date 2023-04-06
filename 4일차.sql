-- join문이 서브쿼리문 쓰는 것도다 속도면이 더 좋음

-- 서브 쿼리 : SELECT문 안에 SELECT문이 하나 더 있는 쿼리문을 말함
-- 서브쿼리는 반드시 ()안에 작성을 해야한다.

-- 윤은해 사원과 동일한 급여를 받고 있는 사원을 조회하기
SELECT * 
FROM EMPLOYEE
WHERE SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '윤은해');

-- D5부서의 평균급여보다 많이 받는 사원구하기
SELECT * 
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = 'D5');

-- 1. 단일행 서브쿼리
-- 서브쿼리 SELECT 문의 결과가 1개열, 1개행인 것
-- 위 예시 2가지처럼 (결과가 하나 나오는) 것을 단일행 서브쿼리라고 한다
-- 컬럼, WHERE절에 비교대상 값


-- 사원들의 급여 평균보다 많이 급여를 받는 사원의 이름, 급여, 부서코드를 출력하기
-- 컬럼절에도 서브쿼리를 쓸수 있음 
SELECT EMP_NAME, SALARY, DEPT_CODE, (SELECT AVG(SALARY) FROM EMPLOYEE) AS AVG
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE);


-- 부서가 총무부인 사원을 조회하기
SELECT * 
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '총무부');

SELECT *
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '총무부';


-- 직책이 과장인 사원을 조회하기
SELECT * 
FROM EMPLOYEE
    WHERE JOB_CODE = (SELECT JOB_CODE FROM JOB WHERE JOB_NAME = '과장');


-- 다중행 서브쿼리문
-- 서브쿼리의 결과가 한개열 다수 행(ROW)을 갖는것
-- IN 연산자를 활용한다

-- 직책이 부장, 과장인 사원을 조회
SELECT * 
FROM EMPLOYEE
WHERE JOB_CODE IN(SELECT JOB_CODE FROM JOB WHERE JOB_NAME IN('과장','부장'));


-- 다중행에 대한 대소비교하기
-- >=, >, <, <=
-- ANY : OR로 ROW를 연결
-- ALL : AND로 ROW를 연결
-- 컬럼 >(=) ANY(서브쿼리) : 다중행 서브쿼리의 결과 중 하나라도 크면 참 -> 다중행 서브쿼리의 결과 중 최소값보다 크면 
-- 컬럼 <(=) ANY(서브쿼리) : 다중행 서브쿼리의 결과 중 하나라도 작으면 참 -> 다중행 서브쿼리의 결과 중 최대값보다 작으면 


SELECT * 
FROM EMPLOYEE
WHERE SALARY >= ANY(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN('D5','D6'));
-- ANY(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN('D5','D6'); 의 결과중 최소값이 180만보다 크면 다 참임

SELECT * 
FROM EMPLOYEE
WHERE SALARY >= (SELECT MIN(SALARY) FROM EMPLOYEE WHERE DEPT_CODE IN('D5','D6'));
-- 위 결가와 값이 동일함


-- 컬럼 >(=) ALL(서브쿼리) : 다중행 서브쿼리의 결과가 모두 클 때 참 -> 다중행 서브쿼리의 결과 중 최대값보다 크면 참
-- 컬럼 <(=) ALL(서브쿼리) : 다중행 서브쿼리의 결과가 모두 작을 때 참 -> 다중행 서브쿼리의 결과 중 최소값보다 작으면 참


SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY < ALL(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN('D5','D6'));
-- WHERE SALARY < (SELECT MIN(SALARY) FROM EMPLOYEE WHERE DEPT_CODE IN('D5','D6'));

-- 2000년 1월 1일 이전 입사자 중 2000년 1월 1일 이후 입사한 사원 중 가장 높게 받는 사원보다 급여을 높게 받는
-- 사원의 사원명, 급여, 조회

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE HIRE_DATE < '00/01/01'   
    AND SALARY > ALL(SELECT SALARY FROM EMPLOYEE WHERE HIRE_DATE > '00/01/01');
    -- AND SALARY > (SELECT MAX(SALARY) FROM EMPLOYEE WHERE HIRE_DATE > '00/01/01);

-- 다중열 서브쿼리 : 열이 다수, 행이 1개인 쿼리문
-- 퇴직한 여사원의 같은부서, 같은 직급에 해당하는 사원 조회하기



SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE ENT_YN='Y' AND SUBSTR(EMP_NO,8,1) = '2')
    AND JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE WHERE ENT_YN='Y' AND SUBSTR(EMP_NO,8,1) = '2')
    AND ENT_YN = 'N';
--WHERE (DEPT_CODE, JOB_CODE)
--    IN (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO,8,1)='2')
--    AND ENT_YN ='N';


-- 기술지원부이면서 급여가 200만원인 사원이 있다고 한다
-- 그 사원의 이름, 부서명, 급여 출력하기
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, SALARY
                            FROM EMPLOYEE 
                               JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                            WHERE DEPT_TITLE = '기술지원부' AND SALARY = 2000000);
    
    
    
-- 사원 중 총무부이고 300만원 이상 월급을 받는 사원

SELECT DEPT_CODE, SALARY
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '총무부' AND SALARY > 3000000;  -- 조인방식

SELECT *
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, SALARY
                                FROM EMPLOYEE
                                    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                                WHERE DEPT_TITLE='총무부' AND SALARY > 3000000); -- 서브쿼리방식
                                

-- 다중행, 다중행다중열 서브쿼리는 컬럼에는 사용하지 못함
-- WHERE, FROM 절에 사용(INLINE VIEW)
SELECT EMP_NAME, (SELECT DEPT_CODE
                        FROM EMPLOYEE
                                JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                                WHERE DEPT_TITLE ='총무부' AND SALARY > 3000000) AS TEST
                                FROM EMPLOYEE;


-- 상관 서브쿼리
-- 서브쿼리를 구성할 때 메인쿼리에 값을 가져와 사용하게 설정
-- 메인쿼리의 값이 서브쿼리의 결과에 영향을 주고, 서브쿼리의 결과가 메인쿼리의 결과에 영향을 주는 쿼리문


SELECT * FROM EMPLOYEE;
-- 본인이 속한 부서의 사원수를 조회를 하기
-- 사원명, 부서코드, 사원수
-- 유동적으로 값이 바껴야함
SELECT EMP_NAME, DEPT_CODE, (SELECT COUNT(*) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE) AS 사원수
FROM EMPLOYEE E;


-- WHERE에 상관서브쿼리 이용하기
-- EXISTS(서브쿼리) : 서브쿼리에 결과가 1행 이상이면 TRUE, 0행 FALSE
-- 각 게시글의 댓글수 구할 때 이용함
SELECT *
FROM EMPLOYEE E
--WHERE EXISTS(SELECT 1 FROM EMPLOYEE WHERE DEPT_CODE = 'D9');
WHERE EXISTS(SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID = E.EMP_ID);


-- 최소급여를 받는 사원 조회하기
SELECT * -- 서브쿼리방식
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

SELECT * -- 상관서브쿼리방식 
FROM EMPLOYEE E    -- 값을 하나씩 비교해서 가장 작은값이 결국 비교할값이 없어서 0이 나오면 NOT붙여서 TRUE가 됨
WHERE NOT EXISTS(SELECT SALARY FROM EMPLOYEE WHERE SALARY < E.SALARY); 


-- 모든 사원의 사원번호, 이름, 매니저아이디, 매니저 이름 조회하기
-- 서브쿼리로 풀어보자

SELECT EMP_ID, EMP_NAME, MANAGER_ID, (SELECT EMP_NAME FROM EMPLOYEE WHERE E.MANAGER_ID = EMP_ID) AS MANAGER_NAME
FROM EMPLOYEE E;


SELECT EMP_NAME, DEPT_CODE, (SELECT COUNT(*) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE) AS 사원수
FROM EMPLOYEE E;

-- 사원의 이름, 급여, 부서명, 소속부서급여평균 조회하기
SELECT EMP_NAME,SALARY, DEPT_TITLE,(SELECT AVG(SALARY) FROM EMPLOYEE WHERE E.DEPT_CODE = DEPT_CODE)
FROM EMPLOYEE E
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
    

-- 직급이 J1이 아닌 사원중에서 자신의 부서별 평균 급여보다 급여를 적게 받는 사원 조회하기
SELECT * 
FROM EMPLOYEE E
WHERE JOB_CODE != 'J1' 
AND SALARY <(SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE);


-- 자신이 속한 직급의 평균급여보다 많이 받는 직원의 이름, 직책명, 급여를 조회하기
-- USING은 별칭을 사용해야함
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE E.JOB_CODE = JOB_CODE);


-- FROM 절에 서브쿼리 이용하기
-- INLINE VIEW
-- FROM절에 사용하는 서브쿼리는 대부분 다중행다중열서브쿼리 사용
-- RESULT SET을 하나의 테이블처럼 사용하게 하는 것
-- RESULT은 출력된 결과이면, 테이블을 저장 장소이다
-- 가상컬럼을 포함하고 있거나, JOIN을 사용한 SELECT문을 사용
-- VIEW : INLINE VIEW, STORED VIEW
-- EMPLOYEE 테이블에 성별을 추가해서 출력하기
SELECT E.*, DECODE(SUBSTR(EMP_NO,8,1),1,'남',2,'여',3,'남',4,'여')AS GENDER
FROM EMPLOYEE E
WHERE DECODE(SUBSTR(EMP_NO,8,1),1,'남',2,'여',3,'남',4,'여') = '여';

-- 위의 결과를 INLINE VIEW 로 만들기
SELECT *
FROM (
    SELECT E.*, DECODE(SUBSTR(EMP_NO,8,1),1,'남',2,'여',3,'남',4,'여')AS GENDER
    FROM EMPLOYEE E
)WHERE GENDER = '여';
    

-- JOIN, 집합연산자 활용했을 때
SELECT * 
FROM (
    SELECT * FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN JOB USING(JOB_CODE)
)
WHERE DEPT_TITLE = '총무부';

SELECT T.*, T.SALARY*12 AS 연봉 
FROM (SELECT E.*, D.*, (SELECT TRUNC(AVG(SALARY),-1) FROM EMPLOYEE 
WHERE DEPT_CODE = E.DEPT_CODE) AS DEPT_SAL_AVG
    FROM EMPLOYEE E
    LEFT JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID) T
WHERE DEPT_SAL_AVG > 3000000;

-- 집합연산자 이용하기  -- 여기다시보기
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



-- ROW에 순위를 정하고 출력하기
-- TOP-N 출력하기
--급여를 많이 받는 사원 1~3위까지 출력하기
SELECT ROWNUM, E.* FROM EMPLOYEE E
WHERE ROWNUM BETWEEN 1 AND 3
ORDER BY SALARY DESC;



-- 1. 오라클이 제공하는 가상컬럼 ROWNUM을 이용하기
SELECT ROWNUM, E.* FROM EMPLOYEE E
WHERE ROWNUM BETWEEN 1 AND 3;

-- SELECT문을 실행할때마다 ROWNUM이 생성이됨
SELECT ROWNUM, T.*
FROM(
    SELECT ROWNUM AS INNERNUM, E.*
    FROM EMPLOYEE E
    ORDER BY SALARY DESC
)T
WHERE ROWNUM <= 5;


-- ROWNUM 의 범위는 반드시 1부터 시작해야 범위를 구할 수 있다
-- 페이지 처리할때 쓰이니중요!
SELECT *
FROM(
    SELECT ROWNUM AS RNUM, T.*
    FROM(SELECT *
        FROM EMPLOYEE 
        ORDER BY SALARY DESC) T)
WHERE RNUM BETWEEN 5 AND 10;


--2. RANK_OVER() 함수 이용하기
-- DENSE_RANK는 공동 등수가 있어도, 중복해서 랭크를 넣지않고, 그 다음값 출력해줌
SELECT *
   FROM(SELECT EMP_NAME, SALARY, 
        RANK() OVER(ORDER BY SALARY DESC) AS NUM,
        DENSE_RANK() OVER(ORDER BY SALARY DESC) AS NUM2
         FROM EMPLOYEE
        )
WHERE NUM BETWEEN 1 AND 23;




-- 평균급여를 많이 받는 부서 3개 출력
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




-- DDL (저장소 만드는것) = 테이블만드는것
-- 데이터 정의 언어로 객체를 만들고(CREATE), 수정하고(ALTER), 삭제(DROP)하는 구문
-- 테이블 = 클래스
-- 열 = 멤버변수(필드)
-- 행 = 객체   

-- DDL에 대해 알아보자
-- 데이터 정의언어로 오라클에서 사용하는 객체를 생성, 수정, 삭제하는 명령어
-- 생성 : CREATE 오브젝트명
-- 수정 : ALTER 오브젝트명
-- 삭제 : DROP 오브젝트명

-- 테이블을 생성하는 방법부터 알아보자
-- 테이블생성 : 데이터를 저장할 수 있는 공간을 생성하는 것
-- 테이블을 생성하기 위해서는 저장공간을 확보하는데 확보할 때 TYPE이 필요
-- 오라클이 제공하는 타입중 자주쓰는 타입에 대해 알아보자
-- 문자형 타입 : CHAR, VARCHAR2, NCHAR, NVARCHAR2, CLOB 
-- 숫자형 타입 : NUMBER
-- 날짜형 타입 : DATE, TIMESTAMP

-- 문자형 타입에 대해 알아보자
 -- CHAR(길이) : 고정형 문자형 저장타입으로 길이만큼 공간을 확보하고 저장한다 * 최대 2000바이트 저장 가능
 -- VARCHAR2(길이) : 가변현 문자열 저장타입으로 저장되는 데이터만큼 공간확보하고 저장한다.
 -- CLOB -> 최대 4GB까지 처리 가능
 
 CREATE TABLE TBL_STR(
    A CHAR(6), 
    B VARCHAR2(6),
    C NCHAR(6),
    D NVARCHAR2(6)
);

SELECT * FROM TBL_STR;

INSERT INTO TBL_STR VALUES('ABC','ABC','ABC','ABC');
INSERT INTO TBL_STR VALUES('가나','가나','가나','가나');
INSERT INTO TBL_STR VALUES('가나','가나','가나','가나다라마바사');
SELECT LENGTH(A), LENGTH(B), LENGTH(C), LENGTH(D)
FROM TBL_STR;


-- 숫자형 자료형
-- NUMBER : 실수, 정수 모두 저장이 가능함
-- 선언방법 
-- NUMBER : 기본값
-- NUMBER(PRECISION, SCALE) : 저장할 범위설정
-- PRECISION : 표편할 수 있는 전체 자리수 (1~38)
-- SCALE : 소수점 이하의 자리수 (-84, 127)

CREATE TABLE TBL_NUM(
    A NUMBER,  -- 대체적으로 이렇게넣음
    B NUMBER(5),  -- 전체자리수가 5자리이지만 소수점을 반올림함
    C NUMBER(5,1), -- 5자리이지만 소수점은 한자리만 표현1
    D NUMBER(5,-2)  -- 둘째자리수까지만 표현
);

SELECT * FROM TBL_NUM;

INSERT INTO TBL_NUM VALUES(1234.567, 1234.567, 1234.567, 1234.567);
-- INSERT INTO TBL_NUM VALUES(123456.123, 12345.123, 123456.123, 123456.123); -- 전체자리수가 5자리이므로 안됨
INSERT INTO TBL_NUM VALUES(123456.123,12345.123,1234.123,0);
INSERT INTO TBL_NUM VALUES(123456.123, 12345.123, 1234.123, 123.1234567);
INSERT INTO TBL_NUM VALUES('1234.567', '1234.567', '1234.567', '1234.567');

-- 날짜
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
