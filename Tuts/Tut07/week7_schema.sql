--STUDENT NAME: AQEEL AHLAM 
--STUDENT NUMBER: 29262674
--TUT NUMBER: FRIDAY 3PM CLASSES


set echo on
spool week7_schema_output.txt

DROP TABLE unit CASCADE CONSTRAINTS PURGE;
DROP TABLE student CASCADE CONSTRAINTS PURGE;
DROP TABLE enrolment CASCADE CONSTRAINTS PURGE;

CREATE TABLE unit (
    unit_code       CHAR(7) CONSTRAINT unit_pk PRIMARY KEY,
    unit_name       VARCHAR2(50) NOT NULL CONSTRAINT uq_unique_name UNIQUE
);

CREATE TABLE student (
    stu_nbr         NUMBER(8) CONSTRAINT student_pk PRIMARY KEY,
    stu_lname       VARCHAR2(50) NOT NULL,
    stu_fname       VARCHAR2(50) NOT NULL,
    stu_dob         DATE NOT NULL,
    CONSTRAINT chk_stu_nbr CHECK (stu_nbr>10000000)
);

CREATE TABLE enrolment (
    stu_nbr         NUMBER(8) NOT NULL,
    unit_code       CHAR(7) NOT NULL,
    enrol_year      NUMBER(4) NOT NULL,
    enrol_semester  CHAR(1) NOT NULL,
    enrol_mark      NUMBER(3),
    enrol_grade     CHAR(2),
    CONSTRAINT pk_enrolment PRIMARY KEY (stu_nbr, unit_code, enrol_year, enrol_semester),
    CONSTRAINT enrol_sem_values CHECK (enrol_semester in ('1','2','3'))
);

ALTER TABLE enrolment
    ADD 
    (CONSTRAINT fk_enrolment_student FOREIGN KEY (stu_nbr)
                            REFERENCES student (stu_nbr),
    CONSTRAINT fk_enrolment_unit FOREIGN KEY (unit_code)
                            REFERENCES unit (unit_code)
);
                            
    

