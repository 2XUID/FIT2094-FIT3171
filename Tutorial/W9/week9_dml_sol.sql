SET ECHO ON;

/*
Databases Week 9 Tutorial Sample Solution
week9_dml_sol.sql

Databases Units
Author: FIT Database Teaching Team
License: Copyright © Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice. 
*/

--9.2.1 UPDATE
/*1. Update the unit name of FIT9999 from 'FIT Last Unit' to 'place holder unit'.*/
select * from unit;

update unit set unit_name = 'place holder unit' where unit_code = 'FIT9999';
commit;

select * from unit;

/*2. Enter the mark and grade for the student with the student number of 11111113 
for the unit code FIT9132 that the student enrolled in semester 1 of 2021. 
The mark is 75 and the grade is D.*/
select * from enrolment;

update enrolment set enrol_mark = 75, enrol_grade = 'D' where stu_nbr = 11111113 
    and enrol_semester = '1'  and enrol_year = 2021 and unit_code='FIT9132';
commit;

select * from enrolment;

/*3. The university introduced a new grade classification scale. 
The new classification are:
0 - 44 is N
45 - 54 is P1
55 - 64 is P2
65 - 74 is C
75 - 84 is D
85 - 100 is HD
Change the database to reflect the new grade classification scale.
*/

select * from enrolment;

update enrolment set enrol_grade = 'N' where enrol_mark >= 0 and enrol_mark <= 44;
update enrolment set enrol_grade = 'P1' where enrol_mark >= 45 and enrol_mark <= 54;
update enrolment set enrol_grade = 'P2' where enrol_mark >= 55 and enrol_mark <= 64;
update enrolment set enrol_grade = 'C' where enrol_mark >= 65 and enrol_mark <= 74;
update enrolment set enrol_grade = 'D' where enrol_mark >= 75 and enrol_mark <= 84;
update enrolment set enrol_grade = 'HD' where enrol_mark >= 85;
commit;

--Alternative solution for Q3
update enrolment 
set enrol_grade = 
CASE
when enrol_mark between 0 and 44 then 'N'
when enrol_mark between 45 and 54 then 'P1'
when enrol_mark between 55 and 64 then 'P2'
when enrol_mark between 65 and 74 then 'C'
when enrol_mark between 75 and 84 then 'D'
when enrol_mark between 85 and 100 then 'HD'
END;
commit;

select * from enrolment;

/*4. Due to the new regulation, the Faculty of IT decided to change 'Project' unit code 
from FIT9161 into FIT5161. Change the database to reflect this situation.
Note: you need to disable the FK constraint before you do the modification 
then enable the FK to have it active again.
*/

select * from unit;
select * from enrolment;

/* A direct update statement on unit table will return error 
"integrity constraint (AAA.STUDENT_ENROLMENT_FK) violated - child record found".

Thus, you need to use the ALTER TABLE statement to disable 
the FOREIGN KEY constraint first and then enable it back.*/

alter table enrolment disable constraint unit_enrolment_fk;

update enrolment
set unit_code = 'FIT5161'
where unit_code = 'FIT9161';

update unit
set unit_code = 'FIT5161'
where unit_code = 'FIT9161';

commit;

ALTER TABLE enrolment enable constraint unit_enrolment_fk;

select * from unit;
select * from enrolment;


--9.2.2 DELETE
/*1. A student with student number 11111114 has taken intermission in semester 1 2021, 
hence all the enrolment of this student for semester 1 2021 should be removed. 
Change the database to reflect this situation.*/
select * from enrolment;

delete from enrolment where stu_nbr = 11111114 and enrol_semester = '1' and enrol_year = 2021;
commit;

select * from enrolment;


/*2. The faculty decided to remove all 'Student's Life' unit's enrolments. 
Change the database to reflect this situation.
Note: unit names are unique in the database.*/

select * from enrolment;

delete from enrolment 
where unit_code = 
    (select unit_code 
     from unit 
     where unit_name = 'Student''s Life');
     
commit;

select * from enrolment;


/*3. Assume that Wendy Wheat (student number 11111113) has withdrawn from the university. 
Remove her details from the database.*/
select * from student;
select * from enrolment;

 
-- this statement will return error "integrity constraint (AAA.STUDENT_ENROLMENT_FK) violated - child record found"
delete from student where stu_nbr = 11111113;

-- so, child records need to be deleted first and then the parent record:
delete from enrolment where stu_nbr = 11111113;
delete from student where stu_nbr = 11111113;
commit;

select * from student;
select * from enrolment;

/*4 Add Wendy Wheat back to the database (use the INSERT statements you have created 
when completing module Tutorial 7 SQL Data Definition Language DDL).*/
insert into student values (11111113,'Wheat','Wendy','05-May-2005');
insert into enrolment values (11111113,'FIT9132',2021,'1',null,null);
insert into enrolment values (11111113,'FIT5111',2021,'1',null,null);
commit;

select * from student;
select * from enrolment;

/*Change the FOREIGN KEY constraints definition for the STUDENT table so it will now include 
the ON DELETE clause to allow CASCADE delete. Hint: You need to use the ALTER TABLE statement
 to drop the FOREIGN KEY constraint first and then put it back 
 using ALTER TABLE with the ADD CONSTRAINT clause. */
-- drop the constraint
alter table enrolment drop constraint STUDENT_ENROLMENT_FK;
-- add the constraint back but now as delete cascade
alter table enrolment add constraint STUDENT_ENROLMENT_FK 
  foreign key (stu_nbr) references student (stu_nbr) on delete cascade;
  
/*
Once you have changed the table, now, perform the deletion of 
the Wendy Wheat (student number 11111113) row in the STUDENT table. 
Examine the ENROLMENT table. What happens to the enrolment records of Wendy Wheat?*/

-- delete Wendy Wheat
delete from student where stu_nbr = 11111113;
commit;

select * from student;
select * from enrolment;

SET ECHO OFF;