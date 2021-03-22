SELECT *
FROM prod;

SELECT *
FROM member;

SELECT *
FROM cart;




SELECT *
FROM lprod;


SELECT *
FROM buyer;

SELECT buyer_id, buyer_name,prod_id, prod_name
FROM PROD,BUYER
WHERE PROD.PROD_BUYER=BUYER.BUYER_ID;

SELECT buyer_id, buyer_name,prod_id, prod_name
FROM PROD,BUYER
WHERE PROD.PROD_BUYER=BUYER.BUYER_ID;

SELECT member.mem_id,member.mem_name, prod.prod_id, prod.prod_name, CART.CART_QTY
FROM prod,member, cart
WHERE member.mem_id=cart.cart_member AND cart.cart_prod=prod.prod_id;

SELECT member.mem_id,member.mem_name, prod.prod_id, prod.prod_name, CART.CART_QTY
FROM member JOIN cart ON (member.mem_id=cart.cart_member) 
            JOIN prod ON (cart.cart_prod=prod.prod_id); 


erd 다이어그램을 참고하여 customer, cycle 테이블을 조인하여
고객별 애음 제품, 애음요일, 개수를 다음과 같은 결과가 나오도록 쿼리를
작성해보세요(고객명이 brown, sally인 고객만 조회
SELECT *
FROM  customer;

SELECT *
FROM  cycle;


SELECT *
FROM  product;


SELECT customer.cid,customer.cnm,cycle.pid,cycle.day,cycle.cnt
FROM customer,cycle
WHERE customer.cid=cycle.CID
      AND  customer.cnm IN('brown','sally');
      
erd 다이어그램을 참고하여 customer, cycle, product 테이블을 조인하여
고객별 애음 제품, 애음요일, 개수, 제품명을 다음과 같은 결과가 나  

SELECT customer.cid,customer.cnm,product.pnm,cycle.pid,cycle.day,cycle.cnt
FROM customer,cycle,product
WHERE customer.cid=cycle.CID
      AND product.pid=cycle.pid
      AND  customer.cnm IN('brown','sally');
      
erd 다이어그램을 참고하여 customer, cycle, product 테이블을 조인하여
애음요일과 관계없이 고객별 애음 제품별, 개수의 합과, 제품명을 다음과 같은
결과가 나오도록 쿼리를 작성해보세요

SELECT customer.cid,customer.cnm,cycle.pid,product.pnm,SUM(cycle.cid) cnt
FROM customer,cycle,product
WHERE customer.cid=cycle.CID
      AND product.pid=cycle.pid
GROUP BY customer.cid,customer.cnm,cycle.pid,product.pnm;      

erd 다이어그램을 참고하여 countries, regions, locations 테이블을
이용하여 지역별 소속 국가, 국가에 소속된 도시 이름을 다음과 같은 결과가
나오도록 쿼리를 작성해보세요

SELECT cycle.pid,product.pnm,SUM(cycle.cid) cnt
FROM cycle,product
WHERE product.pid=cycle.pid
GROUP BY cycle.pid,product.pnm;      



OUTER JOIN : 컬럼 연결이 실패해도 기준이 되는 테이블 쪽의 컬럼 정보는 나오도록 하는 조인
LEFT OUTER JOIN : 기준이 왼쪽에 기술한 테이블이 되는 OUTER JOIN 
테이블1 LEFT OUTER JOIN 테이블2;

RIGHT OUTER JOIN : 기준이 오른쪽에 기술한 테이블이 되는 OUTER JOIN 
테이블2 RIGHT OUTER JOIN 테이블1;

FULL OUTER JOIN

직원의 이름, 직원의 상사 이름 두개의 컬럼이 나오도록 JOIN QUERY 작성

SELECT *
FROM emp;

SELECT e.ename , m.ename
FROM emp e JOIN emp m ON (e.mgr=m.empno);

SELECT e.ename , m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr=m.empno);


SELECT e.ename , m.ename
FROM emp e, emp m
WHERE e.mgr=m.empno;

--데이터가 안나오는 쪽에 (+)를 붙여준다
SELECT e.ename , m.ename
FROM emp e, emp m
WHERE e.mgr=m.empno(+);

SELECT e.ename , m.ename, m.deptno
FROM emp e JOIN emp m ON (e.mgr=m.empno)
WHERE m.deptno=10;

--데이터 몇건이 나올까? 그려볼 것
SELECT e.ename , m.ename, m.deptno
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr=m.empno);

SELECT e.ename , m.ename, m.deptno
FROM emp e FULL OUTER JOIN emp m ON (e.mgr=m.empno);

SELECT e.ename , m.ename
FROM emp e, emp m
WHERE e.mgr(+)=m.empno;

SELECT *
FROM buyprod;
SELECT *
FROM prod;



SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty 
FROM buyprod  RIGHT OUTER JOIN prod  ON (BUY_PROD=prod_id AND buy_date=TO_CHAR('2005/01/25','YYYY/MM/DD');
