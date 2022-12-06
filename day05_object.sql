-- day05_object.sql
/*
# ������

����
CREATE SEQUENCE ��������
[INCREMENT BY n]  -- ����ġ
[START WITH n] -- ���۰�
[{MAXVALUE n | NOMAXVALE}] -- �ִ밪
[{MINVALUE n | NOMINVALUE}] -- �ּҰ�
[{CYCLE N | NOCYCLE}] -- �ִ�, �ּҿ� ������ �� ��� ���� �������� ���θ� ����. nocycle�� �⺻
[{CACHE | NOCACHE}] -- �޸� ĳ�� ����Ʈ ������ 20
*/
SELECT MAX(DEPTNO) FROM DEPT2;

CREATE SEQUENCE DEPT2_SEQ
INCREMENT BY 5
START WITH 50
MAXVALUE 95
CACHE 20
NOCYCLE;

�����ͻ������� ������ ��ȸ
SELECT * FROM USER_SEQUENCES;

������ ���
- NEXTVAL : ������ ������
- CURRVAL : ������ ���簪
[����] NEXTVAL �� ȣ����� ���� ���¿��� CURRVAL �� ���Ǹ� ������ ����.

SELECT DEPT2_SEQ.CURRVAL FROM DUAL;  ==> ���� �߻���

SELECT DEPT2_SEQ.NEXTVAL FROM DUAL;

SELECT DEPT2_SEQ.CURRVAL FROM DUAL;

INSERT INTO DEPT2(DEPTNO,DNAME,LOC)
VALUES(DEPT2_SEQ.NEXTVAL,'SALES','SEOUL');

SELECT * FROM DEPT2;

SELECT DEPT2_SEQ.CURRVAL FROM DUAL;

��������: TEMP_SEQ
���۰�: 100���� ����
����ġ: 5��ŭ�� ����
�ּҰ��� 0����
CYCLE �ɼ� �ֱ�
ĳ�û�� ���� �ʵ���

CREATE SEQUENCE TEMP_SEQ
START WITH 100
INCREMENT BY -5
MINVALUE 0
MAXVALUE 100
CYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME='TEMP_SEQ';

SELECT TEMP_SEQ.NEXTVAL FROM DUAL;

# ������ ����
[���ǻ���] ���۰��� ������ �� ����. ���۰��� �����Ϸ���  DROP�ϰ� �ٽ� CREATE �Ѵ�

ALTER SEQUENCE ��������
INCREMENT BY N
MAXVALUE N
MINVALUE N
CYCLE|NOCYCLE
CACHE N|NOCACHE;

DEPT2_SEQ�� �����ϵ� MAXVALUE�� 1000����
����ġ 1�� �����ϵ��� �����ϼ���
alter sequence dept2_seq
maxvalue 1000
increment by 1;
-- START WITH 10;
-- cannot alter starting sequence number

SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME='DEPT2_SEQ';
INSERT INTO DEPT2 VALUES(DEPT2_SEQ.NEXTVAL,'TEST','TEST');
SELECT * FROM DEPT2;

DESC DEPT2;

SELECT DEPT2_SEQ.CURRVAL FROM DUAL;


# ������ ����
DROP SEQUENCE ��������;

TEMP_SEQ�� �����ϼ���
DROP SEQUENCE TEMP_SEQ;
SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME='TEMP_SEQ';


# VIEW
[���ǻ���] VIEW�� �����Ϸ��� CREATE VIEW ������ ������ �Ѵ�.
system
Abcd1234
�������� ������ ��
grant create view to scott;


CREATE VIEW ���̸�
	AS
	SELECT �÷���1, �÷���2...
	FROM �信 ����� ���̺��
	WHERE ����
    
--EMP���̺��� 20�� �μ��� ��� �÷��� �����ϴ� EMP20_VIEW�� �����϶�.    

CREATE VIEW EMP20_VIEW
AS
SELECT * FROM EMP WHERE DEPTNO=20;

SELECT * FROM EMP20_VIEW;

SELECT * FROM USER_VIEWS;

DESC EMP20_VIEW;

# VIEW ����
DROP VIEW ���̸�;

