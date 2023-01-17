CREATE OR REPLACE PROCEDURE locinsINSERT(I IN NUMBER) IS
NUM NUMBER;
BEGIN
 SELECT COUNT(*) INTO NUM FROM locationcount WHERE location_id= I;
 IF NUM=0 THEN
  INSERT INTO locationcount VALUES(I,1);
 ELSE
  UPDATE locationcount SET countloc= countloc+1 WHERE location_ID= I;
 END IF;
END;
/

CREATE OR REPLACE PROCEDURE locinsupdate(O in number,I IN NUMBER) IS
NUM NUMBER;
BEGIN
 SELECT COUNT(*) INTO NUM FROM locationcount WHERE location_id= I;
 IF NUM=0 THEN
  INSERT INTO locationcount VALUES(I,1);
 ELSE
  UPDATE locationcount SET countloc= countloc+1 WHERE location_ID= I;
 END IF;
 SELECT countloc INTO NUM FROM locationcount WHERE location_id= O;
 IF NUM=1 THEN
  DELETE FROM location WHERE location_ID=O;
 ELSE
  UPDATE locationcount SET countloc= countloc-1 WHERE location_ID= O;
 END IF;
END;
/

CREATE OR REPLACE PROCEDURE locinsdelete(O in number) IS
NUM NUMBER;
BEGIN
 SELECT countloc INTO NUM FROM locationcount WHERE location_id= O;
 IF NUM=1 THEN
  DELETE FROM location WHERE location_ID=O;
 ELSE
  UPDATE locationcount SET countloc= countloc-1 WHERE location_ID= O;
 END IF;
end;
/

create or replace trigger locinschange
after insert or delete or update
on institute
for each row
declare
O NUMBER;
I NUMBER;
BEGIN
 O:= :OLD.location_ID;
 I:= :NEW.location_ID;
 IF O IS NULL THEN
    locinsinsert(I);
 ELSIF I IS NULL THEN
  locinsdelete(O);
 ELSIF O<>I THEN
  locinsupdate(O,I);
 END IF;
END;
/

create or replace 
function threeLoc(ct in varchar2, st in varchar2, cn in varchar2) 
return number is
locid number(7);
begin
if st is null then 
select location_id into locid
from location
where city = ct and country = cn;
else
select location_id into locid
from location
where city = ct and country = cn and state= st;
end if;
return locid;
exception
  WHEN NO_DATA_FOUND THEN
    return 5200000;
  when others then
    return 5300000;
end;
/