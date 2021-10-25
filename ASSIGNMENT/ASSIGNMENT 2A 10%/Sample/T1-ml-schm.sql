--****PLEASE ENTER YOUR DETAILS BELOW****
--T1-ml-schm.sql

--Student ID: Sample Solution
--Student Name:
--Tutorial No:

/* Comments for your marker:



*/

-- 1.1 Add Create table statments for the Missing TABLES below
-- Ensure all column comments, and constraints (other than FK's)
-- are included. FK constraints are to be added at the end of this script

-- BOOK_COPY
CREATE TABLE book_copy (
    branch_code        NUMBER(2) NOT NULL,
    bc_id              NUMBER(6) NOT NULL,
    bc_purchase_price  NUMBER(7, 2) NOT NULL,
    bc_counter_reserve CHAR(1) NOT NULL,
    book_call_no       VARCHAR2(20) NOT NULL
);

ALTER TABLE book_copy
    ADD CONSTRAINT bc_counter_chk CHECK ( bc_counter_reserve IN ( 'N', 'Y' ) );

COMMENT ON COLUMN book_copy.branch_code IS
    'Branch number ';

COMMENT ON COLUMN book_copy.bc_id IS
    'Book copy id within the branch which owns this book copy';

COMMENT ON COLUMN book_copy.bc_purchase_price IS
    'Purchase price for this copy';

COMMENT ON COLUMN book_copy.bc_counter_reserve IS
    'Flag to indicate if on Counter Reserve or not (Y/N)';

COMMENT ON COLUMN book_copy.book_call_no IS
    'Books call number - identifies a book';

ALTER TABLE book_copy ADD CONSTRAINT book_copy_pk PRIMARY KEY ( bc_id,
                                                                branch_code );

-- LOAN
CREATE TABLE loan (
    branch_code             NUMBER(2) NOT NULL,
    bc_id                   NUMBER(6) NOT NULL,
    loan_date_time          DATE NOT NULL,
    loan_due_date           DATE NOT NULL,
    loan_actual_return_date DATE,
    bor_no                  NUMBER(6) NOT NULL
);

COMMENT ON COLUMN loan.branch_code IS
    'Branch number ';

COMMENT ON COLUMN loan.bc_id IS
    'Book copy id within the branch which owns this book copy';

COMMENT ON COLUMN loan.loan_date_time IS
    'Date and time loan taken out';

COMMENT ON COLUMN loan.loan_due_date IS
    'Date loan due';

COMMENT ON COLUMN loan.loan_actual_return_date IS
    'Actual date loan returned';

COMMENT ON COLUMN loan.bor_no IS
    'Borrower identifier';

ALTER TABLE loan
    ADD CONSTRAINT loan_pk PRIMARY KEY ( bc_id,
                                         branch_code,
                                         loan_date_time );

-- RESERVE
CREATE TABLE reserve (
    reserve_id               NUMBER(6) NOT NULL,
    branch_code              NUMBER(2) NOT NULL,
    bc_id                    NUMBER(6) NOT NULL,
    reserve_date_time_placed DATE NOT NULL,
    bor_no                   NUMBER(6) NOT NULL
);

COMMENT ON COLUMN reserve.reserve_id IS
    'Reservation number';

COMMENT ON COLUMN reserve.branch_code IS
    'Branch number ';

COMMENT ON COLUMN reserve.bc_id IS
    'Book copy id within the branch which owns this book copy';

COMMENT ON COLUMN reserve.reserve_date_time_placed IS
    'Date and time reserve was placed';

COMMENT ON COLUMN reserve.bor_no IS
    'Borrower identifier';

ALTER TABLE reserve ADD CONSTRAINT reserve_pk PRIMARY KEY ( reserve_id );

ALTER TABLE reserve
    ADD CONSTRAINT reserve_nk UNIQUE ( branch_code,
                                       bc_id,
                                       reserve_date_time_placed );

-- Add all missing FK Constraints below here

ALTER TABLE loan
    ADD CONSTRAINT bc_loan FOREIGN KEY ( bc_id,
                                         branch_code )
        REFERENCES book_copy ( bc_id,
                               branch_code );

ALTER TABLE reserve
    ADD CONSTRAINT bc_reserve FOREIGN KEY ( bc_id,
                                            branch_code )
        REFERENCES book_copy ( bc_id,
                               branch_code );

ALTER TABLE book_copy
    ADD CONSTRAINT bd_bc FOREIGN KEY ( book_call_no )
        REFERENCES book_detail ( book_call_no );

ALTER TABLE loan
    ADD CONSTRAINT borr_loan FOREIGN KEY ( bor_no )
        REFERENCES borrower ( bor_no );

ALTER TABLE reserve
    ADD CONSTRAINT borr_reserve FOREIGN KEY ( bor_no )
        REFERENCES borrower ( bor_no );

ALTER TABLE book_copy
    ADD CONSTRAINT branch_bookcopy FOREIGN KEY ( branch_code )
        REFERENCES branch ( branch_code );