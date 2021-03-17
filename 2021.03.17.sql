--시험문제: 트랜잭션, not in, 페이징,emp테이블 컬럼의 이름 
Single row function : 단일 행을 기준으로 작업하고, 행당 하나의 결과를 반환: 컬럼의 문자열 길이(length(ename))
Multi row function : 여러 행을 기준으로 작업하고, 하나의 결과를 반환, 그룹함수  (count ,sum, avg)

character

LOWER(문자1개)->소문자
UPPER(문자1개)->대문자
INITCAP()->첫 글자를 대문자로


CONCAT(문자열1, 문자열2)->결합된 하나
SUBSTR(문자열, 시작위치, 끝나는 위치)->문자열의 일부분을 빼오기
SUBSTR(문자열, 시작위치)->문자열의 일부분을 빼오기

INSTR
LPAD
RPAD
TRIM->공백제거
REPLACE(대상문자열, 바꾸고 싶은 문자열, 바꿀 문자열)


함수명을 보고
1. 파라미터(인자)가 어떤게 들어갈까?
2. 몇 개의 파라미터가 들어갈까?
3. 반환되는 값은 무엇일까?

SELECT ename,SUBSTR(ename, 2,4)
FROM emp;

SELECT ename,LOWER(job), INITCAP(job), UPPER(ename),LOWER('TEST')--expression(표현식)
FROM emp;

<DUAL table>
sys계정에 있는 테이블
누구나 사용 가능
DUMMY 컬럼 하나만 존재하며 값은 X이며 데이터는 한 행만 존재
사용용도
-데이터와 관련 없이
    -함수 실행
    -시퀀스 실행
-merge문에서
-데이터 복제시(connect by level)


SELECT *
FROM DUAL
connect by level<=15;

SELECT LOWER('TEST')
FROM DUAL;


Single row function: where절에서도 사용가능/Multi row에서는 사용 불가
emp테이블에 등록된 직원들 중에 직원의 이름이 5글자를 초과하는 직원만 조회

SELECT *
FROM emp
WHERE LENGTH(ename)>5;


SELECT *
FROM emp
WHERE LOWER(ename)='smith';--권장 안해, 실행횟수 많아


SELECT *
FROM emp
WHERE ename=UPPER('smith');

엔코아->엔코아 부사장:b2en->dbian


CONCAT:문자열 함수



SELECT CONCAT('Hello', CONCAT(',', ',World')) CONCAT,
       SUBSTR('Hello, World',1,5) SUBSTR,
       LENGTH('Hello, World') LENGTH,
       INSTR('Hello, World','o') INSTR, --첫번째 o만 나와 
       INSTR('Hello, World','o',6) INSTR2,--6번째부터 o를 다시 찾아
       --('xx회사-개발본부-개발부-개발팀-개발파트') 이럴때 사용
       LPAD('Hello, World',15,'*') LPAD,--문자열의 길이를 15자리로 만들고 싶고, 부족한 부분은 *을 채워넣을래(패딩)
       RPAD('Hello, World',15,'*') RPAD,--오른쪽에 채워넣을래
       REPLACE('Hello, World','o','x') REPLACE,--o를 x로 바꿔줘
       --공백을 제거, 문자열의 앞과, 뒷부분에 있는
       TRIM('   Hello, World   ') TRIM,
       TRIM('d' FROM 'Hello, World') TRIM--d라는 문자열을 지워줘
        
FROM dual;


숫자 함수
ROUND(반올림할 숫자, 자리수): 반올림
TRUNC(버릴 숫자, 자리수): 내림
MOD(피제수, 제수): 나눗셈의 나머지

SELECT *
FROM emp
WHERE ename='SMITH';
ROUND(105.54,1),--반올림 결과가 소수점 첫번째 자리까지 나오도록
ROUND(105.55,1),--반올림 결과가 소수점 첫번째 자리까지 나오도록
ROUND(105.55,0),--소수점 첫번째 자리에서 반올림 해라
ROUND(105.55,-1)--1의 자리에서 반올림 해라:10의 자리수까지 출력

