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

COMMIT;


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
    
COMMIT;    


/*
1b(iii) Take the necessary steps in the database to record changes. 
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE

UPDATE OFFENCE
SET DEM_CODE = (SELECT DEM_CODE FROM DEMERIT WHERE DEM_DESCRIPTION = 'Exceeding the speed limit by 10 km/h or more but less than 25 km/h')
WHERE 
    LIC_NO='100389' AND
    OFF_DATETIME = TO_DATE('7-Jan-2020 7:07 AM', 'DD/MON/YYYY HH:MI AM');
    
COMMIT; 

