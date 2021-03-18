날짜관련 함수

ROUND(DATE,format);
ROUND(DATE,'yyyy');--월에서 반올림해서 연도까지
MONTHS_BETWEEN: DATE타입 인자 두개 -(START DATE, END DATE):두 일자 사이의 개월 수 
ADD_MONTHS: 인자: date, number 더할 개월 수: date로 부터 x개월 뒤의 날짜
NEXT_DAY:인자 : date,number(weekday,주간일자)-date이후의 가장 첫번째 주간일자에 해당하는 date를 반환
LAST_DAY:인자: date: date가 속한 월의 마지막 일자를 date로 반환


MONTH_BETWEEN
SELECT  ename, TO_CHAR(hiredate,'YYYY/DD/MM HH24: MI:SS') hiredate,
        MONTHS_BETWEEN(sysdate, hiredate) MONTHS_BETWEEN,
        ADD_MONTHS(sysdate,5) ADD_MONTHS,
        ADD_MONTHS(TO_DATE('2021-02-15','YYYY/MM/DD'),5) ADD_MONTHS,
        ADD_MONTHS(TO_DATE('2021-02-15','YYYY/MM/DD'),-5)ADD_MONTHS,--5개월 이전의 날짜
        NEXT_DAY(sysdate, 6) NEXT_DAY,--오늘 날짜 이후 처음으로 나타나는 금요일은 몇일인가
        LAST_DAY(sysdate) LAST_DAY,
        --SYSDATE를 이용하여 SYSDATE가 속한 월의 첫번째 날짜 구하기....        
   --오류남TO_DATE(TO_CHAR(sysdate,'YYYYMM')||'01','YYYYMMDD') FIRST DAY
   --      FROM emp;
        TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01', 'YYYYMMDD') FIRST_DAY 
        FROM emp;

[date실습 3] 
파라미터로 yyyymmdd형식의 문자열을 사용하여 해당 년월에 해당하는 일자 수를 구해보세요
SELECT :YYYYMM, 
        TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM,'YYYYMM')),'DD') DT--일자만 빼내고 싶어서 다시 지정

FROM dual;

형변환
-명시적 형변환: TO_DATE, TO_CHAR, TO_NUMBER

-묵시적 형변환:

TO_NUMBER(숫자,FORMAT(0:숫자, 0강제로 0표시, ',' 1000자리 표시, . 소수점,L화폐단위, $달러 화폐 표시 ))

SELECT *
FROM emp
WHERE empno='7369';--묵시적 형변환
WHERE TO_CHAR(empno)='7369';-- 명시적 형변환
        
1. 위에서 아래로
2. 단, 들여쓰기 되어있을 경우 자식노드부터 읽는다

*자식노드부터 읽어 들여쓰기 한것이 자식 노드
0
*1
이면 1->0
0
1
2 EMP
*3 PK EMP
4 DEPT
*5 PK DEPT
3-2-5-4-1-0


NULL처리 함수 :4가지
NVL(expr1, expr2):앞의 값이  null이 아니면 앞의 값을 사용하고 앞의값이 null이면 뒤의 값을 사용해라.
if(expr1==null){
System.out.println("expr2")}
else{
System.out.println("expr1")}

emp테이블에서 comm컬럼의 값이 null일 경우에 0으로 대체해서 조회하기
SELECT empno,sal,comm,sal+ NVL(comm,0)NVL1,
       NVL(sal+comm,0) NVL2--comm에 null이 있으면 SAL값은 무시된다. 

FROM emp;

NVL2(expr1,expr2,expr3)
if(expr1!=null)
   {System.out.println(expr2)}
else
   {System.out.println(expr3)}

comm이 null이 아니면 sal+comm 값을 반환,
comm이 null이면 sal을 반환

SELECT empno,sal, comm, NVL2(comm, sal+comm, sal)
FROM emp;

NULLIF(expr1,expr2)
if(expr1==expr2){
System.out.println(null)}
else{
System.out.println(expr1)}
}

SELECT empno, sal, NULLIF(sal,1250)
FROM emp;




