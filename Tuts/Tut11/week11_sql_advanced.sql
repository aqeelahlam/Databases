--add set echo and spool command here
SET ECHO ON 
SPOOL week11_sql_advanced_output.txt
/*
Databases Week 11 Tutorial
week11_sql_advanced.sql

student id: 29262674
student name: AQEEL AHLAM   
last modified date: 05/06/2020

*/

/* 1. Find the number of scheduled classes assigned to each staff member each year and semester. 
If the number of classes is 2 then this should be labelled as a correct load, 
more than 2 as an overload and less than 2 as an underload. 
Order the list by decreasing order of scheduled class number. */

SELECT 
    TO_CHAR(C.OFYEAR, 'YYYY') AS YEAR,
    C.SEMESTER,
    S.STAFFID,
    S.STAFFFNAME,
    S.STAFFLNAME,
    COUNT(C.UNITCODE) AS NUMBERCLASSES,
    CASE 
        WHEN COUNT(C.UNITCODE) > 2 THEN
            'OVERLOAD'
        WHEN COUNT(C.UNITCODE) < 2 THEN
            'UNDERLOAD'
        WHEN COUNT(C.UNITCODE) = 2   THEN
            'CORRECT LOAD'
        END AS LOAD
FROM
    UNI.STAFF S
INNER JOIN 
    UNI.SCHEDCLASS C
ON 
    S.STAFFID = C.STAFFID
GROUP BY
    C.OFYEAR,
    C.SEMESTER,
    S.STAFFID,
    S.STAFFFNAME,
    S.STAFFLNAME
ORDER BY
    NUMBERCLASSES DESC;

/* 2. Display unit code and unitname for units that do not have a prerequisite. 
Order the list in increasing order of unit code.

There are many approaches that you can take in writing an SQL statement to answer this query. 
You can use the SET OPERATORS, OUTER JOIN and a SUBQUERY. 
Write SQL statements based on all of these approaches.*/

--SET OPERATOR

--SELECT 
--    U.UNITCODE, U.UNITNAME
--FROM 
--    UNI.UNIT U
--INNER JOIN
--    (SELECT 
--        UNITCODE
--    FROM 
--        UNI.UNIT
--    MINUS
--        SELECT 
--            UNITCODE
--        FROM 
--            UNI.PREREQ) P       
--ON 
--    U.UNITCODE = P.UNITCODE
--ORDER BY 
--    UNITCODE;

--OUTER JOIN

--SELECT
--    U.UNITCODE, U.UNITNAME
--FROM 
--    UNI.UNIT U
--FULL OUTER JOIN
--    UNI.PREREQ P
--ON
--    U.UNITCODE = P.UNITCODE
--WHERE P.HAS_PREREQ_OF IS NULL
--ORDER BY U.UNITCODE;

--SUBQUERY

SELECT
    UNITCODE,
    UNITNAME
FROM
    UNI.UNIT
WHERE
    UNITCODE 
NOT IN 
    (SELECT 
        UNITCODE
    FROM 
        UNI.PREREQ)
ORDER BY 
    UNITCODE;

/* 3. List all units offered in 2013 semester 2 which do not have any scheduled class. 
Include unit code, unit name, and chief examiner name in the list. 
Order the list based on the unit code. */

SELECT 
    O.UNITCODE,
    (SELECT 
        UNITNAME
    FROM
        UNI.UNIT
    WHERE
        O.UNITCODE = UNITCODE) AS UNITNAME,
    (SELECT
        STAFFFNAME || ' ' || STAFFLNAME
    FROM 
        UNI.STAFF
    WHERE
        CHIEFEXAM = STAFFID) AS CE_NAME
FROM
    (SELECT 
        * 
    FROM 
        UNI.OFFERING
    WHERE 
        SEMESTER = 2 AND 
        TO_CHAR(OFYEAR,'YYYY') = '2013') O

LEFT OUTER JOIN 

    (SELECT 
        * 
    FROM 
        UNI.SCHEDCLASS
    WHERE 
        SEMESTER = 2 AND 
        TO_CHAR(OFYEAR,'YYYY') = '2013') S 
    ON O.UNITCODE = S.UNITCODE
WHERE
    STAFFID is NULL
ORDER BY
    O.UNITCODE;


 
