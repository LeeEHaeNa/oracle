create table [��Ű��.]���̺��(
   �÷��� �ڷ��� default �⺻��  constraint ���������̸� ������������,
   ...
);
# PRIMARY KEY
-- �÷����ؿ��� �����ϱ�
CREATE TABLE TEST_TAB1(
    NO NUMBER(2) CONSTRAINT TEST_TAB1_NO_PK PRIMARY KEY,
    NAME VARCHAR2(20)
);

DESC TEST_TAB1;

�����ͻ������� ��ȸ

SELECT *
FROM USER_CONSTRAINTS WHERE TABLE_NAME='TEST_TAB1';


INSERT INTO TEST_TAB1(NO,NAME)
VALUES(2,NULL);

SELECT * FROM TEST_TAB1;
COMMIT;

-- ���̺� ���ؿ��� PK����
CREATE TABLE TEST_TAB2(
    NO NUMBER(2),
    NAME VARCHAR2(20),
    CONSTRAINT TEST_TAB2_NO_PK PRIMARY KEY (NO)
);
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='TEST_TAB2';

# �������� ����
ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ� [CASCADE];
 - CASCADE �� �ָ� ��� �������� ���������� �Բ� �����ȴ�.
 
TEST_TAB2�� pk���������� �����ϼ���
ALTER TABLE TEST_TAB2 DROP CONSTRAINT TEST_TAB2_NO_PK;

#�������� �߰�
ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� ������������ (�÷���)

TEST_TAB2�� �ٽ� pk���������� �߰��ϼ���

ALTER TABLE TEST_TAB2 ADD CONSTRAINT TEST_TAB2_PK PRIMARY KEY (NO);

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='TEST_TAB2';

DESC TEMP;





# �������Ǹ� ����
ALTER TABLE ���̺�� RENAME CONSTRAINT OLD�� TO NEW��;
ALTER TABLE TEST_TAB2 RENAME CONSTRAINT TEST_TAB2_PK TO TEST_TAB2_NO_PK;

# Foreign Key ��������
�θ� ���̺�(MASTER)�� PK�� �ڽ����̺�(DETAIL)���� FK�� ����
==> FK�� DETAIL���̺��� �����ؾ� ��
MASTER ���̺��� PK, UK �� ���ǵ� �÷��� FK�� ������ �� �ִ�.
�÷��� �ڷ����� ��ġ�ؾ� �Ѵ�. ũ��� ��ġ���� �ʾƵ� �������
ON DELETE CASCADE �ɼ��� �ָ� MASTER ���̺��� ���ڵ尡 ������ ��
DETAIL ���̺��� ���ڵ嵵 ���� �����ȴ�.

CREATE TABLE DEPT_TAB(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(15),
    LOC VARCHAR2(15),
    CONSTRAINT DEPT_TAB_DEPTNO_PK PRIMARY KEY (DEPTNO)
);
CREATE TABLE EMP_TAB(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(20),
    JOB VARCHAR2(10),
    MGR  NUMBER(4) CONSTRAINT EMP_TAB_MGR_FK REFERENCES EMP_TAB(EMPNO),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2),
    -- ���̺� ���ؿ��� FK�ֱ�
    CONSTRAINT EMP_TAB_DEPTNO_FK FOREIGN KEY (DEPTNO)
    REFERENCES DEPT_TAB (DEPTNO),
    CONSTRAINT EMP_TAB_EMPNO_PK PRIMARY KEY (EMPNO)
);

�μ����� INSERT�ϱ�
10 ��ȹ�� ����
20 �λ�� ��õ

INSERT INTO DEPT_TAB VALUES(10,'��ȹ��','����');
INSERT INTO DEPT_TAB VALUES(20,'�λ��','��õ');
COMMIT;

SELECT * FROM DEPT_TAB;

������� INSERT�ϱ�
INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,DEPTNO)
VALUES(1000,'ȫ�浿','��ȹ',NULL, 10);

INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,DEPTNO)
VALUES(1002,'�̿���','�λ�',NULL, 20);

SELECT * FROM EMP_TAB;
COMMIT;

INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,DEPTNO)
VALUES(1003,'�����','�빫',1002, 20);
INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,DEPTNO)
VALUES(1004,'��浿','�繫',1001, 20);

DEPT_TAB���� ��ȹ�θ� �����غ���
DELETE FROM DEPT_TAB WHERE DEPTNO=10;
==> �ڽ� ���ڵ尡 ���� ���� �θ� ���̺��� ���ڵ带 ������ �� ����.

ȫ�浿�� 20���μ��� �μ��̵� �ϼ���
UPDATE EMP_TAB SET DEPTNO=20 WHERE ENAME='ȫ�浿';

SELECT * FROM EMP_TAB;
DELETE FROM DEPT_TAB WHERE DEPTNO=10;
SELECT * FROM DEPT_TAB;


