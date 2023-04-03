SELECT * FROM DBA_USERS;
SELECT * FROM TAB;

-- DATABASE사용하기
-- 1. 사용할 계정을 관리자(SYSTEM) 계정으로 생성해줌
--     - 관리자로 접속해서 생성명령어를 이용함.
-- 2. 생성한 계정이 DATABASE를 이용하기 위해서는 권한부여 해줘야 한다.
--    - 관리자로 접속해서 권한 부여명령어를 이용
--    - 부여권한 : 접속할수있는 권한(CONNECT), 사용할 수 있는 권한(RESOURCE)

-- 계정생성하는 명령어
-- CREATE USER 사용자계정명 IDENTIFIED BY 비밀번호 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
CREATE USER BS IDENTIFIED BY BS DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
-- 18C버전부터 사용자계정명에 ##을 붙여서 생성해야 한다.
-- ##안붙일 수 있게 설정하기
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- DB에 등록되어 있는 사용자 조회하기
SELECT * FROM DBA_USERS;

-- 사용자를 생성하더라고 권한이 없으면 DB를 이용할 수 없다.
-- 사용자에게 권한부여하기
-- GRANT 권한 or 롤(역할) TO 사용자계정명
GRANT CONNECT TO BS;
-- 테이블을 이용할 수 있는 권한을 부여하기
GRANT RESOURCE TO BS;

GRANT CONNECT, RESOURCE TO BS;

-- BS계정에서 SQL문 실행해보기
SELECT * FROM TAB; --계정에서 이용하고 있는 테이블을 조회하는 명령어
CREATE TABLE TEST(
    TEST VARCHAR2(200)
);
-- USER01/USER01라는 계정을 생성하고 접속하고 아래 명령어 실행하기
--CREATE TABLE USER01(
-- AGE NUMBER
--); 

CREATE USER USER01 IDENTIFIED BY USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
GRANT RESOURCE, CONNECT TO USER01;

CREATE TABLE USER01 (
    AGE NUMBER
);

SELECT * FROM TAB;
SELECT * FROM BS.TEST;
SELECT * FROM USER01.USER01;

-- 기본실습 DB에 대해 알아보자.
-- 사원, 부서, 직책, 근무지, 급여수준, 근무지별 국가
-- 사원테이블의 정보확인하기
SELECT * FROM EMPLOYEE;
-- 부서테이블의 정보확인하기
SELECT * FROM DEPARTMENT;
-- 직책에 대한 정보확인하기
SELECT * FROM JOB;
-- 부서별 근무지
SELECT * FROM LOCATION;
-- 근무지역 국가별정보
SELECT * FROM NATIONAL;
-- 급여수준
SELECT * FROM SAL_GRADE;

-- SELECT문을 활용하기
-- 기본문법
-- SELECT 컬럼명,컬럼명.... OR *
-- FROM 테이블명;

-- SELECT문을 이용해서 EMPLOYEE테이블 조회하기
SELECT EMP_NAME, EMP_NO, EMAIL, PHONE
FROM EMPLOYEE;
-- SELECT문을 이용해서 EMPLOYEE테이블의 전체 컬럼 조회하기
SELECT *
FROM EMPLOYEE;

-- 전체 사원의 이름, 월급, 보너스 입사일을 조회하기
SELECT EMP_NAME, SALARY, BONUS, HIRE_DATE
FROM EMPLOYEE;

-- 모든 내용을 확인할때는 SELECT문을 이용함.
-- SELECT문을 이용해서 산술연산처리하기
-- +,-,*,/(사칙연산) -> 피연산자 리터럴, 컬럼값
SELECT 10+20, 10-20, 20/3, 5*4
FROM DUAL;

-- 리터럴, 컬럼 연산
-- 전체사원의 급여에 100 더하기
SELECT EMP_NAME, SALARY+100, SALARY
FROM EMPLOYEE;

-- 컬럼, 컬럼 연산
SELECT EMP_NAME, SALARY+BONUS
FROM EMPLOYEE;
-- NULL값과 연산은 불가능하다 -> 결과가 무조건 NULL로 출력됨.
SELECT SALARY, BONUS
FROM EMPLOYEE;

-- 산술연산은 숫자형만 가능하다.
-- 오라클에서 문자열 리터럴은 ''을 사용한다.
SELECT '이제 점심먹자'+100
FROM DUAL;

SELECT EMP_NAME, SALARY, BONUS, 10+30
FROM EMPLOYEE;

