CREATE OR REPLACE TRIGGER MAINTAIN_DRONE_RENT_COUNT 
AFTER INSERT OR DELETE ON RENTAL 
FOR EACH ROW 
BEGIN
  IF inserting THEN
        UPDATE drone
        SET drone_rent_count = drone_rent_count + 1
        WHERE drone_id = :new.drone_id;
        
        DBMS_OUTPUT.PUT_LINE('New rental has been added for drone ' 
        || :new.drone_id);
        
    END IF;
    
    IF deleting THEN
        UPDATE drone
        SET drone_rent_count = drone_rent_count - 1
        WHERE drone_id = :old.drone_id;
        
        DBMS_OUTPUT.PUT_LINE('A rental has been deleted for drone ' 
        || :old.drone_id);
        
    END IF;      
END;
/

--Testing Harness
--Initial data
SET SERVEROUTPUT ON;

insert into drone values (10,to_date('11/JAN/2020','dd/MON/yyyy'),1399,0,15,0);

select * from drone;
select * from rental;

--test for insert
insert into rental values (1, 100, to_date('30/JAN/2020','dd/MON/yyyy'), null, 10 );

select * from drone;
select * from rental;

--test for delete
delete from rental where rent_no = 1;

select * from drone;
select * from rental;

rollback;

--End of Testing Harness