/* 4. List full names of students who are enrolled in both Introduction to Databases and Programming Foundations 
(note: unit names are unique). Order the list by student full name.*/

SELECT DISTINCT
    S.STUDFNAME || ' ' || S.STUDLNAME AS STUDENT_FULL_NAME
FROM 
    UNI.STUDENT S
WHERE 
    S.STUDID IN
        (SELECT 
            STUDID 
        FROM 
            UNI.ENROLMENT 
        NATURAL JOIN 
            UNI.UNIT
        WHERE UNITNAME = 'Introduction to Databases') AND
    S.STUDID IN
        (SELECT 
            STUDID 
        FROM 
            UNI.ENROLMENT 
        NATURAL JOIN 
            UNI.UNIT
        WHERE UNITNAME = 'Programming Foundations') 
ORDER BY 
    STUDENT_FULL_NAME;


/* 5. Given that payment rate for tutorial is $42.85 per hour and  payemnt rate for lecture is $75.60 per hour, 
calculate weekly payment per type of class for each staff. 
In the display, include staff name, type of class (lecture or tutorial), 
number of classes, number of hours (total duration), and weekly payment (number of hours * payment rate). 
Order the list by increasing order of staff name*/

SELECT 
    STAFFFNAME || ' ' || STAFFLNAME AS STAFFNAME,
    CASE CLTYPE
        WHEN 'T' THEN 'Tutorial'
        WHEN 'L' THEN 'Lecture'
    END AS TYPE,
    
    COUNT(CLTYPE) AS NO_OF_CLASSES,
    
    SUM(CLDURATION) AS TOTAL_HOURS,
    TO_CHAR((CASE CLTYPE
        WHEN 'T' THEN 
            SUM(CLDURATION) * 42.85
        WHEN 'L' THEN 
            SUM(CLDURATION) * 75.60
    END), '$9999.99') AS WEEKLY_PAYEMNT

FROM 
    UNI.STAFF
NATURAL JOIN 
    UNI.SCHEDCLASS
GROUP BY
    STAFFFNAME || ' ' || STAFFLNAME,
    CLTYPE
ORDER BY 
    STAFFFNAME || ' ' || STAFFLNAME ASC;


/* 6. Assume that all units worth 6 credit points each, calculate each student’s Weighted Average Mark (WAM) and GPA. 
Please refer to these Monash websites: https://www.monash.edu/exams/results/wam and https://www.monash.edu/exams/results/gpa 
for more information about WAM and GPA respectively. 

Calculation example for student 111111111:
WAM = (65x3 + 45x3 + 74x3 +74*6)/(3+3+3+6) = 66.4
GPA = (2x6 + 0.3x6 + 3x6 + 3x6)/(6+6+6+6) = 2.08

Include student id, student full name (in a 40 character wide column headed “Student Full Name”), WAM and GPA in the display. 
Order the list by descending order of WAM then descending order of GPA.
*/
SELECT
    S.STUDID,
    RPAD(S.STUDFNAME || ' ' || S.STUDLNAME, 40) AS "Student Full Name",
    TO_CHAR(ROUND(SUM(CASE SUBSTR(UNITCODE, 4, 1)
        WHEN '1' THEN 
            E.MARK * 3
        ELSE  
            E.MARK * 6
        END) / SUM(CASE SUBSTR(UNITCODE, 4, 1) 
                    WHEN '1' THEN 
                        3
                    ELSE 
                        6
                    END),2), '990.00') AS WAM,
    TO_CHAR(round(SUM(
        CASE 
            WHEN (E.GRADE = 'HD') THEN 
                4
            WHEN (E.GRADE = 'D') THEN 
                3 
            WHEN (E.GRADE = 'C') THEN 
                2 
            WHEN (E.GRADE = 'N') THEN 
                1 
            END * 6)/(COUNT(E.UNITCODE)*6), 2), '0.00') AS GPA
        
FROM 
    UNI.STUDENT S
INNER JOIN
    UNI.ENROLMENT E
ON 
    S.STUDID = E.STUDID
GROUP BY
    S.STUDFNAME || ' ' || S.STUDLNAME,
    S.STUDID
ORDER BY
    WAM DESC,
    GPA DESC;
    
SPOOL OFF    
SET ECHO OFF
    