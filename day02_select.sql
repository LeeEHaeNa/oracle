-- day02_select.sql
select * from tab;
select * from emp;
select * from dept;
select * from salgrade;

SELECT EMPNO, ENAME, SAL, SAL+500 AS SAL_UP, 
COMM, SAL*12+COMM, SAL*12+NVL(COMM, 0) "1 YEAR SAL"   
FROM EMP;
--NVL()
--NVL2(EXPR, ��1, ��2) :  EXPR�� NULL�� �ƴҰ�� ��1�� ��ȯ, NULL�ϰ��� ��2�� ��ȯ
SELECT EMPNO, ENAME, MGR, NVL2(MGR,'����������','�����ھ���') "������ ����" FROM EMP;

--���ڿ� ����: ||

SELECT ENAME|| ' IS A ' ||JOB AS "EMPLOYEE INFO" FROM EMP;

--����] EMP���̺��� �̸��� ������ "KING: 1 YEAR SALARY = 60000"
--	�������� ����϶�.

SELECT ENAME||': 1 YEAR SALARY='|| TO_CHAR(SAL*12+NVL(COMM,0)) FROM EMP;
SELECT ENAME||': 1 YEAR SALARY='|| SAL*12 FROM EMP;

--DISTINCT : �ߺ����� ������
SELECT JOB FROM EMP;
SELECT DISTINCT JOB FROM EMP;

�μ����� ��� �ϴ� ������ �ѹ��� ����ϼ���
SELECT DEPTNO, JOB FROM EMP ORDER BY DEPTNO ASC;
SELECT DISTINCT DEPTNO,JOB FROM EMP
ORDER BY DEPTNO;

SELECT DISTINCT NAME, JOB FROM MEMBER;
SELECT UNIQUE NAME,JOB FROM MEMBER;
--[����]
--	 1] EMP���̺��� �ߺ����� �ʴ� �μ���ȣ�� ����ϼ���.
SELECT DISTINCT DEPTNO FROM EMP;
--	 2] MEMBER���̺��� ȸ���� �̸��� ���� ������ �����ּ���.
SELECT NAME, AGE FROM MEMBER;
--	 3] CATEGORY ���̺� ����� ��� ������ �����ּ���.
SELECT * FROM CATEGORY;
--	 4] MEMBER���̺��� ȸ���� �̸��� ������ ���ϸ����� �����ֵ�,
--	      ���ϸ����� 13�� ���� ����� "MILE_UP"�̶�� ��Ī����
--	      �Բ� �����ּ���.
SELECT NAME, MILEAGE, MILEAGE*13 MILE_UP FROM MEMBER;

# Ư�� �� �˻� - WHERE�� ����ؼ� ������ �ο��� �� �ִ�.

EMP���� �޿��� 3000�̻��� ����� ���,�̸�,����, �޿��� ����ϼ���.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE SAL >= 3000;

--EMP���̺��� �������� MANAGER�� �����
--������ �����ȣ,�̸�,����,�޿�,�μ���ȣ�� ����ϼ���.
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE JOB=upper('manager');

sql���� ��ҹ��� �������� ������, ��(���ͷ�)�� ��ҹ��ڸ� �����Ѵ�.

--EMP���̺��� 1982�� 1��1�� ���Ŀ� �Ի��� ����� 
--�����ȣ,����,����,�޿�,�Ի����ڸ� ����ϼ���
SELECT EMPNO,ENAME,JOB,SAL, HIREDATE
FROM EMP
WHERE HIREDATE > '82/01/01';

--emp���̺��� �޿��� 1300���� 1500������ ����� �̸�,����,�޿�,
--	�μ���ȣ�� ����ϼ���.
SELECT ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE SAL >=1300 AND SAL <=1500;

SELECT ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE SAL BETWEEN 1300 AND 1500;

--emp���̺��� �����ȣ�� 7902,7788,7566�� ����� �����ȣ,
--	�̸�,����,�޿�,�Ի����ڸ� ����ϼ���.
SELECT EMPNO,ENAME, JOB
FROM EMP
WHERE EMPNO IN (7902,7788,7566);
--WHERE EMPNO=7902 OR EMPNO=7788 OR EMPNO=7566;

