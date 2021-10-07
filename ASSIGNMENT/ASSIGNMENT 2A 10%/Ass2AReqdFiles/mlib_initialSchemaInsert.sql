-- Database Teaching Team
-- Assignment 2A 2021 S2
-- Monash Library partial schema and insert
-- This script must not be altered in ANY WAY


--book_detail
CREATE TABLE book_detail (
    book_call_no        VARCHAR2(20) NOT NULL,
    book_title          VARCHAR2(100) NOT NULL,
    book_classification CHAR(1) NOT NULL,
    book_no_pages       NUMBER(4) NOT NULL,
    book_pub_year       DATE NOT NULL,
    book_edition        VARCHAR2(3)
);

ALTER TABLE book_detail
    ADD CONSTRAINT bk_classif_chk CHECK ( book_classification IN ( 'F', 'R' ) );

COMMENT ON COLUMN book_detail.book_call_no IS
    'Books call number - identifies a book';

COMMENT ON COLUMN book_detail.book_title IS
    'Title of book';

COMMENT ON COLUMN book_detail.book_classification IS
    'Book classification - (R)eference or (F)iction';

COMMENT ON COLUMN book_detail.book_no_pages IS
    'No of pages in the book';

COMMENT ON COLUMN book_detail.book_pub_year IS
    'Publication year of book';

COMMENT ON COLUMN book_detail.book_edition IS
    'Book Edition';

ALTER TABLE book_detail ADD CONSTRAINT book_detail_pk PRIMARY KEY ( book_call_no );


--borrower
CREATE TABLE borrower (
    bor_no       NUMBER(6) NOT NULL,
    bor_fname    VARCHAR2(59) NOT NULL,
    bor_lname    VARCHAR2(50) NOT NULL,
    bor_street   VARCHAR2(80) NOT NULL,
    bor_suburb   VARCHAR2(50) NOT NULL,
    bor_postcode CHAR(4) NOT NULL,
    branch_code  NUMBER(2) NOT NULL
);

COMMENT ON COLUMN borrower.bor_no IS
    'Borrower identifier';

COMMENT ON COLUMN borrower.bor_fname IS
    'Borrowers first name';

COMMENT ON COLUMN borrower.bor_lname IS
    'Borrowers last name';

COMMENT ON COLUMN borrower.bor_street IS
    'Borrowers street address';

COMMENT ON COLUMN borrower.bor_suburb IS
    'Borrowers suburb';

COMMENT ON COLUMN borrower.bor_postcode IS
    'Borrowers postcode';

COMMENT ON COLUMN borrower.branch_code IS
    'Branch number ';

ALTER TABLE borrower ADD CONSTRAINT borrower_pk PRIMARY KEY ( bor_no );


--branch
CREATE TABLE branch (
    branch_code        NUMBER(2) NOT NULL,
    branch_name        VARCHAR2(50) NOT NULL,
    branch_address     VARCHAR2(100) NOT NULL,
    branch_contact_no  CHAR(10) NOT NULL,
    branch_count_books NUMBER(5) NOT NULL,
    man_id             NUMBER(2) NOT NULL
);

COMMENT ON COLUMN branch.branch_code IS
    'Branch number ';

COMMENT ON COLUMN branch.branch_name IS
    'Name of Branch';

COMMENT ON COLUMN branch.branch_address IS
    'Address of Branch';

COMMENT ON COLUMN branch.branch_contact_no IS
    'Branch Phone Number';

COMMENT ON COLUMN branch.branch_count_books IS
    'Count of book copies registered to the branch';

COMMENT ON COLUMN branch.man_id IS
    'Managers assigned identifier';

ALTER TABLE branch ADD CONSTRAINT branch_pk PRIMARY KEY ( branch_code );

ALTER TABLE branch ADD CONSTRAINT branch_contact_no_uq UNIQUE ( branch_contact_no );


--manager
CREATE TABLE manager (
    man_id         NUMBER(2) NOT NULL,
    man_fname      VARCHAR2(50) NOT NULL,
    man_lname      VARCHAR2(50) NOT NULL,
    man_contact_no CHAR(10) NOT NULL
);