COALESCE(expr1.......)--가변인자
인자들 중에 가장먼저 등장하는 null이 아닌 인자를 반환
if(expr1 !=null)
    System.out.println(expr1);
else
    COALESCE(expr2.......)--가변인자
    
    if(expr2 !=null)
    System.out.println(expr1);
else
    COALESCE(expr3.......)--가변인자
    
SELECT empno, sal,comm, COALESCE() 
FROM emp;


emp테이블의 정보를 다음과 같이 조회되도록 쿼리를 작성하세요

SELECT empno, ename, mgr, 
       NVL(mgr,9999) mgr_n,
       NVL2(mgr, mgr, 9999) mgr_n_1,
       COALESCE(mgr,9999) mgr_n_2
FROM emp;

[실습5]users 테이블의 정보를 다음과 같이 조회도되록 쿼리를 작성하세요 reg_dt가 Null인 경우 sysdate를 적용

SELECT userid, usernm, reg_dt, NVL(reg_dt,SYSDATE) NVL
FROM users
WHERE userid IN('cony','sally','james','moon');


조건분기
1.  CASE 함수
    WHEN 절=> expr1 비교식(참, 거짓을 판단할 수 있는 수식) true  사용할 값1==>IF
    WHEN 절=> expr1 비교식(참, 거짓을 판단할 수 있는 수식) true  사용할 값2==>ELSE IF
    WHEN 절=> expr1 비교식(참, 거짓을 판단할 수 있는 수식) true  사용할 값3==>ELSE IF
    ELSE 사용할 값
    END
2.  DECODE 함수: 가변인자 사용
    DECODE(expr1,
                search1, return1,
                search2, return3,,
                ,,,,,,,,,,,,[default])
    
    if(expr1==search1){
    
    System.out.println(return1);}
    else if(expr1==search2){
    
    System.out.println(return2);}
     else if(expr1==search3){
    
    System.out.println(return3);}
     else{
     System.out.println(default);
     }
   
    
    


직원들의 급여를 인상하려고 한다.
직군이 SALESMAN이면은 현재 급여에서 5퍼센트 인상
MANAGER 이면 10%
PREGIDENT 이면 20% 인상
나머지는 유지

SELECT ename, job , sal, 
       CASE
        WHEN job='SALESMAN' THEN sal*1.05
        WHEN job='MANAGER' THEN sal*1.10
        WHEN job='PRESIDENT' THEN sal*1.20
        ELSE sal*1.0
       END sal_bonus,
       DECODE(job,'SALESMAN',sal*1.05,
                 'MANAGER' ,sal*1.10,
                 'PRESIDENT',sal*1.20,
                 sal*1.0) sal_bonus_decode//default 값 안쓰면 그냥 null
       

FROM emp;

[실습1]emp 테이블을 이용하여 deptno에 따라 부서명으로 변경해서 다음과 같이 조회되는 쿼리를 작성하세요.

SELECT empno,ename,deptno, CASE
                             WHEN deptno=10  THEN 'ACCOUNTING'
                             WHEN deptno=20  THEN 'RESEARCH'
                             WHEN deptno=30  THEN 'SALES'
                             WHEN deptno=40  THEN 'OPERATION'
                             ELSE 'DDIT'
                             END DNAME,
                             
                             DECODE(deptno,10,'ACCOUNTING',20,'RESEARCH',30,'SALES',40,'OPERATION','DDIT') DNAME2
                             
FROM emp;       
                        
                        
[실습2] emp 테이블을 이용하여 hiredate에 따라 올해 건강보험 검진 대상자인지 조회하는 쿼리를 작성하세요. (생년을 기준으로 하나 여기서는 입사년도를 기준으로 한다.)
SELECT empno, ename, hiredate,  CASE
                                   WHEN MOD(TO_CHAR(hiredate,'YYYY'),2)=MOD(TO_CHAR(SYSDATE,'YYYY'),2) THEN '대상자'
                                   ELSE '비대상자'
                                   END contact_to_doctor
FROM emp;

