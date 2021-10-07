--****PLEASE ENTER YOUR DETAILS BELOW****
--T3-ml-alter.sql

--Student ID: 30874157
--Student Name:Rui Qin
--Tutorial No: 02

/* Comments for your marker:




*/

CREATE TABLE book_copy (
    branch_code          NUMBER(2) NOT NULL,
    bc_id                NUMBER(6) NOT NULL,
    bc_purchase_price    NUMBER(7, 2) NOT NULL,
    bc_counter_reserve   CHAR(1) NOT NULL,
    book_call_no         VARCHAR2(20) NOT NULL,
    CONSTRAINT book_copy_pk PRIMARY KEY ( bc_id,
                                          branch_code ),
    CONSTRAINT bc_counter_reserve_chk CHECK ( bc_counter_reserve IN ( 'Y', 'N' ) )
);
COMMENT ON COLUMN book_copy.branch_code IS
    'Branch number ';

COMMENT ON COLUMN book_copy.bc_id IS
    'book copy identifier';

COMMENT ON COLUMN book_copy.bc_purchase_price IS
    'Purchase price for this copy';

COMMENT ON COLUMN book_copy.bc_counter_reserve IS
    'Flag to indicate if on Counter Reserve or not (Y/N)';

COMMENT ON COLUMN book_copy.book_call_no IS
    'Books call number - identifies a book';

-- LOAN
CREATE TABLE loan (
    branch_code              NUMBER(2) NOT NULL,
    bc_id                    NUMBER(6) NOT NULL,
    loan_date_time           DATE NOT NULL,
    loan_due_date            DATE NOT NULL,
    loan_actual_return_date  DATE,
    bor_no                   NUMBER(6) NOT NULL,
    CONSTRAINT loan_pk PRIMARY KEY ( loan_date_time,
                                         bc_id,
                                         branch_code )
);

COMMENT ON COLUMN loan.branch_code IS
    'Branch number ';

COMMENT ON COLUMN loan.bc_id IS
    'Book copy id unique within the branch which owns this book copy';

COMMENT ON COLUMN loan.loan_date_time IS
    'Date and time loan taken out';

COMMENT ON COLUMN loan.loan_due_date IS
    'Date loan due ';

COMMENT ON COLUMN loan.loan_actual_return_date IS
    'Actual date loan returned';

COMMENT ON COLUMN loan.bor_no IS
    'Borrower identifier';


-- RESERVE
CREATE TABLE reserve (
    reserve_id                NUMBER(6) NOT NULL,
    branch_code               NUMBER(2) NOT NULL,
    bc_id                     NUMBER(6) NOT NULL,
    reserve_date_time_placed  DATE NOT NULL,
    bor_no                    NUMBER(6) NOT NULL,
    CONSTRAINT reserve_pk PRIMARY KEY ( reserve_id ),
    CONSTRAINT reserve_uq UNIQUE ( branch_code,
                                   bc_id,
                                   reserve_date_time_placed )
);
COMMENT ON COLUMN reserve.reserve_id IS
    'Reservation number (unique across all branches)';

COMMENT ON COLUMN reserve.branch_code IS
    'Branch number ';

COMMENT ON COLUMN reserve.bc_id IS
    'Book copy id unique within the branch which owns this book copy';

COMMENT ON COLUMN reserve.reserve_date_time_placed IS
    'Reservation number (unique across all branches)';

COMMENT ON COLUMN reserve.bor_no IS
    'Borrower identifier';

-- Add all missing FK Constraints below here


-- BOOK_COPY
ALTER TABLE book_copy
    ADD CONSTRAINT book_detail_book_copy FOREIGN KEY ( book_call_no )
        REFERENCES book_detail ( book_call_no );

ALTER TABLE book_copy
    ADD CONSTRAINT branch_book_copy FOREIGN KEY ( branch_code )
        REFERENCES branch ( branch_code );


-- LOAN
ALTER TABLE loan
    ADD CONSTRAINT book_copy_loan FOREIGN KEY ( bc_id,
                                                branch_code )
        REFERENCES book_copy ( bc_id,
                               branch_code );

ALTER TABLE loan
    ADD CONSTRAINT borrower_loan FOREIGN KEY ( bor_no )
        REFERENCES borrower ( bor_no );


-- RESERVE
ALTER TABLE reserve
    ADD CONSTRAINT borrower_reserve FOREIGN KEY ( bor_no )
        REFERENCES borrower ( bor_no );

ALTER TABLE reserve
    ADD CONSTRAINT book_copy_reserve FOREIGN KEY ( bc_id,
                                                   branch_code )
        REFERENCES book_copy ( bc_id,
                               branch_code );

COMMIT;
