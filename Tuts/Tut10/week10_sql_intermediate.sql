SET ECHO ON
SPOOL week10_sql_intermediate_output.txt

/*

student id: 29262674
student name: Aqeel Ahlam
last modified date: 29/05/2020

*/

/* 1. Find the average mark of FIT1040 in semester 2, 2013. */

SELECT
    ROUND(AVG(MARK), 2) AS AVERAGE
FROM 
    UNI.ENROLMENT E
WHERE
    E.UNITCODE = 'FIT1040' AND
    E.SEMESTER = 2 AND
    TO_CHAR(E.OFYEAR, 'YYYY') = '2013';

    
/* 2. List the average mark for each offering of FIT1040. 
In the listing, you need to include the year and semester number. 
Sort the result according to the year..*/

SELECT 
    SEMESTER, 
    TO_CHAR(OFYEAR, 'YYYY') AS YEAR,
    ROUND(AVG(MARK), 2) AS AVERAGE
FROM 
    UNI.ENROLMENT E
WHERE
    UNITCODE = 'FIT1040'
GROUP BY
    OFYEAR, 
    SEMESTER
--    TO_CHAR(OFYEAR, 'YYYY')  This part is not necessary
ORDER BY 
    YEAR;
    

/* 3. Find the number of students enrolled in the unit FIT1040 in the year 2013, under the following conditions:
      a. Repeat students are counted each time
      b. Repeat students are only counted once
*/

-- a: 
SELECT 
    E.UNITCODE,
    COUNT(STUDID) AS "NUMBER OF STUDENTS"
FROM
    UNI.ENROLMENT E
WHERE 
    E.UNITCODE = 'FIT1040' AND
    TO_CHAR(E.OFYEAR, 'YYYY') = '2013'
GROUP BY 
    UNITCODE
ORDER BY
    E.UNITCODE;

--b:
SELECT 
    E.UNITCODE,
    COUNT(DISTINCT STUDID) AS "NUMBER OF STUDENTS"
FROM
    UNI.ENROLMENT E
WHERE 
    E.UNITCODE = 'FIT1040' AND
    TO_CHAR(E.OFYEAR, 'YYYY') = '2013'
GROUP BY 
    UNITCODE
ORDER BY
    E.UNITCODE;

/* 4. Find the total number of prerequisite units for FIT2077. */

SELECT 
    P.UNITCODE,
    COUNT(P.HAS_PREREQ_OF) AS "NUMBER OF PREREQ UNITS"
FROM 
    UNI.PREREQ P
WHERE 
    P.UNITCODE = 'FIT2077'
GROUP BY 
    P.UNITCODE;
    
/* 5. Find the total number of prerequisite units for each unit. 
In the list, include the unitcode for which the count is applicable.*/

SELECT 
    P.UNITCODE,
    COUNT(P.HAS_PREREQ_OF) AS "NUMBER OF PREREQ UNITS"
FROM 
    UNI.PREREQ P
GROUP BY 
    P.UNITCODE
ORDER BY
    P.UNITCODE;

/* 6. For each prerequisite unit, calculate how many times it has been used as prerequisite. 
Include the name of the prerequisite unit in the listing .*/

SELECT 
    U.UNITNAME,
    P.HAS_PREREQ_OF AS UNITCODE,
    COUNT(U.UNITCODE) AS "PREREQ UNIT COUNT"
FROM 
    UNI.PREREQ P
JOIN
    UNI.UNIT U
ON 
    P.HAS_PREREQ_OF = U.UNITCODE
GROUP BY
    U.UNITNAME,
    P.HAS_PREREQ_OF
ORDER BY
    U.UNITNAME;
    
/* 7. Find the unit with the highest number of enrolments in a given offering in the year 2013. */

SELECT
    E.UNITCODE,
    E.SEMESTER,
	COUNT(E.UNITCODE) AS "NUMBER OF ENROLMENTS"
FROM
    UNI.ENROLMENT E
WHERE
    TO_CHAR(E.OFYEAR, 'YYYY') = '2013'
GROUP BY 
	E.UNITCODE,
    E.SEMESTER,
    E.OFYEAR
HAVING
    COUNT(E.UNITCODE) = (SELECT MAX(COUNT(E.UNITCODE))
                        FROM
                            UNI.ENROLMENT E
                        WHERE
                            TO_CHAR(E.OFYEAR, 'YYYY') = '2013'
                        GROUP BY
                            E.UNITCODE,
                            E.SEMESTER,
                            E.OFYEAR)
ORDER BY 
    E.UNITCODE;

/* 8. Find all students enrolled in FIT1004 in semester 1, 2013 
who have scored more than the average mark of FIT1004 in the same offering? 
Display the students' name and the mark. 
Sort the list in the order of the mark from the highest to the lowest.*/
SELECT 
    S.STUDFNAME || ' ' || S.STUDLNAME AS NAME,
    E.MARK
FROM 
    UNI.STUDENT S
JOIN 
    UNI.ENROLMENT E
ON
    S.STUDID = E.STUDID
WHERE 
    E.SEMESTER = 1 AND
    TO_CHAR(OFYEAR, 'YYYY') = '2013' AND
    E.UNITCODE = 'FIT1004' AND
    MARK > (SELECT 
                AVG(E.MARK)
            FROM
                UNI.ENROLMENT E
            -- average mark for FIT1004 for the same offering
            WHERE
                E.UNITCODE = 'FIT1004' AND
                E.SEMESTER = 1 AND
                TO_CHAR(E.OFYEAR, 'YYYY') = '2013')
ORDER BY
    E.MARK DESC;                


SPOOL OFF
SET ECHO OFF