SET ECHO ON
SPOOL prop_rental_schema_output.txt

-- Database Teaching Team
-- Property Rental Logical Model Schema script file
-- Schema file includes example constraint to control pay_type


/*
Databases Week 6 Tutorial Sample Solution
prop_rental_schema.sql

Databases Units
Author: FIT Database Teaching Team
License: Copyright © Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice. 
*/



DROP TABLE damage CASCADE CONSTRAINTS;

DROP TABLE maintenance CASCADE CONSTRAINTS;

DROP TABLE owner CASCADE CONSTRAINTS;

DROP TABLE payment CASCADE CONSTRAINTS;

DROP TABLE paymethod CASCADE CONSTRAINTS;

DROP TABLE property CASCADE CONSTRAINTS;

DROP TABLE rent CASCADE CONSTRAINTS;

DROP TABLE tenant CASCADE CONSTRAINTS;


CREATE TABLE damage (
    dam_no             NUMBER(5) NOT NULL,
    dam_datetime       DATE NOT NULL,
    rent_agreement_no  NUMBER(5) NOT NULL,
    dam_type           VARCHAR2(50) NOT NULL,
    dam_cost           NUMBER(6, 2) NOT NULL,
    pay_no             NUMBER(6)
);

COMMENT ON COLUMN damage.dam_no IS
    'Damage number';

COMMENT ON COLUMN damage.dam_datetime IS
    'Date and time damage occured';

COMMENT ON COLUMN damage.rent_agreement_no IS
    'Rental agreement number';

COMMENT ON COLUMN damage.dam_type IS
    'Description of the type of damage';

COMMENT ON COLUMN damage.dam_cost IS
    'Cost of repairs for damage';

COMMENT ON COLUMN damage.pay_no IS
    'Receipt number of payment';

CREATE UNIQUE INDEX damage__idx ON
    damage (
        pay_no
    ASC );

ALTER TABLE damage ADD CONSTRAINT damage_pk PRIMARY KEY ( dam_no );

ALTER TABLE damage ADD CONSTRAINT damage_nk UNIQUE ( rent_agreement_no,
                                                     dam_datetime );

CREATE TABLE maintenance (
    prop_no         NUMBER(4) NOT NULL,
    maint_datetime  DATE NOT NULL,
    maint_desc      VARCHAR2(50) NOT NULL,
    maint_cost      NUMBER(8, 2) NOT NULL
);

COMMENT ON COLUMN maintenance.prop_no IS
    'Unique property identifier';

COMMENT ON COLUMN maintenance.maint_datetime IS
    'Date maintenance was carried out';

COMMENT ON COLUMN maintenance.maint_desc IS
    'Desciption of maintenace carried out';

COMMENT ON COLUMN maintenance.maint_cost IS
    'Cost of maintenace item';

ALTER TABLE maintenance ADD CONSTRAINT maintenance_pk PRIMARY KEY ( prop_no,
                                                                    maint_datetime );

CREATE TABLE owner (
    owner_no       NUMBER(4) NOT NULL,
    owner_givname  VARCHAR2(20),
    owner_famname  VARCHAR2(20),
    owner_address  VARCHAR2(40) NOT NULL
);

COMMENT ON COLUMN owner.owner_no IS
    'Unique identifier for owner ';

COMMENT ON COLUMN owner.owner_givname IS
    'Given name of property owner';

COMMENT ON COLUMN owner.owner_famname IS
    'Family name of property owner';

COMMENT ON COLUMN owner.owner_address IS
    'Address of property owner';

ALTER TABLE owner ADD CONSTRAINT owner_pk PRIMARY KEY ( owner_no );

CREATE TABLE payment (
    pay_no             NUMBER(6) NOT NULL,
    pay_date           DATE NOT NULL,
    pay_type           CHAR(1) NOT NULL,
    pay_amount         NUMBER(6, 2) NOT NULL,
    rent_agreement_no  NUMBER(5) NOT NULL,
    pay_paidby         NUMBER(4) NOT NULL
);

ALTER TABLE payment
    ADD CONSTRAINT chk_pay_type CHECK ( pay_type IN ( 'B', 'D', 'R' ) );

COMMENT ON COLUMN payment.pay_no IS
    'Receipt number of payment';

COMMENT ON COLUMN payment.pay_date IS
    'Date of payment';

COMMENT ON COLUMN payment.pay_type IS
    'Type of payment (Bond, Damage, Rental)';

COMMENT ON COLUMN payment.pay_amount IS
    'Amount of payment';

COMMENT ON COLUMN payment.rent_agreement_no IS
    'Rental agreement number';

COMMENT ON COLUMN payment.pay_paidby IS
    'Id of payment method';

ALTER TABLE payment ADD CONSTRAINT payment_pk PRIMARY KEY ( pay_no );

