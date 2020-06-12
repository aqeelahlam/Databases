--****PLEASE ENTER YOUR DETAILS BELOW****
--Q2-tds-queries.sql
--Student ID: 29262674
--Student Name: Aqeel Ahlam
--Tutorial No: 5

/* Comments for your marker:

*/

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
    
-- HIGHEST OFFENCES FOR EACH MANUFACTURER 

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
    COUNT(O.OFF_NO) AS "Total Times Booked"
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
HAVING
   COUNT(O.OFF_NO) = (SELECT
                        MAX(TOTAL_OFFENCES)
                    FROM
                        (SELECT
                            COUNT(O.OFF_NO) AS TOTAL_OFFENCES
                        FROM
                            DEMERIT D1
                        JOIN
                            OFFENCE O 
                        ON 
                            D.DEM_CODE = O.DEM_CODE
                        WHERE 
                            D.DEM_CODE = D1.DEM_CODE
                        GROUP BY
                            D1.DEM_CODE,
                            O.LIC_NO))
ORDER BY 
    D.DEM_CODE ASC,
    O.LIC_NO ASC;


/*
2(viii) Query 8
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE      
    
SELECT 
    REGION,
    SUM(TOTAL) AS "Total Vehicles Manufactured",
    CONCAT(TO_CHAR(ROUND((SUM(TOTAL)/(SELECT COUNT(V1.VEH_VIN) FROM VEHICLE V1)*100),2), '990.00'), '%') AS "Percentage of Vehicles Manufactured"
FROM (SELECT
            CASE 
                WHEN V_IN.VEH_VIN like 'A%' OR V_IN.VEH_VIN like 'B%' OR V_IN.VEH_VIN like 'C%' THEN
                    'Africa'
                WHEN V_IN.VEH_VIN like 'J%' OR V_IN.VEH_VIN like 'K%' OR V_IN.VEH_VIN like 'L%' OR V_IN.VEH_VIN like 'M%' 
                    OR V_IN.VEH_VIN like 'N%' OR V_IN.VEH_VIN like 'O%' OR V_IN.VEH_VIN like 'P%' OR V_IN.VEH_VIN like 'Q%' 
                    OR V_IN.VEH_VIN like 'R%' THEN 'Asia'
                WHEN V_IN.VEH_VIN like 'S%' OR V_IN.VEH_VIN like 'T%' OR V_IN.VEH_VIN like 'U%' OR V_IN.VEH_VIN like 'V%' 
                    OR V_IN.VEH_VIN like 'W%' OR V_IN.VEH_VIN like 'X%' OR V_IN.VEH_VIN like 'Y%' OR V_IN.VEH_VIN like 'Z%' 
                    THEN 'Europe'
                WHEN V_IN.VEH_VIN like '1%' OR V_IN.VEH_VIN like '2%' OR V_IN.VEH_VIN like '3%' OR V_IN.VEH_VIN like '4%' 
                    OR V_IN.VEH_VIN like '5%' THEN 'North America'
                WHEN V_IN.VEH_VIN like '6%' OR V_IN.VEH_VIN like '7%' THEN 'Oceania'
                WHEN V_IN.VEH_VIN like '9%' OR V_IN.VEH_VIN like '9%' THEN 'South America'
                ELSE 'Unknown'
            END AS REGION,
            COUNT(VEH_VIN) as TOTAL
        FROM 
            VEHICLE V_IN
        GROUP BY VEH_VIN)
GROUP BY 
    REGION
UNION SELECT 'Total', (SELECT COUNT(VEH_VIN) FROM VEHICLE), 
    (SELECT TO_CHAR(SUM(ROUND((COUNT(V_IN.VEH_VIN)/(SELECT COUNT(VEH_VIN) FROM VEHICLE))*100,2)), '990.99') || '%' FROM VEHICLE V_IN
        GROUP BY
            CASE
                WHEN V_IN.VEH_VIN like 'A%' OR V_IN.VEH_VIN like 'B%' OR V_IN.VEH_VIN like 'C%' THEN
                    'Africa'
                WHEN V_IN.VEH_VIN like 'J%' OR V_IN.VEH_VIN like 'K%' OR V_IN.VEH_VIN like 'L%' OR V_IN.VEH_VIN like 'M%' 
                    OR V_IN.VEH_VIN like 'N%' OR V_IN.VEH_VIN like 'O%' OR V_IN.VEH_VIN like 'P%' OR V_IN.VEH_VIN like 'Q%' 
                    OR V_IN.VEH_VIN like 'R%' THEN 'Asia'
                WHEN V_IN.VEH_VIN like 'S%' OR V_IN.VEH_VIN like 'T%' OR V_IN.VEH_VIN like 'U%' OR V_IN.VEH_VIN like 'V%' 
                    OR V_IN.VEH_VIN like 'W%' OR V_IN.VEH_VIN like 'X%' OR V_IN.VEH_VIN like 'Y%' OR V_IN.VEH_VIN like 'Z%' 
                    THEN 'Europe'
                WHEN V_IN.VEH_VIN like '1%' OR V_IN.VEH_VIN like '2%' OR V_IN.VEH_VIN like '3%' OR V_IN.VEH_VIN like '4%' 
                    OR V_IN.VEH_VIN like '5%' THEN 'North America'
                WHEN V_IN.VEH_VIN like '6%' OR V_IN.VEH_VIN like '7%' THEN 'Oceania'
                WHEN V_IN.VEH_VIN like '9%' OR V_IN.VEH_VIN like '9%' THEN 'South America'
                ELSE 'Unknown'
            END) FROM VEHICLE V_OUTER 
ORDER BY 
    "Total Vehicles Manufactured" ASC,
    REGION ASC;