--****PLEASE ENTER YOUR DETAILS BELOW****
--T1-ml-drop.sql

--Student ID: 30874157
--Student Name:Rui Qin
--Tutorial No: 02

/* Comments for your marker:




*/

-- 1.2 Add Drop table statements for ALL table below (not just those created
-- in this script)use ONLY
--      DROP TABLE tblname PURGE
-- syntax DO NOT use CASCADE CONSTRAINTS

ALTER TABLE borrower
  DROP CONSTRAINT branch_borr;

ALTER TABLE branch
  DROP CONSTRAINT branch_contact_no_uq;

ALTER TABLE book_copy
  DROP CONSTRAINT book_detail_book_copy;

ALTER TABLE book_copy
  DROP CONSTRAINT branch_book_copy;

ALTER TABLE loan
  DROP CONSTRAINT book_copy_loan;

ALTER TABLE loan
  DROP CONSTRAINT borrower_loan;

ALTER TABLE reserve
  DROP CONSTRAINT reserve_uq;

ALTER TABLE reserve
  DROP CONSTRAINT borrower_reserve;

ALTER TABLE reserve
  DROP CONSTRAINT book_copy_reserve;

ALTER TABLE loan
  DROP CONSTRAINT loan_branch;

DROP TABLE book_copy PURGE;

DROP TABLE book_detail PURGE;

DROP TABLE loan PURGE;

DROP TABLE reserve PURGE;

DROP TABLE borrower PURGE;

-- Drop the manager_type is for the T3 new table 
-- which relate with manager and branch

ALTER TABLE manager_type
  DROP CONSTRAINT manager_type_branch;
  
ALTER TABLE manager_type
  DROP CONSTRAINT manager_type_manager;

DROP TABLE manager_type PURGE;

DROP TABLE manager PURGE;

DROP TABLE branch PURGE;

COMMIT;