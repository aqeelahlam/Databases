--STUDENT NAME: AQEEL AHLAM 
--STUDENT NUMBER: 29262674
--TUT NUMBER: FRIDAY 3PM CLASSES

SET ECHO ON
SPOOL week9_dml_output.txt

-- 9.2.1: UPDATE

--TASK 1:
UPDATE UNIT
SET UNIT_NAME = 'place holder unit'
WHERE UNIT_CODE = 'FIT9999';

COMMIT;

--TASK 2:
UPDATE ENROLMENT
SET ENROL_MARK = 75, ENROL_GRADE = 'D'
WHERE 
STU_NBR = '11111113' AND 
UNIT_CODE = 'FIT5132' AND
ENROL_SEMESTER = '2' AND
ENROL_YEAR = 2014;

COMMIT;

--TASK 3:
UPDATE ENROLMENT
SET ENROL_GRADE = 'P1' 
WHERE ENROL_MARK >= 45 and ENROL_MARK <=54;

UPDATE ENROLMENT
SET ENROL_GRADE = 'P2'
WHERE ENROL_MARK >= 55 and ENROL_MARK <=64;

UPDATE ENROLMENT
SET ENROL_GRADE = 'C'
WHERE ENROL_MARK >= 65 and ENROL_MARK <=74;

UPDATE ENROLMENT
SET ENROL_GRADE = 'D'
WHERE ENROL_MARK >= 75 and ENROL_MARK <=84;

UPDATE ENROLMENT
SET ENROL_GRADE = 'HD'
WHERE ENROL_MARK >= 85 and ENROL_MARK <=100;

COMMIT;

-- 9.2.2: DELETE

--TASK 1:
DELETE FROM ENROLMENT 
WHERE 
STU_NBR = 11111114 AND
ENROL_SEMESTER = '2' AND
ENROL_YEAR = 2014;

COMMIT;

--TASK 2 (ERROR DUE TO RESTRICT- DELETE CHILD FIRST)

DELETE FROM ENROLMENT 
WHERE STU_NBR = 11111113;

DELETE FROM STUDENT 
WHERE STU_NBR = 11111113;

COMMIT;

--TASK 3:

INSERT INTO STUDENT VALUES (11111113,'Wheat','Wendy','05-May-1990'); 
INSERT INTO ENROLMENT VALUES (11111113,'FIT5132',2014,'2',null,null);
INSERT INTO ENROLMENT VALUES (11111113,'FIT5111',2014,'2',null,null);

COMMIT;

--DROPPING FOREIGN KEY

ALTER TABLE ENROLMENT DROP CONSTRAINT FK_ENROLMENT_STUDENT;
ALTER TABLE ENROLMENT ADD CONSTRAINT FK_ENROLMENT_STUDENT FOREIGN KEY(STU_NBR) REFERENCES STUDENT(STU_NBR)
ON DELETE CASCADE;

DELETE FROM STUDENT 
WHERE STU_NBR = 11111113;

COMMIT;

SPOOL OFF
SET ECHO OFF
