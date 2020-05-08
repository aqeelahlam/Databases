--STUDENT NAME: AQEEL AHLAM 
--STUDENT NUMBER: 29262674
--TUT NUMBER: FRIDAY CLASSES

DROP TABLE employee CASCADE CONSTRAINTS PURGE;
DROP TABLE team CASCADE CONSTRAINTS PURGE;

CREATE TABLE employee (
    emp_no          NUMBER(5) NOT NULL,
    emp_fname       VARCHAR2(30),
    emp_lname       VARCHAR2(30),
    emp_street      VARCHAR(50) NOT NULL,
    emp_town        VARCHAR(30) NOT NULL,
    emp_pcode       CHAR(4) NOT NULL,
    emp_dob         DATE NOT NULL,
    emp_taxno       VARCHAR(20)
);

ALTER TABLE employee ADD CONSTRAINT pk_employee PRIMARY KEY ( emp_no );

CREATE TABLE team (
    team_no         NUMBER(3) NOT NULL,
    emp_no          NUMBER(5)
);

ALTER TABLE team ADD CONSTRAINT pk_team PRIMARY KEY ( team_no );

ALTER TABLE employee
    ADD
        (CONSTRAINT fk_employee_team FOREIGN KEY (team_no) 
                            REFERENCES team (team_no)
                            ON DELETE SET NULL,
         CONSTRAINT fk_employee_employee FOREIGN KEY (mentor_no)
                            REFERENCES employee (emp_no)
                            ON DELETE SET NULL);
                            
ALTER TABLE team
    ADD CONSTRAINT fk_employee_leads FOREIGN KEY (emp_no)
                            REFERENCES employee (emp_no)
                            ON DELETE SET NULL;
                            
                            





