-- �ܹ� �ּ�
/* ���� �ּ�
   ���� �� �ּ�*/
-- SQL(Structured Query Language)   
-- �л���� ���α׷�
--�л�  Entity ===> Table (Relation)
--
--CREATE TABLE ���̺��(
--�÷���1 �ڷ���(ũ��) ��������,
--�÷���2 �ڷ���(ũ��) ....,
--);
CREATE TABLE STUDENT(
   NO NUMBER(4) PRIMARY KEY, -- UNIQUE, NOT NULL
   NAME VARCHAR2(30) NOT NULL,
   TEL VARCHAR2(15) NOT NULL,
   ADDR VARCHAR2(100),
   INDATE DATE DEFAULT SYSDATE,
   SCLASS VARCHAR2(50),
   SROOM NUMBER(3)
);
desc student;

select * from student;

--INSERT INTO ���̺��(�÷���1, �÷���2, ...)
--VALUES(��1, ��2, ....);
--COMMIT;

INSERT INTO STUDENT(NO, NAME, TEL, ADDR,SCLASS, SROOM)
VALUES(1,'ȫ�浿','010-1111','���� ������','�ڹٹ�',101);

SELECT NO,NAME, TEL, SCLASS FROM STUDENT;
SELECT * FROM STUDENT;

INSERT INTO STUDENT(NO,NAME,TEL,ADDR)
VALUES(2,'��ö��','010-2222','���� ������');
COMMIT;

INSERT INTO STUDENT
VALUES(3,'�̿���','010-3333','���� ������',SYSDATE,'�����͹�',201);

ROLLBACK;
SELECT * FROM STUDENT;

--�ڹٹ� 2���߰�
INSERT INTO STUDENT
VALUES(4,'��ö��','010-4444','��õ ������', SYSDATE,'�ڹٹ�',101);

INSERT INTO STUDENT
VALUES(5,'������','010-5444','���� ������', SYSDATE,'�ڹٹ�',101);

--�����͹� 2���߰�
INSERT INTO STUDENT(NO,NAME,TEL)
VALUES(6,'�̹���','010-4545');

INSERT INTO STUDENT(NO,NAME,TEL, SCLASS, SROOM)
VALUES(7,'�̿���','010-4545','������',301);

COMMIT;

SELECT * FROM STUDENT ORDER BY SCLASS ASC;

SELECT * FROM STUDENT
WHERE SCLASS='�ڹٹ�';

SELECT * FROM STUDENT
WHERE SCLASS='������';

--���̺� ����
--DROP TABLE ���̺��
DROP TABLE STUDENT;

-- �б�
--���̺��: SCLASS
--�б޹�ȣ: SNO NUMBER(4)
--�б޸� : SNAME VARCHAR2(30)
--���ǹ�ȣ: SROOM NUMBER(3)

DROP TABLE SCLASS;

CREATE TABLE SCLASS(
  SNO NUMBER(4) PRIMARY KEY,
  SNAME VARCHAR2(30) NOT NULL,
  SROOM NUMBER(3)
);
DESC SCLASS;

-- �б������� 3�� INSERT�ϱ�
--10 �鿣�尳���ڹ� 101
--20 �����͹�   201
--30 �����չ�   301

INSERT INTO SCLASS(SNO,SNAME,SROOM)
VALUES(10,'�鿣�尳���ڹ�',101);
INSERT INTO SCLASS
VALUES(20,'�����͹�',201);
INSERT INTO SCLASS(SNAME,SROOM, SNO)
VALUES('�����չ�',301,30);

COMMIT;
SELECT * FROM SCLASS;

--UPDATE ���̺�� SET �÷���=��
--WHERE ������
UPDATE SCLASS SET SNAME='�鿣�尳���ڹ�'
WHERE SNO=10;

SELECT * FROM SCLASS;

ROLLBACK;
/*
�л����̺��: STUDENT
�й�:NO
�̸�: NAME
����ó: TEL
�ּ�: ADDR
�����: INDATE
�б޹�ȣ: SNO_FK
*/
DROP TABLE STUDENT;

CREATE TABLE STUDENT(
    NO NUMBER(4) PRIMARY KEY,
    NAME VARCHAR2(30) NOT NULL,
    TEL VARCHAR2(15) NOT NULL,
    ADDR VARCHAR2(100),
    INDATE DATE DEFAULT SYSDATE,
    SNO_FK NUMBER(4) REFERENCES SCLASS (SNO) -- �ܷ�Ű ����
);

DESC STUDENT;

-- �Ϸù�ȣ�� ������ �ִ� ��ü: SEQUENCE

