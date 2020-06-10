--add set echo and spool command here
set echo on
spool week8_SQLBasic_PartA_output.txt
/*
Databases Week 8 Tutorial
week8_SQLBasic_PartA.sql

student id: 29262674
student name: Aqeel Ahlam
last modified date: 16/05/2020

*/

/* A1. List ALL units AND their details. */

select * from uni.unit;



/* A2. List all students' details who have the surname 'Smith'.*/

select *
from uni.student
where studlname = 'Smith';

/* A3. List the student's surname, firstname and address for those students 
who have a surname starting with the letter 'S' and firstname contains the letter 'i'*/

select studlname,studfname,studaddress
from uni.student
where studlname like 'S%' and studfname like '%i%';

/* A4. List the unit code of all units that are offered in semester 1 of 2014. */

select unitcode
from uni.offering
where semester = '1' and to_char(ofyear,'yyyy') = '2014';
  
/* A5. Assuming that a unit code is created based on the following rules:
a. The first three letters represent faculty abbreviation, eg FIT for the Faculty of Information Technology.
b. The first digit of the number following the letter represents the year level. 
   For example, FIT2094 is a unit code from Faculty of IT (FIT) and the number 2 refers to a second year unit.

List the unit details of all first year units in the Faculty of Information Technology.*/

select *
from uni.unit
where unitcode like 'FIT1%';



/* A6. List the unit code and semester of all units that were offered in either semester 1 or summer of 2013.*/

select unitcode,semester
from uni.offering
where (semester ='1' or semester = '3') and to_char(ofyear,'yyyy') = '2013';



/* A7. List the student number, mark, unit code and semester for those tudents who have passed any unit in semester 1 of 2013. */

select studid,mark,unitcode,semester
from UNI.enrolment
where mark >= 50 and to_char(ofyear,'yyyy')='2013' and semester = '1';

spool off
set echo off