--10�� �μ��� �ƴ� ����� �̸�,����,�μ���ȣ�� ����ϼ���
SELECT ENAME, JOB, DEPTNO
FROM EMP WHERE DEPTNO <> 10;

--  emp���̺��� ������ SALESMAN �̰ų� PRESIDENT��
--	����� �����ȣ,�̸�,����,�޿��� ����ϼ���.
select empno, ename, job, sal
from emp
where job ='SALESMAN' or job='PRESIDENT';
--	Ŀ�̼�(COMM)�� 300�̰ų� 500�̰ų� 1400�� ��������� ����ϼ���
select * from emp
where comm in (300,500,1400);
	
--	Ŀ�̼��� 300,500,1400�� �ƴ� ����� ������ ����ϼ���
select * from emp
where comm not in (300,500,1400);

-- Ŀ�̼��� null�� ����� ������ ����ϼ���
--select * from emp where comm=null; [x]
select * from emp where comm is null;
--null���� �񱳴� is null or is not null �� ���Ѵ�

--emp���� �̸��� S�ڷ� �����ϴ� ��� ������ �����ּ���
select * from emp
where ename like 'S%';

select * from emp
where ename like '%S';

--	-�̸� �� S�ڰ� ���� ����� ������ �����ּ���.
select ename from emp
where ename like '%S%';
--  �̸��� �ι� °�� O�ڰ� ���� ����� ������ �����ּ���.
select ename from emp
where ename like '_O%';

-- EMP���̺��� �Ի����ڰ� 82�⵵�� �Ի��� ����� ���,�̸�,����
--	   �Ի����ڸ� ����ϼ���.
select empno, ename, job, hiredate from emp
where hiredate like '82%';

alter session set nls_date_format='yyyy-mm-dd';
alter session set nls_date_format='dd-mon-yy';
alter session set nls_date_format='yy/mm/dd';

select hiredate from emp;

-- �� ���̺� ��� ���� �达�� ����� ������ �����ּ���.
    select * from member where name like '��%';
-- �� ���̺� ��� '����'�� ���Ե� ������ �����ּ���.
    select * from member where addr like '%����%';
-- ī�װ� ���̺� ��� category_code�� 0000�� ���� ��ǰ������ �����ּ���.
select * from category
where category_code like '%0000';

select * from products
where category_fk  like '%0000';

--- EMP���̺��� �޿��� 1100�̻��̰� JOB�� MANAGER�� �����
--	���,�̸�,����,�޿��� ����ϼ���.
select empno, ename, job, sal
from emp
where sal >= 1100 and job='MANAGER';

--	- EMP���̺��� �޿��� 1100�̻��̰ų� JOB�� MANAGER�� �����
--	���,�̸�,����,�޿��� ����ϼ���.
select empno, ename, job, sal
from emp
where sal >= 1100 or job='MANAGER';
--	- EMP���̺��� JOB�� MANAGER,CLERK,ANALYST�� �ƴ�
--	  ����� ���,�̸�,����,�޿��� ����ϼ���.    
select empno,ename,job, sal
from emp
where job not in ('MANAGER','CLERK','ANALYST');

select empno,ename,job, sal
from emp
WHERE job <>'MANAGER' AND JOB <>'CLERK' AND JOB != 'ANALYST';

--	- EMP���̺��� �޿��� 1000�̻� 1500���ϰ� �ƴ� ����� ������ �����ּ���
SELECT * FROM EMP WHERE SAL NOT BETWEEN 1000 AND 1500;

--   - EMP���̺��� �̸��� 'S'�ڰ� ���� ���� ����� �̸��� ���
--	  ����ϼ���.
select ename
from emp
where ename not like '%S%';
--	- ������̺��� ������ PRESIDENT�̰� �޿��� 1500�̻��̰ų�
--	   ������ SALESMAN�� ����� ���,�̸�,����,�޿��� ����ϼ���.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE JOB='PRESIDENT' AND SAL >=1500 OR JOB='SALESMAN';

������ �켱����
�񱳿����� > NOT > AND > OR 

ORDER BY ��
- �������� : ASC
- �������� : DESC
- NULL ���� ���������� �� ���� ���߿�, ������������ ���� �����´�

WGHO ����
- WHERE
- GROUP BY
- HAVING
- ORDER BY

