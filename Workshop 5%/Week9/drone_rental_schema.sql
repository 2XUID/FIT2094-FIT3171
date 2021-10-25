DROP TABLE drone CASCADE CONSTRAINTS;

DROP TABLE rental CASCADE CONSTRAINTS;


CREATE TABLE drone (
    drone_id           NUMBER(5) NOT NULL,
    drone_pur_date     DATE NOT NULL,
    drone_pur_price    NUMBER(7, 2) NOT NULL,
    drone_flight_time  NUMBER(6, 1) NOT NULL,
    drone_cost_hr      NUMBER(6, 2) NOT NULL,
    drone_rent_count   NUMBER(3) NOT NULL
);

COMMENT ON COLUMN drone.drone_id IS
    'drone id (unique for each drone)';

COMMENT ON COLUMN drone.drone_pur_date IS
    'drone purchase date';

COMMENT ON COLUMN drone.drone_pur_price IS
    'drone purchase price';

COMMENT ON COLUMN drone.drone_flight_time IS
    'drone flight time completed since purchase - initially 0';

COMMENT ON COLUMN drone.drone_cost_hr IS
    'drone rate per hour';

COMMENT ON COLUMN drone.drone_rent_count IS
    'number of times a drone rented';

ALTER TABLE drone ADD CONSTRAINT drone_pk PRIMARY KEY ( drone_id );

CREATE TABLE rental (
    rent_no    NUMBER(8) NOT NULL,
    rent_bond  NUMBER(6, 2) NOT NULL,
    rent_out   DATE NOT NULL,
    rent_in    DATE,
    drone_id   NUMBER(5) NOT NULL
);

COMMENT ON COLUMN rental.rent_no IS
    'rental number';

COMMENT ON COLUMN rental.rent_bond IS
    'rental bond';

COMMENT ON COLUMN rental.rent_out IS
    'date/time that the drone leaves';

COMMENT ON COLUMN rental.rent_in IS
    'drone return date/time';

COMMENT ON COLUMN rental.drone_id IS
    'drone id (unique for each drone)';

ALTER TABLE rental ADD CONSTRAINT rental_pk PRIMARY KEY ( rent_no );

ALTER TABLE rental
    ADD CONSTRAINT drone_rental FOREIGN KEY ( drone_id )
        REFERENCES drone ( drone_id );
