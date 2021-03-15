--EMPNO: 직원번호, ENAME:직원이름 , JOB:담당업무
--MGR: 상위 담당자, HIREDATE; 입사일자, SAL:급여 , COMM: 상여금 .DEPTNO: 부서번호 

SELECT *
FROM emp;


SELECT *
FROM emp
WHERE  deptno <> deptno;
--WHERE 1<>1; 항상 거짓

--입사일자가 1982년 1월 1일 이후인 모든 직원 조회 하는 SELECT 쿼리를 작성하세요.
SELECT *
FROM emp
WHERE TO_DATE('1982/01/01', 'YYYY/MM/DD') <= hiredate; --이후이면 포함해야해.
--WHERE TO_DATE('19820101', 'YYYYMMDD') <= hiredate;--이렇게도 가능해.

WHERE 절에서 사용 가능한 연산자
-비교(=,!=,>,<,....)

- '+'는 이항연산자


비교대상 BETWEEN 비교대상의 허용 시작값 AND 빅대상의 허용 종료값 - 삼항연산자
ex: 부서번호가 10번에서 20번 사이의 속한 직원들만 조회

SELECT *
FROM emp
WHERE deptno BETWEEN 10 AND 20;

--emp테이블에서 급여(sal)가 1000보다 크거나 같고 2000보다 작거나 같은 직원들만 조회

SELECT *
FROM emp
--WHERE sal BETWEEN 1000 AND 2000;
WHERE  sal >=1000 AND sal<=2000;


SELECT *
FROM emp
WHERE  sal >=1000 AND sal<=2000 AND deptno=10;

[실습1]
emp 테이블에서 입사 일자가 1982년 1월 1일 이후부터 1983년 1월 1일 이전인 사원의  ename, hiredate  를 조회하는 쿼리를 작성하시오

SELECT ename, hiredate
FROM emp
WHERE  hiredate BETWEEN TO_DATE('1982/01/01', 'YYYY/MM/DD') AND TO_DATE('1983/01/01', 'YYYY/MM/DD');

SELECT ename, hiredate
FROM emp
WHERE  hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD') AND hiredate<=TO_DATE('1983/01/01', 'YYYY/MM/DD');

BETWEEN AND : 포함 (이상, 이하)
              초과 , 미만의 개념을 적용하려면 비교연산자 사용방법 밖에 없음
            
IN  연산자 =(or 와 같은 개념)-이항연산자
대상자 IN (대상자와 비교 할 값, 대상자와 비교할 값, 대상자와 비교할 값, ........)
deptno IN (10,20)==> deptno 값이 10이나 20번이면 TRUE

SELECT *
FROM emp
WHERE deptno =10 OR deptno=20;
--WHERE deptp IN (10,20)==> deptno 값이 10이나 20번이면 TRUE

SELECT *
FROM emp
WHERE 10 IN (10,20); --언제나 참



[실습2] users테이블에서 ,userid가 brown, cony, sally인 데이터를 다음과 같이 조회하시오

SELECT *
FROM users;


 
 SELECT userid 아이디, usernm 이름, alias 별명
 FROM users
 --WHERE userid IN ('brown', 'cony', 'sally');
 WHERE userid ='brown' or userid ='cony' or userid ='sally';
 
 
LIKE 연산자: 문자열 매칭 조회
게시글: 제목 검색, 내용 검색
       제목에 [맥북에어]가 들어가는 게시글만 조회


1. 얼마 안된 맥북에어 팔아요
2. 맥북에어 팔아요
3. 팝니다 맥북에어

테이블명: 게시글
제목컬럼: 제목




SELECT *
FROM 게시글
WHERE 제목 LIKE('%멕북에어%') OR 내용 LIKE('%멕북에어%');

 % : 0개 이상의 문자  (EX, 'C%': 첫 글자는 C인데 뒤에는 몇 개의 문자가 더 붙어도 상관 없음)
 _ : 1개의 문자      (EX, 'C%': 첫 글자는 C인데 뒤에는 몇 개의 문자가 더 붙어도 상관 없음)
 
SELECT *
FROM users
WHERE userid LIKE 'c%';



userid가 c로 시작하면서 c 이후에 3개의 글자가 오는 사용자

SELECT *
FROM users
WHERE userid LIKE 'c__';


userid에 l이 들어가는 모든 사용자 조회

