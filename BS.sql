-- 2주차 시작
-- 오라클에서 제공하는 함수에 대해 알아보자
-- 단일행 함수 : 테이블의 모든 행에 결과가 반환되는 함수
--              문자, 숫자, 날짜, 형변환, 선택함수(조건활용)
-- 그룹함수 : 테이블에 한개의 결과가 반환되는 함수
--          합계, 평균, 갯수, 최대값, 최소값 

-- 단일행 함수 활용하기
-- 사용하는 위치
-- SELECT문의 컬럼을 작성하는 부분, WHERE절
-- INSERT, UPDATE, DELETE문에서 사용이 가능


-- 문자열 함수에 대해 알아보자
-- 문자열을 처리하는 기능
-- LENGTH : 지정된 컬럼이나, 리터럴값에 대한 길이를 출력해주는 함수
-- LENGTH('문자열' 또는 컬럼명) -> 문자열의 개수를 출력
SELECT LENGTH('오늘 월요일 힘내요!')
FROM DUAL;

SELECT EMAIL,LENGTH(EMAIL)
FROM EMPLOYEE;

-- 이메일이 16글자 이상인 사원을 조회하기
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE
WHERE LENGTH(EMAIL) >= 16;

-- LENGTHB : 차지하는 (B)YTE를 출력 
-- EXPRESS버전에서 한글을 3BYTE로 저장함. ENTERPRISE버전에서는 2BYTE
 SELECT LENGTHB('ABCD'), LENGTHB('월요일') FROM EMPLOYEE;


-- INSTR : JAVA의 INDEXOF와 유사한 기능함
-- INSTR('문자열' 또는 컬럼, '찾을 문자'[,시작위치, 찾을번째(횟수)])
-- 오라클에서는 인덱스가 1부터 시작함, 문자가 존재하지 않으면 0으로 리턴함
SELECT INSTR('GD아카데미','GD'), INSTR('GD아카데미','아'), INSTR('GD아카데미','병')
FROM DUAL;

SELECT EMAIL, INSTR(EMAIL,'j') -- 각 이메일에서 j가 존재하는 위치 인덱스 값 리턴
FROM EMPLOYEE;

-- EMAIL 주소에 j가 포함되어있는 사원 찾기
-- LIKE로 찾아도되지만 INSTR로도 가능함
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE INSTR(EMAIL,'j')>0;  


