# subquery

-- ������̺��� scott�� �޿����� ���� ����� �����ȣ,�̸�,����
--	�޿��� ����ϼ���.

select sal from emp where ename=upper('scott');

select empno, ename, job, sal from emp
where sal >3000;

select empno, ename, job, sal from emp
where sal > ( select sal from emp where ename=upper('scott') );


  select empno,ename,job,sal from emp
  where sal > (select sal from emp where ename=upper('scott'));

# �������� ��ȯ�ϴ� ��������

����2]������̺��� �޿��� ��պ��� ���� ����� ���,�̸�
	����,�޿�,�μ���ȣ�� ����ϼ���.
select empno, ename, job, sal, deptno
from emp
where sal < ( select avg(sal) from emp   );
    
--������̺��� ����� �޿��� 20�� �μ��� �ּұ޿�
--		���� ���� �μ��� ����ϼ���.    
select deptno, min(sal)
from emp 
group by deptno
having min(sal) > ( select min(sal) from emp where deptno=20 );

# ������ ��������
: ���������� 1�� �̻��� ���� ��ȯ�ϴ� ���
=> �����༭������ �����ڸ� ����ؾ� �Ѵ�.
   in ������
   any
   all
   exists
--    - �������� �ִ� �޿��� �޴� ����� 
--	 �����ȣ�� �̸��� ����ϼ���.
select job, empno, ename, sal from emp
where  (job, sal) in (
select job, max(sal)
from emp group by job
) order by 1;

# any ������

select deptno, ename, sal from emp
where deptno <> 20 and sal > ANY (select sal from emp where job='SALESMAN');

==> SALESMAN�� ����� �ּұ޿����� �����鼭 20���μ��� �ƴ� ��������� ����϶� �ǹ�

# ALL ������

select deptno, ename, sal from emp
where deptno <> 20 and sal > ALL (select sal from emp where job='SALESMAN');

==> SALESMAN�� ����� �ִ�޿����� �����鼭 20���μ��� �ƴ� ��������� ����϶� �ǹ�

# EXISTS : �������� ������ ���翩�θ� ���� �����ϴ� ���鸸 ����� ��ȯ�Ѵ�
-- ������ ������ ������ �����ּ���
SELECT EMPNO, ENAME, SAL FROM EMP E
WHERE EXISTS ( SELECT EMPNO FROM EMP WHERE E.EMPNO = MGR  );

# ���߿� ��������

�μ����� �ּұ޿��� �޴� ����� ���,�̸�,�޿�,�μ���ȣ�� ����ϼ���
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE (DEPTNO, SAL ) IN
(SELECT DEPTNO, MIN(SAL)
FROM EMP
GROUP BY DEPTNO);

--84] �� ���̺� �ִ� �� ���� �� ���ϸ����� 
--	���� ���� �ݾ��� �� ������ �����ּ���.
SELECT * FROM MEMBER
WHERE MILEAGE = (SELECT MAX(MILEAGE) FROM MEMBER);

--	85] ��ǰ ���̺� �ִ� ��ü ��ǰ ���� �� ��ǰ�� �ǸŰ����� 
--	    �ǸŰ����� ��պ��� ū  ��ǰ�� ����� �����ּ���. 
--	    ��, ����� ���� ���� ����� ������ ���� �Ǹ� ������
--	    50������ �Ѿ�� ��ǰ�� ���ܽ�Ű����.

SELECT * FROM PRODUCTS
WHERE OUTPUT_PRICE > 
( SELECT AVG(OUTPUT_PRICE) FROM PRODUCTS WHERE OUTPUT_PRICE<=500000)
AND OUTPUT_PRICE <=500000;

--	86] ��ǰ ���̺� �ִ� �ǸŰ��ݿ��� ��հ��� �̻��� ��ǰ ����� ���ϵ� �����
--	    ���� �� �ǸŰ����� �ִ��� ��ǰ�� �����ϰ� ����� ���ϼ���.
SELECT * FROM PRODUCTS
WHERE OUTPUT_PRICE >= 
( SELECT AVG(OUTPUT_PRICE) FROM PRODUCTS 
WHERE OUTPUT_PRICE <> ( SELECT MAX(OUTPUT_PRICE)FROM PRODUCTS) );

87] ��ǰ ī�װ� ���̺��� ī�װ� �̸��� ��ǻ�Ͷ�� �ܾ ���Ե� ī�װ���
	    ���ϴ� ��ǰ ����� �����ּ���.

select * from products
    where category_fk IN (select category_code from category where category_name LIKE '%��ǻ��%');
