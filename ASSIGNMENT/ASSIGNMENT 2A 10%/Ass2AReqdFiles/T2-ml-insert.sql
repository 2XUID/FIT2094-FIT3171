--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-ml-insert.sql

--Student ID: 30874157
--Student Name:Rui Qin
--Tutorial No: 02

/* Comments for your marker:




*/

-- 2 (a) Load the BOOK_COPY, LOAN and RESERVE tables with your own
-- test data following the data requirements expressed in the brief
-- BOOK_COPY
INSERT INTO book_copy VALUES (
    10,
    10,
    27.20,
    'Y',
    '005.74 D691D'
);
INSERT INTO book_copy VALUES (
    10,
    17,
    45.20,
    'N',
    '005.756 G476F'
);
INSERT INTO book_copy VALUES (
    10,
    18,
    23.40,
    'N',
    '005.432 L761P'
);
INSERT INTO book_copy VALUES (
    11,
    11,
    12.90,
    'Y',
    '005.756 G476F'
);
INSERT INTO book_copy VALUES (
    11,
    16,
    45.20,
    'N',
    '005.432 L761P'
);

INSERT INTO book_copy VALUES (
    11,
    19,
    23.08,
    'N',
    '823.914 A211H'
);
INSERT INTO book_copy VALUES (
    12,
    12,
    58.20,
    'N',
    '112.6 S874D'
);
INSERT INTO book_copy VALUES (
    12,
    15,
    100.20,
    'N',
    '823.914 H219A'
);
INSERT INTO book_copy VALUES (
    13,
    13,
    45.20,
    'N',
    '005.432 L761P'
);
INSERT INTO book_copy VALUES (
    13,
    14,
    23.08,
    'N',
    '823.914 A211H'
);

--update counter of book in branch
--Clayton
UPDATE branch
SET
    branch_count_books = (
        SELECT
            branch_count_books
        FROM
            branch
        WHERE
            branch_contact_no = '0395413120'
    ) + 3
WHERE
    branch_code = (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395413120'
    );
--Glen Waverley
UPDATE branch
SET
    branch_count_books = (
        SELECT
            branch_count_books
        FROM
            branch
        WHERE
            branch_contact_no = '0395601655'
    ) + 3
WHERE
    branch_code = (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395601655'
    );
--Mount Waverley
UPDATE branch
SET
    branch_count_books = (
        SELECT
            branch_count_books
        FROM
            branch
        WHERE
            branch_contact_no = '0398075022'
    ) + 2
WHERE
    branch_code = (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0398075022'
    );
--Mulgrave
UPDATE branch
SET
    branch_count_books = (
        SELECT
            branch_count_books
        FROM
            branch
        WHERE
            branch_contact_no = '0395461253'
    ) + 2
WHERE
    branch_code = (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395461253'
    );


-- LOAN
INSERT INTO loan VALUES (
    11,
    19,
    TO_DATE('2021/08/03', 'yyyy/mm/dd'),
    TO_DATE('2021/08/17', 'yyyy/mm/dd'),
    TO_DATE('2021/08/21', 'yyyy/mm/dd'),
    1
);
INSERT INTO loan VALUES (
    11,
    16,
    TO_DATE('2021/08/03', 'yyyy/mm/dd'),
    TO_DATE('2021/08/17', 'yyyy/mm/dd'),
    TO_DATE('2021/08/14', 'yyyy/mm/dd'),
    1
);
INSERT INTO loan VALUES (
    10,
    18,
    TO_DATE('2021/08/01', 'yyyy/mm/dd'),
    TO_DATE('2021/08/15', 'yyyy/mm/dd'),
    TO_DATE('2021/08/04', 'yyyy/mm/dd'),
    2
);
INSERT INTO loan VALUES (
    12,
    12,
    TO_DATE('2021/08/01', 'yyyy/mm/dd'),
    TO_DATE('2021/08/15', 'yyyy/mm/dd'),
    TO_DATE('2021/08/04', 'yyyy/mm/dd'),
    2
);
INSERT INTO loan VALUES (
    12,
    15,
    TO_DATE('2021/08/01', 'yyyy/mm/dd'),
    TO_DATE('2021/08/15', 'yyyy/mm/dd'),
    TO_DATE('2021/08/07', 'yyyy/mm/dd'),
    2
);
INSERT INTO loan VALUES (
    10,
    10,
    TO_DATE('2021/08/04', 'yyyy/mm/dd'),
    TO_DATE('2021/08/18', 'yyyy/mm/dd'),
    TO_DATE('2021/08/12', 'yyyy/mm/dd'),
    3
);
INSERT INTO loan VALUES (
    13,
    13,
    TO_DATE('2021/08/04', 'yyyy/mm/dd'),
    TO_DATE('2021/08/18', 'yyyy/mm/dd'),
    TO_DATE('2021/08/12', 'yyyy/mm/dd'),
    3
);
INSERT INTO loan VALUES (
    11,
    11,
    TO_DATE('2021/08/04', 'yyyy/mm/dd'),
    TO_DATE('2021/08/18', 'yyyy/mm/dd'),
    TO_DATE('2021/08/12', 'yyyy/mm/dd'),
    3
);
-- RESERVE
INSERT INTO reserve VALUES (
    10,
    12,
    12,
    TO_DATE('2021/08/29 16:00:00','yyyy/mm/dd hh24:mi:ss'),
    5
);
INSERT INTO reserve VALUES (
    11,
    13,
    13,
    TO_DATE('2021/08/30 16:00:00','yyyy/mm/dd hh24:mi:ss'),
    1
);
COMMIT;