SELECT INSTR('GD아카데미 GD게임즈 GD음악사 GD화이팅','GD',3), -- 3은 시작위치임(
       INSTR('GD아카데미 GD게임즈 GD음악사 GD화이팅','GD',-1), --  -1은 역순방향으로 찾음 (답: 20)    
       INSTR('GD아카데미 GD게임즈 GD음악사 GD화이팅','GD',1,3) -- 1번째에서 시작하는데,3번에 GD있는 값 찾기 (답: 14)
FROM DUAL; 


    -- 사원테이블에서 @의 위치를 찾기
SELECT EMP_NAME,EMAIL,INSTR(EMAIL,'@') FROM EMPLOYEE;


-- LPAD / RPAD : 문자열의 길이가 지정한 길이만큼 차지않았을 때 빈 공백을 채워주는 함수
-- LPAD / RPAD(문자열 또는 컬럼, 최대길이, 대체문자)
SELECT LPAD('유병승',10,'*'), -- 유병승(3글자지만 2BYTE씩 계산하므로) 총 6바이트 즉 -> *이 앞에 4개가 붙음
       RPAD('유병승',10,'@'), -- 오른쪽으로 나머지 칸수 @로 대체
       LPAD('유병승',10) -- 왼쪽 나머지 공백을 대체
FROM DUAL;


SELECT EMAIL, RPAD(EMAIL,20,'#')  -- 이메일 오른쪽부분 나머지부분을 #으로 대체
FROM EMPLOYEE;

-- LTRIM/ RTRIM : 공백을 제거하는 함수, 특정문자를 지정해서 삭제
-- LTRIM/RTRIM('문자열'또는 컬럼[,'특정문자']) 
SELECT '     병승',LTRIM('     병승'),   -- 문자열 기준으로 왼쪽 공백값들 다 제거
                  RTRIM('   병승   '),  -- 문자열 기준으로 오른쪽 공백값들 다 제거
                  RTRIM('   병  승 ')
FROM DUAL;

-- 특정문자를 지정해서 삭제할 수 있다
SELECT '병승2222', RTRIM('병승2222','2'),  -- 오른쪽에 2로 시작하는 부분 다 제거
                 RTRIM('병승22122','2'),  -- 2아닌 다른 숫자로 막히는 부분까지만 제거 -> 병승221 출력됨
                 RTRIM('병승22122','12')  -- '12' -> (1또는 2) 다 삭제 (OR같은거임)              
FROM DUAL;


-- TRIM : 양쪽에 있는 값을 제거하는 함수, 기본 : 공백, 설정하면 설정값을 제거(삭제할 기준은 한글자만 가능)
-- TRIM('문자열'||컬럼)
-- TRIM(LEADING||TRALLING||BOTH '제거할문자' FROM 문자열||컬럼명)

SELECT '     월요일    ', TRIM('     월요일    '),  -- 양쪽에 있는 공백값을 제거해줌
                    'ZZZZZZ마징가ZZZZZZ', TRIM('Z' FROM 'ZZZZZZ마징가ZZZZZZ'), -- 양쪽에 있는 Z 지워줌
                    TRIM(LEADING 'Z' FROM 'ZZZZZ마징가ZZZZZZ'),  -- 문자열 왼쪽 부분 Z다 삭제
                    TRIM(TRAILING 'Z' FROM 'ZZZZZ마징가ZZZZZZ'),  -- 문자열 오른쪽 부분 Z다 삭제
                    TRIM(BOTH 'Z' FROM 'ZZZZZ마징가ZZZZZZ')  -- 문자열 양쪽 부분 Z다 삭제
FROM EMPLOYEE;  


-- SUBSTR : 문자열을 잘라내는 기능 =  JAVA SUBSTRING메소드와 동일
-- SUBSTR('문자열' 또는 컬럼명, 시작인덱스번호[,길이])  -- 인덱스번호는 1번부터 시작
SELECT SUBSTR('SHOWMETHEMONEY',5), -- 5번째부터 끝까지 잘라내서 보여줌 (METHEMONEY)출력
      SUBSTR('SHOWMETHEMONEY',5,2), -- 5번째부터 잘라서 보여주는데 2글자만 보여줌 (ME) 출력
      SUBSTR('SHOWMETHEMONEY',INSTR('SHOWMETHEMONEY','MONEY')),
      SUBSTR('SHOWMETHEMONEY',-5,2) -- (-)는 역순의 의미로 역순부터 5번째인 M부터 2개 글자 출력 (MO)출력
FROM DUAL;


-- 사원의 이메일에서 아이디 값만 출력하기
-- 아이디가 7글자인 사원만 조회
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1)
FROM EMPLOYEE
WHERE LENGTH(SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1)) >=7;


-- 사원의 성별을 표시하는 번호를출력하기
-- 여자사원만 조회
-- 2 또는 4 -> 여성
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN(2,4); 


-- 영문자를 처리하는 함수 : UPPER, LOWER, INITCAP
SELECT UPPER('welcome TO OrACLE worLd'),  -- 모두 대문자로
       LOWER('welcome TO OrACLE worLd'),  -- 모두 소문자로
       INITCAP('welcome TO OrACLE worLd') -- 첫글자만 대문자
FROM DUAL;


-- CONCAT : 문자열 결합해주는 함수
-- || 연산자와 동일함
SELECT EMP_NAME||EMAIL, CONCAT(EMP_NAME, EMAIL), -- EMP_NAME, EMAIL 합침
                        CONCAT(CONCAT(EMP_NAME, EMAIL),SALARY) -- EMP_NAME, EMAIL, SALARY 다 합침
FROM EMPLOYEE;



