grp3 
SELECT CASE
                             WHEN deptno=10  THEN 'ACCOUNTING'
                             WHEN deptno=20  THEN 'RESEARCH'
                             WHEN deptno=30  THEN 'SALES'
                             WHEN deptno=40  THEN 'OPERATION'
                             ELSE 'DDIT'
                             END DNAME
, MAX(sal),MIN(sal), ROUND(AVG(sal),2), SUM(sal), count(sal),count(mgr),count(*)
FROM emp
GROUP BY deptno;


GRP4 직원의 입사 년원별로 몇명의 직원이 입사했는지 조회하는 쿼리를 작성하세요
SELECT TO_CHAR(hiredate,'YYYYMM') , COUNT(*)
FROM   emp
GROUP BY TO_CHAR(hiredate,'YYYYMM')
ORDER BY TO_CHAR(hiredate,'YYYYMM');

GRP5 직원의 입사 년별로 몇명의 직원이 입사했는지 조회

SELECT TO_CHAR(hiredate,'YYYY') , COUNT(*)
FROM   emp
GROUP BY TO_CHAR(hiredate,'YYYY')
ORDER BY TO_CHAR(hiredate,'YYYY');

GRP6 회사에 존재하는 부서의 개수

SELECT count(*)
FROM dept;

grp7 직원이 속한 부서의 개수를 구해라 
SELECT COUNT(*) CNT
FROM(SELECT COUNT(*)
FROM emp
GROUP BY deptno);


[잘못생각]
--WHERE detpno IS NOT NULL
WHERE detpno IS NOT NULL
GROUP BY empno;


JOIN -RDMS는 중복을 최소화 하는 형태의 데이터 베이스
     -다른 테이블과 결합하여 데이터를 조회
     
     데이터의 확장(결합)
     1. 컬럼에 대한 확장 : JOIN
     2. 행에 대한 확장: 집합연산자(UNION ALL, UNION, MINUS, INTERSECT )
     
JOIN  emp 테이블에는 부서코드만 존재, 부서정보를 담은 dept테이블 별도로 생성
      emp 테이블과 dept테이블의 연결고리(deptno)로 조인하여 실제 부서명을 조인한다
      
JOIN
1. 표준 SQL -ANSI SQL 
2. 비표준 SQL- DBMS 를 만드는 회사에서 만든 고유의 SQL 문법


ANSI : SQL 
ORACLE : SQL

ANSI SQL :NATURAL JOIN -조인하고자 하는 테이블의 연결컬럼 명(타입)이 동일한 경우 (emp-deptno, dept-deptno)
-연결 컬럼의 값이 동일할 때 (=)컬럼이 확장된다

SELECT emp.ename  --NATURAL JOIN에서는 emp.deptno 연결고리 컬럼은 한정자를 쓰지 못한다u
FROM emp NATURAL JOIN dept;


ORACLE JOIN: 
1.FROM 절에 조인할 테이블을 , 형태로 구분하여 나열
2.WHERE : 조인할 테이블의 연결조건을 기술

SELECT *
FROM emp,dept
WHERE emp.deptno=dept.deptno;

7369  SMITH , 7902 FORD
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e,emp m  --동일 테이블에서 조회할 때는 별칭을 정해줘야 해
WHERE e.mgr=m.empno;


ANSI JOIN: JOIN WITH USING
조인 하려고 하는 테이블의 컬럼명과 타입이 같은 컬럼이 두개 이상인 상황에서
두 컬럼을 모두 조인 조건으로 참여시키지 않고, 개발자가 원하는 특정 컬럼으로만 연결을 시키고 싶을 때 사용

SELECT *     --emp.deptno 연결 컬럼으로는 한정자 사용 불가
FROM emp JOIN dept USING (deptno);

==
SELECT *     --emp.deptno 연결 컬럼으로는 한정자 사용 불가
FROM emp,dept
WHERE emp.deptno=dept.deptno;



JOIN WITH ON: NATURAL JOIN, JOIN WITH USING을 대체할 수 있는 보편적인 문법
조인 컬럼을 개발자가 임의로 지정

SELECT *
FROM emp JOIN dept ON (emp.deptno=dept.deptno);

--사원 번호, 이름 상사의 사원번호, 이름
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON(e.mgr=m.empno);  --동일 테이블에서 조회할 때는 별칭을 정해줘야 해

--사원 번호, 이름 상사의 사원번호, 이름
--+ 사원의 번호가 7329애소 7698인 사람
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON(e.mgr=m.empno)--동일 테이블에서 조회할 때는 별칭을 정해줘야 해
WHERE e.empno BETWEEN 7329 AND 7698;

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e,emp m 
WHERE e.mgr=m.empno--동일 테이블에서 조회할 때는 별칭을 정해줘야 해
      AND e.empno BETWEEN 7329 AND 7698;

논리적인 조인 형태
1. SELF JOIN: JOIN 테이블이 같은 경우
 -계층구조
2. NONEQUI-JOIN : 조인 조건이 =equals가 아닌 조인

SELECT *
FROM emp, dept
WHERE emp.deptno !=dept.deptno;

SELECT *
FROM salgrade;
--salgrade 를 이용하여 직원의 급여 등급 구하기
--empno, ename, sal, 급여등급
--ansi, orale
SELECT emp.ename, salgrade.GRADE
FROM emp JOIN salgrade ON(emp.sal BETWEEN salgrade.LOSAL AND salgrade.HISAL);

SELECT emp.ename,emp.sal, salgrade.GRADE
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.LOSAL AND salgrade.HISAL;

실습1 . emp , dept 테이블을 이용하여 다음과 같이 조회되도록 작성
SELECT EMP.EMPNO, EMP.ENAME,DEPT.deptno, DEPT.DNAME
FROM emp, dept
WHERE emp.deptno= dept.deptno;

실습 2 부서번호가 10번이나 30분인 데이터만 조회

SELECT EMP.EMPNO, EMP.ENAME,DEPT.deptno, DEPT.DNAME
FROM emp, dept
WHERE emp.deptno= dept.deptno
      AND dept.deptno IN('10','30');--emp.deptno로 사용해도 가능
      
실습3 급여가 2500초과인 사람만 조회

SELECT EMP.EMPNO, EMP.ENAME, sal,DEPT.deptno, DEPT.DNAME
FROM emp, dept
WHERE emp.deptno= dept.deptno
      AND sal>2500;
      
실습 4 급여가 2500초과 사번이 7600보다 큰 직원

SELECT EMP.EMPNO, EMP.ENAME, sal,DEPT.deptno, DEPT.DNAME
FROM emp, dept
WHERE emp.deptno= dept.deptno
      AND sal>2500
      AND emp.empno>7600;

실습5 급여가 2500초과 사번이 7600보다 크고 리서치 부서에 속하는 직원

SELECT EMP.EMPNO, EMP.ENAME, sal,DEPT.deptno, DEPT.DNAME
FROM emp, dept
WHERE emp.deptno= dept.deptno
      AND sal>2500
      AND emp.empno>7600
      AND dname='RESEARCH';