DROP VIEW EMP20_VIEW;

# VIEW ����
CREATE OR REPLACE ���̸�
AS SELECT��;


--[����] 
--	�����̺��� �� ���� �� ���̰� 19�� �̻���
--	���� ������
--	Ȯ���ϴ� �並 ��������.
--	�� ���� �̸��� MEMBER_19�� �ϼ���.

CREATE OR REPLACE VIEW MEMBER_19
AS SELECT * FROM MEMBER WHERE AGE >=19;

SELECT * FROM MEMBER_19;

CREATE OR REPLACE VIEW MEMBER_19
AS SELECT * FROM MEMBER WHERE AGE >=40;


EMP���̺��� 30�� �μ��� EMPNO�� EMP_NO�� ENAME�� NAME����
	SAL�� SALARY�� �ٲپ� EMP30_VIEW�� �����Ͽ���.

CREATE OR REPLACE VIEW EMP30_VIEW
AS SELECT EMPNO EMP_NO, ENAME NAME, SAL SALARY FROM EMP
WHERE DEPTNO=30;

SELECT * FROM EMP30_VIEW;

CREATE OR REPLACE VIEW EMP30_VIEW(ENO, NAME, SALARY, DNO)
AS SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO=30;

7499 ����� EMP���� 20�� �μ��� �̵���Ű����

UPDATE EMP SET DEPTNO=20 WHERE EMPNO=7499;
SELECT * FROM EMP;

-- �����̺��� �����ϸ� ���õ� �䵵 �����ȴ�.
-- �並 �����ϸ� �����̺���? ==> �並 �����ϸ� �����̺� �����ȴ�
SELECT * FROM EMP30_VIEW;

UPDATE EMP30_VIEW SET DNO=10 WHERE ENO=7521;

SELECT * FROM EMP;

ROLLBACK;
EMP �� DEPT ���̺��� JOIN�ؼ� VIEW�� ���弼��.
EMP_DEPT_VIEW

CREATE OR REPLACE VIEW EMP_DEPT_VIEW
AS
SELECT E.DEPTNO, DNAME, ENAME, JOB
FROM DEPT D JOIN EMP E
ON D.DEPTNO = E.DEPTNO;

SELECT * FROM EMP_DEPT_VIEW ORDER BY 1;

create or replace view emp_dept_view
as
select * from dept d join emp e
using(deptno);

# WITH READ ONLY �ɼ�
 WITH READ ONLY �ɼ��� �ָ� �信 DML������ ������ �� ����.
 
 CREATE OR REPLACE VIEW EMP10_VIEW
 AS SELECT EMPNO,ENAME,JOB, DEPTNO
 FROM EMP WHERE DEPTNO=10
 WITH READ ONLY;
 
 SELECT * FROM EMP10_VIEW;
 
 UPDATE EMP10_VIEW SET JOB='SALESMAN' WHERE EMPNO=7782;
 
-- "cannot perform a DML operation on a read-only view"

# WITH CHECK OPTION �ɼ�

EMP���� JOB�� SALESMAN�� ����鸸 ��Ƽ� EMP_SALES_VIEW �����
WITH CHECK OPTION�� �ּ���


CREATE OR REPLACE VIEW EMP_SALES_VIEW
AS SELECT * FROM EMP WHERE JOB='SALESMAN'
WITH CHECK OPTION;
==> WHERE���� �����ϰ� üũ ��
    WHERE���� ����Ǵ� ���� INSERT�ǰų�, UPDATE�Ǵ� ���� ���´�.

SELECT * FROM EMP_SALES_VIEW;

UPDATE EMP_SALES_VIEW SET DEPTNO=10 WHERE EMPNO=7499;
==> ����������

UPDATE EMP_SALES_VIEW SET JOB='MANAGER' WHERE ENAME='WARD'; -- ���� �߻�
==> view WITH CHECK OPTION where-clause violation


# INLINE VIEW 

FROM ������ ���� ���������� �ζ��κ��� �Ѵ�

--EMP ���� ���ټ��� 3�� �̾Ƽ� �ؿܿ����� �������� �Ѵ�
--3���� �����ϼ���

