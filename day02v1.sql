
order by 절
-오름차순: asc
-내림차순: desc
-null 값은 오름차순일 때 가장 나중에, 내림차순에서는 가장 먼저온다 

wgho 순서 
- where
- group by
- having
- order by

--사원테이블에서 입사일자 순으로 정렬하여 사번,이름,업무,급여,
--	입사일자를 출력하세요.
select empno, ename, job, sal, hiredate
from emp order by hiredate desc;

select empno,ename,sal, sal*12 from emp order by sal*12 desc;
select empno,ename,sal, sal*12 y from emp order by y desc;

order by 1 asc;

select empno, ename, hiredate, deptno, job, sal
from emp
order by deptno, job sal desc;

SELECT * FROM MEMBER;
SELECT * FROM PRODUCTS;
SELECT * FROM CATEGORY;
SELECT * FROM SUPPLY_COMP;

--1] 상품 테이블에서 판매 가격이 저렴한 순서대로 상품을 정렬해서 
--    보여주세요.
select * from products order by output_price asc;

--2] 고객 테이블의 정보를 이름의 가나다 순으로 정렬해서 보여주세요.
--      단, 이름이 같을 경우에는 나이가 많은 순서대로 보여주세요.
select * from member order by name asc, age desc;

--3] 상품 테이블에서 배송비의 내림차순으로 정렬하되, 
--	    같은 배송비가 있는 경우에는
--		마일리지의 내림차순으로 정렬하여 보여주세요.
select * from products order by trans_cost desc, mileage desc;
--4]사원테이블이서 입사일이 1981 2월20일 ~ 1981 5월1일 사이에
--	    입사한 사원의 이름,업무 입사일을 출력하되, 입사일 순으로 출력하세요.
select ename,job,hiredate from emp 
where hiredate between '81/02/20' and '81/05/01' order by hiredate asc;

--5] 사원테이블에서 부서번호가 10,20인 사원의 이름,부서번호,업무를 출력하되
--	    이름 순으로 정렬하시오.
select ename,deptno,job from emp where deptno in(10,20) order by ename asc;

select * from emp;

select ename, sal, comm from emp
where comm>=sal*1.1;

select * from emp
where job in ('clerk','analyst') and sal not in (1000,3000,5000);

select * from emp
where ename like'%ll%' and deptno=30 or mgr=7782;


