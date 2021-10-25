SET ECHO ON;

/*
Databases Week 9 Tutorial Sample Solution
week9_dml_sol.sql

Databases Units
Author: FIT Database Teaching Team
License: Copyright © Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice. 
*/

--9.2.1 UPDATE
/*1. Update the unit name of FIT9999 from 'FIT Last Unit' to 'place holder unit'.*/
SELECT
    *
FROM
    unit;

UPDATE unit
SET
    unit_name = 'place holder unit'
WHERE
    unit_code = 'FIT9999';

COMMIT;

SELECT
    *
FROM
    unit;

/*2. Enter the mark and grade for the student with the student number of 11111113 
for the unit code FIT9132 that the student enrolled in semester 1 of 2021. 
The mark is 75 and the grade is D.*/
SELECT
    *
FROM
    enrolment;

UPDATE enrolment
SET
    enrol_mark = 75,
    enrol_grade = 'D'
WHERE
        stu_nbr = 11111113
    AND enrol_semester = '1'
    AND enrol_year = 2021
    AND unit_code = 'FIT9132';

COMMIT;

SELECT
    *
FROM
    enrolment;

/*3. The university introduced a new grade classification scale. 
The new classification are:
0 - 44 is N
45 - 54 is P1
55 - 64 is P2
65 - 74 is C
75 - 84 is D
85 - 100 is HD
Change the database to reflect the new grade classification scale.
*/

SELECT
    *
FROM
    enrolment;

UPDATE enrolment
SET
    enrol_grade = 'N'
WHERE
        enrol_mark >= 0
    AND enrol_mark <= 44;

UPDATE enrolment
SET
    enrol_grade = 'P1'
WHERE
        enrol_mark >= 45
    AND enrol_mark <= 54;

UPDATE enrolment
SET
    enrol_grade = 'P2'
WHERE
        enrol_mark >= 55
    AND enrol_mark <= 64;

UPDATE enrolment
SET
    enrol_grade = 'C'
WHERE
        enrol_mark >= 65
    AND enrol_mark <= 74;

UPDATE enrolment
SET
    enrol_grade = 'D'
WHERE
        enrol_mark >= 75
    AND enrol_mark <= 84;

UPDATE enrolment
SET
    enrol_grade = 'HD'
WHERE
    enrol_mark >= 85;

COMMIT;

--Alternative solution for Q3
UPDATE enrolment
SET
    enrol_grade =
        CASE
            WHEN enrol_mark BETWEEN 0 AND 44    THEN
                'N'
            WHEN enrol_mark BETWEEN 45 AND 54   THEN
                'P1'
            WHEN enrol_mark BETWEEN 55 AND 64   THEN
                'P2'
            WHEN enrol_mark BETWEEN 65 AND 74   THEN
                'C'
            WHEN enrol_mark BETWEEN 75 AND 84   THEN
                'D'
            WHEN enrol_mark BETWEEN 85 AND 100  THEN
                'HD'
        END;

COMMIT;

SELECT
    *
FROM
    enrolment;

/*4. Due to the new regulation, the Faculty of IT decided to change 'Project' unit code 
from FIT9161 into FIT5161. Change the database to reflect this situation.
Note: you need to disable the FK constraint before you do the modification 
then enable the FK to have it active again.
*/

SELECT
    *
FROM
    unit;

SELECT
    *
FROM
    enrolment;

/* A direct update statement on unit table will return error
"integrity constraint (AAA.STUDENT_ENROLMENT_FK) violated - child record found".

Thus, you need to use the ALTER TABLE statement to disable
the FOREIGN KEY constraint first and then enable it back.*/

ALTER TABLE enrolment DISABLE CONSTRAINT unit_enrolment_fk;

UPDATE enrolment
SET
    unit_code = 'FIT5161'
WHERE
    unit_code = 'FIT9161';

UPDATE unit
SET
    unit_code = 'FIT5161'
WHERE
    unit_code = 'FIT9161';

COMMIT;

ALTER TABLE enrolment ENABLE CONSTRAINT unit_enrolment_fk;

SELECT
    *
FROM
    unit;

SELECT
    *
FROM
    enrolment;


--9.2.2 DELETE
/*1. A student with student number 11111114 has taken intermission in semester 1 2021,
hence all the enrolment of this student for semester 1 2021 should be removed.
Change the database to reflect this situation.*/
SELECT
    *
FROM
    enrolment;

DELETE FROM enrolment
WHERE
        stu_nbr = 11111114
    AND enrol_semester = '1'
    AND enrol_year = 2021;

COMMIT;

SELECT
    *
FROM
    enrolment;


/*2. The faculty decided to remove all 'Student's Life' unit's enrolments. 
Change the database to reflect this situation.
Note: unit names are unique in the database.*/

SELECT
    *
FROM
    enrolment;

DELETE FROM enrolment
WHERE
    unit_code = (
        SELECT
            unit_code
        FROM
            unit
        WHERE
            unit_name = 'Student''s Life'
    );

COMMIT;

SELECT
    *
FROM
    enrolment;


/*3. Assume that Wendy Wheat (student number 11111113) has withdrawn from the university. 
Remove her details from the database.*/
SELECT
    *
FROM
    student;

SELECT
    *
FROM
    enrolment;

 
-- this statement will return error "integrity constraint (AAA.STUDENT_ENROLMENT_FK) violated - child record found"
DELETE FROM student
WHERE
    stu_nbr = 11111113;

-- so, child records need to be deleted first and then the parent record:
DELETE FROM enrolment
WHERE
    stu_nbr = 11111113;

DELETE FROM student
WHERE
    stu_nbr = 11111113;

COMMIT;

SELECT
    *
FROM
    student;

SELECT
    *
FROM
    enrolment;
/*4 Add Wendy Wheat back to the database (use the INSERT statements you have created
when completing module Tutorial 7 SQL Data Definition Language DDL).*/
INSERT INTO student VALUES (
    11111113,
    'Wheat',
    'Wendy',
    '05-May-2005'
);

INSERT INTO enrolment VALUES (
    11111113,
    'FIT9132',
    2021,
    '1',
    NULL,
    NULL
);

INSERT INTO enrolment VALUES (
    11111113,
    'FIT5111',
    2021,
    '1',
    NULL,
    NULL
);

COMMIT;

SELECT
    *
FROM
    student;

SELECT
    *
FROM
    enrolment;

/*Change the FOREIGN KEY constraints definition for the STUDENT table so it will now include 
the ON DELETE clause to allow CASCADE delete. Hint: You need to use the ALTER TABLE statement
 to drop the FOREIGN KEY constraint first and then put it back 
 using ALTER TABLE with the ADD CONSTRAINT clause. */
-- drop the constraint
ALTER TABLE enrolment DROP CONSTRAINT student_enrolment_fk;
-- add the constraint back but now as delete cascade
ALTER TABLE enrolment
    ADD CONSTRAINT student_enrolment_fk FOREIGN KEY ( stu_nbr )
        REFERENCES student ( stu_nbr )
            ON DELETE CASCADE;
/*
Once you have changed the table, now, perform the deletion of
the Wendy Wheat (student number 11111113) row in the STUDENT table.
Examine the ENROLMENT table. What happens to the enrolment records of Wendy Wheat?*/

-- delete Wendy Wheat
DELETE FROM student
WHERE
    stu_nbr = 11111113;

COMMIT;

SELECT
    *
FROM
    student;

SELECT
    *
FROM
    enrolment;

SET ECHO OFF;