-- REPLACE : 대상문자(컬럼)에서 지정문자를 찾아서 특정문자로 변경하는 것
-- REPLACE('문자열'||컬럼명,'찾을문자','대체문자')
SELECT EMAIL, REPLACE(EMAIL,'BS','GD')  -- 이메일의 BS문자를 GD로 바꿔줌
FROM EMPLOYEE;

-- UPDATE EMPLOYEE SET EMAIL=REPLACE(EMAIL,'BS','GD'); -- EMAIL에 있는 BS를 GS로 바꿈
-- ROLLBACK  -- 되돌리는것















-- REVERSE : 문자열을 거꾸로 만들어주는 기능
SELECT EMAIL, REVERSE(EMAIL), EMP_NAME, REVERSE(EMP_NAME)  -- 한글같은경우에는 뒤집으면 깨짐
FROM EMPLOYEE;


-- TRANSLATE : 매칭되는 문자로 변경해주는 함수
SELECT TRANSLATE('010-3644-6259','0123456789','영일이삼사오육칠팔구') -- 두번째와 세번째 인자가 매칭기준이며 첫번째 인자는 변경대상이다
FROM DUAL;


-- 숫자 처리함수
-- ABS : 절대값을 처리하는 함수
SELECT ABS(-10), ABS(10)
FROM DUAL;

-- MOD : 나머지를 구하는 함수 (자바의 %연산자와 동일)
SELECT MOD(3,2)   
FROM DUAL;  -- 1출력
SELECT E.*, MOD(SALARY,3)  -- *과 컬럼을 같이 출력하고 싶을때에는 앞에 E.으로 붙임  
FROM EMPLOYEE E; -- 0,1,2 중 출력

-- 소수점을 처리하는 함수
-- ROUND : 소수점을 반올림하는 함수
-- ROUND(숫자 || 컬럼명[,자리수])
SELECT 126.567,ROUND(126.567), -- 127이 출력됨 (소수점반올림해서 제거)
               ROUND(126.467), -- 126이 출력됨
               ROUND(126.567,2) -- 소수점 둘째자리에서 반올림됨 -> 126.57 출력됨
FROM DUAL;

-- 보너스를 포함한 월급구하기
SELECT EMP_NAME, SALARY, ROUND(SALARY+SALARY*NVL(BONUS,0)-(SALARY*0.03))
FROM EMPLOYEE;

-- FLOOR : 소수점자리 버림
SELECT 126.567, FLOOR(126.567)  -- 소수점을 쓰고싶지 않을 때 사용
FROM DUAL;  -- 126으로 출력

-- TRUNC : 소수점자리 버림 (자리수를 지정)
SELECT 126.567, TRUNC(126.567,2), -- 소수점 두자리까지만 표현하고 나머지는 버림   (126.56)
                TRUNC(126.567,-2), -- 소수점자리에서 역순으로 두자리까지 표현하고 나머지버림 (100)
                TRUNC(2123456.32,-2) -- (2123400)
FROM DUAL;


-- CEIL : 소수점 올림
SELECT 126.567, CEIL(126.567), CEIL(126.111)  -- 127로 출력
FROM EMPLOYEE;


-- 날짜처리함수 이용하기
-- 오라클에서 날짜를 출력할 때는 2가지 방식이 있음
-- 1. SYSDATE 예약어 -> 날짜 년/월/일 오늘 날짜(오라클이 설치되어 있는 컴퓨터의 날짜)를 출력해줌.
-- 2. SYSTIMESTAMP예약어 -> 날짜 + 시간까지 출력해줌
SELECT SYSDATE, SYSTIMESTAMP
FROM DUAL;

-- 컴퓨터에서는 날짜를 표현할 때 long으로 표현함
-- 날짜도 산술연산처리가 가능함 (+,-) 연산가능 -> 일수가 차감, 추가됨
SELECT SYSDATE-2,  -- 4/3 기준으로 4/1출력
       SYSDATE+30   -- 4/3 기준으로 5/3출력
FROM DUAL;

-- NEXT_DAY : 매개변수로 전달받은 요일 중 가장 가까운 다음 날짜 출력
SELECT SYSDATE, NEXT_DAY(SYSDATE,'월')  -- 월요일이 가장가까운 다음 날짜 -> 4월 10일
FROM DUAL;

