SET ECHO ON 
SPOOL  Week8_SQLBasic_PartB_output.txt


/*
Databases Week 8 Tutorial Sample Solution
week8_SQLBasic_PartB.sql

student id: 29262674
student name: AQEEL AHLAM
last modified date: 16/5/20
*/

/* B1. List all the unit codes, semester and name of the chief examiner for all 
      the units that are offered in 2014.*/
SELECT 
    O.UNITCODE, 
    O.SEMESTER,
    O.CHIEFEXAM,
    S.STAFFFNAME || ' ' || S.STAFFLNAME AS NAME
FROM 
    UNI.OFFERING O
JOIN 
    UNI.STAFF S
ON
    O.CHIEFEXAM = S.STAFFID
WHERE
    TO_CHAR(OFYEAR, 'YYYY') = '2014'
ORDER BY 
    O.UNITCODE;

/* B2. List all the unit codes and the unit names and their year and semester 
      offerings. To display the date correctly in Oracle, you need to use to_char function. 
      For example, to_char(ofyear,'YYYY'). */

SELECT
    UNITCODE, 
    UNITNAME,
    TO_CHAR(OFYEAR, 'YYYY'),
    SEMESTER
FROM 
    UNI.OFFERING 
NATURAL JOIN 
    UNI.UNIT
ORDER BY
    UNITCODE;

/* B3. List the unit code, semester, class type (lecture or tutorial), 
      day and time for all units taught by Albus Dumbledore in 2013. 
      Sort the list according to the unit code.*/
      
SELECT 
    UNITCODE,
    SEMESTER,
    CLTYPE,
    CLDAY, 
    TO_CHAR(CLTIME, 'HH:MI PM')
FROM
    UNI.SCHEDCLASS C
JOIN
    UNI.STAFF S
ON
    S.STAFFID = C.STAFFID
WHERE
    S.STAFFFNAME = 'Albus' 
    AND
    S.STAFFLNAME = 'Dumbledore' 
    AND 
    TO_CHAR(C.OFYEAR, 'YYYY') = '2013'
ORDER BY 
    UNITCODE;


/* B4. Create a study statement for Mary Smith. A study statement contains 
      unit code, unit name, semester and year study was attempted, the mark 
      and grade. */

SELECT 
    UNITCODE,
    U.UNITNAME,
    SEMESTER,
    TO_CHAR(OFYEAR, 'YYYY') AS YEAR,
    MARK,
    GRADE
FROM 
    UNI.ENROLMENT E
JOIN 
    UNI.STUDENT S
USING 
    (STUDID)
JOIN
    UNI.OFFERING O
USING
    (UNITCODE, SEMESTER, OFYEAR)
JOIN
    UNI.UNIT U
USING 
    (UNITCODE)
WHERE
    S.STUDFNAME = 'Mary' 
AND
    S.STUDLNAME = 'Smith'
ORDER BY
    UNITCODE;

/* Questions based on B4
Why can't I use identifiers by default for the all the attributes in SELECT?
eg: E.UNITCODE
Why can't I use different JOINS, it doesnt seem to work when there is a combo
of NATURAL, USING and ON joins
*/


/* B5. List the unit code and unit name of the pre-requisite units of 
      'Advanced Data Management' unit */

SELECT 
    --U.UNITCODE,
    --U.UNITNAME,
    P.HAS_PREREQ_OF AS PREREQ_UNITCODE,
    U.UNITNAME AS PREREQ_UNITNAME
FROM
    UNI.UNIT U
JOIN 
    UNI.PREREQ P
ON 
    U.UNITCODE = P.UNITCODE
JOIN
    UNI.UNIT U2
ON
    U2.UNITCODE = P.HAS_PREREQ_OF
WHERE
    U.UNITNAME = 'Advanced Data Management'
ORDER BY
    PREREQ_UNITCODE;


/* B6. Find all students (list their id, firstname and surname) who 
       have a failed unit in the year 2013 */
SELECT
    S.STUDID,
    STUDFNAME,
    STUDLNAME
FROM 
    UNI.STUDENT S
JOIN
    UNI.ENROLMENT E
ON 
    S.STUDID = E.STUDID
WHERE
    E.GRADE = 'N' 
AND
    TO_CHAR(OFYEAR, 'YYYY') = '2013'
ORDER BY 
    S.STUDID;
    
    


/* B7.	List the student name, unit code, semester and year for those 
        students who do not have marks recorded */

SELECT 
    STUDFNAME || ' ' || STUDLNAME AS NAME,
    UNITCODE,
    SEMESTER,
    --MARK,
    TO_CHAR(OFYEAR, 'YYYY') AS YEAR
FROM 
    UNI.STUDENT S
NATURAL JOIN
    UNI.ENROLMENT E
WHERE 
    E.MARK IS NULL
ORDER BY
    NAME;

SPOOL OFF
SET ECHO OFF