--������̺��� �Ի����� ������ �����Ͽ� ���,�̸�,����,�޿�,
--	�Ի����ڸ� ����ϼ���.
SELECT EMPNO, ENAME,JOB, SAL, HIREDATE
FROM EMP ORDER BY HIREDATE;

SELECT EMPNO, ENAME,JOB, SAL, HIREDATE
FROM EMP ORDER BY HIREDATE DESC;

SELECT EMPNO,ENAME,SAL, SAL*12 FROM EMP ORDER BY SAL*12 DESC;

SELECT EMPNO,ENAME,SAL, SAL*12 Y FROM EMP ORDER BY Y DESC;
SELECT EMPNO,ENAME,SAL, SAL*12 FROM EMP
ORDER BY 4 DESC;
--��� ���̺��� �μ���ȣ�� ������ �� �μ���ȣ�� ���� ���
--	�޿��� ���� ������ �����Ͽ� ���,�̸�,����,�μ���ȣ,�޿���
--	����ϼ���.
SELECT EMPNO, ENAME, JOB, DEPTNO, SAL
FROM EMP
ORDER BY DEPTNO ASC, SAL DESC;

--	��� ���̺��� ù��° ������ �μ���ȣ��, �ι�° ������
--	������, ����° ������ �޿��� ���� ������ �����Ͽ�
--	���,�̸�,�Ի�����,�μ���ȣ,����,�޿��� ����ϼ���.
SELECT EMPNO, ENAME, HIREDATE, DEPTNO, JOB, SAL
FROM EMP
ORDER BY DEPTNO, JOB, SAL DESC;

--1] ��ǰ ���̺��� �Ǹ� ������ ������ ������� ��ǰ�� �����ؼ� 
--    �����ּ���.
select * from products order by output_price asc;

--2] �� ���̺��� ������ �̸��� ������ ������ �����ؼ� �����ּ���.
--      ��, �̸��� ���� ��쿡�� ���̰� ���� ������� �����ּ���.
select * from member order by name asc, age desc;

--3] ��ǰ ���̺��� ��ۺ��� ������������ �����ϵ�, 
--	    ���� ��ۺ� �ִ� ��쿡��
--		���ϸ����� ������������ �����Ͽ� �����ּ���.
select * from products order by trans_cost desc, mileage desc;

--4]������̺��̼� �Ի����� 1981 2��20�� ~ 1981 5��1�� ���̿�
--	    �Ի��� ����� �̸�,���� �Ի����� ����ϵ�, �Ի��� ������ ����ϼ���.
select ename,job,hiredate from emp 
where TO_CHAR(HIREDATE,'YY/MM/DD') >='81/02/20' AND
TO_CHAR(HIREDATE,'YY/MM/DD') <='81/05/01';

select ename,job,hiredate from emp 
where TO_CHAR(HIREDATE,'YY/MM/DD') BETWEEN '81/02/20' AND '81/05/01';

select ename,job,hiredate
from emp where hiredate between '1981-02-20' and '1981-05-01'
order by hiredate asc;

SELECT HIREDATE FROM EMP;
--5] ������̺��� �μ���ȣ�� 10,20�� ����� �̸�,�μ���ȣ,������ ����ϵ�
--	    �̸� ������ �����Ͻÿ�.

select ename,deptno,job from emp where deptno in(10,20) order by ename asc;

--6] ������̺��� ���ʽ��� �޿����� 10%�� ���� ����� �̸�,�޿�,���ʽ�
--    �� ����ϼ���.
SELECT ENAME, SAL, COMM
FROM EMP
WHERE COMM > SAL *1.1;
--WHERE COMM  >  SAL+ SAL *10/100;

--7] ������̺��� ������ CLERK�̰ų� ANALYST�̰�
--     �޿��� 1000,3000,5000�� �ƴ� ��� ����� ������ 
SELECT * FROM EMP
WHERE JOB IN ('CLERK','ANALYST') AND SAL NOT IN (1000,3000,5000);
--
--8] ������̺��� �̸��� L�� ���ڰ� �ְ� �μ��� 30�̰ų�
--    �Ǵ� �����ڰ� 7782���� ����� ������ ����ϼ���.
SELECT * FROM EMP
WHERE ENAME LIKE '%LL%' AND DEPTNO =30 OR MGR=7782;