-- 사원테이블에서  사원명, 부서코드, 월급, 연봉 조회하기
SELECT EMP_NAME, DEPT_CODE, SALARY, SALARY*12
FROM EMPLOYEE;
-- 사원테이블에서  사원명, 부서코드, 월급, 보너스가 포함된 연봉 조회하기
SELECT EMP_NAME,DEPT_CODE, SALARY, (SALARY+(SALARY*BONUS))*12
FROM EMPLOYEE;

-- 테이블에 존재하는 컬럼만 조회가 가능하다
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE;
--SELECT * FROM DEPARTMENT;

SELECT * FROM EMPLOYEE;
-- 조회된 컬럼에 별칭을 부여할 수 있다. -> 가상컬럼에 많이 사용
-- AS 예약어를 사용한다.
-- 예) SELECT EMP_NAME AS 사원명 FROM EMPLOYEE
SELECT EMP_NAME AS 사원명, SALARY AS 월급, EMAIL AS 이메일
FROM EMPLOYEE;
-- AS 를 생략하고 띄어쓰기로 부여할 수 있다.
SELECT EMP_NAME 사원명, SALARY 월급, EMAIL 이메일
FROM EMPLOYEE;

-- 별칭에 띄어쓰기, 특수기호가 가능하니?
SELECT EMP_NAME AS "사 원 명", SALARY AS "$월$급"
FROM EMPLOYEE;


-- 조회되는 데이터의 중복을 제거해주는 명령어 : DISTINCT
-- 컬럼명 앞에 사용, SELECT문의 맨 앞에 작성
-- SELECT DISTINCT 컬럼명[,컬럼명...] FROM 테이블명
SELECT DEPT_CODE FROM EMPLOYEE;
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;
-- SELECT EMP_NAME, DISTINCT DEPT_CODE FROM EMEPLOYEE;
SELECT DISTINCT DEPT_CODE, EMP_NAME FROM EMPLOYEE;
SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE;
SELECT DISTINCT DEPT_CODE, JOB_CODE, SALARY FROM EMPLOYEE;

-- 오라클에서 문자열을 연결해주는 연산자 -> ||
SELECT '점심'+'맛있다' 
FROM DUAL;

SELECT '점심'||'맛없다 FEAT 반장'
FROM DUAL;
-- || 연산은 컬럼을 합쳐서 출력할때도 사용한다.
SELECT EMP_NAME||EMP_NO||EMAIL AS INFO
FROM EMPLOYEE;
SELECT EMP_NAME||SALARY||BONUS
FROM EMPLOYEE;

SELECT EMP_NAME||'님의 월급은 '||SALARY||' 보너스'||BONUS
FROM EMPLOYEE;

-- 원하는 ROW(DATA)만 출력하기
-- 지정한 조건에 맞는 데이터만 가져오기
-- WHERE 조건식 이용한다.
-- 사용방식
-- SELECT 컬럼, 컬럼...... OR *
-- FROM 테이블명
-- WHERE 조건식

SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE='D9';
-- 사원 중 월급이 200만원이상인 사원을 조회하기
SELECT * 
FROM EMPLOYEE
WHERE SALARY>=2000000;

-- 사원 중 직책이 J2가 아닌 사원 조회하기
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE != 'J2';

-- 여러개의 비교연산 처리하기
-- 사원 중 부서가 D5이고 월급이 300만원 이상인 사원의 이름, 부서코드, 월급 조회하기
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND SALARY>=3000000;

-- 사원 중 부서가 D5이거나 월급이 300만원 이상인 사원의 이름, 부서코드, 월급 조회하기
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' OR SALARY>=3000000;

SELECT * 
FROM EMPLOYEE
WHERE 1=2;

-- 날짜를 대소비교하기
-- 날짜를 대소비교할때는 문자로 비교, 문자열 패턴을 맞춰줌.
-- 기본적이 날짜를 표시하는 문자열 패턴 : YY/MM/DD -> 'YY/MM/DD'
SELECT HIRE_DATE 
FROM EMPLOYEE;
-- 입사일이 2000년 01월 01일 이전이 사원의 이름, 입사일을 조회하기
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE<'00/01/01';

-- 입사일이 95년 01월 01일이전인 사원의 전체내용 조회하기
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE < '95/01/01';

-- 특정 범위에 있는 값을 조회하기
-- 사원 중 월급 200만원이상 300만원 이하 월급을 받는 사원의 사원명, 월급, 보너스, 입사일을 조회하기
SELECT EMP_NAME, SALARY, BONUS, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY>=2000000 AND SALARY <=3000000;
-- 사원중 입사일이 00년01월01부터 02년12월31일 까지인 사원 전체 조회하기
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE>='00/01/01' AND HIRE_DATE<='02/12/31';

