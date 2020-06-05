-- Q1

SELECT
    unitcode,
    unitname,
    to_char(ofyear, 'yyyy') AS year,
    semester,
    mark,
    CASE grade
        WHEN 'N'   THEN
            'Fail'
        WHEN 'P'   THEN
            'Pass'
        WHEN 'C'   THEN
            'Credit'
        WHEN 'D'   THEN
            'Distinction'
        WHEN 'HD'  THEN
            'High Distinction'
    END AS explained_grade
FROM
         uni.enrolment
    NATURAL JOIN uni.unit
WHERE
    studid = (
        SELECT
            studid
        FROM
            uni.student
        WHERE
                upper(studfname) = upper('Rani')
            AND upper (studlname) = upper('Dewa')
    )
ORDER BY
    year,
    Semester;

-- Q2    

SELECT
    u.unitcode,
    COUNT(has_prereq_of) AS no_of_prereq
FROM
    uni.unit      u
    LEFT OUTER JOIN uni.prereq    p ON u.unitcode = p.unitcode
GROUP BY
    u.unitcode
ORDER BY
    no_of_prereq DESC;

--Q3

SELECT
    unitcode,
    to_char(ofyear, 'YYYY') AS year,
    semester,
    COUNT(studid) AS no_of_enrolment,
    to_char(nvl(round(AVG(mark), 2), 0), '990.99') AS average
FROM
    uni.offering
    LEFT OUTER JOIN uni.enrolment USING ( ofyear,
                                          semester,
                                          unitcode )
GROUP BY
    unitcode,
    ofyear,
    semester
ORDER BY
    average; 































    
    
    
    
    
    
    
    
    