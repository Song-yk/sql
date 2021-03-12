--DML(SELECT, UPDATE, INSERT, DELETE)->CRUD
--SELECT 테이블의 컬럼명을 콤마로 구분하여 나열| *
--FROM 가져올 데이터가 담긴 테이블 이름;

--부서번호가 10인 직원들만 조회
--부서번호 : deptno
SELECT *
FROM emp
WHERE deptno = 10;
--users텡블에서 ,userid 컬럼의 값이 brown인 사람만 조회
SELECT *
FROM users
WHERE userid='brown';--데이터는 대소문자를 구별한다(BROWN은 사용 불가)


--emp 테이블에서 부서번호가 20번 보다 큰 부서에 속한 직원 조회

SELECT *
FROM emp
WHERE deptno >20;

--emp 테이블에서 부서번호가 20번 부서에 속하지 않는 모든 직원 조회

SELECT *
FROM emp
WHERE deptno <>20;

WHERE : 기술한 조건을 참(true)으로 만족하는 행들만 조회한다(FILTER)


SELECT *
FROM emp
WHERE 1=1;

SELECT empno, ename
FROM emp;

--prod 테이블의 모든 컬럼을 조회하는 select 쿼리 작성

SELECT *
FROM prod;

--prod_id, prod_name 두개의 컬럼만 조회하는 select 쿼리 작성

SELECT prod_id, prod_name
FROM prod;


--실습(select1)

SELECT *
FROM lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

-- 숫자, 날짜 타입에 대해 가능한 연산 : +,-,*,/,()-우선순위 변경
-- NUMBER(7,2) : 전체 자리는 7자 , 소수 2자리까지 
-- DATE : 날짜
-- VARCHAR2(10 BYTE) : 문자열을 10BYTE까지만 저장
컬럼정보를 보는 방법
1. SELECT * ==> 컬럼의 이름을 알 수 있음
2. sqldeveloper의 테이블 객체를 클릭하여 정보확인
3. DESC 테이블명;//DESCRIBE 설명하다의 약자

empno : number;
SELECT empno empnumber, empno +10 emp_plus ,10,
       hiredate, hiredate+10,hiredate-10  --날짜에는 + 와 - 연산자만 가능 
FROM emp;

empno +10 / 10 ==> expression(컬럼명이 아닌 것 다)

select 조회를 아무리 해도 원본데이터 값은 영향 없음

alias : 컬럼의 이름을 변경
        컬럼 | expression [AS] [별칭명]

SELECT empno empno, empno+10 AS empno_plus
FROM emp;


SELECT empno "empno", empno+10 AS empno_plus
FROM emp;

NULL : 아직 모르는 값
       0과 공백은 NULL과 다르다
       ****NULL을 포함한 연산은 결과가 항상 NULL****
       ===> NULL값을 다른 값으로 치환해 주는 함수       
SELECT ename, sal, comm, sal+comm, comm+100
FROM emp;



--실습(SELECT2)


SELECT prod_id AS id, prod_name AS name
FROM prod;

SELECT lprod_gu gu, lprod_nm nm
FROM lprod;

SELECT buyer_id 바이어아이디, buyer_name 이름
FROM buyer;

literal : 값 자체
literal 표기법 : 값을 표현하는 방법

java 정수 값을 어떻게 표현할까(10)?
int a=10;
float f=10f;
long l =10L;
String s= "Hello world";


SELECT empno,10,'Hello World' --문자열은 ''로 표현
FROM emp;

문자열 연산 
java: String msg= "Hello"+", World";


SELECT empno+10, ename ||',World'

FROM emp;

Function :  단일 행으로 작업하고, 해당 하나의 값을 반환하는 것


--SELECT empno+10, ename ||',World' || ',world'
SELECT  CONCAT(ename,'Hello')--두개의 문자를 결합하는 함수
FROM emp;


아이디: brown
아이디: apeech
-
-
SELECT '아이디 :' || userid, CONCAT('아이디 : ',userid)
FROM users;

SELECT 'SELECT * FROM ' || table_name ||';' QUERY
FROM user_tables; --오라클에서 관리하는 전체 테이블

SELECT CONCAT('SELECT * FROM ', table_name) || ';'QUERY
FROM user_tables; --오라클에서 관리하는 전체 테이블

SELECT CONCAT(CONCAT('SELECT * FROM ', table_name), ';') QUERY
FROM user_tables; --오라클에서 관리하는 전체 테이블

SELECT CONCAT('SELECT * FROM ' ||table_name, ';') QUERY
FROM user_tables; --오라클에서 관리하는 전체 테이블

--입사일자가 81년 3월 1일 이후인 사람만 출력

SELECT  empno, ename, hiredate
FROM emp
WHERE hiredate>'81/03/01';--나라마다 표기법이 다르기 때문에 살짝 위험

문자열을 날짜 타입으로 변환하는 방법
TO_DATE(날짜 문자열, 날짜 문자열의 포맷팅)
TO_DATE('1981/03/01', 'YYYY/MM/DD')

SELECT  empno, ename, hiredate
FROM emp
WHERE hiredate>TO_DATE('1981/03/01', 'YYYY/MM/DD');