-- LOCALE의 값을 가지고 언어선택
SELECT * FROM V$NLS_PARAMETERS;
ALTER SESSION SET NLS_LANGUAGE = 'AMERICAN';  -- SESSION 을 미국으로 바꿔서
SELECT SYSDATE, NEXT_DAY(SYSDATE,'MON'),NEXT_DAY(SYSDATE,'TUESDAY') -- 외국언어에 맞춰서 출력함
FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN'; -- 다시 한국으로 바꿔줌

-- LAST_DAY : 그달의 마지막날을 출력
SELECT SYSDATE, LAST_DAY(SYSDATE),  -- 4월은 30일 까지 있음
                LAST_DAY(SYSDATE+30) -- 5월은 31일 까지 있음
FROM DUAL;


-- ADD_MONTHS : 개월수를 더하는 함수
SELECT SYSDATE, ADD_MONTHS(SYSDATE,4) -- 4월3일 기준으로 8월 3일이 나옴
FROM DUAL;


-- MONTHS_BETWEEN : 두개의 날짜를 받아서 두 날짜의 개월수를 계산해주는 함수
SELECT FLOOR(ABS(MONTHS_BETWEEN(SYSDATE,'23/08/17'))) -- 소수점까지 버려주기
FROM DUAL;

-- 날짜의 년도, 월, 일자를 따로 출력할 수 있는 함수
-- EXTRACT(YEAR || MONTH || DAY FROM 날짜) : 숫자로 출력해줌
-- 현재날짜의 년, 월, 일 출력하기
SELECT EXTRACT(YEAR FROM SYSDATE) AS 년, EXTRACT(MONTH FROM SYSDATE) AS 월,
       EXTRACT(DAY FROM SYSDATE) AS 일
       FROM DUAL;


-- 사원 중 12월에 입사한 사원들을 구하시오
SELECT EMP_NAME, HIRE_DATE 
FROM EMPLOYEE
WHERE EXTRACT(MONTH FROM HIRE_DATE) = 12;

SELECT EXTRACT(DAY FROM HIRE_DATE) +100  -- 날짜처리함수에서는 사칙연산 가능함
FROM EMPLOYEE;

-- 오늘 군대복부기간은 1년 6개월 계산해서
-- 전역일자를 구하고, 전역때까지 먹는 짬밥수(하루세끼)를 구하기
SELECT ADD_MONTHS(SYSDATE,18) AS 전역일자, (ADD_MONTHS(SYSDATE,18)-SYSDATE)*3 AS 짬밥수 
FROM DUAL;


-- 형변환 함수
-- 오라클에서는 자동형변환이 잘 작동을 함
-- 오라클에서도 데이터를 저장하는 타입이 있음
-- 문자 : CHAR, VARCHAR2, NCHAR, NVARCHAR2  -> JAVA String과 동일
-- 숫자 : NUMBER 
-- 날짜 : DATE, TIMESTAMP

-- TO_CHAR : 숫자, 날짜를 문자형으로 변경해주는 함수
-- 날짜를 문자형으로 변경하기
-- 날짜값을 기호로 표시해서 문자형으로 변경을 한다.
-- Y > 년, M : 월, D : 일, H : 시, MI : 분, SS : 초

SELECT SYSDATE, TO_CHAR(SYSDATE,'YYYY-MM-DD'), -- 오늘날짜를 'YYYY-MM-DD' 형식으로 출력
                TO_CHAR(SYSDATE,'YYYY-MM-DD HH:MI:SS') -- 오늘날짜를 'YYYY-MM-DD HH:MI:SS' 형식으로 출력
FROM DUAL;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE,'YYYY.MM.DD') -- 사원들의 고용날짜를 'YYYY.MM.DD' 형식으로 출력
FROM EMPLOYEE;


