
-- 각 그룹별 집계와 총 집계를 한번에 출력해주는 함수
-- ROLLUP(), CUBE()
-- 둘의 차이는 합계가 먼저 나오는지, 마지막에 나오는지 차이임
-- GROUP BY ROLLUP(컬럼명)
-- GROUP BY CUBE(컬럼명)
-- 부서별 급여합계와 총합계를 조회하는 구문

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE;


SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY ROLLUP(DEPT_CODE);  -- 그룹별로 집계해주고 전체 합계까지 구해줌 (합계를마지막에)


SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE);  -- 합계를 처음에


SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE);

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE);


-- ROLLUP, CUBE 함수의 인수로 한개이상의 컬럼을 넣을 수 있다
-- ROLLUP : 두개 이상의 인수를 전달했을 때 두개 컬럼의 집계, 첫번째 인수컬럼의 소계, 전체 총계
-- CUBE : 두개 이상 인수를 전달했을 때 두개 컬럼의 집계, 첫번째 인수컬럼의 소계, 두번째 인수컬럼의 소계, 전체 총계
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL  
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE); 

SELECT * FROM EMPLOYEE;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)  -- 큐브는 모든 집계의 총 합계가 나옴
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE, JOB_CODE);



-- 부서별, 직책별, 총사원을 한번에 조회하기
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE, JOB_CODE);


-- GROUPING 함수를 이용하면 집계한 결과에 대한 분기처리를 할 수 있다.
-- ROLLUP, CUBE로 집계된 ROW에 대한 분기처리
-- GROUPING 함수를 실행하면, ROLLUP, CUBE로 집계된 ROW 1을 반환 아니면 0을 반환
-- 1일때 null임 , 0일때 null 아님
SELECT COUNT(*),
    CASE
        WHEN GROUPING(DEPT_CODE)=0 AND GROUPING(JOB_CODE)=1 THEN '부서별인원'
        WHEN GROUPING(DEPT_CODE)=1 AND GROUPING(JOB_CODE)=0 THEN '직책별인원'
        WHEN GROUPING(DEPT_CODE)=0 AND GROUPING(JOB_CODE)=0 THEN '부서_직책인원'
        WHEN GROUPING(DEPT_CODE)=1 AND GROUPING(JOB_CODE)=1 THEN '총인원'
    END AS 결과
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE, JOB_CODE);

-- 테이블에서 조회한 데이터 정렬하기
-- ORDER BY 구문을 사용함
-- SELECT 컬럼명....
-- FROM 테이블명
-- [WHERE 조건식]
-- [GROUP BY 컬럼명]
-- [HAVING 조건식]
-- [ORDER BY 컬럼명 정렬방식(DESC,ASC)]  - DESC (내림차순), ASC(오름차순) ,생략시 ASC로 기본값임

-- 이름을 기준으로 정렬하기
SELECT * FROM EMPLOYEE
ORDER BY EMP_NAME DESC; -- 내림차순


-- 월급이 높은 사람부터 낮은사람으로 정렬하기
-- 이름, 급여, 보너스
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
ORDER BY SALARY DESC; -- 내림차순


-- 부서 코드를 기준으로 오름차순 정렬하고 값이 같으면 월급이 내림차순으로 정렬하기
-- 순서대로 적으면 됨
SELECT * FROM EMPLOYEE   
ORDER BY DEPT_CODE ASC, SALARY DESC; 

-- 정렬했을 때 NULL값에 대한 처리
-- BONUS를 많이 받는 사원부터 출력하기
SELECT * FROM EMPLOYEE
-- ORDER BY BONUS DESC; -- NULL 인값을 먼저 출력한다
-- ORDER BY BONUS ASC; -- NULL 인값을 나중에 출력한다
-- 옵션을 설정해서 NULL 값 출력위치를 변경할 수 있다.
-- ORDER BY BONUS DESC NULLS LAST;  -- NULL값을 마지막에다 처리할 수 있다.
-- ORDER BY BONUS ASC NULLS FIRST;  -- NULL값을 처음으로 처리할 수 있다.
;

-- ORDER BY 절에서는 별칭을 사용할 수 있다
SELECT EMP_NAME, SALARY AS 월급, BONUS
FROM EMPLOYEE
ORDER BY 월급;

