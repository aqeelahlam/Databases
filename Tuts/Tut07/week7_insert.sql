set echo on
spool week7_insert_output.txt

truncate table enrolment;
truncate table student;
truncate table unit;

-- 7.3.1 Basic Insert Statement

insert into student values (11111111,'Bloggs','Fred','01-Jan-1990');
insert into student values (11111112,'Nice','Nick','10-Oct-1994');
insert into student values (11111113,'Wheat','Wendy','05-May-1990');
insert into student values (11111114, 'Sheen','Cindy','25-Dec-1996');
-- If you want to see the records
--select * from student;

insert into unit values ('FIT9999','FIT Last Unit');
insert into unit values ('FIT5132','Introduction to Databases');
insert into unit values ('FIT5016','Project');
insert into unit values ('FIT5111','Students Life');

--select * from unit;

insert into enrolment values (11111111, 'FIT5132',2013,'1',35,'N');
insert into enrolment values (11111111, 'FIT5016',2013,'1',61,'C');
insert into enrolment values (11111111, 'FIT5132',2013,'2',42,'N');
insert into enrolment values (11111111, 'FIT5111',2013,'2',76,'D');
insert into enrolment values (11111111, 'FIT5132',2014,'2',null,null);
insert into enrolment values (11111112, 'FIT5132',2013,'2',83,'HD');
insert into enrolment values (11111112, 'FIT5111',2013,'2',79,'D');
insert into enrolment values (11111113, 'FIT5132',2014,'2',null,null);
insert into enrolment values (11111113, 'FIT5111',2014,'2',null,null);
insert into enrolment values (11111114, 'FIT5111',2014,'2',null,null);

--select * from enrolment

COMMIT;

-- 7.3.2 Using SEQUENCEs in an INSERT statement
DROP SEQUENCE student_seq;

CREATE SEQUENCE student_seq START WITH 11111115 INCREMENT BY 1;

INSERT INTO student VALUES (student_seq.NEXTVAL,'Mouse','Mickey','15-Oct-1997');
--select * from student;

INSERT INTO enrolment VALUES (student_seq.CURRVAL, 'FIT5132',2016,'2',null,null);
--select * from enrolment;

COMMIT;


-- 7.3.3 Advance INSERT

INSERT INTO student VALUES (student_seq.NEXTVAL, 'Ahlam','Aqeel','15-Oct-1997');

INSERT INTO enrolment VALUES (student_seq.CURRVAL,
    (SELECT unit_code FROM unit WHERE unit_name = 'Introduction to Databases'),
    2016,'2',null,null);
    
--select * from enrolment;
    
COMMIT;

-- 7.3.4 Creating a table and inserting data as a single SQL statement
DROP TABLE FIT5111_STUDENT CASCADE CONSTRAINTS PURGE;

CREATE TABLE FIT5111_STUDENT
    AS SELECT * 
    FROM enrolment
    WHERE unit_code = 'FIT5111';
    
--This is to check if the table exists
SELECT table_name from user_tables;

SELECT * FROM FIT5111_STUDENT;

spool off
set echo off




