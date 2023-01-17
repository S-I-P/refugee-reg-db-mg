create user user_refDbMg identified by pass_refDbMg;
grant all privileges to user_refDbMg;
connect user_refDbMg/pass_refDbMg;
@/home/sql/tableCreate.sql
@/home/sql/EduOcc.sql
@/home/sql/location.sql
@/home/sql/OtherProcTrig.sql