SELECT *
FROM users
WHERE userid LIKE '%l%';

[실습3]member 테이블에서 회원의 성이 [신]씨인 사람의 mem_id, mem_name 을 조회하는 쿼리를 작성하시오

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

SELECT mem_id, mem_name
FROM member;


[실습4]member 테이블에서 이름에[이]가 들어가는 사람의 mem_id, mem_name 을 조회하는 쿼리를 작성하시오

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';


IS (NULL 비교)
emp 테이블에서 comm 칼럼의 값이 null인사람만 조회

SELECT *
FROM  emp
--WHERE sal=NULL; --사용 불가
WHERE comm IS NULL;

emp 테이블에서 comm 칼럼의 값이 null이 아닌 사람만 조회

SELECT *
FROM  emp
--WHERE sal=NULL; --사용 불가
WHERE comm IS NOT NULL;

emp 테이블에서 매니저가 없는 직원만 조회

SELECT *
FROM  emp
--WHERE sal=NULL; --사용 불가
WHERE mgr IS  NULL;


BETWEEN AND , IN, LIKE, IS

AND, OR , NOT(논리연산자)
AND : 두가지 조건을 동시에 만족시키는지 확인할 때
조건 AND 조건2;
OR: 두가지 조건중 하나라도 만족 시키는지 확인할 때
조건 OR 조건2;
NOT: 부정형 논리연산자, 특정 조건을 부정
mrg IS NULL: mrg  컬럼의 값이 NULL 인 사람만 조회
mrg IS NOT NULL: mrg  컬럼의 값이 NULL이 아닌 사람만 조회

emp테이블에서 mrg의 사번이 7698이면서 
sal 값이 1000보다 큰 직원만 조회;

SELECT *
FROM  emp
WHERE mgr=7698 AND sal>1000;
--조건의 순서는 결과와 무관하다.


﻿
AND 조건이 많아지면: 조회되는 데이터 건수는 줄어든다.

OR 조건이 많아지면: 조회되는 데이터 건수는 많아진다.

﻿NOT: 부정형 연산자, 다른 연산자와 결합하여 쓰인다.
   IS NOT, NOT IN, NOT LIKE

부서번호가 30번이 아닌 직원들   

SELECT *
FROM emp
WHERE deptno <>30;



SELECT *
FROM emp
WHERE deptno NOT IN (30);

SELECT *
FROM emp
WHERE ename NOT LIKE 'S%';

NOT IN 연산자 사용시 주의점 : 비교값중에 NULL이 포함되면 데이터가 조회되지 않는다.



SELECT *
FROM emp
WHERE mgr IN (7698,7839,NULL);

==> mgr =7698 or mgr=7839 or mgr=NULL

SELECT *
FROM emp
WHERE comm IN (1400,NULL);




SELECT *
FROM emp
WHERE mgr NOT IN (7698,7839,NULL);

==> mgr !=7698 AND mgr !=7839 AND mgr!=NULL  --> 결과가 나오지 않음
[실습 7]
emp 테이블에서 job이 SALESMAN이고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요

SELECT *
FROM emp
WHERE job='SALESMAN' AND hiredate>=TO_DATE('1981/06/01', 'YYYY/MM/DD');

[실습8]
emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요.
(IN, NOT IN 사용 금지)

SELECT *
FROM emp
WHERE deptno <> 10 AND hiredate>=TO_DATE('1981/06/01', 'YYYY/MM/DD');

[실습10]
emp테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요
(부서는 10, 20, 30 만 있다고 가정하고 IN 연산자 사용)

SELECT *
FROM emp
WHERE deptno IN (20, 30) AND hiredate>=TO_DATE('1981/06/01', 'YYYY/MM/DD');

[실습11]
emp 테이블에서 job이 SALESMAN이거나 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요
SELECT *
FROM emp
WHERE job='SALESMAN' OR hiredate>=TO_DATE('1981/06/01', 'YYYY/MM/DD');

[실습12] 플면 좋고, 못풀어도 괜찮은 문제

emp테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는 직원의 정보를 조회하세요
SELECT *
FROM emp
WHERE job='SALESMAN' OR empno LIKE '78%';

[실습13] 
emp테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는 직원의 정보를 조회하세요
(LIKE연산자 사용하지 마세요)
SELECT *
FROM emp
WHERE job='SALESMAN' OR empno BETWEEN 7800 AND 7899;


