--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-ml-dm.sql

--Student ID: Sample Solution
--Student Name:
--Tutorial No:

/* Comments for your marker:




*/

-- 2 (b) (i)
-- Book details
INSERT INTO book_detail VALUES (
    '005.74 C824C',
    'Database Systems: Design, Implementation, and Management',
    'R',
    793,
    TO_DATE('2019', 'YYYY'),
    '13'
);

-- first copy
insert into book_copy values (
(select branch_code from branch where branch_contact_no = '0395413120'),
(
        SELECT
            branch_count_books + 1
        FROM
            branch
        WHERE
            branch_contact_no = '0395413120'),120,'N','005.74 C824C');

UPDATE branch
    SET
        branch_count_books = branch_count_books + 1
WHERE
    branch_contact_no = '0395413120';

-- second copy
insert into book_copy values (
(select branch_code from branch where branch_contact_no = '0395601655'),
(
        SELECT
            branch_count_books + 1
        FROM
            branch
        WHERE
            branch_contact_no = '0395601655'),120,'N','005.74 C824C');

UPDATE branch
    SET
        branch_count_books = branch_count_books + 1
WHERE
    branch_contact_no = '0395601655';

-- third copy
insert into book_copy values (
(select branch_code from branch where branch_contact_no = '0395461253'),
(
        SELECT
            branch_count_books + 1
        FROM
            branch
        WHERE
            branch_contact_no = '0395461253'),120,'N','005.74 C824C');

UPDATE branch
    SET
        branch_count_books = branch_count_books + 1
WHERE
    branch_contact_no = '0395461253';

COMMIT;

-- 2 (b) (ii)

DROP SEQUENCE borrower_seq;

DROP SEQUENCE reserve_seq;

CREATE SEQUENCE borrower_seq START WITH 100;

CREATE SEQUENCE reserve_seq START WITH 100;

-- 2 (b) (iii)

INSERT INTO borrower VALUES (
    borrower_seq.NEXTVAL,
    'Ada',
    'Lovelace',
    '1 Programmer Way',
    'Programville',
    '5000',
    (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395413120'
    )
);

COMMIT;

INSERT INTO reserve VALUES (
    reserve_seq.nextval,
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
            AND   branch_code = (
                SELECT
                    branch_code
                FROM
                    branch
                WHERE
                    branch_contact_no = '0395413120'
            )
    ),
    TO_DATE('14-Sep-2021 3:30 PM','DD-MON-YYYY HH:MI PM'),
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

COMMIT;

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
            book_call_no = '005.74 C824C'
            AND   branch_code = (
                SELECT
                    branch_code
                FROM
                    branch
                WHERE
                    branch_contact_no = '0395413120'
            )
    ),
    (TO_DATE('14-Sep-2021 3:30 PM','DD-MON-YYYY HH:MI PM') - 3/24) + 7,
    TO_DATE('14-Sep-2021','DD-MON-YYYY') + 7 + 14,
    NULL,
    (
        SELECT
            bor_no
        FROM
            borrower
        WHERE
            bor_fname = 'Ada'
            AND   bor_lname = 'Lovelace'
    )
);

DELETE FROM reserve
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
                book_call_no = '005.74 C824C'
            AND branch_code = (
                SELECT
                    branch_code
                FROM
                    branch
                WHERE
                    branch_contact_no = '0395413120'
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
    );

COMMIT;