-- day03_join.sql

�μ����̺�� ������̺��� �����غ���

select d.deptno, dname, e.deptno, ename, job, sal
from dept d, emp e
where d.deptno = e.deptno order by 1;

����� �������� �̿��� ���� => ǥ��

select d.*, e.*
from dept d join emp e
on d.deptno = e.deptno order by d.deptno;

-- SALESMAN�� �����ȣ,�̸�,�޿�,�μ���,�ٹ����� ����Ͽ���.

select EMPNO, ENAME, SAL, JOB, DNAME, LOC
from emp e, dept d
where e.deptno = d.deptno and e.job='SALESMAN';

select EMPNO, ENAME, SAL, JOB, DNAME, LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO 
WHERE E.JOB='SALESMAN';


--���� ������ �ִ� ī�װ� ���̺�� ��ǰ ���̺��� �̿��Ͽ� �� ��ǰ���� ī�װ�
--	      �̸��� ��ǰ �̸��� �Բ� �����ּ���.
SELECT CATEGORY_NAME, PRODUCTS_NAME
FROM CATEGORY C JOIN PRODUCTS P
ON C.CATEGORY_CODE = P.CATEGORY_FK ORDER BY 1;

--ī�װ� ���̺�� ��ǰ ���̺��� �����Ͽ� ȭ�鿡 ����ϵ� ��ǰ�� ���� ��
--	      ������ü�� �Ｚ�� ��ǰ�� ������ �����Ͽ� ī�װ� �̸��� ��ǰ�̸�, ��ǰ����
--	      ������ ���� ������ ȭ�鿡 �����ּ���.
SELECT CATEGORY_NAME, PRODUCTS_NAME, OUTPUT_PRICE, COMPANY
FROM CATEGORY C JOIN PRODUCTS P
ON C.CATEGORY_CODE = P.CATEGORY_FK AND P.COMPANY='�Ｚ';
          
--�� ��ǰ���� ī�װ� �� ��ǰ��, ������ ����ϼ���. �� ī�װ��� 'TV'�� ���� 
--	      �����ϰ� ������ ������ ��ǰ�� ������ ������ ������ �����ϼ���    
select category_name, products_name, output_price
from category c join products p
on c.category_name != 'TV' and c.category_code = p.category_fk order by 3;


SELECT D.DNAME, E.ENAME
FROM DEPT D JOIN EMP E
USING(DEPTNO);


# NON-EQUIJOIN
����������EQUAL(=)�� �ƴ� �ٸ� �����ȣ�� ��������� ���

EMP�� SALGRADE�� ������ ���
EMP�� SAL ==> SALGRADE�� LOSAL ~ HISAL ���̿� ����

SELECT EMPNO, ENAME,SAL, GRADE, LOSAL, HISAL
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;


97] ���޾�ü ���̺�� ��ǰ ���̺��� �����Ͽ� ���޾�ü �̸�, ��ǰ��,
		���ް��� ǥ���ϵ� ��ǰ�� ���ް��� 100000�� �̻��� ��ǰ ����
		�� ǥ���ϼ���. ��, ���⼭�� ���޾�üA�� ���޾�üB�� ��� ǥ��
		�ǵ��� �ؾ� �մϴ�.

SELECT EP_NAME, PRODUCTS_NAME, INPUT_PRICE
FROM SUPPLY_COMP S JOIN PRODUCTS P
ON (S.EP_NAME='���޾�üA' OR S.EP_NAME='���޾�üB') 
AND P.INPUT_PRICE >=100000;

#CARTESIAN PRODUCT
SELECT D.*, E.*
FROM DEPT D, EMP E;


SELECT D.*, E.*
FROM DEPT D, EMP E
WHERE D.DEPTNO= E.DEPTNO;

# OUTER JOIN
EQUAL ���ǿ� �������� �ʴ� �����Ͱ� �ִ���  NULL�� �����Ͽ� �������

SELECT D.DEPTNO, DNAME, ENAME, JOB
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO(+) ORDER BY 1;

����� �������� ���
[1] LEFT OUTER JOIN : ���� ���̺��� �������� ���
[2] RIGHT OUTER JOIN : ������ ���̺��� �������� ���
[3] FULL OUTER JOIN: ���� �� �ƿ��� ������ �Ŵ� ���

[1] LEFT OUTER JOIN
SELECT  DISTINCT(E.DEPTNO), D.DEPTNO
FROM DEPT D LEFT OUTER JOIN EMP E
ON D.DEPTNO = E.DEPTNO ORDER BY 2;

[2] RIGHT OUTER JOIN
SELECT  DISTINCT(E.DEPTNO), D.DEPTNO
FROM DEPT D RIGHT OUTER JOIN EMP E
ON D.DEPTNO = E.DEPTNO ORDER BY 2;
        
