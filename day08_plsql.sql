--day08_plsql.sql
--# ��Ű��
--���� ���� ���ν���, �Լ�, Ŀ�� ���� �ϳ��� ��Ű���� ���� ������ �� �ִ�.
--- �����
--- ���� (package body)

-- ��Ű�� �����
create or replace package empInfo as
procedure allEmp;
procedure allSal;
end empInfo;

-- ��Ű�� ���� ����
create or replace package body empInfo as
    procedure allEmp
    is
    cursor empCr is
    select empno, ename, hiredate from emp
    order by 3;
    begin
    for k in empCr loop
        dbms_output.put_line(k.empno||lpad(k.ename,16,' ')||lpad(k.hiredate,16,' '));
    end loop;
    exception
        when others then
        dbms_output.put_line(SQLERRM||'������ �߻���');
    end allEmp;
    -- allSal�� ��ü �޿� �հ�, �����, �޿����, �ִ�޿�, �ּұ޿��� ������ ����ϴ� ���ν���
    procedure allSal
    is
    begin
        dbms_output.put_line('�޿�����'||lpad('�����',10,' ')||lpad('��ձ޿�',10,' ')||
            lpad('�ִ�޿�',10,' ')||lpad('�ּұ޿�',10,' '));
        for k in (select sum(sal) sm, count(empno) cnt, round(avg(sal)) av,
        max(sal) mx, min(sal) mn from emp) loop
            dbms_output.put_line(k.sm||lpad(k.cnt,10,' ')||lpad(k.av,10,' ')||
            lpad(k.mx,10,' ')||lpad(k.mn,10,' '));
        end loop;
    end  allSal;    
end empInfo;
/

set serveroutput on

exec empInfo.allEmp;
exec empInfo.allSal;
--# TRIGGER
--INSERT, UPDATE, DELETE ���� ����ɶ� ���������� ����Ǵ� ������ ���ν���

CREATE OR REPLACE TRIGGER TRG_DEPT
BEFORE
UPDATE ON DEPT
FOR EACH ROW
DECLARE
MSG VARCHAR2(30);
BEGIN
    MSG:='HI';
    DBMS_OUTPUT.PUT_LINE('���� �� �÷���: '|| :OLD.DNAME);
    DBMS_OUTPUT.PUT_LINE('���� �� �÷���: '|| :NEW.DNAME);
END;
/
SELECT * FROM DEPT;
UPDATE DEPT SET DNAME='���' WHERE DEPTNO=40;
ROLLBACK;

-- Ʈ���� ��Ȱ��ȭ
ALTER TRIGGER TRG_DEPT DISABLE;

-- Ʈ���� Ȱ��ȭ
ALTER TRIGGER TRG_DEPT ENABLE;

-- �����ͻ������� ��ȸ
SELECT * FROM USER_TRIGGERS WHERE TRIGGER_NAME='TRG_DEPT';

-- Ʈ���� ����
DROP TRIGGER TRG_DEPT;

--EMP ���̺� �����Ͱ� INSERT�ǰų� UPDATE�� ��� (BEFORE)
--��ü ������� ��ձ޿��� ����ϴ� Ʈ���Ÿ� �ۼ��ϼ���.

CREATE OR REPLACE TRIGGER TRG_EMP_AVG
BEFORE INSERT OR UPDATE ON EMP
--FOR EACH ROW
--WHEN :NEW.EMPNO >0
DECLARE
AVG_SAL NUMBER(10);
BEGIN
    SELECT ROUND(AVG(SAL),2) INTO AVG_SAL
    FROM EMP;
    DBMS_OUTPUT.PUT_LINE('��ձ޿�: '||AVG_SAL);
END;
/
INSERT INTO EMP(EMPNO,ENAME,DEPTNO,SAL)
VALUES(9002,'PETER2',20,3000);
ROLLBACK;

UPDATE EMP SET SAL=SAL*1.1 WHERE EMPNO=7788;

SELECT AVG(SAL) FROM EMP;

--[Ʈ���� �ǽ� 1] �� Ʈ����
--�԰� ���̺� ��ǰ�� �԰�� ���
--��ǰ ���̺� ��ǰ ���������� �ڵ����� ����Ǵ� 
--Ʈ���Ÿ� �ۼ��غ��ô�.