�θ����̺�
BOARD_TAB
NO NUMBER(8)  PK
USERID VARCHAR2(20) NOT NULL,
TITLE VARCHAR2(100),
CONTENT VARCHAR2(1000)
WDATE DATE �⺻�� SYSDATE

�ڽ����̺�
REPLY_TAB
RNO NUMBER(8) PK
CONTENT VARCHAR2(300)
USERID VARCHAR2(20) not null,
NO_FK NUMBER(8)==> FK�� �ֵ� ON DELETE CASCADE �ɼ��� ����ϱ�

create table board_tab(
    no number(8) primary key,
    userid varchar2(20) not null,
    title varchar2(100),
    content varchar2(1000),
    wdate date default sysdate
);
create table reply_tab(
    rno number(8) primary key,
    content varchar2(300),
    userid varchar2(20) not null,
    no_fk number(8) references board_tab(no) on delete cascade
);

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='REPLY_TAB';

INSERT INTO BOARD_TAB VALUES(2,'CHOI','���� �ݰ�����','�ȳ�2',SYSDATE);
COMMIT;

SELECT * FROM BOARD_TAB;
��۴ޱ�
INSERT INTO REPLY_TAB VALUES(3,'�ȳ�???','KIM',1);

COMMIT;
SELECT * FROM REPLY_TAB;

BOARD_TAB�� REPLY_TAB�� JOIN�ؼ� ���� ����ϼ���

SELECT B.NO, B.TITLE, B.USERID, B.WDATE, R.CONTENT, R.USERID
FROM BOARD_TAB B JOIN REPLY_TAB R
ON B.NO = R.NO_FK;

DELETE FROM BOARD_TAB WHERE NO=2;
-- ON DELETE CASCADE �ɼ��� �־��� ������ �θ���� �����ϸ� �ڽı۵� �Բ� �����ȴ�.

# UNIQUE KEY
�÷����� ����
CREATE TABLE UNI_TAB1(
    DEPTNO NUMBER(2) CONSTRAINT UNI_TAB1_DEPTNO_UK UNIQUE,
    DNAME CHAR(20),
    LOC CHAR(10)
);
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='UNI_TAB1';
INSERT INTO UNI_TAB1 VALUES(NULL,'������4','����');
SELECT * FROM UNI_TAB1;
COMMIT;

���̺� ���� ����
UNI_TAB2
CREATE TABLE UNI_TAB2(
    DEPTNO NUMBER(2),
    DNAME CHAR(20),
    LOC CHAR(10),
    CONSTRAINT UNI_TAB2_DEPTNO_UK UNIQUE (DEPTNO)
);

# NOT NULL �������� -üũ���������� ����
- NOT NULL ���������� �÷� ���ؿ����� ������ �� �ִ�.
CREATE TABLE NN_TAB(
    DEPTNO NUMBER(2) CONSTRAINT NN_TAB_DEPTNO_NN NOT NULL,
    DNAME CHAR(20) NOT NULL,
    LOC CHAR(10)
    -- CONSTRAINT LOC_NN NOT NULL (LOC) [X]
);

# CHECK ��������
- ���� �����ؾ��ϴ� ������ �����Ѵ�

CREATE TABLE CK_TAB(
    DEPTNO NUMBER(2) CONSTRAINT CK_TAB_DEPTNO_CK CHECK ( DEPTNO IN (10,20,30,40)),
    DNAME CHAR(20)
);
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='CK_TAB';
INSERT INTO CK_TAB VALUES(50,'BAA'); --[X]

���̺� ���ؿ��� CK_TAB2 LOC �� '����','����' ���� ������ 

CREATE TABLE CK_TAB2(
    DEPTNO NUMBER(2),
    DNAME CHAR(20),
    LOC CHAR(10),
    PRIMARY KEY (DEPTNO),
    CHECK (LOC IN ('����','����'))
);
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='CK_TAB2';

ZIPCODE ���̺� �����
create table zipcode(
    post1 char(3),
    post2 char(3),
    addr varchar2(60) constraint zipcode_addr_nn not null,
    constraint zipcode_post_pk primary key(post1,post2)
);
desc zipcode;

MEMBER_TAB ���̺� �����
create table member_tab(
    id number(4),
    name varchar2(10) constraint member_tab_name_nn not null,
    gender char(1),
    jumin1 char(6),
    jumin2 char(7),
    tel varchar2(15),
    post1 char(3),
    post2 char(3),
    addr  varchar2(60),
    constraint member_tab_id_pk primary key (id),
    constraint member_tab_gender_ck check ( gender in ('F','M')),
    constraint member_tab_jumin_uk unique (jumin1, jumin2),
    constraint member_tab_post_fk foreign key (post1, post2)
    references zipcode(post1, post2)
);
desc member_tab;

select * from user_constraints where table_name=upper('member_tab');

drop table member_tab5;

# subquery �� �̿��� ���̺� ����

--��� ���̺��� 30�� �μ��� �ٹ��ϴ� ����� ������ �����Ͽ�
--         EMP_30 ���̺��� �����Ͽ���. �� ���� ���,�̸�,����,�Ի�����,
--		  �޿�,���ʽ��� �����Ѵ�.

