-- AQEEL AHLAM
-- 29262674

-- Q1
SELECT 
    STUDID,
    STUDFNAME || ' ' || STUDLNAME AS NAME,
    TO_CHAR(STUDDOB, 'DD-MON-YYYY') AS DOB
FROM
    UNI.STUDENT
ORDER BY
    STUDDOB, NAME;

-- WE SHOULD NOT USE THIS AS IT WILL USE THE ALPHABETS SINCE A IS FIRST, APRIL COMES FIRST:
--ORDER BY
--    DOB, NAME;
    
    
-- Q2

SELECT 
    S.STUDID,
    S.STUDFNAME || ' ' || S.STUDLNAME AS NAME,
    E.UNITCODE,
    TO_CHAR(E.OFYEAR, 'YYYY') AS YEAR,
    E.SEMESTER
FROM 
    UNI.STUDENT S
JOIN 
    UNI.ENROLMENT E
ON 
    S.STUDID = E.STUDID
WHERE
    E.MARK IS NULL
ORDER BY
    UNITCODE, STUDID;
    
    