-- 숫자를 문자형으로 변경하기
-- 패턴에 맞춰서 변환 -> 자리수를 어떻게 표현할지 선택
-- 0 : 변환대상값의 자리수가 지정한 자리수와 일치하지 않을때, 값이 없는 자리에 0을 표시하는 패턴
-- 9 : 변환대상값의 자리수가 지정한 자리수와 일치하지 않을때, 값이 없는 자리에 생략하는 패턴 (앞에 생기는 공백은 FM으로 제거해야함)
-- 통화를 표시하고 싶을때는 L을 표시
SELECT 1234567, TO_CHAR(1234567,'000,000,000'), -- 001,234,567 이 출력됨
                TO_CHAR(1234567,'999,999,999'), -- 1,234,567 출력됨 (앞 두자리 생략됨)
                TO_CHAR(500,'L999,999,999') -- 앞에 L 쓰면은 달러 표시됨
FROM DUAL;

SELECT 180.5, TO_CHAR(180.5,'000,000.00'), -- 000,180.50으로 출력됨
          TO_CHAR(180.5,'FM999,999.00') AS 키 -- 180.50이 출력됨 (FM써야 공백제거됨)
FROM DUAL;


-- 월급을 통화표시하고 ,로 구분해서 출력하고 입사일은 0000.00.00으로 출력하기
SELECT EMP_NAME, TO_CHAR(SALARY,'FML999,999,999') AS 급여,
                 TO_CHAR(HIRE_DATE,'YYYY.MM.DD') AS 입사일
FROM EMPLOYEE;


-- 숫자형으로 변경하기
-- TO_NUMBER함수를 이용
-- 문자를 숫자형으로 변경하기
SELECT 1000000+1000000, TO_NUMBER('1,000,000','999,999,999')+1000000,  -- 문자열 1,000,000이 패턴에맞쳐서 숫자로 변환됨
    TO_CHAR(TO_NUMBER('1,000,000','999,999,999')+1000000,'FML999,999,999') -- 숫자로 변환된 값을 다시 패턴에맞춰서 표기
FROM DUAL;

-- 날짜형으로 변경하기
-- 숫자를 날짜로 변경
-- 문자열을 날짜로 변경
SELECT TO_DATE('23/12/25','YY/MM/DD')-SYSDATE, -- 문자열을 날짜로 변경함
        TO_DATE('241225','YYMMDD'), -- 문자열을 날짜로 변경함
        TO_DATE('25-12-25','YY-MM-DD') -- 문자열을 날짜로 변경함
FROM DUAL;


SELECT TO_DATE(20230405,'YYYYMMDD'), 
        TO_DATE(230505,'YYMMDD'),
        TO_DATE(TO_CHAR(000224,'000000'),'YYMMDD') -- 숫자앞에 000은 없어지는값이라서 문자열로 바꾼후에 그 값을 날짜로 바꿈
FROM DUAL;

-- NULL값을 처리해주는 함수
-- NVL 함수 : NVL(컬럼,대체값)
-- NVL2 함수 : NVL2(컬럼,NULL이 아닐때, NULL일때)
SELECT EMP_NAME, DEPT_CODE, NVL(DEPT_CODE,'인턴'), 
                NVL2(DEPT_CODE,'있음','없음') 
FROM EMPLOYEE;



-- 조건에 따라 출력할 값을 변경해주는 함수
-- 1. DECODE
-- DECODE(컬럼명||문자열,'예상값','대체값','예상값2',.....) -- 예상값이 나오면 대체값으로 출력해라
-- 주민번호에서 8번째자리의 수가 1이면 남자, 2이면 여자 출력하는 컬럼추가하기
SELECT EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO,8,1),'1','남자','2','여자') AS GENDER
FROM EMPLOYEE;


-- 각 직책코드의 명칭을 출력하기
-- J1 대표, J2 부사장, J3 부장, J4 과장
-- 쌍으로 값을 이루면 IF 조건문이며, 마지막 하나의 값 사원은 ELSE문이라고 생각하면된다.
SELECT EMP_NAME, JOB_CODE, DECODE(JOB_CODE,'J4','과장','J3','부장','J2','부사장','J1','대표','사원') 
FROM EMPLOYEE;

