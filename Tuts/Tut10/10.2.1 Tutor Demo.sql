-- 10.2.1 : LEAD TUTOR DEMO

-- QUESTION 1

/*
SELECT 
    MAX(E.MARK) AS MAX_MARK
FROM
    UNI.ENROLMENT E
WHERE
    E.UNITCODE = 'FIT1004' AND
    E.SEMESTER = 1 AND
    TO_CHAR(E.OFYEAR, 'YYYY') = '2013';
*/

-- QUESTION 2
/*
SELECT 
    UNITCODE,
    TO_CHAR(E.OFYEAR, 'YYYY') AS "YEAR OF OFFERING",
    SEMESTER,
    COUNT(STUDID) AS TOTAL
FROM
    UNI.ENROLMENT E
WHERE
    TO_CHAR(E.OFYEAR, 'YYYY') = '2013'
GROUP BY
    UNITCODE, 
    OFYEAR, 
    SEMESTER   
--HAVING : USED ONLY WHEN YOU HAVE A CONDITION
ORDER BY
    TOTAL;
*/

-- QUESTION 3

SELECT 
    STUDFNAME
    || ' '
    || studlname AS fullname,
    to_char(studdob, 'dd/mm/yyyy') AS date_of_birth
FROM
         uni.student s
    JOIN uni.enrolment e ON s.studid = e.studid
WHERE
        e.unitcode = 'FIT1004'
    AND studdob = (
    -- THIS WILL RETURN ONE ROW FOR US TO DO THE COMPARISON
        SELECT
            MIN(studdob)
        FROM
                 uni.student s
            JOIN uni.enrolment e ON s.studid = e.studid
        WHERE
            e.unitcode = 'FIT1004'
    )
ORDER BY
    s.studid;
    
-- THIS IS WHEN WE GET MULTIPLE ROWS
SELECT 
    studfname
    || ' '
    || studlname AS fullname,
    to_char(studdob, 'dd/mm/yyyy') AS date_of_birth
FROM
         uni.student s
    JOIN uni.enrolment e ON s.studid = e.studid
WHERE
        e.unitcode = 'FIT1004'
    AND studdob IN (
    -- THIS WILL RETURN ONE ROW FOR US TO DO THE COMPARISON
        SELECT
            (studdob)
        FROM
                 uni.student s
            JOIN uni.enrolment e ON s.studid = e.studid
        WHERE
            e.unitcode = 'FIT1040'
    )
ORDER BY
    s.studid;    



























