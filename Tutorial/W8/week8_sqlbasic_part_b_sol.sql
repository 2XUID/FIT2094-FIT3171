/*
Databases Week 8 Tutorial Sample Solution
week8_sqlbasic_part_b.sql

Databases Units
Author: FIT Database Teaching Team
License: Copyright © Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice.
*/

/* B1. List all the unit codes, semester and name of the chief examiners
for all the units that are offered in 2020. 
Order the output by semester then by unit code.*/

SELECT
    o.unitcode,
    semester,
    stafffname,
    stafflname
FROM
    uni.offering   o
    JOIN uni.staff      s ON o.chiefexam = s.staffid
WHERE
    TO_CHAR(ofyear, 'yyyy') = '2020'
ORDER BY
    semester, o.unitcode;



/* B2. List all unit codes, unit names and their year and semester of offering. 
Order the output by unit code then by offering year and then semester. */

SELECT
    u.unitcode,
    unitname,
    TO_CHAR(ofyear, 'yyyy') AS offeringyr,
    semester
FROM
    uni.unit       u
    JOIN uni.offering   o ON u.unitcode = o.unitcode
ORDER BY
    unitcode,
    offeringyr,
    semester;


/* B3. List the student name (firstname and surname) as one attribute 
and the unit name of all enrolments for semester 1 of 2020. 
Order the output by unit name, within a given unit name, order by student id.*/

SELECT
    studfname ||' '|| studlname as student_name,
    unitname
FROM
    uni.student     s
    JOIN uni.enrolment   e ON s.studid = e.studid
    JOIN uni.unit        u ON e.unitcode = u.unitcode
WHERE 
    e.semester = 1
    and TO_CHAR(ofyear,'yyyy') = '2020'
ORDER BY
    unitname,
    s.studid;
    

/* B4. List the unit code, semester, class type (lecture or tutorial), day and time
for all units taught by Windham Ellard in 2020.
Sort the list according to the unit code.*/

SELECT
    unitcode,
    semester,
    cltype,
    clday,
    TO_CHAR(cltime, 'HHAM') AS time
FROM
    uni.staff        s
    JOIN uni.schedclass   sc ON s.staffid = sc.staffid
WHERE
    TO_CHAR(ofyear, 'yyyy') = '2020'
    AND stafffname = 'Windham'
    AND stafflname = 'Ellard'
ORDER BY
    unitcode;

/* B5. Create a study statement for Friedrick Geist.
A study statement contains unit code, unit name, semester and year study was attempted,
the mark and grade. If the mark and/or grade is unknown, show the mark and/or grade as ‘N/A’.
Sort the list by year, then by semester and unit code. */

SELECT
    e.unitcode,
    unitname,
    semester,
    TO_CHAR(ofyear, 'yyyy') AS "YEAR OF ENROLMENT",
    nvl(TO_CHAR(mark, '999'), 'N/A') AS mark,
    nvl(grade, 'N/A') AS grade
FROM
    uni.student     s
    JOIN uni.enrolment   e ON s.studid = e.studid
    JOIN uni.unit        u ON e.unitcode = u.unitcode
WHERE
    studfname = 'Friedrick'
    AND studlname = 'Geist'
ORDER BY
    "YEAR OF ENROLMENT",
    semester,
    unitcode;

/* B6. List the unit code and unit name of the prerequisite units
of 'Introduction to data science' unit.
Order the output by prerequisite unit code. */

SELECT
    has_prereq_of   AS prereq_unitcode,
    u2.unitname     AS prereq_unitname
FROM
    uni.unit     u1
    JOIN uni.prereq   p ON u1.unitcode = p.unitcode
    JOIN uni.unit     u2 ON u2.unitcode = p.has_prereq_of
WHERE
    u1.unitname = 'Introduction to data science'
ORDER BY
    prereq_unitcode;

/* B7. Find all students (list their id, firstname and surname)
who have received an HD for FIT2094 unit in semester 2 of 2019.
Sort the list by student id. */

SELECT
    s.studid,
    studlname,
    studfname
FROM
    uni.student     s
    JOIN uni.enrolment   e ON s.studid = e.studid
WHERE
    mark >= 80
    AND unitcode = 'FIT2094'
    AND semester = 2
    AND TO_CHAR(ofyear, 'yyyy') = '2019'
ORDER BY
    s.studid;


/* B8.	List the student full name, and unit code for those students
who have no mark in any unit in semester 1 of 2020.
Sort the list by student full name. */

SELECT
    studfname || ' ' || studlname as student_full_name,
    e.unitcode
FROM
    uni.student     s
    JOIN uni.enrolment   e ON s.studid = e.studid
WHERE
    mark IS NULL
    AND semester = 1
    AND TO_CHAR(ofyear, 'yyyy') = '2020'
order by student_full_name;
