SPOOL week7_insert_output.txt

SET ECHO ON

/*
Databases Week 7 Tutorial Sample Solution
week7_insert.sql

Databases units
Author: FIT Database Teaching Team
License: Copyright © Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice. 
*/

-- 7.3.1
-- Basic INSERT statement
-- ================================================================

INSERT INTO student VALUES (
    11111111,
    'Bloggs',
    'Fred',
    '01-Jan-2003'
);

INSERT INTO student VALUES (
    11111112,
    'Nice',
    'Nick',
    '10-Oct-2004'
);

INSERT INTO student VALUES (
    11111113,
    'Wheat',
    'Wendy',
    '05-May-2005'
);

INSERT INTO student VALUES (
    11111114,
    'Sheen',
    'Cindy',
    '25-Dec-2004'
);

INSERT INTO unit VALUES (
    'FIT9999',
    'FIT Last Unit'
);

INSERT INTO unit VALUES (
    'FIT9132',
    'Introduction to Databases'
);

INSERT INTO unit VALUES (
    'FIT9161',
    'Project'
);

INSERT INTO unit VALUES (
    'FIT5111',
    'Student''s Life'
);



INSERT INTO enrolment VALUES (
    11111111,
    'FIT9132',
    2020,
    '1',
    35,
    'N'
);

INSERT INTO enrolment VALUES (
    11111111,
    'FIT9161',
    2020,
    '1',
    61,
    'C'
);

INSERT INTO enrolment VALUES (
    11111111,
    'FIT9132',
    2020,
    '2',
    42,
    'N'
);

INSERT INTO enrolment VALUES (
    11111111,
    'FIT5111',
    2020,
    '2',
    76,
    'D'
);

INSERT INTO enrolment VALUES (
    11111111,
    'FIT9132',
    2021,
    '1',
    NULL,
    NULL
);

INSERT INTO enrolment VALUES (
    11111112,
    'FIT9132',
    2020,
    '2',
    83,
    'HD'
);

INSERT INTO enrolment VALUES (
    11111112,
    'FIT9161',
    2020,
    '2',
    79,
    'D'
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

/*
  A different approach to inserting is illustrated below by using a list of
  the attributes you which to insert, any not listed will be made null.

  This approach is also useful if the data you have contains the attributes in a
  different order (for example you are working with data from another source) - the
  attributes are simply listed in the order they appear in the data itself

*/

INSERT INTO enrolment (stu_nbr, unit_code, enrol_year, enrol_semester) VALUES (
    11111114,
    'FIT9132',
    2021,
    '1'
);
INSERT INTO enrolment (stu_nbr, unit_code, enrol_year, enrol_semester) VALUES (
    11111114,
    'FIT5111',
    2021,
    '1'
);

COMMIT;

-- 7.3.2
-- Using seqeunces for INSERT
-- ================================================================
-- Create sequence
DROP SEQUENCE student_seq;

CREATE SEQUENCE student_seq START WITH 11111115 INCREMENT BY 1;

SELECT
    *
FROM
    cat;
-- cat refers to your Oracle catalogue, the objects which you own

-- Insert Mickey Mouse

INSERT INTO student VALUES (
    student_seq.NEXTVAL,
    'Mouse',
    'Mickey',
    '03-Feb-2004'
);

SELECT
    *
FROM
    student;

-- Add an enrolment

INSERT INTO enrolment VALUES (
    student_seq.CURRVAL,
    'FIT9132',
    2021,
    '1',
    NULL,
    NULL
);

COMMIT;

SELECT
    *
FROM
    enrolment;

-- 7.3.3
-- Advanced Insert
-- ================================================================

INSERT INTO student VALUES (
    student_seq.NEXTVAL,
    'Last',
    'First',
    '01-Jan-2005'
);

INSERT INTO enrolment VALUES (
    student_seq.CURRVAL,
    (
        SELECT
            unit_code
        FROM
            unit
        WHERE
            unit_name = 'Introduction to Databases'
    ),
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

-- 7.3.4
-- Create table and Insert data from a single SQL statement
-- ================================================================

DROP TABLE fit5111_student;

CREATE TABLE fit5111_student
    AS
        SELECT
            *
        FROM
            enrolment
        WHERE
            unit_code = 'FIT5111';

COMMENT ON COLUMN fit5111_student.stu_nbr IS
    'Student number';

COMMENT ON COLUMN fit5111_student.unit_code IS
    'Unit code';

COMMENT ON COLUMN fit5111_student.enrol_year IS
    'Enrolment year';

COMMENT ON COLUMN fit5111_student.enrol_semester IS
    'Enrolment semester';

COMMENT ON COLUMN fit5111_student.enrol_mark IS
    'Enrolment mark (real)';

COMMENT ON COLUMN fit5111_student.enrol_grade IS
    'Enrolment grade (letter)';
 
--Check if the table exist

SELECT
    *
FROM
    cat;

--List the contents of the table

SELECT
    *
FROM
    fit5111_student;

SPOOL OFF

SET ECHO OFF