[3] FULL OUTER JOIN
SELECT DISTINCT(E.DEPTNO), D.DEPTNO
FROM DEPT D FULL OUTER JOIN EMP E
ON D.DEPTNO = E.DEPTNO ORDER BY 2;

--����98] ��ǰ���̺��� ��� ��ǰ�� ���޾�ü, ���޾�ü�ڵ�, ��ǰ�̸�, 
--          ��ǰ���ް�, ��ǰ �ǸŰ� ������ ����ϵ� ���޾�ü�� ����
--          ��ǰ�� ����ϼ���(��ǰ�� ��������).
SELECT S.EP_CODE, EP_NAME, PRODUCTS_NAME, INPUT_PRICE, OUTPUT_PRICE
FROM SUPPLY_COMP S RIGHT OUTER JOIN PRODUCTS P
ON S.EP_CODE = P.EP_CODE_FK;
--
--	����99] ��ǰ���̺��� ��� ��ǰ�� ���޾�ü, ī�װ���, ��ǰ��, ��ǰ�ǸŰ�
--		������ ����ϼ���. ��, ���޾�ü�� ��ǰ ī�װ��� ���� ��ǰ��
--		����մϴ�.

SELECT EP_NAME, CATEGORY_NAME, PRODUCTS_NAME, OUTPUT_PRICE
FROM SUPPLY_COMP S RIGHT OUTER JOIN PRODUCTS P
ON S.EP_CODE = P.EP_CODE_FK
LEFT OUTER JOIN CATEGORY C
ON P.CATEGORY_FK = C.CATEGORY_CODE;

# SELF JOIN
�ڱ� ���̺�� �����ϴ� ���
�� ����� ������ ����ϵ� ������� ������ �̸��� �Բ� �����ּ���

SELECT E.EMPNO, E.ENAME, E.MGR, M.EMPNO, M.ENAME "MANAGER"
FROM EMP E JOIN EMP M
ON E.MGR = M.EMPNO;

--[����] emp���̺��� "������ �����ڴ� �����̴�"�� ������ ����ϼ���.

SELECT E.ENAME||'�� �����ڴ� '||M.ENAME||'�̴�' 
FROM EMP E JOIN EMP M
ON E.MGR=M.EMPNO;

#UNION: ������
SELECT DEPTNO FROM DEPT UNION
SELECT DEPTNO FROM EMP;

#UNION ALL
SELECT DEPTNO FROM DEPT UNION ALL
SELECT DEPTNO FROM EMP;

#INTERSECT : ������
SELECT DEPTNO FROM DEPT
INTERSECT SELECT DEPTNO FROM EMP;

#MINUS : ������
SELECT DEPTNO FROM DEPT MINUS
SELECT DEPTNO FROM EMP;

--1. emp���̺��� ��� ����� ���� �̸�,�μ���ȣ,�μ����� ����ϴ� 
--   ������ �ۼ��ϼ���.

--2. emp���̺��� NEW YORK���� �ٹ��ϰ� �ִ� ����� ���Ͽ� �̸�,����,�޿�,
--    �μ����� ����ϴ� SELECT���� �ۼ��ϼ���.
SELECT ENAME, JOB, SAL, DNAME, LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO AND D.LOC='NEW YORK';

--3. EMP���̺��� ���ʽ��� �޴� ����� ���Ͽ� �̸�,�μ���,��ġ�� ����ϴ�
--    SELECT���� �ۼ��ϼ���.
SELECT ENAME, DNAME, LOC, COMM
FROM DEPT D JOIN EMP E
ON D.DEPTNO = E.DEPTNO AND COMM IS NOT NULL;

--5. �Ʒ��� ����� ����ϴ� ������ �ۼ��Ͽ���(�����ڰ� ���� King�� �����Ͽ�
--	��� ����� ���)

select e.ename Employee, e.empno "Emp#",
m.ename Manager, m.empno "Mgr#"
from emp e left outer join emp m
on e.mgr = m.empno order by 3 desc;

select e.ename Employee, e.empno "Emp#",
m.ename Manager, m.empno "Mgr#"
from emp e, emp m
where e.mgr = m.empno(+) order by 3 desc;
	---------------------------------------------
	Emplyee		Emp#		Manager	Mgr#
	---------------------------------------------
	KING		7839
	BLAKE		7698		KING		7839
	CKARK		7782		KING		7839
	.....
	---------------------------------------------

select ep_name,category_fk,products_name,output_price
from supply_comp sc full outer join products p
on sc.ep_code=p.ep_code_fk;