88] �� ���̺� �ִ� ������ �� ������ �������� ���� ���̰� ���� ����� ������
    ȭ�鿡 �����ּ���.
    SELECT * FROM MEMBER
    WHERE (JOB, AGE) IN
    (SELECT JOB, MAX(AGE) FROM MEMBER
    GROUP BY JOB);

	--* UPDATE������ ���
    -- UPDATE ���̺�� SET �÷���=��,... WHERE ����

	89] �� ���̺� �ִ� �� ���� �� ���ϸ����� ���� ���� �ݾ���
	     ������ ������ ���ʽ� ���ϸ��� 5000���� �� �ִ� SQL�� �ۼ��ϼ���.
	update member set mileage =	mileage + 5000 where mileage = (select max(mileage)
                                                             from member);
    SELECT * FROM MEMBER;
    ROLLBACK;

	90] �� ���̺��� ���ϸ����� ���� ���� ������ڸ� �� ���̺��� 
	      ������� �� ���� �ڿ� ����� ��¥�� ���ϴ� ������ �����ϼ���.	 
    UPDATE MEMBER SET REG_DATE = ( SELECT MAX(REG_DATE) FROM MEMBER)
    WHERE MILEAGE =0;
    
    	* DELETE������ ���
        DELETE FROM ���̺�� WHERE ������;
        
	91] ��ǰ ���̺� �ִ� ��ǰ ���� �� ���ް��� ���� ū ��ǰ�� ���� ��Ű�� 
	      SQL���� �ۼ��ϼ���.
	      delete from products where input_price = (select max(input_price) from products);
            select * from products;
            rollback;

	92] ��ǰ ���̺��� ��ǰ ����� ���� ��ü���� ������ ��,
	     �� ���޾�ü���� �ּ� �Ǹ� ������ ���� ��ǰ�� �����ϼ���.
         delete from products where (ep_code_fk,output_price) in(
            select ep_code_fk,min(output_price) from products
            group by ep_code_fk);
            
        select * from products;
        rollback;
        
# INSERT���� SUBQUERY ���        
CATEGORY���̺��� ī���ؼ� CATEGORY_COPY�� ����� �����ʹ� ���� ������ �����ϼ���
�׷��� CATEGORY ���̺��� ������ǰ���� �����ͼ� CATEGORY_COPY�� INSERT�ϼ���

DROP TABLE CATEGORY_COPY;
         
CREATE TABLE CATEGORY_COPY
AS
SELECT * FROM CATEGORY WHERE 1=2;

SELECT * FROM CATEGORY_COPY;

INSERT INTO CATEGORY_COPY
SELECT * FROM CATEGORY
WHERE CATEGORY_CODE LIKE '0001%';
        
         
EMP���� EMP_COPY ���̺�� ������ �����ϱ�         
�޿������ 3��޿� ���ϴ� ��������鸸 EMP_COPY�� INSERT�ϼ���

CREATE TABLE EMP_COPY
AS
SELECT * FROM EMP WHERE 1=2;

SELECT * FROM EMP_COPY;

INSERT INTO EMP_COPY
SELECT E.* FROM EMP E JOIN SALGRADE S
ON  E.SAL BETWEEN S.LOSAL AND S.HISAL AND S.GRADE=3;

COMMIT;

# FROM �������� �������� ===> INLINE VIEW

EMP�� DEPT ���̺��� ������ MANAGER�� ����� �̸�, ����,�μ���,
�ٹ����� ����ϼ���.

SELECT ENAME, JOB, DNAME, LOC
FROM EMP E JOIN DEPT D
USING(DEPTNO)
WHERE JOB='MANAGER';

SUBQUERY �� ������ ������ Ǯ���

SELECT A.ENAME, JOB, DNAME, LOC FROM 
(SELECT * FROM EMP WHERE JOB='MANAGER') A JOIN DEPT D
ON A.DEPTNO = D.DEPTNO;


RANK() OVER() �Լ� : ��ŷ�� �Ű��ִ� �Լ�

SELECT ENAME, SAL FROM EMP
ORDER BY SAL DESC;

# RANK() OVER() : �м����� �������� ��ŷ�� �ű�� �Լ�
SELECT * FROM (
SELECT RANK() OVER( ORDER BY SAL DESC ) RNK, EMP.* FROM EMP
)
WHERE RNK <=5;

# ROW_NUMBER() OVER() : ���ȣ�� �Ű��ִ� �Լ�
SELECT * FROM(
SELECT ROWNUM RN, A.* FROM
(SELECT * FROM EMP ORDER BY HIREDATE DESC) A
)
WHERE RN <=5;

SELECT * FROM(
SELECT ROW_NUMBER() OVER(ORDER BY HIREDATE DESC) RN, EMP.*
FROM EMP) WHERE RN <=5;

select * from memo;
desc memo;
drop table memo;

create sequence memo_seq






         
         
         
         
         