-- 범위의 값을 조회할때 BETWEEN AND 연산을 이용하기
-- 컬럼명 BETWEEN 값 AND 값 ;
SELECT EMP_NAME, SALARY, BONUS, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000;
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '00/01/01' AND '02/12/31' AND DEPT_CODE ='D9';

-- LIKE연산자 이용하기
-- 검색을 문자열 패턴으로 검색하는 기능 -> 부분일치, 포함여부, 원하는 문자열패턴검색
-- 문자열 패턴을 나타내는 기호
-- % : 문자가 0개이상 아무문자나 허용할때 사용
-- 예)  %강% : 강 o, 한강, 두강, 두만강, 한강다리, 강강술래 -> 강이 포함되어있는 문자열
--      %강 : 강으로 끝나는 말
--      강% : 강으로 시작하는 말
-- _ : 문자가 1개 아무문자나 허용할때 사용
-- 예) _강_ : 중간에 강이 있는 세글자
--    _강 : 강으로 끝나는 두글자
--    강_ : 강으로 시작하는 두글자
--    _강% : 두글자 이상의 두번째자리에 강을 포함하는 문자
-- 컬럼명 LIKE '패턴';

-- 사원 중 유씨성을 가진 사원의 이름, 월급, 부서코드를 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '유__';

-- 이메일 주소에 yo를 포함하고 있는 사원의 사원명, 이메일 조회하기
SELECT EMP_NAME, EMAIL 
FROM EMPLOYEE
WHERE EMAIL LIKE '%yo%';

-- 이메일주소에 j를 포함하고 유씨성을 가진 사원 조회하기
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '%j%' AND EMP_NAME LIKE '유__'; 

-- LIKE에 일치하지 않는 사원 찾기
-- NOT부정연산사용
-- 김씨가 아닌 사원들 찾기
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '김%';

-- 이메일주소에 _앞글자가 3글자인 사원의 사원명 이메일 조회하기
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___*_%' ESCAPE '*';

-- NULL값을 조회하기
-- NULL -> 쓰레기, 아무의미없는 값 -> 연산이 불가능
-- 오라클리 제공하는 NULL비교연산자를 사용
-- IS NULL, IS NOT NULL
-- 보너스를 받지 않는 사원조회하기
SELECT EMP_NAME,BONUS
FROM EMPLOYEE
--WHERE BONUS='(null)';
WHERE BONUS IS NULL;

-- 보너스를 받고있는 사원의 이름, 보IS너스를 조회하기
SELECT EMP_NAME,BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;


-- 조회된 컬럼값이 NULL일때 대체하기
-- NVL(컬럼명,대체값)함수를 이용
SELECT EMP_NAME, SALARY, NVL(BONUS,0)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE,'인턴') AS DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;
--CREATE TABLE NAMETEST(
--    NAME2 VARCHAR2(200),
--    AGE NUMBER
--);
--
--INSERT INTO NAMETEST VALUES('유병승', 19);
--
--SELECT * FROM NAMETEST
--WHERE NAME2 NOT LIKE '%유%' OR NAME2 IS NULL;
--
--DROP TABLE NAMETEST;

-- 다중값 동등비교하기
-- IN / NOT IN : 여러개의 값을 OR로 연결해서 동등비교할때 사용하는 연산자
-- 사원 중 부서코드가 D5,D6,D7,D8인  사원구하기
SELECT * 
FROM EMPLOYEE
--WHERE DEPT_CODE='D5' OR DEPT_CODE='D6' OR DEPT_CODE='D7' OR DEPT_CODE='D8';
WHERE DEPT_CODE NOT IN ('D5','D6','D7','D8');

-- 서브쿼리문
--SELECT EMP_NAME, DEPT_CODE
--FROM EMPLOYEE
--WHERE DEPT_CODE IN(SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE='총무부' OR DEPT_TITLE LIKE '%해외%');

-- 연산자 우선순위
-- 직책이 J7이거나  J2인 사원 중 급여가 200만원이상인 사원을 조회하기
-- 이름, 월급, 직책코드
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE (JOB_CODE='J7' OR JOB_CODE='J2') AND SALARY>=2000000;

--SCOTT/TIGER 계정을 생성 후 SCOTT_EN 테이블 추가