-- 2. CASE WHEN THEN ELSE
-- CASE
--      WHEN 조건식 THEN 실행내용
--      WHEN 조건식 THEN 실행내용
--      WHEN 조건식 THEN 실행내용
--      ELSE 실행
-- END

SELECT EMP_NAME, JOB_CODE,
        CASE
            WHEN JOB_CODE = 'J1' THEN '대표'
            WHEN JOB_CODE = 'J2' THEN '부사장'
            WHEN JOB_CODE = 'J3' THEN '부장'
            WHEN JOB_CODE = 'J4' THEN '과장'
            ELSE '사원'                     
        END AS 직책,
        CASE JOB_CODE
            WHEN 'J1' THEN '대표'
            WHEN 'J2' THEN '부사장'
        END
FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;

--월급을 기준으로 고액월급자와 중간월급자 그외를 나눠서 출력하기
-- 월급이 400만원 이상 : 고액월급자,   월급 : 400만원 미만이면 300만이상이면 중간월급자
-- 나머지는 그외를 출력하는 가상컬럼 만들기
-- 이름 월급 결과

SELECT EMP_NAME, SALARY, 
        CASE
            WHEN SALARY >= 4000000 THEN '고액월급자'
            WHEN SALARY >= 3000000 THEN '중간월급자'
            ELSE '그외'
        END AS 결과
FROM EMPLOYEE;


-- 사원테이블에서 현재나이 구하기     -- YY로 가져왔을땐 앞자리 두자리가 20으로 붙여짐  -- RR로가져왔을땐 앞자리 두자리가 19로 붙여짐 
SELECT EMP_NAME, EMP_NO,EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'YY'))||'살' AS YY년,
EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR'))||'살' AS RR년,
    EXTRACT(YEAR FROM SYSDATE)-(
    TO_NUMBER(SUBSTR(EMP_NO,1,2))+
    CASE
        WHEN SUBSTR(EMP_NO,8,1) IN (1,2) THEN 1900
        WHEN SUBSTR(EMP_NO,8,1) IN (3,4) THEN 2000
    END
    ) AS 살 
FROM EMPLOYEE;

-- RR로 년도를 출력할 때
-- 현재년도   입력년도   계산년도
-- 00~49    00~49       현세기     입력년도가 62년도 일경우 전세기로감 ex) 2023 - 1962  
-- 00~49    50~99       전세기
-- 50~99    00~49       다음세기        
-- 50~99    50~99       현세기

insert into EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,BONUS,MANAGER_ID,HIRE_DATE, ENT_DATE,ENT_YN) 
values ('251','월드컵','320808-4123341','go_dm@kh.or.kr',null,'D2','J2','S5',4480000,null,null,to_date('94/01/20','RR/MM/DD'),null,'N');
SELECT * FROM EMPLOYEE;

UPDATE EMPLOYEE SET EMP_NO='320808-1123341' WHERE EMP_ID ='252';
COMMIT;


-- 그룹함수 활용하기
-- 테이블의 데이터에 대한 집계하는 함수들의 합계, 평균, 갯수, 최대값, 최소값을 구하는 함수
-- 그룹함수의 결과는 기본적으로 한개의 값만 가져옴
-- 종류
-- SUM : 특정 컬럼에 대한 총합 -> SUM(컬럼(NUMBER))
-- AVG : 테이블의 특정컬럼에 대한 평균 -> AVG(컬럼(NUMBEER)))
-- COUNT : 테이블의 데이터수(ROW수) -> COUNT(* 혹은 컬럼)
-- MIN : 테이블의 특정 컬럼에 대한 최소값 -> MIN(컬럼명)
-- MAX : 테이블의 특정 컬럼에 대한 최대값 -> MAX(컬럼명)

-- 사원의 월급의 총 합계를 구해보자
SELECT TO_CHAR(SUM(SALARY),'FML999,999,999') AS 총합계 FROM EMPLOYEE;

-- D5 부서의 월급의 총 합계를 구해보자
SELECT TO_CHAR(SUM(SALARY),'FML999,999,999') AS "D5의 총 월급 " FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';


-- J3사원의 급여 합계를 구하시오
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE JOB_CODE = 'J3';