CREATE TABLE paymethod (
    paymethod_id    NUMBER(4) NOT NULL,
    paymethod_name  VARCHAR2(15) NOT NULL
);

COMMENT ON COLUMN paymethod.paymethod_id IS
    'Id of payment method';

COMMENT ON COLUMN paymethod.paymethod_name IS
    'Name of payment method';

ALTER TABLE paymethod ADD CONSTRAINT paymethod_pk PRIMARY KEY ( paymethod_id );

CREATE TABLE property (
    prop_no       NUMBER(4) NOT NULL,
    prop_address  VARCHAR2(40) NOT NULL,
    prop_value    NUMBER(10, 2) NOT NULL,
    owner_no      NUMBER(4) NOT NULL
);

COMMENT ON COLUMN property.prop_no IS
    'Unique property identifier';

COMMENT ON COLUMN property.prop_address IS
    'Address of property';

COMMENT ON COLUMN property.prop_value IS
    'Value of property';

COMMENT ON COLUMN property.owner_no IS
    'Unique identifier for owner ';

ALTER TABLE property ADD CONSTRAINT property_pk PRIMARY KEY ( prop_no );

CREATE TABLE rent (
    rent_agreement_no  NUMBER(5) NOT NULL,
    rent_lease_start   DATE NOT NULL,
    rent_weekly_rate   NUMBER(6, 2) NOT NULL,
    rent_bond          NUMBER(6, 2) NOT NULL,
    rent_lease_period  NUMBER(2) NOT NULL,
    prop_no            NUMBER(4) NOT NULL,
    tenant_no          NUMBER(4) NOT NULL
);

COMMENT ON COLUMN rent.rent_agreement_no IS
    'Rental agreement number';

COMMENT ON COLUMN rent.rent_lease_start IS
    'Date on which rental agreement starts';

COMMENT ON COLUMN rent.rent_weekly_rate IS
    'Weekly rental rate paid by tenant';

COMMENT ON COLUMN rent.rent_bond IS
    'Bond paid by tenant';

COMMENT ON COLUMN rent.rent_lease_period IS
    'Period in months for lease';

COMMENT ON COLUMN rent.prop_no IS
    'Unique property identifier';

COMMENT ON COLUMN rent.tenant_no IS
    'Unique identifier for tenant';

ALTER TABLE rent ADD CONSTRAINT rent_pk PRIMARY KEY ( rent_agreement_no );

ALTER TABLE rent ADD CONSTRAINT rent_nk UNIQUE ( prop_no,
                                                 rent_lease_start );

CREATE TABLE tenant (
    tenant_no       NUMBER(4) NOT NULL,
    tenant_famname  VARCHAR2(20),
    tenant_givname  VARCHAR2(20),
    tenant_address  VARCHAR2(40) NOT NULL,
    tenant_phone    CHAR(10) NOT NULL
);

COMMENT ON COLUMN tenant.tenant_no IS
    'Unique identifier for tenant';

COMMENT ON COLUMN tenant.tenant_famname IS
    'Family name of tenant';

COMMENT ON COLUMN tenant.tenant_givname IS
    'Given name of tenant';

COMMENT ON COLUMN tenant.tenant_address IS
    'Address of  tenant';

COMMENT ON COLUMN tenant.tenant_phone IS
    'Phone number of tenant ';

ALTER TABLE tenant ADD CONSTRAINT tenant_pk PRIMARY KEY ( tenant_no );

ALTER TABLE damage
    ADD CONSTRAINT damage_payment FOREIGN KEY ( pay_no )
        REFERENCES payment ( pay_no );

ALTER TABLE property
    ADD CONSTRAINT owner_property FOREIGN KEY ( owner_no )
        REFERENCES owner ( owner_no );

ALTER TABLE payment
    ADD CONSTRAINT paymethod_payment FOREIGN KEY ( pay_paidby )
        REFERENCES paymethod ( paymethod_id );

ALTER TABLE maintenance
    ADD CONSTRAINT property_maintenance FOREIGN KEY ( prop_no )
        REFERENCES property ( prop_no );

ALTER TABLE rent
    ADD CONSTRAINT property_rent FOREIGN KEY ( prop_no )
        REFERENCES property ( prop_no );

ALTER TABLE damage
    ADD CONSTRAINT rent_damage FOREIGN KEY ( rent_agreement_no )
        REFERENCES rent ( rent_agreement_no );

ALTER TABLE payment
    ADD CONSTRAINT rent_payment FOREIGN KEY ( rent_agreement_no )
        REFERENCES rent ( rent_agreement_no );

ALTER TABLE rent
    ADD CONSTRAINT tenant_rent FOREIGN KEY ( tenant_no )
        REFERENCES tenant ( tenant_no );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             1
-- ALTER TABLE                             19
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0

SPOOL OFF
SET ECHO OFF