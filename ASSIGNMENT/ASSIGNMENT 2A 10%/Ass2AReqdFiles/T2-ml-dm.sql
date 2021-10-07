--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-ml-dm.sql

--Student ID: 30874157
--Student Name:Rui Qin
--Tutorial No: 02

/* Comments for your marker:



*/

-- 2 (b) (i)


-- insert new book
INSERT INTO book_detail VALUES (
    '005.74 C824C',
    'Database Systems: Design, Implementation, and Management',
    'R',
    793,
    TO_DATE('2019','YYYY'),
    '13'
);
-- insert new book's copy
INSERT INTO book_copy VALUES (
    10,
    20,
    120.00,
    'N',
    '005.74 C824C'
);
INSERT INTO book_copy VALUES (
    11,
    20,
    120.00,
    'N',
    '005.74 C824C'
);
INSERT INTO book_copy VALUES (
    13,
    20,
    120.00,
    'N',
    '005.74 C824C'
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
    ) + 1
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
    ) + 1
WHERE
    branch_code = (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395601655'
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
    ) + 1
WHERE
    branch_code = (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395461253'
    );


-- 2 (b) (ii)
CREATE SEQUENCE bor_no_seq START WITH 100 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE reserve_id_seq START WITH 100 INCREMENT BY 1 NOCACHE;
--DROP SEQUENCE bor_no_seq;
--DROP SEQUENCE reserve_id_seq;
--These are drop of sequences, but I need to use sequences under so I drop before commit.


-- 2 (b) (iii)
INSERT INTO borrower VALUES (
    bor_no_seq.NEXTVAL,
    'Ada',
    'Lovelace',
    '1 Swanston street',
    'Melbourne',
    '3000',
    (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395413120'
    )
);
INSERT INTO reserve VALUES (
    reserve_id_seq.NEXTVAL,
    (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395413120'
    ),
    (
        SELECT
            bc_id
        FROM
            book_copy
        WHERE
            book_call_no = '005.74 C824C'
            AND branch_code = (
                SELECT
                    branch_code
                FROM
                    branch
                WHERE
                    branch_contact_no = '0395413120'
            )
    ),
    TO_DATE('2021/09/14 15:30:00','yyyy/mm/dd hh24:mi:ss'),
    bor_no_seq.CURRVAL
);


-- 2 (b) (iv)
INSERT INTO loan VALUES (
    (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395413120'
    ),
    (
        SELECT
            bc_id
        FROM
            book_copy
        WHERE
            branch_code = (
                SELECT
                    branch_code
                FROM
                    branch
                WHERE
                    branch_contact_no = '0395413120'
            )
            AND bc_id = (
                SELECT
                    bc_id
                FROM
                    book_copy
                WHERE
                    branch_code = (
                        SELECT
                            branch_code
                        FROM
                            branch
                        WHERE
                            branch_contact_no = '0395413120'
                    )
                    AND book_call_no = '005.74 C824C'
            )
    ),
    (
        SELECT
            reserve_date_time_placed + 7 - ( 2 / 24 )
        FROM
            reserve
        WHERE
            branch_code = (
                SELECT
                    branch_code
                FROM
                    branch
                WHERE
                    branch_contact_no = '0395413120'
            )
            AND bc_id = (
                SELECT
                    bc_id
                FROM
                    book_copy
                WHERE
                    branch_code = (
                        SELECT
                            branch_code
                        FROM
                            branch
                        WHERE
                            branch_contact_no = '0395413120'
                    )
                    AND book_call_no = '005.74 C824C'
            )
            AND bor_no = (
                SELECT
                    bor_no
                FROM
                    borrower
                WHERE
                    bor_fname = 'Ada'
                    AND bor_lname = 'Lovelace'
            )
    ),
    (
        SELECT
            reserve_date_time_placed + 7 - ( 2 / 24 ) + 14
        FROM
            reserve
        WHERE
            branch_code = (
                SELECT
                    branch_code
                FROM
                    branch
                WHERE
                    branch_contact_no = '0395413120'
            )
            AND bc_id = (
                SELECT
                    bc_id
                FROM
                    book_copy
                WHERE
                    branch_code = (
                        SELECT
                            branch_code
                        FROM
                            branch
                        WHERE
                            branch_contact_no = '0395413120'
                    )
                    AND book_call_no = '005.74 C824C'
            )
            AND bor_no = (
                SELECT
                    bor_no
                FROM
                    borrower
                WHERE
                    bor_fname = 'Ada'
                    AND bor_lname = 'Lovelace'
            )
    ),
    NULL,
    (
        SELECT
            bor_no
        FROM
            borrower
        WHERE
            bor_fname = 'Ada'
            AND bor_lname = 'Lovelace'
    )
);

DELETE FROM reserve
WHERE
    bor_no = (
        SELECT
            bor_no
        FROM
            borrower
        WHERE
            bor_fname = 'Ada'
            AND bor_lname = 'Lovelace'
    )
    AND branch_code = (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395413120'
    )
    AND bc_id = (
        SELECT
            bc_id
        FROM
            book_copy
        WHERE
            branch_code = (
                SELECT
                    branch_code
                FROM
                    branch
                WHERE
                    branch_contact_no = '0395413120'
            )
            AND book_call_no = '005.74 C824C'
    );

DROP SEQUENCE bor_no_seq;
DROP SEQUENCE reserve_id_seq;
COMMIT