--****PLEASE ENTER YOUR DETAILS BELOW****
--Q4-tds-plsql.sql
--Student ID: 29262674
--Student Name: Aqeel Ahlam
--Tutorial No: 5

/* Comments for your marker:


*/

SET SERVEROUTPUT ON

/* (i) Write a trigger which will, from this point forward, automatically maintain the total number of times each police officer has booked a driver for a traffic offence attribute you added in Task 3. 
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/


-- HERE


CREATE OR REPLACE TRIGGER TOTAL_OFFENCE_TRIGGER
AFTER INSERT ON OFFENCE

FOR EACH ROW
BEGIN 
    IF INSERTING THEN 
    UPDATE OFFICER
    SET TOTAL_BOOKINGS = TOTAL_BOOKINGS + 1
    WHERE OFFICER_ID = :NEW.OFFICER_ID;
    END IF;
    DBMS_OUTPUT.PUT_LINE('The number of bookings for Officer ' || :NEW.OFFICER_ID || ' Has been incremented');  
END;
/

---- TEST HARNESS TASK 1 ----
--DISPLAY BEFORE TABLES--
SELECT OFFICER_ID, TOTAL_BOOKINGS FROM OFFICER WHERE OFFICER_ID = 10000015;
    
INSERT INTO OFFENCE VALUES (110, TO_DATE('21/06/2019 03:20', 'DD/MM/YYYY HH24:MI'), 'Larry Place, Melbourne, 3000', 99, 10000015, '100143', '5YJSA3H10EFP46509', 'No');
COMMIT;

--DISPLAY AFTER TABLES--
SELECT OFFICER_ID, TOTAL_BOOKINGS FROM OFFICER WHERE OFFICER_ID = 10000015;



/* (ii) Write a trigger which will, from this point forward, make sure that driver and police have at least one name before their data is added into the database. The trigger must prevent the insertion if both names are nulls. 
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/

--Trigger for Driver:
CREATE OR REPLACE TRIGGER DRIVER_TRIGGER
BEFORE INSERT ON DRIVER

FOR EACH ROW
BEGIN 
    IF (:NEW.LIC_FNAME IS NULL) AND (:NEW.LIC_LNAME IS NULL) THEN 
        RAISE_APPLICATION_ERROR(-20000, 'No First/Last is input for driver');
    ELSE
        DBMS_OUTPUT.PUT_LINE('The driver has been successfully added');  
    END IF;
END;
/

---- TEST HARNESS DRIVER ----

--DRIVER WITH AT LEAST ONE NAME

--DISPLAY COUNT OF DRIVER--
SELECT COUNT(*) FROM DRIVER;

INSERT INTO DRIVER VALUES ('10400', 'Aqeel', NULL, '0176894080', '7 Nadayu 28', 'Clayton', '3168', TO_DATE('15-Oct-1997', 'DD-MON-YYYY'), TO_DATE('10-Aug-2024', 'DD-MON-YYYY'));
COMMIT;

SELECT COUNT(*) FROM DRIVER;
--DRIVER COUNT INCREMENTED BY 1


--DRIVER WITH NO FNAME OR LNAME 

SELECT COUNT(*) FROM DRIVER;

INSERT INTO DRIVER VALUES ('10401', NULL, NULL, '0176894081', '7 Nadayu 28', 'Clayton', '3168', TO_DATE('16-Oct-1997', 'DD-MON-YYYY'), TO_DATE('10-Aug-2022', 'DD-MON-YYYY'));
COMMIT;

SELECT COUNT(*) FROM DRIVER;
--DRIVER COUNT DOES NOT INCREMENT BY 1


--Trigger for officer:

CREATE OR REPLACE TRIGGER OFFICER_TRIGGER
BEFORE INSERT ON OFFICER

FOR EACH ROW
BEGIN 
    IF (:NEW.OFFICER_FNAME IS NULL) AND (:NEW.OFFICER_FNAME IS NULL) THEN 
        RAISE_APPLICATION_ERROR(-20000, 'No First/Last is input for Officer');
    ELSE
        DBMS_OUTPUT.PUT_LINE('The Officer has been successfully added');  
    END IF;
END;
/

---- TEST HARNESS OFFICER ----

--OFFICER WITH AT LEAST ONE NAME

--DISPLAY COUNT OF OFFICER--
SELECT COUNT(*) FROM OFFICER;

INSERT INTO OFFICER VALUES (10000022, 'Aqeel', NULL,0);
COMMIT;

SELECT COUNT(*) FROM OFFICER;
--OFFICER COUNT INCREMENTED BY 1


--OFFICER WITH NO FNAME OR LNAME 

SELECT COUNT(*) FROM OFFICER;

INSERT INTO OFFICER VALUES (10000023, NULL, NULL,0);
COMMIT;

SELECT COUNT(*) FROM OFFICER;
--OFFICER COUNT DOES NOT INCREMENT BY 1



/* (iii) The local government wants to maintain a history of all drivers’ license expiry dates. Write a trigger to record the current and new lic_expiry date of a driver’s license whenever there is a change in a driver’s license expiry date. The trigger must check if the new licence expiry date is at least 30 months (2.5 years) later than current license expiry date, otherwise it must prevent the change.
Hint: to carry out this task, you need to create another table where the history of all drivers’ license expiry dates is recorded. In the table, include the licence number, the current expiry date, the new expiry date and the date when the update is done.
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/

DROP TABLE HISTORY cascade constraints PURGE;

CREATE TABLE HISTORY (
    LIC_NO              CHAR(10) CONSTRAINT HISTORY_PK PRIMARY KEY,       
    CURRENT_EXP_DATE    DATE NOT NULL,
    NEW_EXP_DATE        DATE NOT NULL,
    UPDATE_DATE         DATE NOT NULL
);

COMMENT ON COLUMN HISTORY.LIC_NO IS
    'Date Offence was Revoked';

COMMENT ON COLUMN HISTORY.CURRENT_EXP_DATE IS
    'Current expiry date';

COMMENT ON COLUMN HISTORY.NEW_EXP_DATE IS
     'New expiry Date';
     
COMMENT ON COLUMN HISTORY.UPDATE_DATE IS
     'Date update is done';   

ALTER TABLE HISTORY
    ADD 
    CONSTRAINT FK_HISTORY_OFFENCE FOREIGN KEY (lic_no)
        REFERENCES DRIVER (lic_no);

COMMIT;


CREATE OR REPLACE TRIGGER TOTAL_STUDENT_TRIGGER 
AFTER INSERT OR DELETE ON ENROLMENT
FOR EACH ROW
BEGIN 
    IF INSERTING THEN 
    UPDATE UNIT
    SET UNIT_CURRENT_STU_COUNT = UNIT_CURRENT_STU_COUNT + 1
    WHERE UNIT_CODE = :NEW.UNIT_CODE;
    END IF;
    
    IF DELETING THEN 
    UPDATE UNIT
    SET UNIT_CURRENT_STU_COUNT = UNIT_CURRENT_STU_COUNT - 1 
    WHERE UNIT_CODE = :NEW.UNIT_CODE;
    INSERT INTO AUDIT_LOG VALUES (AUDIT_SEQ.NEXTVAL, SYSDATE, USER, :OLD.STU_NO, :OLD.UNIT_CODE);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TEST_TRIGGER
BEFORE UPDATE OF LIC_EXPIRY ON DRIVER
FOR EACH ROW

BEGIN
    IF (MONTHS_BETWEEN(:OLD.lic_expiry,:NEW.lic_expiry))>30 THEN
        INSERT INTO history(lic_no, CURRENT_EXP_DATE, NEW_EXP_DATE, UPDATE_DATE) 
        VALUES(:OLD.lic_no, :old.lic_expiry, :new.lic_expiry, sysdate);
        DBMS_OUTPUT.PUT_LINE('New License expiry history record added.');
    ELSE
        raise_application_error(-20000
                , 'Invalid Expiry Date');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TEST_TRIGGER
BEFORE UPDATE OF LIC_EXPIRY ON DRIVER
FOR EACH ROW

BEGIN
        IF (:NEW.lic_expiry >= add_months(:OLD.lic_expiry, 30)) THEN
        INSERT INTO history(lic_no, CURRENT_EXP_DATE, NEW_EXP_DATE, UPDATE_DATE) 
        VALUES(:OLD.lic_no, :old.lic_expiry, :new.lic_expiry, sysdate);
        DBMS_OUTPUT.PUT_LINE('New License expiry history record added.');
    ELSE
        raise_application_error(-20000
                , 'Invalid Expiry Date');
    END IF;
END;
/



UPDATE DRIVER
SET lic_expiry = TO_DATE('03-Jan-2022', 'DD-MON-YYYY')
WHERE lic_no = '100007';
ROLLBACK;
SELECT LIC_FNAME, LIC_EXPIRY FROM DRIVER WHERE LIC_NO = '100007';


