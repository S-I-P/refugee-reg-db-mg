create or replace 
TRIGGER DOCPASS
AFTER INSERT
ON DOCTOR_NURSE_OFFICER
DECLARE
IDENTITY NUMBER;
BEGIN
    SELECT MAX(DOCTOR_NURSE_OFFICER_ID) INTO IDENTITY
    FROM DOCTOR_NURSE_OFFICER;
    INSERT INTO PASS VALUES(IDENTITY,(SELECT DBMS_RANDOM.STRING('P',8) FROM DUAL));
END;
/

create or replace 
procedure locinseduocc(ct in varchar2, st in varchar2, cn in varchar2,insn in varchar2,
rid in number, ey in number , d in varchar2 , o in varchar2 , s in varchar2,msg out number
,insid out number) is
locid number;
begin
locid:= threeloc(ct,st,cn);
if locid = 5200000 then
  insert into location values(location_seq.nextval,ct,st,cn);
  select max(location_id) into locid from location;
end if;
if locid <> 5300000 then
  insid := threeins(locid,insn);
  if insid = 6300000 then
    insert into institute values(institute_seq.nextval,insn,locid);
    select max(institute_id) into insid from institute;
  end if;
else
  msg:= 0; 
end if;

if insid <> 6400000 then
  insert into educational_occupational_info values(rid,insid,ey,d,o,s);
  msg:= 1;
else
  msg:= 0;
end if; 

end;
/

create or replace 
procedure uplocins(ct in varchar2, st in varchar2, cn in varchar2,insn in varchar2,msg out number,insid out number) is
locid number;
begin
locid:= threeloc(ct,st,cn);
if locid = 5200000 then
  insert into location values(location_seq.nextval,ct,st,cn);
  select max(location_id) into locid from location;
end if;
if locid <> 5300000 then
  insid := threeins(locid,insn);
  if insid = 6300000 then
    insert into institute values(institute_seq.nextval,insn,locid);
    select max(institute_id) into insid from institute;
  end if;
else
  msg:= 0;
end if;

if insid <> 6400000 then
  msg:= 1;
else
  msg:= 0;
end if;
end;
/