-- 평균구하기 AVG함수
-- 전체사원에 대한 평균구하기
SELECT AVG(SALARY) FROM EMPLOYEE;

-- D5의 급여 평균을 구하기
SELECT AVG(SALARY) FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';


-- D5부서의 급여합계와 평균구하기--
-- 그룹함수 사용할때는 SELECT 뒤에 일반 속성을 사용할 수 없음
SELECT SUM(SALARY), AVG(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';


-- NULL값에 대해서는 어떻게 처리가될까 -> 널값은 데이터 제외해버림
SELECT SUM(BONUS),AVG(BONUS),AVG(NVL(BONUS,0)) --> 보너스 NULL값인 사람들은 0값으로 바꿈
FROM EMPLOYEE;


-- 테이블의 데이터수 확인하기
-- 널인값들은 제외함
-- *는 전체 포함(NULL값도 포함)
SELECT COUNT(*),COUNT(DEPT_CODE), COUNT(BONUS)
FROM EMPLOYEE;

-- D6부서의 인원 조회
SELECT COUNT(*) FROM EMPLOYEE
WHERE DEPT_CODE = 'D6';


-- 400만원 이상 월급을 받는 사람 수
SELECT COUNT(*) AS "400만원 이상 월급받는 사람 수" FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- D5부서에서 보너스를 받고 있는 사원의 수는?
SELECT COUNT(*) FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND BONUS IS NOT NULL;

SELECT COUNT(BONUS) FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';  -- 위와 같은결과임


-- 부서가 D6, D5, D7인 사람의 수, 급여 합계, 평균을 조회하세요
SELECT COUNT(*) AS 사원수,SUM(SALARY) AS 급여합계,AVG(SALARY) AS 급여평균 FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D6','D7');

SELECT MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE;


-- GROUP BY 절 활용하기
-- 그룹함수를 사용했을 때 특정 기준으로 컬럼값을 묶어서 처리하는 것 -> 묶인 그룹별 그룹함수의 결과가 출력됨
-- SELECT 컬럼
-- FROM 테이블명
-- [WHERE 조건식]
-- [GROUP BY 컬럼명 [,컬럼명,컬럼명,....]]
-- [ORDER BY 컬럼명]

-- 부서별 급여 합계를 구하시오
SELECT DEPT_CODE,SUM(SALARY) -- 부서가 중복되는것끼리 합계구하기 
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 직책별 급여의 합계, 평균을 구하시오
SELECT JOB_CODE,SUM(SALARY),AVG(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 부서별 사원수 구하기
SELECT DEPT_CODE,COUNT(*) FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- GROUP BY 절에는 다수의 컬럼을 넣을 수 있다
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;  -- DEPT_CODE와 JOB_CODE 둘 다 공통되는 것 으로 묶음

-- GROUP BY를 사용한 절에서 WHERE도 사용이 가능하다
SELECT DEPT_CODE, SUM(SALARY) 
FROM EMPLOYEE
WHERE BONUS IS NOT NULL -- 조건으로 먼저 제외한 후 그룹으로 묶음
GROUP BY DEPT_CODE;


-- 부서별 인원이 3명 이상인 부서만 출력
SELECT DEPT_CODE,COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) >= 3;


-- 직책별 인원수가 3명이상인 직책 출력
SELECT JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING COUNT(*) >= 3;

-- 평균급여가 300만원 이상인 부서 출력하기
SELECT DEPT_CODE,AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

-- 매니저가 관리하는 사원이 2명이상인 매니저 아이디 출력하기
SELECT MANAGER_ID, COUNT(*)
FROM EMPLOYEE 
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING COUNT(*) >=2;

-- 남자, 여자의 급여 평균을 구하고 인원수를 구하기
SELECT SUBSTR(EMP_NO,8,1), AVG(SALARY), COUNT(*) FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1); 

SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','남','3','남','2','여','4','여') AS 성별, AVG(SALARY), COUNT(*)
FROM EMPLOYEE 
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','남','3','남','2','여','4','여');





SELECT * FROM EMPLOYEE;