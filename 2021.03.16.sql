AND 가 OR 보다 우선순위가 높다.
==>헷갈리면 ()를 사용하여 우선순위를 조정하자.

직원의 이름이 ALLEN이면서 JOB이 SALESMAN거나 이름이 SMITH인 직원을 조회

SELECT *
FROM emp
WHERE ename='SMITH' OR ename='ALLEN' AND job='SALESMAN';


직원의 이름이 allen이거나 snith이면서 
job이 salesmana인 직원을 조회

SELECT *
FROM emp
WHERE (ename='SMITH' OR ename='ALLEN') AND job='SALESMAN';

[WHERE 실습 14]
EMP테이블에서
1.JOB이 SALESMAN이거나 
2. 사원번호가 78로 시작하면서 입사일자가 1981년 6월 1일 이후인 
직원의 정보를 조회하세요
SELECT *
FROM emp
WHERE job='SALESMAN' OR empno LIKE '78%' AND hiredate>=TO_DATE('1981/06/01', 'YYYY/MM/DD');

데이터 정렬
-TABLE 객체에는 데이터 저장/조회시 순서를 보장하지 않음
-보편적으로 데이터가 입력된 순서대로 조회됨
-데이터가 항상 동일한 순서로 조회되는 것을 보장하지 않는다
-데이터가 삭제되고, 다른 데이터가 들어 올 수도 있음

OREDR BY 
-ASC: 오름차순 (기본)
-DESC : 내림차순


데이터 정렬이 필요한 이유?
1.TABLE 객체는 순서를 보장하지 않습니다.
==>오늘 실행한 쿼리를 내일 실행할 경우 동일한 순서로 조회가 되지 않을 수도 있음
2.실생활에서는 정렬된 데이터가 필요한 경우가 있다
==>게시판의 게시글은 보편적으로 가장 최신글이 처음에 나오고, 가장 오래된 글이 밑에 있다

SQL 에서 정렬: ORDER BY (컬럼명|인덱스|별칭)  ==> SELECT =>FROM=>[WHERE]=>ORDER BY

SELECT *
FROM emp
ORDER BY ename DESC; --내림차순

SELECT *
FROM emp
ORDER BY job, sal; 

SELECT *
FROM emp
ORDER BY job DESC, sal ASC;



정렬이 컬럼명이 아니라 SELECT 절의 컬럼 순서(index)
SELECT *
FROM emp
;

SELECT *
FROM emp
ORDER BY 2;--두번째 컬럼을 기준으로 정렬

SELECT ename, job 직업
FROM emp
ORDER BY 직업;--alias 명칭으로 정렬 가능


[orderby 1]
1.dept테이블의 모든 정보를 부서이름으로 오름차순 정렬로 조회되도록 쿼리를 작성하세요

2.dept테이블의 모든 정보를 부서위치로 내림차순 정렬로 조회되도록 쿼리를 작성하세요

SELECT *
FROM dept
ORDER BY deptno DESC;

SELECT *
FROM dept
ORDER BY loc DESC;

[orderby 2]
1.emp테이블에서 comm정보가 있는 사람들만 조회하고, 많이 받는 사람이 먼저 조회되도록 정렬하고, 상여가 같을 경우 사번으로 내림차순 정렬하세요
SELECT *
FROM  emp
WHERE comm IS NOT NULL AND comm <>0
ORDER BY comm DESC, empno desc ;

[orderby 3]
emp테이블에서 관리자가 있는 사람들만 조회하고, 직군 순으로 오름차순 정렬하고, 직군이 같은 경우에 사번이 큰 사원이 먼저 조회되도록 작성

SELECT *
FROM  emp
WHERE mgr IS NOT NULL 
ORDER BY job ,empno desc ;

[orderby 4]
emp테이블에서 10번부서 혹은 30번 부서에 속하는 사람들 중 급여가 1500이 넘는 사람들만 조회하고 이름으로 내림차순 정렬되도록 쿼리를 작성해.
SELECT *
FROM  emp
WHERE deptno IN (10, 30)
      AND sal >1500 
ORDER BY ename desc ;

페이징 처리(게시글): 전체 데이터를 조회하는게 아니라 페이지 사이즈가 정해졌을 때 원하는 페이지의 데이터만 가져오는 방법
(1. 400건을 다 조회하고 필요한 20건만 사용하는 방법=> 전체조회 :400건
 2. 400건의 데이터중 원하는 페이지의 20건만 조회=>페이징 처리)
==>정렬의 기준이 뭔데????일반적으로 게시글의 작성일시 역순
페이징 처리시 고려할 변수: 페이지 번호, 페이지 사이즈
ROWNUM: 행번호를 부여하는 특수 키워드(오라클에서만 제공)
*제약사항
ROWNUM은 WHERE절에서도 사용 가능하다
단, ROWNUM 사용을 1부터 사용하는 경우에만 사용 가능
WHERE ROWNUM BETWEEN 1 AND 5;====>O
WHERE ROWNUM BETWEEN 10 AND 15;====>X
WHERE ROWNUM <[=]10;===>O
WHERE ROWNUM >10;===>X
전체 데이터: 14건
페이지사이즈: 5건
1번째 페이지: 1~5
2번째 페이지: 6~ 10
2번째 페이지: 11~ 15(14)



인라인 뷰
ALIAS
SELECT *
FROM (SELECT ROWNUM RN, empno, ename
FROM(SELECT  empno, ename
FROM emp
ORDER BY ename))
--정렬 먼저하고 ROWNUM적용
WHERE RN BETWEEN (:page-1)* :pagesize+1 AND :page * :pagesize;--변수 표시 : 
--6페이지부터 10페이지를 검색하고 싶어서 사용




SQL실행 순서
FROM=>WHERE=>SELECT=> ORDER BY
SELECT  ROWNUM, empno, ename
FROM emp
ORDER BY ename;



pageSize :5건
1 page : rn RN BETWEEN 1 AND 5;
2 page : rn RN BETWEEN 6 AND 10;
3 page : rn RN BETWEEN 11 AND 15;
n page : rn RN BETWEEN (:page-1)* :pagesize+1 AND :page * :pagesize;--변수 표시 : 


(ROW 실습 1)emp 테이블에서 ROWNUM 값이 1~10 인 값만 조회하는 쿼리를 작성
SELECT  ROWNUM, empno, ename
FROM emp
WHERE ROWNUM <=10;

(ROW 실습 2) ROWNUM값이 10~20 인 값만 조회하는 쿼리를 작성

SELECT *
FROM (SELECT ROWNUM RN, empno, ename
FROM(SELECT  empno, ename
FROM emp))
WHERE RN BETWEEN 10 AND 20;


(ROW 실습 3) emp테이블의 사원 정보를 이름컬럼으로 오름차순 적용 했을 떄의 11~14번째 행을 조회

SELECT *
FROM (SELECT ROWNUM RN, empno, ename
FROM(SELECT  empno, ename
FROM emp
ORDER BY ename))
WHERE RN BETWEEN 11 AND 20;


SELECT ROWNUM , emp.*-- '*' 사용할 땐 한정자를 꼭 해줘야 해 
FROM emp;

SELECT ROWNUM rs, e.*-- 여기 값도 변경해줘야 해
FROM emp e;--TABLE에 대한 alias 사용시에는 AS를 쓰지 않아


SELECT a.*
FROM (SELECT ROWNUM RN, empno, ename
FROM(SELECT  empno, ename
FROM emp
ORDER BY ename)) a
WHERE RN BETWEEN 11 AND 20;