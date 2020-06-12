--****PLEASE ENTER YOUR DETAILS BELOW****
--Q3-tds-mods.sql
--Student ID: 29262674
--Student Name: Aqeel Ahlam
--Tutorial No: 5

/* Comments for your marker:

*/


/*
3(i) Changes to live database 1
*/
--PLEASE PLACE REQUIRED SQL STATEMENTS FOR THIS PART HERE

--ALTER TABLE OFFICER
--DROP COLUMN TOTAL_BOOKINGS;

ALTER TABLE OFFICER
    ADD TOTAL_BOOKINGS NUMBER(5) DEFAULT 0;
    
COMMENT ON COLUMN OFFICER.TOTAL_BOOKINGS IS
    'Total Number of bookings';
 
UPDATE OFFICER P
SET P.TOTAL_BOOKINGS = CASE 
    WHEN (SELECT COUNT(O1.OFF_NO) FROM OFFENCE O1 where O1.OFFICER_ID = p.OFFICER_ID) > 0 THEN
    (SELECT 
        COUNT(O.OFF_NO)
    FROM 
        OFFENCE O
    WHERE
        O.OFFICER_ID = P.OFFICER_ID
    GROUP BY OFFICER_ID)
    ELSE 0 END;
    
COMMIT;

--select count(*) from offence where officer_id = '10000021';
-- 
--    
--select * from officer;

/*
3(ii) Changes to live database 2
*/
--PLEASE PLACE REQUIRED SQL STATEMENTS FOR THIS PART HERE

------------------------------
--DROP TABLE statements
------------------------------
DROP TABLE REASON cascade constraints PURGE;
DROP TABLE REVOKED cascade constraints PURGE;
------------------------------
--CREATE TABLE statements
------------------------------

CREATE TABLE REASON (
    REASON_CODE    CHAR(3) CONSTRAINT REASON_PK PRIMARY KEY,       
    REASON_DESC    VARCHAR2(150) NOT NULL
);

COMMENT ON COLUMN REASON.REASON_CODE IS
    'Reason Code';

COMMENT ON COLUMN REASON.REASON_DESC IS
    'Reason Description';


----------------------
--INSERT STATEMENTS--
----------------------
-- INSERTING VALUES INTO REASON
INSERT INTO REASON VALUES('FOS','First offence exceeding the speed limit by less than 10km/h');
INSERT INTO REASON VALUES('FEU','Faulty equipment used');
INSERT INTO REASON VALUES('DOU','Driver objection upheld');
INSERT INTO REASON VALUES('COH','Court hearing');
INSERT INTO REASON VALUES('EIP','Error in proceedings'); 

COMMIT;

CREATE TABLE REVOKED (
    DATE_REVOKED    DATE NOT NULL,       
    OFF_NO          NUMBER(8) NOT NULL,
    OFFICER_ID      NUMBER(8) NOT NULL,
    REASON_CODE     CHAR(3) NOT NULL
);

COMMENT ON COLUMN REVOKED.DATE_REVOKED IS
    'Date Offence was Revoked';

COMMENT ON COLUMN REVOKED.OFF_NO IS
    'Offence number (unique)';

COMMENT ON COLUMN REVOKED.OFFICER_ID IS
     'Police officer id number';
     
COMMENT ON COLUMN REVOKED.REASON_CODE IS
     'Reason Code';    

--ADDING PRIMARY KEY CONSTRAINT
ALTER TABLE REVOKED ADD CONSTRAINT REVOKED_PK PRIMARY KEY (DATE_REVOKED, OFF_NO );

--ADDING FOREIGN KEY CONSTRAINT
ALTER TABLE REVOKED
    ADD 
    (CONSTRAINT FK_REVOKED_OFFENCE FOREIGN KEY (OFF_NO)
                            REFERENCES OFFENCE (OFF_NO),
    CONSTRAINT FK_REVOKED_OFFICER FOREIGN KEY (OFFICER_ID)
                            REFERENCES OFFICER (OFFICER_ID),
    CONSTRAINT FK_REVOKED_REASON FOREIGN KEY (REASON_CODE)
                            REFERENCES REASON (REASON_CODE));
                            
--ALTER TABLE OFFENCE
--DROP COLUMN  IS_REVOKED;

ALTER TABLE OFFENCE
    ADD IS_REVOKED CHAR(3) DEFAULT 'No';
    
COMMENT ON COLUMN OFFENCE.IS_REVOKED IS
     'Is the offence revoked?';   
        
ALTER TABLE OFFENCE
    ADD CHECK (IS_REVOKED IN (
        'Yes',
        'No'
    ));
    
    