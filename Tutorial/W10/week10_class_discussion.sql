/*
Databases Week 10 Tutorial Sample Solution
week10_class_discussion.sql

Databases Units
Author: FIT Database Teaching Team
License: Copyright © Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice. 
*/

/* 1. Find the maximum mark for FIT9136 in semester 2, 2019. */

SELECT
    MAX(mark) AS max_mark
FROM
    uni.enrolment
WHERE
        unitcode = 'FIT9136'
    AND semester = 2
    AND to_char(ofyear, 'YYYY') = '2019';
    
/* 2. Find the total number of enrolment per semester for each unit in the year 2019. 
The list should include the unitcode, semester and year. 
Order the list in increasing order of enrolment numbers.*/

SELECT
    unitcode,
    to_char(ofyear, 'YYYY')      AS "YEAR of OFFER",
    semester,
    COUNT(studid)                AS total
FROM
    uni.enrolment
WHERE
    to_char(ofyear, 'YYYY') = '2019'
GROUP BY
    unitcode,
    ofyear,
    semester
ORDER BY
    total;
    
/* 3. Find the oldest student/s in FIT9132? 
Display the student’s full name and the date of birth. 
Sort the list by student id. */

SELECT
    studfname
    || ' '
    || studlname AS fullname,
    to_char(studdob, 'dd/mm/yyyy') AS date_of_birth
FROM
         uni.student s
    JOIN uni.enrolment e ON s.studid = e.studid
WHERE
        e.unitcode = 'FIT9132'
    AND studdob = (
        SELECT
            MIN(studdob)
        FROM
                 uni.student s
            JOIN uni.enrolment e ON s.studid = e.studid
        WHERE
            e.unitcode = 'FIT9132'
    )
ORDER BY
    s.studid;
