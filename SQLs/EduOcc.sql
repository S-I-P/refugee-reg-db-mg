CREATE OR REPLACE PROCEDURE EDUOCCINSERT(I IN NUMBER) IS
NUM NUMBER;
BEGIN
 SELECT COUNT(*) INTO NUM FROM inscount WHERE institute_id= I;
 IF NUM=0 THEN
  INSERT INTO INSCOUNT VALUES(I,1);
 ELSE
  UPDATE INSCOUNT SET TOTAL_REFUGEE= TOTAL_REFUGEE+1 WHERE INSTITUTE_ID= I;
 END IF;
END;
/

CREATE OR REPLACE PROCEDURE EDUOCCUPDATE(O IN NUMBER,I IN NUMBER) IS
NUM NUMBER;
BEGIN
 SELECT TOTAL_REFUGEE INTO NUM FROM inscount WHERE institute_id= O;
 IF NUM=1 THEN
  DELETE FROM INSTITUTE WHERE INSTITUTE_ID=O;
 ELSE
  UPDATE INSCOUNT SET TOTAL_REFUGEE= TOTAL_REFUGEE-1 WHERE INSTITUTE_ID= O;
 END IF;
 SELECT COUNT(*) INTO NUM FROM inscount WHERE institute_id= I;
 IF NUM=0 THEN
  INSERT INTO INSCOUNT VALUES(I,1);
 ELSE
  UPDATE INSCOUNT SET TOTAL_REFUGEE= TOTAL_REFUGEE+1 WHERE INSTITUTE_ID= I;
 END IF;
END;
/

CREATE OR REPLACE PROCEDURE EDUOCCDELETE(O IN NUMBER) IS
NUM NUMBER;
BEGIN
 SELECT TOTAL_REFUGEE INTO NUM FROM inscount WHERE institute_id= O;
 IF NUM=1 THEN
  DELETE FROM INSTITUTE WHERE INSTITUTE_ID=O;
 ELSE
  UPDATE INSCOUNT SET TOTAL_REFUGEE= TOTAL_REFUGEE-1 WHERE INSTITUTE_ID= O;
 END IF;
END;
/

create or replace trigger eduocc
after insert or delete or update
on educational_occupational_info
for each row
declare
O NUMBER;
I NUMBER;
BEGIN
 O:= :OLD.INSTITUTE_ID;
 I:= :NEW.INSTITUTE_ID;
 IF O IS NULL THEN
  eduoccinsert(I);
 ELSIF I IS NULL THEN
  eduoccdelete(O);
 ELSIF O<>I THEN
  eduoccupdate(O,I);
 END IF;
END;
/

create or replace 
function threeIns(locid in number, n in varchar2) 
return number is
insid number(7);
begin
select institute_id into insid
from institute
where institute_name= n and location_id= locid;
return insid;
exception
  WHEN NO_DATA_FOUND THEN
    return 6300000;
  when others then
    return 6400000;
end;
/