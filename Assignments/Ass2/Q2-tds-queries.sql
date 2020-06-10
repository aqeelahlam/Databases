--****PLEASE ENTER YOUR DETAILS BELOW****
--Q2-tds-queries.sql
--Student ID:
--Student Name:
--Tutorial No: 

/* Comments for your marker:




*/
SELECT * FROM SUSPENSION;

/*
2(i) Query 1
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE

SELECT 
    DEM_POINTS AS "Demerit Points",
    DEM_DESCRIPTION AS "Demerit Descriptions"
FROM
    DEMERIT
WHERE
    DEM_DESCRIPTION like '%Heavy%' or 
    DEM_DESCRIPTION like '%heavy%' or
    DEM_DESCRIPTION like 'Exceed%'
ORDER BY 
    DEM_POINTS, DEM_DESCRIPTION;


/*
2(ii) Query 2
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE

SELECT
    VEH_MAINCOLOR AS "Main Colour",
    VEH_VIN AS VIN,
    TO_CHAR(VEH_YRMANUF, 'YYYY') AS "Year Manufactured"
FROM 
    VEHICLE
WHERE
    (TO_CHAR(VEH_YRMANUF, 'YYYY') >= '2012' AND TO_CHAR(VEH_YRMANUF, 'YYYY') <= '2014') AND
    (VEH_MODNAME = 'Range Rover' OR
    VEH_MODNAME = 'Range Rover Sport')
ORDER BY
    VEH_YRMANUF DESC, 
    VEH_MAINCOLOR ASC;

/*
2(iii) Query 3
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE

SELECT
    D.LIC_NO AS "Licence No.",
    D.LIC_FNAME || ' ' || LIC_LNAME AS "Driver Fullname",
    D.LIC_DOB AS DOB,
    D.LIC_STREET || ' ' || LIC_TOWN || ' ' || LIC_POSTCODE AS "Driver Address",
    TO_CHAR(S.SUS_DATE, 'DD/MON/YY') AS "Suspended On",
    TO_CHAR(S.SUS_ENDDATE, 'DD/MON/YY') AS "Suspended Till"
FROM 
    DRIVER D
JOIN 
    SUSPENSION S
ON
    D.LIC_NO = S.LIC_NO
WHERE 
    SUS_DATE >= ADD_MONTHS(SYSDATE, -30)
ORDER BY
    D.LIC_NO ASC,
    SUS_DATE DESC;

/*
2(iv) Query 4
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE

SELECT
    DISTINCT D.DEM_CODE AS "Demerit Code",
    D.DEM_DESCRIPTION AS "Demerit Descriptions",
    COUNT (O.OFF_NO) "Total Offences (All Months)",
    NVL(TO_NUMBER(SUM(CASE
        WHEN TO_CHAR(O.OFF_DATETIME, 'MM') = '01' THEN 1
        END), '90'), 0) AS "Jan",
    NVL(TO_NUMBER(SUM(CASE
        WHEN TO_CHAR(O.OFF_DATETIME, 'MM') = '02' THEN 1
        END), '90'), 0) AS "Feb",
    NVL(TO_NUMBER(SUM(CASE
        WHEN TO_CHAR(O.OFF_DATETIME, 'MM') = '03' THEN 1
        END), '90'), 0) AS "Mar",
    NVL(TO_NUMBER(SUM(CASE
        WHEN TO_CHAR(O.OFF_DATETIME, 'MM') = '04' THEN 1
        END), '90'), 0) AS "Apr",    
    NVL(TO_NUMBER(SUM(CASE
        WHEN TO_CHAR(O.OFF_DATETIME, 'MM') = '05' THEN 1
        END), '90'), 0) AS "May",
    NVL(TO_NUMBER(SUM(CASE
        WHEN TO_CHAR(O.OFF_DATETIME, 'MM') = '06' THEN 1
        END), '90'), 0) AS "Jun",
    NVL(TO_NUMBER(SUM(CASE
        WHEN TO_CHAR(O.OFF_DATETIME, 'MM') = '07' THEN 1
        END), '90'), 0) AS "Jul",
    NVL(TO_NUMBER(SUM(CASE
        WHEN TO_CHAR(O.OFF_DATETIME, 'MM') = '08' THEN 1
        END), '90'), 0) AS "Aug",    
    NVL(TO_NUMBER(SUM(CASE
        WHEN TO_CHAR(O.OFF_DATETIME, 'MM') = '09' THEN 1
        END), '90'), 0) AS "Sep",    
    NVL(TO_NUMBER(SUM(CASE
        WHEN TO_CHAR(O.OFF_DATETIME, 'MM') = '10' THEN 1
        END), '90'), 0) AS "Oct",
    NVL(TO_NUMBER(SUM(CASE
        WHEN TO_CHAR(O.OFF_DATETIME, 'MM') = '11' THEN 1
        END), '90'), 0) AS "Nov",
    NVL(TO_NUMBER(SUM(CASE
        WHEN TO_CHAR(O.OFF_DATETIME, 'MM') = '12' THEN 1
        END), '90'), 0) AS "Dec"            
FROM 
    OFFENCE O
RIGHT OUTER JOIN --TO DISPLAY ALL THE DEMERITS
    DEMERIT D
ON
    O.DEM_CODE = D.DEM_CODE
--WHERE TO_CHAR(O.OFF_DATETIME, 'YYYY') = '2017' -- IN CASE for a particular year
GROUP BY
    D.DEM_CODE,
    D.DEM_DESCRIPTION
ORDER BY 
    "Total Offences (All Months)" DESC,
    D.DEM_CODE ASC;

/*
2(v) Query 5
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE


SELECT
    V.VEH_MANUFNAME AS "Manufacturer Name",
    COUNT(O.OFF_NO) AS "Total No. of Offences",
    SUM(DEM_POINTS) 
FROM 
    OFFENCE O
JOIN 
    VEHICLE V
USING
    (VEH_VIN)
JOIN 
    DEMERIT D
ON
    O.DEM_CODE = D.DEM_CODE
GROUP BY
    VEH_MANUFNAME
HAVING
    COUNT(DEM_POINTS) >= 2
ORDER BY
    "Total No. of Offences" DESC,
    V.VEH_MANUFNAME ASC;

-- FOR MAX OFFENCE CAUSED BY MANUFACTURER

SELECT
    V.VEH_MANUFNAME AS "Manufacturer Name",
    COUNT(O.OFF_NO) AS "Total No. of Offences"
FROM 
    OFFENCE O
JOIN 
    VEHICLE V
USING
    (VEH_VIN)
JOIN 
    DEMERIT D
ON
    O.DEM_CODE = D.DEM_CODE
WHERE
    D.DEM_POINTS >= 2
GROUP BY
    VEH_MANUFNAME
HAVING
     COUNT(O.OFF_NO) = (SELECT MAX(COUNT(O.OFF_NO))
                        FROM 
                            OFFENCE O
                        JOIN 
                            VEHICLE V
                        USING
                            (VEH_VIN)
                        JOIN 
                            DEMERIT D
                        ON
                            O.DEM_CODE = D.DEM_CODE
                        WHERE
                            D.DEM_POINTS >= 2
                        GROUP BY
                            VEH_MANUFNAME)
ORDER BY
    "Total No. of Offences" DESC,
    V.VEH_MANUFNAME ASC;
    
-- HIGHEST OFFENCES FOR EACH MANUFACTURER - CORRECT ANSWER  

SELECT
    V.VEH_MANUFNAME AS "Manufacturer Name",
    COUNT(O.OFF_NO) AS "Total No. of Offences"
FROM 
    OFFENCE O
JOIN 
    VEHICLE V
USING
    (VEH_VIN)
JOIN 
    DEMERIT D
USING
    (DEM_CODE)
WHERE 
    DEM_POINTS >= 2
GROUP BY
    VEH_MANUFNAME
ORDER BY
    "Total No. of Offences" DESC,
    V.VEH_MANUFNAME ASC;

/*
2(vi) Query 6
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE

SELECT
    LIC_NO AS "Licence No.",
    LIC_FNAME || ' ' || LIC_LNAME AS "Driver Name",
    OFFICER_ID AS "Officer ID",
    OFFICER_FNAME || ' ' || OFFICER_LNAME AS "Officer Name"
FROM
    DRIVER D
JOIN 
    OFFENCE O
USING 
    (LIC_NO)
JOIN 
    OFFICER P
USING 
    (OFFICER_ID)
JOIN
    DEMERIT DEM
USING 
    (DEM_CODE)
WHERE                             
    D.LIC_LNAME  = P.OFFICER_LNAME
GROUP BY 
    LIC_NO,
    LIC_FNAME || ' ' || LIC_LNAME,
    OFFICER_ID,
    OFFICER_FNAME || ' ' || OFFICER_LNAME
ORDER BY
    LIC_NO ASC;
    

/*
2(vii) Query 7
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE

SELECT 
    D.DEM_CODE AS "Demerit Code",
    D.DEM_DESCRIPTION AS "Demerit Descriptions",
    O.LIC_NO AS "License No.",
    P.LIC_FNAME || ' ' || P.LIC_LNAME AS "Driver Fullname",
    COUNT(*)
FROM
    DEMERIT D
JOIN
    OFFENCE O 
ON 
    D.DEM_CODE = O.DEM_CODE
JOIN
    DRIVER P
ON
    O.LIC_NO = P.LIC_NO   
GROUP BY
    D.DEM_CODE,
    D.DEM_DESCRIPTION,
    O.LIC_NO,
    P.LIC_FNAME || ' ' || P.LIC_LNAME
--HAVING
--    COUNT(*) = MAX(SELECT
--                    o.lic_no,
--                    D.DEM_CODE,
--                    COUNT(*)
--                FROM
--                    DEMERIT D
--                JOIN
--                    OFFENCE O 
--                ON 
--                    D.DEM_CODE = O.DEM_CODE
----                WHERE 
----                    COUNT(*) = MAX(COUNT(*))
--                GROUP BY
--                    o.lic_no,
--                    D.DEM_CODE)
----                    o.lic_no)

ORDER BY 
    D.DEM_CODE ASC,
    O.LIC_NO ASC;

SELECT 
    D.DEM_CODE AS "Demerit Code",
    D.DEM_DESCRIPTION AS "Demerit Descriptions",
    O.LIC_NO AS "License No.",
    P.LIC_FNAME || ' ' || P.LIC_LNAME AS "Driver Fullname"
FROM
    DEMERIT D
JOIN
    OFFENCE O 
ON 
    D.DEM_CODE = O.DEM_CODE
JOIN
    DRIVER P
ON
    O.LIC_NO = P.LIC_NO   
ORDER BY 
    D.DEM_CODE ASC,
    O.LIC_NO ASC;
























/*
2(viii) Query 8
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE


SELECT 
    V.veh_vin
    (CASE SUBSTR(TO_CHAR(V.veh_vin)), 0, 1)
        WHEN 'A' THEN "Africa"
    ELSE  
        "BLAH"
    END) AS TEST
FROM VEHICLE V;




select 
    veh_vin
from vehicle;
