CREATE VIEW EMP_OLD_VIEW
AS SELECT * FROM EMP ORDER BY HIREDATE ASC;

SELECT * FROM EMP_OLD_VIEW;

SELECT ROWNUM, EMPNO, ENAME, HIREDATE FROM EMP_OLD_VIEW WHERE ROWNUM <4;

SELECT * FROM(
SELECT ROWNUM RN, A.* FROM
(SELECT * FROM EMP ORDER BY HIREDATE ASC) A
)
WHERE RN <4;


# INDEX
- �ڵ������Ǵ� ��� : PRIMARY KEY �� UNIQUE  ���������� �ָ� �ڵ����� �����ȴ�.
- ��������� �����ϴ� ���: ����ڰ� Ư�� �÷��� �����ؼ� UNIQUE INDEX �Ǵ� NON-UNIQUE
  �ε����� ������ �� �ִ�.

CREATE INDEX �ε����� ON ���̺�� (�÷���[, �÷���2])
- ����] �ε����� NOT NULL �� �÷����� ��밡���ϴ�.

EMP ���� ����� �ε����� �����ϼ���
EMP_ENAME_INDX

CREATE INDEX EMP_ENAME_INDX ON EMP (ENAME);

SELECT * FROM EMP WHERE ENAME='SCOTT';

�ε����� �����ϸ� ���������� �ش� �÷��� �о �������� ������ �Ѵ�.
ROWID�� ENAME�� �����ϱ� ���� ��������� �Ҵ��� �� ���� �����Ѵ�.


�����ͻ������� ��ȸ
SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='INDEX';

SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='VIEW';

SELECT * FROM USER_INDEXES;

SELECT * FROM USER_IND_COLUMNS
WHERE INDEX_NAME='EMP_ENAME_INDX';

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME='DEPT2';

--��ǰ ���̺��� �ε����� �ɾ�θ� ���� �÷��� ã�� �ε����� ���弼��.

CREATE INDEX PRODUCTS_CATEGORY_FK_INDX ON PRODUCTS (CATEGORY_FK);
CREATE INDEX PRODUCTS_EP_CODE_FK_INDX ON PRODUCTS (EP_CODE_FK);


SELECT * FROM USER_INDEXES WHERE TABLE_NAME='PRODUCTS';

ī�װ�, ��ǰ, ���޾�ü�� JOIN�ؼ� ����ϼ���
CREATE OR REPLACE VIEW PRODUCTS_INFO_VIEW
AS
SELECT C.CATEGORY_CODE, CATEGORY_NAME, PNUM, PRODUCTS_NAME, OUTPUT_PRICE,
EP_CODE_FK, EP_NAME
FROM CATEGORY C RIGHT OUTER JOIN PRODUCTS P
ON C.CATEGORY_CODE = P.CATEGORY_FK
LEFT OUTER JOIN SUPPLY_COMP S
ON P.EP_CODE_FK = S.EP_CODE;

SELECT * FROM PRODUCTS_INFO_VIEW
ORDER BY OUTPUT_PRICE ASC;

# DROP INDEX �ε�����;
EMP_ENAME_INDX �ε����� �����ϼ���

DROP INDEX EMP_ENAME_INDX;

SELECT * FROM USER_INDEXES WHERE TABLE_NAME='EMP';

# �ε��� ����
==> DROP �ϰ� �ٽ� �����Ѵ�.

# SYNONYM : ���Ǿ�

CREATE [PUBLIC] SYNONYM FOR ��ü

- PUBLIC �� DBA�� �� �� �ִ�
- ���Ǿ� ���� ���ѵ� �ο��޾ƾ� �� �� �ִ�.
SYSTEM�������� �����ؼ�
GRANT CREATE SYNONYM TO SCOTT

�����ͻ������� ��ȸ
SELECT * FROM USER_OBJECTS
WHERE OBJECT_TYPE='SYNONYM';

���Ǿ� ����
DROP SYNONYM ���Ǿ��;

DROP SYNONYM NOTE;

SELECT * FROM NOTE;

SELECT * FROM MYSTAR.MYSTARSTABLENOTE;


