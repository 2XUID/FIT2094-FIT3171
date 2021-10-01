SET ECHO ON

SPOOL week7_schema_alter_output.txt

/*
Databases Week 7 Tutorial Sample Solution
week7_schema_alter.sql

Author: FIT Database Teaching Team
License: Copyright © Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice.
*/

-- 7.1
-- DDL for Student-Unit-Enrolment model (using ALTER TABLE)
--

--
-- Place DROP commands at head of schema file
--

DROP TABLE enrolment PURGE;

DROP TABLE student PURGE;

DROP TABLE unit PURGE;

-- Create Tables
-- Here using both table and column constraints
--

CREATE TABLE student (
    stu_nbr     NUMBER(8) NOT NULL,
    stu_lname   VARCHAR2(50) NOT NULL,
    stu_fname   VARCHAR2(50) NOT NULL,
    stu_dob     DATE NOT NULL
);

COMMENT ON COLUMN student.stu_nbr IS
    'Student number';

COMMENT ON COLUMN student.stu_lname IS
    'Student last name';

COMMENT ON COLUMN student.stu_fname IS
    'Student first name';

COMMENT ON COLUMN student.stu_dob IS
    'Student date of birth';

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( stu_nbr );

ALTER TABLE student ADD CONSTRAINT ck_stu_nbr CHECK ( stu_nbr > 10000000 );

CREATE TABLE unit (
    unit_code   CHAR(7) NOT NULL,
    unit_name   VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN unit.unit_code IS
    'Unit code';

COMMENT ON COLUMN unit.unit_name IS
    'Unit name';

ALTER TABLE unit ADD CONSTRAINT unit_pk PRIMARY KEY ( unit_code );

ALTER TABLE unit ADD CONSTRAINT uq_unit_name UNIQUE ( unit_name );

CREATE TABLE enrolment (
    stu_nbr          NUMBER(8) NOT NULL,
    unit_code        CHAR(7) NOT NULL,
    enrol_year       NUMBER(4) NOT NULL,
    enrol_semester   CHAR(1) NOT NULL,
    enrol_mark       NUMBER(3),
    enrol_grade      CHAR(3)
);

COMMENT ON COLUMN enrolment.stu_nbr IS
    'Student number';

COMMENT ON COLUMN enrolment.unit_code IS
    'Unit code';

COMMENT ON COLUMN enrolment.enrol_year IS
    'Enrolment year';

COMMENT ON COLUMN enrolment.enrol_semester IS
    'Enrolment semester';

COMMENT ON COLUMN enrolment.enrol_mark IS
    'Enrolment mark (real)';

COMMENT ON COLUMN enrolment.enrol_grade IS
    'Enrolment grade (letter)';

ALTER TABLE enrolment
    ADD CONSTRAINT enrolment_pk PRIMARY KEY ( stu_nbr,
                                              unit_code,
                                              enrol_year,
                                              enrol_semester );

ALTER TABLE enrolment
    ADD CONSTRAINT student_enrolment_fk FOREIGN KEY ( stu_nbr )
        REFERENCES student ( stu_nbr );

ALTER TABLE enrolment
    ADD CONSTRAINT unit_enrolment_fk FOREIGN KEY ( unit_code )
        REFERENCES unit ( unit_code );

ALTER TABLE enrolment
    ADD CONSTRAINT ck_enrol_sem CHECK ( enrol_semester IN (
        '1',
        '2',
        '3'
    ) );

SPOOL OFF

SET ECHO OFF