CREATE TABLE EMP_30(ENO, ENAME, JOB, HDATE, SAL,COMM)
AS
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, COMM 
FROM EMP WHERE DEPTNO=30;

SELECT * FROM EMP_30;
SELECT * FROM EMP WHERE DEPTNO=30;

-- [����1]
--		EMP���̺��� �μ����� �ο���,��� �޿�, �޿��� ��, �ּ� �޿�,
--		�ִ� �޿��� �����ϴ� EMP_DEPTNO ���̺��� �����϶�.
DROP TABLE EMP_DEPTNO;
CREATE TABLE EMP_DEPTNO
AS
SELECT  DEPTNO, COUNT(EMPNO) CNT, ROUND(AVG(SAL)) AVG_SAL, 
SUM(SAL) SUM_SAL, MIN(SAL) MIN_SAL, MAX(SAL) MAX_SAL
FROM EMP GROUP BY DEPTNO;

SELECT * FROM EMP_DEPTNO;
	
--	[����2]	EMP���̺��� ���,�̸�,����,�Ի�����,�μ���ȣ�� �����ϴ�
--		EMP_TEMP ���̺��� �����ϴµ� �ڷ�� �������� �ʰ� ������
--		�����Ͽ���
CREATE TABLE EMP_TEMP
AS
SELECT EMPNO, ENAME, JOB, HIREDATE, DEPTNO
FROM EMP WHERE 1=2;

SELECT * FROM EMP_TEMP;

--#DDL
--CREATE, DROP, ALTER, RENAME, TRUNCATE

--# �÷� �߰� ���� ����
ALTER TABLE ���̺�� ADD �߰����÷����� [DEFAULT ��]
ALTER TABLE ���̺�� MODIFY �������÷�����
ALTER TABLE ���̺�� RENAME COLUMN OLD_NAME TO NEW_NAME;
ALTER TABLE ���̺�� DROP COLUMN �������÷���

CREATE TABLE TEMP(
NO NUMBER(4)
);
DESC TEMP;

TEMP���̺� NAME�÷��� �߰��ϼ���
TEMP ���̺� INDATE�߰��ϵ� �⺻���� SYSDATE

ALTER TABLE TEMP ADD NAME VARCHAR2(20) NOT NULL;
ALTER TABLE TEMP ADD INDATE DATE DEFAULT SYSDATE;

PRODUCTS ���̺� PROD_DESC �÷��� �߰��ϵ� NOT NULL ���������� �ּ���
ALTER TABLE PRODUCTS ADD PROD_DESC VARCHAR2(1000);
SELECT * FROM PRODUCTS;

TEMP���̺��� NO �÷��� �ڷ����� CHAR(4)�� �����ϼ���
ALTER TABLE TEMP MODIFY NO CHAR(4);
DESC TEMP;

TEMP ���̺��� NO �÷����� NUM ���� �����ϼ���
ALTER TABLE TEMP RENAME COLUMN NO TO NUM;

TEMP ���̺��� INDATE �÷��� �����ϼ���
alter table temp DROP COLUMN INDATE;
DESC TEMP;

ALTER TABLE PRODUCTS DROP COLUMN PROD_DESC;
DESC PRODUCTS;

TEMP ���̺��� NUM �÷��� PRIMARY KEY ���������� �߰��ϼ���
ALTER TABLE TEMP ADD CONSTRAINT TEMP_NUM_PK PRIMARY KEY (NUM);

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='TEMP';
INSERT INTO TEMP VALUES(1,'AAA');
SELECT * FROM TEMP;

�������� ��Ȱ��ȭ
ALTER TABLE ���̺�� DISABLE CONSTRAINT �������Ǹ� [CASCADE];

TEMP�� PK���������� ��Ȱ��ȭ ��Ű����

ALTER TABLE TEMP DISABLE CONSTRAINT TEMP_NUM_PK;

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='TEMP';

DELETE FROM TEMP;
COMMIT;

�������� Ȱ��ȭ
ALTER TABLE ���̺�� ENABLE CONSTRAINT �������Ǹ� [CASCADE];

# ��ü �̸� ����
RENAME OLD_NAME TO NEW_NAME;

TEMP ���̺���� TEST���̺�� �����ϼ���

RENAME TEMP TO TEST_TEMP;

SELECT * FROM TAB;

# ���̺� ����
DROP TABLE ���̺�� [CASCADE CONSTRAINT];

DROP TABLE TEST_TEMP CASCADE CONSTRAINT;

TEMP�� PK���������� Ȱ��ȭ ��Ű����
ALTER TABLE TEMP ENABLE CONSTRAINT TEMP_NUM_PK;

DROP TABLE TEST PURGE;

���̺� ��� ������ �����Ͱ� �����ȴ�.
���� �ε����� ��� �����ȴ�.
VIEW, SYNONYM ������ �����ͻ������� ���������� ����ϸ� ���� �߻��Ѵ�
