SET ECHO ON 
SPOOL week7_altertable_output.txt

alter TABLE unit
    ADD (unit_credit_points NUMBER(2,0) DEFAULT 6);
    
INSERT INTO unit VALUES ('FIT2004','Algorithms and Data Structures', 6);

select * from unit;

commit;

spool off
set echo off