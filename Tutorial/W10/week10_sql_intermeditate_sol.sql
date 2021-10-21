/*
Databases Week 10 Tutorial Sample Solution
week10_sql_intermediate_sol.sql

Databases Units
Author: FIT Database Teaching Team
License: Copyright © Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice.
*/

/* 1. Find the average mark of FIT2094 in semester 2, 2019.
Show the average mark with two decimal places.
Name the output column as “Average Mark”. */

SELECT
    to_char(AVG(mark), '990.00') AS "Average Mark"
FROM
    uni.enrolment
WHERE
    unitcode = 'FIT2094'
    AND semester = 2
    AND to_char(ofyear, 'YYYY') = '2019';

/* 2. List the average mark for each offering of FIT9136.
In the listing, include the year and semester number.
Sort the result according to the year then the semester.*/

SELECT
    to_char(ofyear, 'YYYY') AS "YEAR of OFFER",
    semester,
    round(AVG(mark), 1) AS avg_mark
FROM
    uni.enrolment
WHERE
    unitcode = 'FIT9136'
GROUP BY
    ofyear,
    semester
ORDER BY
    ofyear,
    semester;

/* 3. Find the number of students enrolled in FIT1045 in the year 2019,
under the following conditions:
      a. Repeat students are counted each time
      b. Repeat students are only counted once
*/

-- a. Repeat students are counted each time

SELECT
    COUNT(studid) AS student_count
FROM
    uni.enrolment
WHERE
    unitcode = 'FIT1045'
    AND to_char(ofyear, 'YYYY') = '2019';

-- b. Repeat students are only counted once

SELECT
    COUNT(DISTINCT studid) AS student_count
FROM
    uni.enrolment
WHERE
    unitcode = 'FIT1045'
    AND to_char(ofyear, 'YYYY') = '2019';

/* 4. Find the total number of prerequisite units for FIT5145. */

SELECT
    COUNT(has_prereq_of) AS no_prereqs
FROM
    uni.prereq
WHERE
    unitcode = 'FIT5145';


/* 5. Find the total number of prerequisite units for each unit.
In the list, include the unitcode for which the count is applicable.
Order the list by unit code.*/

SELECT
    unitcode,
    COUNT(has_prereq_of) AS no_prereqs
FROM
    uni.prereq
GROUP BY
    unitcode
ORDER BY
    unitcode;

/*6. Find the total number of students
whose marks are being withheld (grade is recorded as 'WH')
for each unit offered in semester 1 2020.
In the listing include the unit code for which the count is applicable.
Sort the list by descending order of the total number of students
whose marks are being withheld, then by the unitcode*/

SELECT
    unitcode,
    COUNT(studid) AS total_no_students
FROM
    uni.enrolment
WHERE
    semester = 1
    AND to_char(ofyear, 'yyyy') = '2020'
    AND grade = 'WH'
GROUP BY
    unitcode
ORDER BY
    total_no_students DESC, unitcode;

/* 7. For each prerequisite unit, calculate how many times
it has been used as a prerequisite (number of times used).
In the listing include the prerequisite unit code,
the prerequisite unit name and the number of times used.
Sort the output by unit name. */

SELECT
    has_prereq_of AS unitcode,
    u.unitname,
    COUNT(u.unitcode) AS no_times_used
FROM
    uni.prereq   p
    JOIN uni.unit     u ON u.unitcode = has_prereq_of
GROUP BY
    has_prereq_of,
    u.unitname
ORDER BY
    unitname;

/*8. Display unit code and unit name of units
which had at least 1 student who was granted deferred exam
(grade is recorded as 'DEF') in semester 1 2020.
Order the list by unit code.*/

SELECT
    unitcode,
    unitname
FROM
    uni.enrolment
    NATURAL JOIN uni.unit
WHERE
    semester = 1
    AND to_char(ofyear, 'yyyy') = '2020'
    AND grade = 'DEF'
GROUP BY
    unitcode,
    unitname
ORDER BY
    unitcode;

/* 9. Find the unit/s with the highest number of enrolments
for each offering in the year 2019.
Sort the list by semester then by unit code. */


SELECT
    unitcode,
    semester,
    COUNT(studid) AS student_count
FROM
    uni.enrolment
WHERE
    to_char(ofyear, 'YYYY') = '2019'
GROUP BY
    unitcode,
    semester
HAVING
    COUNT(studid) = (
        SELECT
            MAX(COUNT(studid))
        FROM
            uni.enrolment
        WHERE
            to_char(ofyear, 'YYYY') = '2019'
        GROUP BY
            unitcode,
            ofyear,
            semester
    )
ORDER BY
    semester,
    unitcode;

/* 10. Find all students enrolled in FIT3157 in semester 1, 2020
who have scored more than the average mark for FIT3157 in the same offering?
Display the students' name and the mark.
Sort the list in the order of the mark from the highest to the lowest
then in increasing order of student name.*/

SELECT
    studfname || ' ' || studlname as student_name,
    mark
FROM
    uni.student     s
    JOIN uni.enrolment   e ON s.studid = e.studid
WHERE
    unitcode = 'FIT3157'
    AND semester = 1
    AND to_char(ofyear, 'YYYY') = '2020'
    AND mark > (
        SELECT
            AVG(mark)
        FROM
            uni.enrolment
        WHERE
            unitcode = 'FIT3157'
            AND semester = 1
            AND to_char(ofyear, 'YYYY') = '2020'
    )
ORDER BY
    mark DESC, student_name;
