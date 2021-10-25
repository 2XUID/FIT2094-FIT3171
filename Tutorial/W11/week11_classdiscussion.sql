/*
Databases Week 11 Tutorial Sample Solution
week11_classdiscussion.sql

Databases Units
Author: FIT Database Teaching Team
License: Copyright © Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice. 
*/

/* 1. Assuming that the student name is unique, 
display Claudette Serman’s academic record, 
include the unit code, unit name, year, semester, mark and explained_grade in the listing. 
The Explained Grade column must show Fail for N, Pass for P, Credit for C, 
Distinction for D and High Distinction for HD. 
Order the list in increasing order of year, 
within the same year order the list in increasing order of semester, 
within the same semester order the list in increasing order of unit code order. */

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
                upper(studfname) = upper('Claudette')
            AND upper (studlname) = upper('Serman')
    )
ORDER BY
    year,
    semester,
    unitcode;

    
/* 2. Find the total number of prerequisite units for all units. 
Include in the list the unit code of units that do not have a prerequisite. 
Order the list in descending order of the number of prerequisite units.*/

SELECT
    u.unitcode,
    COUNT(has_prereq_of) AS no_of_prereq
FROM
    uni.unit      u
    LEFT OUTER JOIN uni.prereq    p ON u.unitcode = p.unitcode
GROUP BY
    u.unitcode
ORDER BY
    no_of_prereq DESC, unitcode;

