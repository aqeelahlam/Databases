--****PLEASE ENTER YOUR DETAILS BELOW****
--Q1b-tds-dm.sql
--Student ID:
--Student Name:
--Tutorial No: 

SET SERVEROUTPUT ON;


/* Comments for your marker:




*/


/*
1b(i) Create a sequence 
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE

DROP SEQUENCE OFFENCE_SEQ;

CREATE SEQUENCE OFFENCE_SEQ START WITH 100 INCREMENT BY 1;


/*
INSERT INTO student VALUES (offence_seq.NEXTVAL,'Mouse','Mickey','15-Oct-1997');
--select * from student;

INSERT INTO enrolment VALUES (offence_seq.CURRVAL, 'FIT5132',2016,'2',null,null);
--select * from enrolment;

COMMIT;
*/

/*
1b(ii) Take the necessary steps in the database to record data.
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE

--10-Aug-2019 08:04 AM booked for traffic offence “Blood alcohol charge” by police officer Dolley Hedling (10000011)

INSERT INTO OFFENCE VALUES (OFFENCE_SEQ.NEXTVAL,    
    TO_DATE('10-Aug-2019 08:04 AM', 'DD/MON/YYYY HH:MI AM'),
    'Mockingbird Way, Richmond South, 3121',
    (SELECT DEM_CODE FROM DEMERIT WHERE DEM_DESCRIPTION = 'Blood alcohol charge'),
    10000011,
    '100389',
    'JYA3HHE05RA070562');

--On 16-Oct-2019 9:00 PM booked for traffic offence “Level crossing offence” by police officer Geoff Kilmartin (10000015)

INSERT INTO OFFENCE VALUES (OFFENCE_SEQ.NEXTVAL,    
    TO_DATE('16-Oct-2019 9:00 PM', 'DD/MON/YYYY HH:MI AM'),
    'Packers Pass, Richmond South, 3121',
    (SELECT DEM_CODE FROM DEMERIT WHERE DEM_DESCRIPTION = 'Level crossing offence'),
    10000015,
    '100389',
    'JYA3HHE05RA070562');

--On 7-Jan-2020 7:07 AM booked for traffic offences “Exceeding the speed limit by 25 km/h or more” by police officer Geoff Kilmartin (10000015)
INSERT INTO OFFENCE VALUES (OFFENCE_SEQ.NEXTVAL,    
    TO_DATE('7-Jan-2020 7:07 AM', 'DD/MON/YYYY HH:MI AM'),
    'Huxley Road, Richmond South, 3121',
    (SELECT DEM_CODE FROM DEMERIT WHERE DEM_DESCRIPTION = 'Exceeding the speed limit by 25 km/h or more'),
    10000015,
    '100389',
    'JYA3HHE05RA070562');




DELETE FROM OFFENCE WHERE OFF_NO='100'; 
DELETE FROM OFFENCE WHERE OFF_NO='101'; 

SELECT * FROM OFFENCE 
ORDER BY OFF_NO;

SELECT * FROM VEHICLE
WHERE VEH_VIN = 'JYA3HHE05RA070562';

SELECT * FROM DRIVER
WHERE LIC_NO='100389';

SELECT * FROM DEMERIT;

/*
1b(iii) Take the necessary steps in the database to record changes. 
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE





