CREATE TABLE MYPRODUCT(
    PCODE CHAR(6) PRIMARY KEY,
    PNAME VARCHAR2(20) NOT NULL,
    PCOMPANY VARCHAR2(20),
    PRICE NUMBER(8),
    PQTY NUMBER DEFAULT 0
);
DESC MYPRODUCT;
--'A001', 'A002'
CREATE SEQUENCE MYPRODUCT_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE;
INSERT INTO MYPRODUCT
VALUES('A00'||MYPRODUCT_SEQ.NEXTVAL,'��Ʈ��','A��',800000,10);

INSERT INTO MYPRODUCT
VALUES('A00'||MYPRODUCT_SEQ.NEXTVAL,'������','B��',100000,20);

INSERT INTO MYPRODUCT
VALUES('A00'||MYPRODUCT_SEQ.NEXTVAL,'ű����','C��',70000,30);
commit;

select * from myproduct;
-- �԰� ���̺�
create table myinput(
    incode number primary key, --�԰��ȣ
    pcode_fk char(6) references myproduct (pcode), --�԰��ǰ�ڵ�
    indate date default sysdate, --�԰���
    inqty number(6), --�԰����
    inprice number(8) --�԰���
);
create sequence myinput_seq nocache;

--�԰� ���̺� ��ǰ�� ������
--��ǰ ���̺��� ���������� �����ϴ� Ʈ���Ÿ� �ۼ��ϼ���


create or replace trigger trg_input_product
after
insert on myinput
for each row
declare 
    cnt number := :new.inqty;
    code char(6) := :new.pcode_fk;
begin
    update myproduct set pqty = pqty+cnt where pcode = code;
    DBMS_OUTPUT.PUT_LINE(CODE||'��ǰ�� �߰��� '||CNT||'�� ����');
end;
/
-- �԰� ���̺� A001��ǰ�� 10�� 500000���� INSERT�ϱ�

SELECT * FROM MYPRODUCT;
INSERT INTO MYINPUT
VALUES(MYINPUT_SEQ.NEXTVAL,'A002',SYSDATE, 8,50000);

--�԰� ���̺��� ������ ����� ���-UPDATE���� ����� ��
--��ǰ ���̺��� ������ �����ϴ� Ʈ���Ÿ� �ۼ��ϼ���
CREATE OR REPLACE TRIGGER trg_input_product2
AFTER UPDATE ON MYINPUT
FOR EACH ROW
DECLARE
GAP NUMBER;
BEGIN
--         10           20 => -10
--         20           10 => +10
   GAP:=:NEW.INQTY-:OLD.INQTY;
   UPDATE MYPRODUCT SET PQTY=PQTY+GAP WHERE PCODE =:NEW.PCODE_FK;
   DBMS_OUTPUT.PUT_LINE('NEW: '||:NEW.INQTY||', OLD: '||:OLD.INQTY||', GAP: '||GAP);
END;
/
SELECT * FROM MYPRODUCT;
SELECT * FROM MYINPUT;
UPDATE MYINPUT SET INQTY=10 WHERE INCODE=1;
UPDATE MYINPUT SET INQTY=18 WHERE INCODE=2;

SELECT * FROM USER_TRIGGERS;
SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='TRIGGER';\

--[Ʈ���� �ǽ�2] - ���� Ʈ����
--EMP ���̺� ���Ի���� ������(INSERT) �α� ����� ������
--� DML������ �����ߴ���, DML�� ����� ������ �ð�, USER �����͸�
--EMP_LOG���̺� �������.
CREATE TABLE EMP_LOG(
    LOG_CODE NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(30),
    LOG_DATE DATE DEFAULT SYSDATE,
    BEHAVIOR VARCHAR2(20)
);
CREATE SEQUENCE EMP_LOG_SEQ NOCACHE;

CREATE OR REPLACE TRIGGER TRG_EMP_LOG
BEFORE INSERT ON EMP
BEGIN
    IF ( TO_CHAR(SYSDATE,'DY') IN ('FRI','SAT','SUN')) THEN
        RAISE_APPLICATION_ERROR(-20001,'��,��,�Ͽ��� �Է��۾��� �� �� �����ϴ�');
    ELSE
        INSERT INTO EMP_LOG VALUES(EMP_LOG_SEQ.NEXTVAL,USER,SYSDATE,'INSERT');
    END IF;
END;
/
--EMP�� ���,�����, �޿�,�μ���ȣ�� ���� INSERT�ϼ���
INSERT INTO EMP(EMPNO, ENAME, SAL, DEPTNO)
VALUES(9010,'THOMAS',3300,20);

SELECT * FROM EMP_LOG;