-- SELECT 문을 이용해서 데이터를 조회하면 RESULT SET이 출력되는데
-- RESULT SET에 출력되는 컬럼에는 자동으로 INDEX번호가 1부터 부여가 됨
SELECT *
FROM EMPLOYEE
ORDER BY 1;  -- 2는 테이블의 2번에있는 EMP_NAME으로 정렬해줌

-- 집합연산자
-- 여러개의 SELECT문을 한개의 결과(RESULT SET)으로 출력해주는 것
-- 첫번째 SELECT문의 컬럼수와 이후 SELECT 문의 컬럼수가 같아야한다.
-- 각 컬럼별 데이터 타입도 동일해야 한다.
-- 중복값은 하나만 출력됨

-- UNION : 두개 이상의 SELECT 문을 합치는 연산자
-- SELECT 문 UNION SELECT 문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- 컬럼수 4개
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION   -- 중복값은 하나만 출력해줌
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- 컬럼수 4개
FROM EMPLOYEE
WHERE SALARY >= 3000000;


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL  -- 중복값들 다 출력해줌
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE SALARY >= 3000000;



SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- 컬럼수 4개
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS   -- 차집합 공통된건 빼줌
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- 컬럼수 4개
FROM EMPLOYEE
WHERE SALARY >= 3000000;


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- 컬럼수 4개
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT   --  공통된 부분만 출력
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- 컬럼수 4개
FROM EMPLOYEE
WHERE SALARY >= 3000000;


-- 두 SELECT문의 컬럼의 수가 다르면 안된다.
-- 컬럼의 종류(타입)도 같아야함
SELECT EMP_ID, EMP_NAME, SALARY -- 컬럼수 3개
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- 컬럼수 4개
FROM EMPLOYEE
WHERE SALARY >= 3000000;


-- 다른 테이블에 있는 데이터 합치기
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
UNION
SELECT DEPT_ID, DEPT_TITLE, NULL  -- 없는값에는 NULL로 맞춰줌
FROM DEPARTMENT;


-- 3개 테이블 합친후에 하나 테이블 빼기
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
-- GROUP BY 절이 있는 구문을 하나로 작성하게 해주는 기능

-- 부서, 직책별, 매니저별 급여 평균
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE, MANAGER_ID;
-- 부서, 직책별 급여평균
SELECT DEPT_CODE, JOB_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;
-- 부서, 매니저별 급여평균
SELECT DEPT_CODE, MANAGER_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, MANAGER_ID;

-- 위 3가지를 하나로 묶어서 표현
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY GROUPING
        SETS((DEPT_CODE, JOB_CODE, MANAGER_ID),(DEPT_CODE, JOB_CODE), (DEPT_CODE,MANAGER_ID));
        
        


-- join에 대해 알아보자
-- 두개이상의 테이블을 특정컬럼을 기준으로 연결해주는 기능
-- JOIN 의 종류 2가지
-- 1. INNER JOIN : 기준되는 값이 일치하는 ROW만 가져오는 JOIN
-- 2. OUTER JOIN : 기준되는 값이 일치하지 않은 ROW도 가져오는 JOIN * 기준이 필요

-- JOIN을 작성하는 방법 : 2가지
-- 1. 오라클 조인방식 : ,와 WHERE로 작성
-- 2. ANSI 표준 조인방식 : JOIN, ON||USING 예약어를 사용해서 작성

-- EMPLOYEE 테이블과 DEPARTMENT 테이블 JOIN하기
-- 두 테이블 일치되는것을 먼저 찾기
-- EMPLOYEE 와 DEPARTMENT 공통적인 컬럼은 DEPT_ID임
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

-- 오라클 방식으로 JOIN 하기
SELECT * 
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID; -- DEPT_CODE와 DEPT_ID과 일치하는 것끼리 JOIN


-- ANSI 표준으로 JOIN하기
-- JOIN 예약어 뒤에는 JOIN할 컬럼을 적고, 조건을 적어줌
SELECT *
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; 


-- 사원에 대해 사원명, 이메일, 전화번호, 부서명을 조회하기
SELECT EMP_NAME, EMAIL, PHONE, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; 

-- JOIN 문에서도 WHERE절 사용하기
-- 부서가 총무부인 사원의 (사원명, 월급, 보너스, 부서명) 조회하기
SELECT EMP_NAME, SALARY, BONUS, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID  -- 여기까지 실행하면 이미 합쳐졌기 때문에 WHERE 절에서 TITLE 사용가능
WHERE DEPT_TITLE = '총무부';
        
        
-- JOIN문에서 GROUP BY절 사용하기
-- 부서별 평균급여를 출력하기 (부서명, 평균급여)
SELECT DEPT_TITLE, AVG(SALARY)
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_TITLE
HAVING AVG(SALARY) >= 3000000;



-- JOIN할 때 기준이되는 컬럼명이 [중복]된다면 반드시 별칭을 작성해야 한다
-- 사원명, 급여, 보너스, 직책명을 조회하기
SELECT *
FROM EMPLOYEE E
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE; -- USING이 없으면 출력될때 기준되는 컬럼 두개 다 출력
                                        -- USING으로 하면 기준되는 컬럼 하나만 출력


-- 동일한 기준의 컬럼명으로 조인할 때는 USING 이용할 수 있다.
SELECT EMP_NAME, SALARY, BONUS, JOB_NAME
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);
    
    
-- 직책이 과장인 사원의 이름, 직책명, 직책코드, 월급을 조회
SELECT EMP_NAME, JOB_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE) -- EMPLOYEE와 JOB 테이블의 기준되는 컬럼이 JOB_CODE로 같음
WHERE JOB_NAME = '과장';


-- INNER 조인일때는 비교되는 컬럼이 null이면 비교대상 x
SELECT COUNT(*)
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; 

    
-- OUTER JOIN 사용하기
-- 컬럼에 대해 동일비교를 했을 때 없는 ROW를 출력해주는 JOIN
-- 기준이 되는 테이블(모든 데이터를) 설정해줘야한다.
-- LEFT OUTER JOIN : JOIN을 기준으로 왼쪽에 있는 테이블을 기준으로 설정
-- RIGHT OUTER JOIN : JOIN을 기준으로 오른쪽에 있는 테이블을 기준으로 설정
-- 일치되는 ROW가 없는 경우 모든 컬럼을 null로 표시함
SELECT *
FROM EMPLOYEE LEFT OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

SELECT *
FROM EMPLOYEE RIGHT OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;


-- CROSS JOIN -- 모든 ROW를 연결해주는 JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE CROSS JOIN DEPARTMENT
ORDER BY 1;

-- SELF JOIN : 한개의 테이블에 다른 컬럼의 값을 가지고 있는 컬럼이 있는 경우
-- 그 두개 컬럼을 이용해서 JOIN
SELECT * FROM EMPLOYEE;
-- 매니저가 있는 사원의 이름, 매니저 아이디, 매니저 비밀번호, 매니저 이름 조회
SELECT E.EMP_NAME, E.MANAGER_ID, M.EMP_ID, M.EMP_NAME
FROM EMPLOYEE E
    JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;
    
    SELECT * FROM EMPLOYEE;
-- 사원이름, 매니저 아이디, 매니저 사원번호, 매니저 이름 조회
-- 매니저가 없으면 없음 출력하기


SELECT E.EMP_NAME, NVL(E.MANAGER_ID,'없음'), NVL(M.EMP_ID,'없음'), NVL(M.EMP_NAME,'없음')
FROM EMPLOYEE E
    RIGHT OUTER JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;  


--  동등조인 동등비교를 해서 처리함. ON 컬럼명 = 컬럼명
--  비동등 조인에 대해 알아보자
--  연결할 테이블이 범위값을 가져야한다
SELECT * FROM SAL_GRADE;
SELECT *
FROM EMPLOYEE
   JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- 회원등급 포인트제로, 상품등급(상태), 댓글 수에 따른 회원 등급

-- 다중조인을 할 수 있다.
-- 3개 이상의 테이블을 연결해서 사용하기
-- 사원명, 직책명, 부서명 조회하기
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING(JOB_CODE);
    

-- 사원의 사원명, 부서명, 직책명, 근무지역 조회하기

SELECT EMP_NAME, JOB_NAME,  DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE  -- EMPLOYEE를 기준으로 밑에 JOIN할 테이블들과 각각 기준잡을 컬럼을 선택해야한다
    LEFT JOIN JOB USING(JOB_CODE)
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    LEFT JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;


