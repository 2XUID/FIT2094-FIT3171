--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-ml-insert.sql

--Student ID: Sample Solution
--Student Name:
--Tutorial No:

/* Comments for your marker:



*/

-- 2 (a) Load the BOOK_COPY, LOAN and RESERVE tables with your own
-- test data following the data requirements expressed in the brief

-- BOOK COPY
INSERT INTO book_copy VALUES (
    10,
    1,
    150.43,
    'Y',
    '005.432 L761P'
);

INSERT INTO book_copy VALUES (
    12,
    1,
    150.43,
    'N',
    '005.432 L761P'
);

INSERT INTO book_copy VALUES (
    13,
    1,
    150.43,
    'N',
    '005.432 L761P'
);

INSERT INTO book_copy VALUES (
    10,
    2,
    24.56,
    'N',
    '823.914 A211H'
);

INSERT INTO book_copy VALUES (
    10,
    3,
    82.83,
    'N',
    '005.74 D691D'
);

INSERT INTO book_copy VALUES (
    12,
    2,
    82.83,
    'N',
    '005.74 D691D'
);

INSERT INTO book_copy VALUES (
    13,
    2,
    85.67,
    'Y',
    '005.74 D691D'
);

INSERT INTO book_copy VALUES (
    13,
    3,
    90.23,
    'N',
    '005.74 D691D'
);

INSERT INTO book_copy VALUES (
    12,
    3,
    22.06,
    'N',
    '112.6 S874D'
);

INSERT INTO book_copy VALUES (
    12,
    4,
    19.99,
    'N',
    '823.914 H219A'
);

INSERT INTO book_copy VALUES (
    12,
    5,
    19.99,
    'N',
    '823.914 H219A'
);

UPDATE branch
SET
    branch_count_books = 3
WHERE
    branch_code = 10;

UPDATE branch
SET
    branch_count_books = 5
WHERE
    branch_code = 12;

UPDATE branch
SET
    branch_count_books = 3
WHERE
    branch_code = 13;

-- LOAN

INSERT INTO loan VALUES (
    12,
    1,
    TO_DATE('01-Jun-2021 09:00 AM', 'dd-mon-yyyy hh:mi AM'),
    TO_DATE('15-Jun-2021', 'dd-mon-yyyy'),
    TO_DATE('10-Jun-2021', 'dd-mon-yyyy'),
    4
);

INSERT INTO loan VALUES (
    12,
    2,
    TO_DATE('01-Jun-2021 10:15 AM', 'dd-mon-yyyy hh:mi AM'),
    TO_DATE('15-Jun-2021', 'dd-mon-yyyy'),
    TO_DATE('15-Jun-2021', 'dd-mon-yyyy'),
    4
);

INSERT INTO loan VALUES (
    13,
    1,
    TO_DATE('01-Jun-2021 02:00 PM', 'dd-mon-yyyy hh:mi AM'),
    TO_DATE('15-Jun-2021', 'dd-mon-yyyy'),
    TO_DATE('15-Jun-2021', 'dd-mon-yyyy'),
    5
);

INSERT INTO loan VALUES (
    12,
    1,
    TO_DATE('15-Jun-2021 10:00 AM', 'dd-mon-yyyy hh:mi AM'),
    TO_DATE('29-Jun-2021', 'dd-mon-yyyy'),
    TO_DATE('01-Aug-2021', 'dd-mon-yyyy'),
    1
);

INSERT INTO loan VALUES (
    13,
    1,
    TO_DATE('15-Jun-2021 11:00 AM', 'dd-mon-yyyy hh:mi AM'),
    TO_DATE('29-Jun-2021', 'dd-mon-yyyy'),
    TO_DATE('05-Aug-2021', 'dd-mon-yyyy'),
    1
);

INSERT INTO loan VALUES (
    12,
    2,
    TO_DATE('17-Jun-2021 10:00 AM', 'dd-mon-yyyy hh:mi AM'),
    TO_DATE('01-Jul-2021', 'dd-mon-yyyy'),
    TO_DATE('29-Jun-2021', 'dd-mon-yyyy'),
    3
);

INSERT INTO loan VALUES (
    12,
    1,
    TO_DATE('06-Aug-2021 01:00 PM', 'dd-mon-yyyy hh:mi AM'),
    TO_DATE('20-Aug-2021', 'dd-mon-yyyy'),
    TO_DATE('20-Aug-2021', 'dd-mon-yyyy'),
    4
);

INSERT INTO loan VALUES (
    12,
    2,
    TO_DATE('06-Aug-2021 01:00 PM', 'dd-mon-yyyy hh:mi AM'),
    TO_DATE('20-Aug-2021', 'dd-mon-yyyy'),
    TO_DATE('20-Aug-2021', 'dd-mon-yyyy'),
    5
);

INSERT INTO loan VALUES (
    13,
    1,
    TO_DATE('06-Aug-2021 01:06 PM', 'dd-mon-yyyy hh:mi AM'),
    TO_DATE('20-Aug-2021', 'dd-mon-yyyy'),
    TO_DATE('18-Aug-2021', 'dd-mon-yyyy'),
    4
);

INSERT INTO loan VALUES (
    12,
    4,
    TO_DATE('12-Aug-2021 11:50 AM', 'dd-mon-yyyy hh:mi AM'),
    TO_DATE('26-Aug-2021', 'dd-mon-yyyy'),
    NULL,
    1
);

INSERT INTO loan VALUES (
    12,
    5,
    TO_DATE('13-Aug-2021 10:00 AM', 'dd-mon-yyyy hh:mi AM'),
    TO_DATE('27-Aug-2021', 'dd-mon-yyyy'),
    NULL,
    2
);

-- RESERVE
INSERT INTO reserve VALUES (
    1,
    12,
    4,
    TO_DATE('16-Aug-2021 10:00 AM', 'dd-mon-yyyy hh:mi AM'),
    2
);

INSERT INTO reserve VALUES (
    2,
    12,
    5,
    TO_DATE('18-Aug-2021 11:30 AM', 'dd-mon-yyyy hh:mi AM'),
    1
);

COMMIT;