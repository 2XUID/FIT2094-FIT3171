/*
Databases Week 9 Tutorial
week9_dml.sql

student id: 
student name:
last modified date:

*/

---==9.2.1 UPDATE==--
/*1. Update the unit name of FIT9999 from 'FIT Last Unit' to 'place holder unit'.*/


/*2. Enter the mark and grade for the student with the student number of 11111113 
for the unit code FIT9132 that the student enrolled in semester 1 of 2021. 
The mark is 75 and the grade is D.*/


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


/*4. Due to the new regulation, the Faculty of IT decided to change 'Project' unit code 
from FIT9161 into FIT5161. Change the database to reflect this situation.
Note: you need to disable the FK constraint before you do the modification 
then enable the FK to have it active again.
*/



--==9.2.2 DELETE==--
/*1. A student with student number 11111114 has taken intermission in semester 1 2021, 
hence all the enrolment of this student for semester 1 2021 should be removed. 
Change the database to reflect this situation.*/


/*2. The faculty decided to remove all 'Student's Life' unit's enrolments. 
Change the database to reflect this situation.
Note: unit names are unique in the database.*/


/*3. Assume that Wendy Wheat (student number 11111113) has withdrawn from the university. 
Remove her details from the database.*/


/*4 Add Wendy Wheat back to the database (use the INSERT statements you have created 
when completing module Tutorial 7 SQL Data Definition Language DDL).*/

/*Change the FOREIGN KEY constraints definition for the STUDENT table so it will now include 
the ON DELETE clause to allow CASCADE delete. Hint: You need to use the ALTER TABLE statement
 to drop the FOREIGN KEY constraint first and then put it back 
 using ALTER TABLE with the ADD CONSTRAINT clause. */
  
/*
Once you have changed the table, now, perform the deletion of 
the Wendy Wheat (student number 11111113) row in the STUDENT table. 
Examine the ENROLMENT table. What happens to the enrolment records of Wendy Wheat?*/