-- 1. 오라클을 설치한다. 
-- 2. SQLDEVELOPER압축 푼다 -> EXE파일 실행
-- 3. SYSTEM계정 접속생성하기 ->> DBA
-- 4. BS/BS 계정 생성, 권한 부여
-- 5. BS접속 생성하기 
-- 6. BS계정에서 BS.sql 스크립트실행하기
-- 7. BS계정에서 작업하기
-- 8. system계정으로 접속
-- 9. scott/tiger계정 생성 및 권한부여
-- 10. scott접속 생성
-- 11. scott 계정에서 scott_en.sql파일 실행

CREATE USER SCOTT IDENTIFIED BY TIGER DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
 GRANT CONNECT, RESOURCE TO SCOTT;


-- 오늘날짜를 출력할 수 있음 
--SYSDATE
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE-10 FROM DUAL;
SELECT SYSDATE-HIRE_DATE
FROM EMPLOYEE;

-- BASICSELECT
--JOB테이블에서 JOB_NAME의 정보만 출력되도록 하시오
SELECT JOB_NAME
FROM JOB;
--DEPARTMENT테이블의 내용 전체를 출력하는 SELECT문을 작성하시오
SELECT *
FROM DEPARTMENT;
--EMPLOYEE 테이블에서 이름(EMP_NAME),이메일(EMAIL),전화번호(PHONE),고용일(HIRE_DATE)만 출력하시오
SELECT EMP_NAME,EMAIL,PHONE,HIRE_DATE
FROM EMPLOYEE;
--EMPLOYEE 테이블에서 고용일(HIRE_DATE) 이름(EMP_NAME),월급(SALARY)를 출력하시오
SELECT HIRE_DATE, EMP_NAME,SALARY
FROM EMPLOYEE;
--EMPLOYEE 테이블에서 월급(SALARY)이 2,500,000원이상인 사람의 EMP_NAME 과 SAL_LEVEL을 출력하시오 
SELECT EMP_NAME,SAL_LEVEL
FROM EMPLOYEE
WHERE SALARY>=2500000;
--EMPLOYEE 테이블에서 월급(SALARY)이 350만원 이상이면서 
--JOB_CODE가 'J3' 인 사람의 이름(EMP_NAME)과 전화번호(PHONE)를 출력하시오
SELECT EMP_NAME,PHONE
FROM EMPLOYEE
WHERE SALARY>=3500000 AND JOB_CODE='J3';
--EMPLOYEE 테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총 수령액-(월급*세금 3%))가 출력되도록 하시오
SELECT EMP_NAME AS 이름,SALARY*12 AS 연봉,(SALARY+(SALARY*NVL(BONUS,0)))*12 AS 총수령액,(SALARY+(SALARY*NVL(BONUS,0)))*12-((SALARY*0.03)*12) AS 실수령액
FROM EMPLOYEE;
--EMPLOYEE 테이블에서 이름, 근무 일수(입사한지 몇일인가)를 출력해보시오. (날짜도 산술연산가능함.)
SELECT EMP_NAME AS 이름,SYSDATE - HIRE_DATE AS 근무일수
FROM EMPLOYEE;
--EMPLOYEE 테이블에서 20년 이상 근속자의 이름,월급,보너스율를 출력하시오
SELECT EMP_NAME AS 이름, SALARY AS 월급, NVL(BONUS,0) AS 보너스
FROM EMPLOYEE
WHERE SYSDATE - HIRE_DATE>=365*20;
--EMPLOYEE 테이블에서 고용일이 90/01/01 ~ 01/01/01 인 사원의 전체 내용을 출력하시오
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';
--이름에 '이'가 들어가는 사원을 모두 출력하세요.
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%이%';
--EMPLOYEE 테이블에서 이름 끝이 연으로 끝나는 사원의 이름을 출력하시오
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';
--EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 출력하시오
SELECT EMP_NAME,PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';
--EMPLOYEE 테이블에서 메일주소 '_'의 앞이 4자이면서, DEPT_CODE가 D9 또는 D6이고 
--고용일이 90/01/01 ~ 00/12/01이면서, 월급이 270만원이상인 사원의 전체 정보를 출력하시오
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____*_%' ESCAPE '*' AND DEPT_CODE = 'D9' OR DEPT_CODE = 'D6' AND HIRE_DATE BETWEEN '09/01/01' AND '00/12/01' AND SALARY>=2700000;
--부서 배치를 받지 않았지만 보너스를 지급하는 직원 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;
--관리자도 없고 부서 배치도 받지 않은 직원 이름 조회..
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;