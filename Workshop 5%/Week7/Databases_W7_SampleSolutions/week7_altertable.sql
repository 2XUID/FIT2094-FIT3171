spool week7_altertable_output.txt
set echo on

/*
Databases Week 7 Tutorial Sample Solution
week7_altertable.sql

Databases units
Author: FIT Database Teaching Team
License: Copyright © Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice. 
*/


-- 7.4
-- Changing a tables structure
-- ================================================================

ALTER TABLE unit ADD (
    unit_credit_points NUMBER(2, 0) DEFAULT 6
);

COMMENT ON COLUMN unit.unit_credit_points IS
    'Unit credit points';

INSERT INTO unit VALUES (
    'FIT9111',
    'Unit FIT9111',
    12
);

COMMIT;

SELECT
    *
FROM
    unit;


spool off
set echo off
