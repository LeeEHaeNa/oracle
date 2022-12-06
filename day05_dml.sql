create table emp_10
as
select * from emp where 1<>1;

select * from emp_10;

insert into emp_10 (empno, job, ename, hiredate,mgr, sal, comm, deptno)
values(1000,'MANAGER','TOM',SYSDATE,NULL,2000,NULL,10);
COMMIT;

DESC EMP_10;

ALTER TABLE EMP_10 ADD CONSTRAINT EMP_10_ENAME_NN NOT NULL(ENAME); --[X]

-- �÷��� �����ϸ鼭 NOT NULL�� �߰�
ALTER TABLE EMP_10 MODIFY ENAME VARCHAR2(20) NOT NULL;

INSERT INTO EMP_10(EMPNO,JOB,MGR, SAL, ENAME) VALUES(1001,'SALESMAN',1000,3000,'JAMES');

SELECT * FROM EMP_10;

-- SUBQUERY�� Ȱ���� INSERT
INSERT INTO EMP_10
SELECT * FROM EMP WHERE DEPTNO=10;

INSERT���� �÷� ������ ���������� �÷� ������ ������������ 1�� 1�� �����ؾ� �ϸ�
�ڷ����� ũ�Ⱑ ���ƾ� �Ѵ�.

SELECT * FROM EMP_10;

# UPDATE ��
UPDATE ���̺�� SET �÷���1=��1, .... WHERE ������;

--EMP���̺��� ī���Ͽ� EMP2���̺��� ����� �����Ϳ� ������ ��� �����ϼ���
CREATE TABLE EMP2
AS
SELECT * FROM EMP;
SELECT * FROM EMP2;
ROLLBACK;
--EMP2���� ����� 7788�� ����� �μ���ȣ�� 10�� �μ��� �����ϼ���.
UPDATE EMP2 SET DEPTNO=10 WHERE EMPNO=7788;

--EMP2���� ����� 7369�� ����� �μ��� 30�� �μ��� �޿��� 3500���� �����ϼ���
UPDATE EMP2 SET DEPTNO=30, SAL=3500 WHERE EMPNO=7369;

ROLLBACK;

CREATE TABLE MEMBER2
AS SELECT * FROM MEMBER;

--2] ��ϵ� ��2 ���� �� ���� ���̸� ���� ���̿��� ��� 5�� ���� ������ 
--	      �����ϼ���.
update member2 set age = age+5;

--	 2_1] ��2 �� 13/09/01���� ����� ������ ���ϸ����� 350���� �÷��ּ���.
update member2 set mileage=mileage+350 where reg_date>'13/09/01';
SELECT * FROM MEMBER2;

--3] ��ϵǾ� �ִ� ��2 ���� �� �̸��� '��'�ڰ� ����ִ� ��� �̸��� '��' ���
--	     '��'�� �����ϼ���.
UPDATE MEMBER2 SET NAME=REPLACE(NAME,'��','��') WHERE NAME LIKE '��%';
SELECT * FROM MEMBER2;
ROLLBACK;

# UPDATE �Ҷ� ���Ἲ���������� �Ű��� ��

CREATE TABLE DEPT2
AS SELECT * FROM DEPT;

DEPT2���̺��� DEPTNO�� ���� PRIMARY KEY ���������� �߰��ϼ���
ALTER TABLE DEPT2 ADD CONSTRAINT DEPT2_PK PRIMARY KEY (DEPTNO);

EMP2 ���̺��� DEPTNO�� ���� FOREIGN KEY ���������� �߰��ϵ�
DEPT2�� DEPTNO�� �ܷ�Ű�� �����ϵ��� �ϼ���

ALTER TABLE EMP2 ADD CONSTRAINT EMP2_FK FOREIGN KEY (DEPTNO)
REFERENCES DEPT2 (DEPTNO);

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME ='EMP2';

UPDATE EMP2 SET DEPTNO =10 WHERE DEPTNO=20;

SELECT * FROM EMP2;

UPDATE EMP2 SET DEPTNO =50 WHERE DEPTNO=20;
-- integrity constraint (SCOTT.EMP2_FK) violated - parent key not found

ROLLBACK;

# DELETE ��
DELETE FROM ���̺�� WHERE ������;

--- EMP2���̺��� �����ȣ�� 7499�� ����� ������ �����϶�.
DELETE FROM EMP2 WHERE EMPNO=7499;
SELECT * FROM EMP2;
ROLLBACK;
--- EMP2���̺��� �ڷ� �� �μ����� 'SALES'�� ����� ������ �����϶�.
DELETE FROM EMP2 WHERE DEPTNO = (SELECT DEPTNO FROM DEPT2 WHERE DNAME='SALES');

---- PRODUCTS2 �� ���� �׽�Ʈ�ϱ�
CREATE TABLE PRODUCTS2 AS SELECT * FROM PRODUCTS;

--1] ��ǰ ���̺� �ִ� ��ǰ �� ��ǰ�� �Ǹ� ������ 10000�� ������ ��ǰ�� ��� 
--	      �����ϼ���.
SELECT * FROM PRODUCTS2;

DELETE FROM PRODUCTS2 WHERE OUTPUT_PRICE <= 10000;

--	2] ��ǰ ���̺� �ִ� ��ǰ �� ��ǰ�� ��з��� ������ ��ǰ�� �����ϼ���.

DELETE FROM PRODUCTS2 WHERE CATEGORY_FK 
= ( SELECT CATEGORY_CODE FROM CATEGORY WHERE CATEGORY_NAME LIKE '%����%' 
AND MOD(CATEGORY_CODE,100)=0);

DELETE FROM PRODUCTS2;
 -- WHERE �������� ������ ��� ���ڵ尡 �����ȴ�.
COMMIT;


TCL : TRANSACTION CONTROL LANGUAGE
- COMMIT
- ROLLBACK
- SAVEPOINT (ǥ�� �ƴ�. ����Ŭ���� ����)

UPDATE EMP2 SET ENAME='CHARSE' WHERE EMPNO=7788;
SELECT * FROM EMP2;

UPDATE EMP2 SET DEPTNO=30 WHERE EMPNO=7788;

--SAVEPOINT ����Ʈ��;
SAVEPOINT POINT1; -- ������ ����

UPDATE EMP2 SET JOB='MANAGER';

ROLLBACK TO SAVEPOINT POINT1;

SELECT * FROM EMP2;
COMMIT;