--CREATE SEQUENCE ��������
--START WITH ���۰�
--INCREMENT BY ����ġ
--NOCACHE;

DROP SEQUENCE STUDENT_SEQ;

CREATE SEQUENCE STUDENT_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE;

INSERT INTO STUDENT(NO,NAME, TEL, ADDR, SNO_FK)
VALUES(STUDENT_SEQ.NEXTVAL,'ȫ�浿','1111','���� ������ �Ｚ��',10);

INSERT INTO STUDENT
VALUES(STUDENT_SEQ.NEXTVAL,'��ö��','2222','���� ������ ������', SYSDATE, 20);

SELECT * FROM STUDENT;

--10���б� 2~3�� �߰�
INSERT INTO STUDENT(NO,NAME, TEL, ADDR, SNO_FK)
VALUES(STUDENT_SEQ.NEXTVAL,'�̼���','2111','���� ���α� �����',10);

INSERT INTO STUDENT(NO,NAME, TEL, ADDR, SNO_FK)
VALUES(STUDENT_SEQ.NEXTVAL,'�̿���','3111','���� ������ ȭ�',10);

--20�� �б�  2~3�� �߰�
INSERT INTO STUDENT(NO,NAME, TEL, ADDR, SNO_FK)
VALUES(STUDENT_SEQ.NEXTVAL,'�����','3111','���� ���α� ��â��',20);
INSERT INTO STUDENT(NO,NAME, TEL, ADDR, SNO_FK)
VALUES(STUDENT_SEQ.NEXTVAL,'��ö��','4111','���� ������ ���굿',20);
--30�� �б� 1�� �߰�
INSERT INTO STUDENT(NO,NAME, TEL, ADDR, SNO_FK)
VALUES(STUDENT_SEQ.NEXTVAL,'�ֿ���','3111','���� ��걸 ���̵�',30);
COMMIT;
SELECT * FROM STUDENT ORDER BY SNO_FK ASC;
--DELETE FROM ���̺��
--WHERE ������;
DELETE FROM STUDENT WHERE NO=11;
ROLLBACK;
COMMIT;
INSERT INTO STUDENT(NO,NAME,TEL,SNO_FK)
VALUES(STUDENT_SEQ.NEXTVAL,'����','7878',10);

--���̺� 2���� �ϳ��� ���ļ� ��������
-- JOIN ��
--SELECT ���̺�1.�÷���1,...,���̺�2.�÷���...
--FROM ���̺��1 JOIN ���̺��2
--ON ���̺�1.PK = ���̺�2.FK;


SELECT STUDENT.NO, NAME, TEL,INDATE, SNAME, SROOM
FROM SCLASS JOIN STUDENT
ON SCLASS.SNO = STUDENT.SNO_FK ORDER BY SNAME ASC;

UPDATE SCLASS SET SROOM =401 WHERE SNO=20;
COMMIT;

-- �б޺� �ο��� �˾ƺ���
SELECT COUNT(*) FROM STUDENT;
SELECT SNO_FK, COUNT(*) FROM STUDENT
GROUP BY SNO_FK ORDER BY SNO_FK ASC;


SELECT * FROM EMP;

--������̺��� ���, �����, �޿�, 500�� �λ��Ų �޿��� ������ �����ּ���

SELECT EMPNO, ENAME, SAL, SAL+500 AS SAL_UP FROM EMP;
-- AS => ALIAS (��Ī)

��� ���̺��� ���, �����, �޿�, ���ʽ�(COMM)�� ������ ����ϼ���

SELECT EMPNO, ENAME, SAL, COMM, JOB FROM EMP;

���� = ���޿��� *12 + ���ʽ�

������̺��� ���, �����, �޿�, ���ʽ�, ������ �Բ� 1�� ������ �Բ� ����ϼ���

SELECT EMPNO, ENAME, SAL, COMM, JOB, SAL*12+COMM "����" FROM EMP;

NVL(�÷���, ��1)
�÷��� ���� NULL�� ��� ��1�� ġȯ�ϴ� �Լ�
SELECT EMPNO, ENAME, SAL, COMM, JOB, SAL *12 +NVL(COMM, 0) "��  ��" FROM EMP;

NVL2(�÷���, ��1, ��2)
�÷����� NULL�� �ƴ� ���� ��1�� ��ȯ�ϰ�, NULL�̸� ��2�� ��ȯ�ϴ� �Լ�

SELECT EMPNO, ENAME, MGR, JOB FROM EMP;

������̺��� ������(MGR)�� �ִ� ���� 1, ������0�� ����ϼ���

SELECT EMPNO,ENAME,MGR, NVL2(MGR,1,0) MGR2 FROM EMP;

