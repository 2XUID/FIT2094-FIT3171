/*
Databases Week 8 Tutorial Sample Solution
week8_classdiscussion.sql

Databases Units
Author: FIT Database Teaching Team
License: Copyright © Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice. 
*/

/* 1. List all students and their details. Order the output by student id. */

SELECT
    *
FROM
    uni.student
ORDER BY
    studid;
    
/* 2. List the student's details for those students who have a surname starting with the letter "S". 
In the display, rename the columns studfname and studlname to firstname and lastname. 
Order the output by student first name.*/

SELECT
    studid,
    studfname   AS firstname,
    studlname   AS lastname,
    studdob,
    studaddress,
    studphone,
    studemail
FROM
    uni.student
WHERE
    studlname LIKE 'S%'
ORDER BY
    firstname;
    
  
/* 3. List full name of all students who have marks in the range of 80 to 100 
in FIT9132 semester 2 of 2019. Order the output by full name.*/

SELECT
    studlname|| ' ' || studfname as fullname
FROM
    uni.student     s
    JOIN uni.enrolment   e ON s.studid = e.studid
WHERE
    mark BETWEEN 80 AND 100
    and unitcode = 'FIT9132'
    and semester = 2
    and to_char(ofyear,'yyyy') = '2019'
ORDER BY
    fullname;
    

/* 4. List the unit code, unit name and the unit code 
and unit name of the prerequisite units of all units in the database. 
Order the output by unit code and prerequisite unit code. */

SELECT
    u1.unitcode,
    u1.unitname,
    has_prereq_of   AS prereq_unitcode,
    u2.unitname     AS prereq_unitname
FROM
    uni.unit     u1
    JOIN uni.prereq   p ON u1.unitcode = p.unitcode
    JOIN uni.unit     u2 ON u2.unitcode = p.has_prereq_of
ORDER BY
    unitcode,
    prereq_unitcode;