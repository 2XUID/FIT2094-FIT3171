--****PLEASE ENTER YOUR DETAILS BELOW****
--T3-ml-alter.sql

--Student ID: 30874157
--Student Name:Rui Qin
--Tutorial No: 02

/* Comments for your marker:




*/

-- 3 (a)
ALTER TABLE book_copy ADD bc_state CHAR(1) DEFAULT 'G' NOT NULL ;
COMMENT ON COLUMN book_copy.bc_state IS
    'Record whether a book is damaged (D) or lost (L) or good (G)';
ALTER TABLE book_copy
    ADD CONSTRAINT bc_state_chk CHECK ( bc_state IN (
        'D',
        'L',
        'G'
    ) );

-- update the special book state
UPDATE book_copy
SET
    bc_state = 'L'
WHERE
    branch_code = (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395601655'
    )AND
    bc_id = (
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
                    branch_contact_no = '0395601655'
            )
    );


-- 3 (b)
ALTER TABLE loan ADD branch_bc_returned NUMERIC(2);

COMMENT ON COLUMN loan.branch_bc_returned IS
    'Branch code where book is returned';

ALTER TABLE loan
    ADD CONSTRAINT loan_branch FOREIGN KEY ( branch_bc_returned )
        REFERENCES branch ( branch_code );

UPDATE loan
SET
    branch_bc_returned = branch_code
WHERE
    loan_actual_return_date IS NOT NULL;


-- 3 (c)
CREATE TABLE manager_type (
    branch_code       NUMERIC(2) NOT NULL,
    man_id            NUMERIC(2) NOT NULL,
    mt_type           CHAR(2) NOT NULL
);

COMMENT ON COLUMN manager_type.branch_code IS
    'Branch number ';

COMMENT ON COLUMN manager_type.man_id IS
    'Manager id ';

COMMENT ON COLUMN manager_type.mt_type IS
    'type of collection manager manages - F (Fiction),R(Reference), FR(Fiction Reference)';

--because the relationship change, not min one max one so drop man_id
ALTER TABLE branch DROP COLUMN man_id;
--define primary key
ALTER TABLE manager_type ADD CONSTRAINT manager_type_pk PRIMARY KEY ( branch_code,
                                                                      man_id );
ALTER TABLE manager_type
    ADD CONSTRAINT manager_type_branch FOREIGN KEY ( branch_code )
        REFERENCES branch ( branch_code );

ALTER TABLE manager_type
    ADD CONSTRAINT manager_type_manager FOREIGN KEY ( man_id )
        REFERENCES manager ( man_id );

ALTER TABLE manager_type
    ADD CONSTRAINT mt_type_chk CHECK ( mt_type IN (
        'F',
        'R',
        'FR'
    ) );

-- insert manager of clayton
INSERT INTO manager_type VALUES (
    (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395413120'
    ),
    10,
    'R'
);

INSERT INTO manager_type VALUES (
    (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395413120'
    ),
    12,
    'F'
);

COMMIT;