SELECT 
ROUND(105.54,1) ROUND1,--반올림 결과가 소수점 첫번째 자리까지 나오도록
ROUND(105.55,1) ROUND2,--반올림 결과가 소수점 첫번째 자리까지 나오도록
ROUND(105.55,0) ROUND3,--소수점 첫번째 자리에서 반올림 해라
ROUND(105.55,-1)ROUND4, --1의 자리에서 반올림 해라:10의 자리수까지 출력
ROUND(105.55)ROUND4 --두번째 인자 생략하면 기본적으로 0으로 설정
FROM dual;

SELECT 
TRUNC(105.54,1) TRUNC1,--소수점 둘째 자리까지 절삭
TRUNC(105.55,1) TRUNC2,--소수점 둘째 자리까지 절삭
TRUNC(105.55,0) TRUNC3,--소수점 첫번째 자리에서 절삭
TRUNC(105.55,-1)TRUNC4, --1의 자리에서 절삭
TRUNC(105.55) TRUNC5--두번째 인자 생략하면 기본적으로 0으로 설정

FROM dual;

sal 을 1000으로 나눴을 때의 몫, sal을 1000으로 나눴을 때의 나머지
SELECT empno, ename, sal, TRUNC(sal/1000,0) , MOD(sal, 1000)
FROM emp;
     
날짜<==>문자
서버의 현재 시간 : SYSDATE

SELECT SYSDATE +1 ,SYSDATE +1/24 ,SYSDATE +1/24/60/60 --정수를 더하면 하루씩 더하는 것 1/24:1시간 더하라는 것 +1/24/60 :1분 더하라는 것
--+1/24/60/60: 1초 더하라는 것
FROM dual;

[실습1]
1.2019년 12월 31일을 Date형으로 표현
SELECT SYSDATE -(365+365+17+28+31+1)
FROM dual;

2.2019년 12월 31일을 표현하고 5일 이전 날짜
SELECT SYSDATE -(365+365+17+28+31+1),SYSDATE -(17+28+31+5),SYSDATE ,SYSDATE-3 
FROM dual;


3.현재날짜
SELECT SYSDATE 
FROM dual;

4. 현재날짜에서 3일전 값
SELECT SYSDATE-3 
FROM dual;


[정답]
SELECT TO_DATE('2019/12/31','YYYY/MM/DD') LASTDAY,
       TO_DATE('2019/12/31','YYYY/MM/DD')-5 LASTDAY2,
       SYSDATE,
       SYSDATE-3
FROM dual;       


TO_DATE:인자-문자, 문자의 형식
TO_CHAR: 인자-날짜, 문자의 형식

SELECT SYSDATE,TO_CHAR(SYSDATE, 'YYYY-MM-DD'),TO_CHAR(SYSDATE, 'YYYY')
FROM dual;
0:일요일 1: 월요일 2: 화요일 3: 수요일 ......
SELECT SYSDATE,TO_CHAR(SYSDATE, 'IW'),TO_CHAR(SYSDATE, 'D')   --IW로 몇주째인지 알 수 있음
FROM dual;

YYYY:4자리 년도
MM: 2자리 월
DD: 2자리 일자
D: 주간 일자(1~7)
IW: 주차(1~53)
HH,HH12: 2자리 시간 (12시간 표현)
HH24: 2자리 시간(24시간 표현)
MI: 2자리 분
SS: 2자리 초

오늘 날짜를 다음과 같은 포맷으로 조회하는 쿼리를 작성하시오
1.년-월-일
2.년-월-일 시간(24)-분-초
3.일-월-년

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD'), TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'), TO_CHAR(SYSDATE,'DD-MM-YYYY')
FROM dual;

SELECT TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD')
FROM dual;