COMMENT ON COLUMN manager.man_id IS
    'Managers assigned identifier';

COMMENT ON COLUMN manager.man_fname IS
    'Managers first name';

COMMENT ON COLUMN manager.man_lname IS
    'Managers last name';

COMMENT ON COLUMN manager.man_contact_no IS
    'Managers contact number';

ALTER TABLE manager ADD CONSTRAINT manager_pk PRIMARY KEY ( man_id );

ALTER TABLE borrower
    ADD CONSTRAINT branch_borr FOREIGN KEY ( branch_code )
        REFERENCES branch ( branch_code );

ALTER TABLE branch
    ADD CONSTRAINT manager_branch FOREIGN KEY ( man_id )
        REFERENCES manager ( man_id );
-- insert sample data


-- data for MANAGER table.
INSERT INTO manager VALUES (
    10,
    'Indiana',
    'Jones',
    '0402982977'
);

INSERT INTO manager VALUES (
    11,
    'Lara',
    'Croft',
    '0402983090'
);

INSERT INTO manager VALUES (
    12,
    'Nathan',
    'Drake',
    '1410402977'
);


-- data for BRANCH table.
INSERT INTO branch VALUES (
    10,
    'Clayton Library',
    '9-15 Cooke Street, Clayton 3168',
    '0395413120',
    0,
    10
);

INSERT INTO branch VALUES (
    11,
    'Glen Waverley Library',
    '112 Kingsway, Glen Waverley 3150',
    '0395601655',
    0,
    11
);

INSERT INTO branch VALUES (
    12,
    'Mount Waverley Library',
    '41 Miller Crescent, Mount Waverley 3149',
    '0398075022',
    0,
    11
);

INSERT INTO branch VALUES (
    13,
    'Mulgrave Library',
    '36 - 42 Mackie Road, Mulgrave 3170',
    '0395461253',
    0,
    12
);


-- data for borrower table.
INSERT INTO borrower VALUES (
    1,
    'Mark',
    'Zuckerberg',
    '1 Facebook Way',
    'Faceville',
    '1000',
    10
);

INSERT INTO borrower VALUES (
    2,
    'Sergey',
    'Brin',
    '2 Alphabet Way',
    'Alphaville',
    '2000',
    11
);

INSERT INTO borrower VALUES (
    3,
    'Larry',
    'Page',
    '1 Alphabet Way',
    'Alphaville',
    '2000',
    11
);

INSERT INTO borrower VALUES (
    4,
    'Bill',
    'Gates',
    '1 Microsoft Way',
    'Microville',
    '3000',
    12
);

INSERT INTO borrower VALUES (
    5,
    'Tim',
    'Cook',
    '1 ApplePark Lane',
    'Appleville',
    '4000',
    13
);


-- data for BOOK_DETAIL table.
INSERT INTO book_detail VALUES (
    '005.74 D691D',
    'Database integrity challenges and solutions',
    'R',
    344,
    TO_DATE('2002', 'YYYY'),
    NULL
);

INSERT INTO book_detail VALUES (
    '005.756 G476F',
    'Fundamentals of database management systems',
    'R',
    395,
    TO_DATE('2012', 'YYYY'),
    '2'
);

INSERT INTO book_detail VALUES (
    '112.6 S874D',
    'Digital copyright : law and practice',
    'R',
    298,
    TO_DATE('2019', 'YYYY'),
    '5'
);

INSERT INTO book_detail VALUES (
    '005.432 L761P',
    'A practical guide to linux commands, editors, and shell programming',
    'R',
    1184,
    TO_DATE('2018', 'YYYY'),
    '4'
);

INSERT INTO book_detail VALUES (
    '823.914 A211H',
    'The hitchhiker''s guide to the galaxy',
    'F',
    158,
    TO_DATE('1979', 'YYYY'),
    NULL
);

INSERT INTO book_detail VALUES (
    '823.914 H219A',
    'The abyss beyond dreams',
    'F',
    614,
    TO_DATE('2014', 'YYYY'),
    NULL
);

COMMIT;

