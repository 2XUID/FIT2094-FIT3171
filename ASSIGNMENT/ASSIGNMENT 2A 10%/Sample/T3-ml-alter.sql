--****PLEASE ENTER YOUR DETAILS BELOW****
--T3-ml-alter.sql

--Student ID: Sample Solution
--Student Name:
--Tutorial No:

/* Comments for your marker:

*/

-- 3 (a)
ALTER TABLE book_copy ADD (
    bc_status CHAR(1) DEFAULT 'G' NOT NULL
);

COMMENT ON COLUMN book_copy.bc_status IS
    'Status of book (D,L,G)';

ALTER TABLE book_copy
    ADD CONSTRAINT bc_status_chk CHECK ( bc_status IN ( 'D', 'L', 'G' ) );

UPDATE book_copy
SET
    bc_status = 'L'
WHERE
        branch_code = (
            SELECT
                branch_code
            FROM
                branch
            WHERE
                branch_contact_no = '0395601655'
        )
    AND book_call_no = '005.74 C824C';

COMMIT;

-- 3 (b)

ALTER TABLE loan ADD (
    loan_return_branch NUMBER(2)
);

COMMENT ON COLUMN loan.loan_return_branch IS
    'Branch which loan was retruned to';

ALTER TABLE loan
    ADD CONSTRAINT loan_ret_branch_fk FOREIGN KEY ( loan_return_branch )
        REFERENCES branch ( branch_code );

UPDATE loan
SET
    loan_return_branch = branch_code
WHERE
    loan_actual_return_date IS NOT NULL;

COMMIT;

-- 3 (c)

DROP TABLE branch_manager PURGE;

CREATE TABLE branch_manager
    AS
        SELECT
            branch_code,
            man_id,
            'A' AS bm_collection
        FROM
            branch;

COMMENT ON COLUMN branch_manager.branch_code IS
    'Branch number';

COMMENT ON COLUMN branch_manager.man_id IS
    'Managers assigned identifier';

COMMENT ON COLUMN branch_manager.bm_collection IS
    'Collection managed (F,R,A)';

ALTER TABLE branch_manager ADD CONSTRAINT branch_manager_pk PRIMARY KEY ( branch_code,
                                                                          man_id );

ALTER TABLE branch_manager
    ADD CONSTRAINT chk_bm_collection CHECK ( bm_collection IN ( 'F', 'R', 'A' ) );

ALTER TABLE branch_manager
    ADD CONSTRAINT branch_manager_bc FOREIGN KEY ( branch_code )
        REFERENCES branch ( branch_code );

ALTER TABLE branch_manager
    ADD CONSTRAINT manager_branch_mi FOREIGN KEY ( man_id )
        REFERENCES manager ( man_id );
        
-- No penalty if not provided as we have not explicitly covered CREATE INDEX
-- have seen in schema file generated from Ass1B when unique used
CREATE UNIQUE INDEX branch_collection_idx ON
    branch_manager (
        branch_code,
        bm_collection
    );

ALTER TABLE branch DROP COLUMN man_id;

-- Could use two separate commits here, one after each operation 
-- Below treats the changes as a single transaction

UPDATE branch_manager
SET
    bm_collection = 'R'
WHERE
        branch_code = (
            SELECT
                branch_code
            FROM
                branch
            WHERE
                branch_contact_no = '0395413120'
        )
    AND man_id = 10;

INSERT INTO branch_manager VALUES (
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