[실습3] users테이블을 이용하여 reg_dt에 따라 올해 건강보험 검진대상자인지 조회하는 쿼리를 작성하세요.
SELECT userid, usernm, reg_dt,  CASE
                                   WHEN MOD(TO_CHAR(reg_dt,'YYYY'),2)=MOD(TO_CHAR(SYSDATE,'YYYY'),2) THEN '대상자'
                                   ELSE '비대상자'
                                   END contact_to_doctor
FROM users
WHERE usernm IN('브라운','코니','샐리','제임스','문');


WHERE 절 다음에 나옴 GROUP FUNCTION : 여러 행을 그룹으로 하여 하나의 행으로 결과 값을 반환하는 함수
-AVG: 평균
-COUNT:건수
-MAX:최대값
-MIN: 최소값
-SUM:합계

--group by 절에 나온 컬럼이 select절에 그룹함수가 적용되지 않은채로 기술되면 에러
--그래서 empno를 select절에 넣어주고 싶으면 GROUP BY절에도 넣어줘야해=>그럼 14개 다나옴
--아니면 함수적용 해줘야 해
--where절은 그룹 함수 조건으로 사용할 수 없다-> having절 사용
--null값은 계산에서 제외된다(무시)

SELECT empno, deptno, MAX(sal),--그룹중에 가장 점수가 큰 사람 
               MIN(sal),
               ROUND(AVG(sal),2),
               SUM(sal),
               COUNT(sal) count,  -- sal 컬럼의 값이 null 이 아닌 행의 건수
               COUNT(mgr),
               COUNT(*)--그룹핑된 행 건수
FROM emp
GROUP BY deptno,  empno;

--하지만 상수는 그룹핑 하지 않아도 괜찮다.
SELECT 'TEST',deptno,
               MAX(sal),--그룹중에 가장 점수가 큰 사람 
               MIN(sal),
               ROUND(AVG(sal),2),
               SUM(sal),
               COUNT(sal) count,  -- sal 컬럼의 값이 null 이 아닌 행의 건수
               COUNT(mgr),
               COUNT(*)--그룹핑된 행 건수
FROM emp
GROUP BY deptno;

SELECT 'TEST',deptno,
               MAX(sal),--그룹중에 가장 점수가 큰 사람 
               MIN(sal),
               ROUND(AVG(sal),2),
               SUM(sal),
               COUNT(sal) count,  -- sal 컬럼의 값이 null 이 아닌 행의 건수
               COUNT(mgr),
               COUNT(*)--그룹핑된 행 건수
FROM emp
GROUP BY deptno
HAVING COUNT(*)>=4; --그룹함수의 조건은 having절에 써야 해 




SELECT 'TEST',deptno,
               MAX(sal),--그룹중에 가장 점수가 큰 사람 
               MIN(sal),
               ROUND(AVG(sal),2),
               SUM(sal),
               COUNT(sal) count,  -- sal 컬럼의 값이 null 이 아닌 행의 건수
               COUNT(mgr),
               SUM(comm), --null값이 무시된 채 계산된다
               SUM(NVL(comm,0)),
               NVL(SUM(comm),0),
               COUNT(*)   --그룹핑된 행 건수
FROM emp
GROUP BY deptno;


SELECT count(*),
               MAX(sal), 
               MIN(sal),
               ROUND(AVG(sal),2),
               SUM(sal),
               COUNT(sal) count,  -- sal 컬럼의 값이 null 이 아닌 행의 건수
               COUNT(mgr)
            
FROM emp;
SELECT MOD('97',2),
FROM dual;


[4]emp테이블을 이용하여 다음을 구하시오
-직원중 가장 높은 급여
-가장 낮은 급여
-급여 평균
-직원의 급여 합
-급여가 있는 직원의 수
-상급자가 있는 직원의 수
-전체 직원의 수

SELECT MAX(sal),MIN(sal), AVG(sal), SUM(sal), count(sal),count(mgr),count(*)
FROM emp;

SELECT MAX(sal),MIN(sal), ROUND(AVG(sal),2), SUM(sal), count(sal),count(mgr),count(*)
FROM emp
GROUP BY deptno;

 