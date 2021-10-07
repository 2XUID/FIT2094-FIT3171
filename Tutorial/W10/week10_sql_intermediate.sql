/*
Databases Week 10 Tutorial
week10_sql_intermediate.sql

student id: 
student name:
last modified date:

*/

/* 1. Find the average mark of FIT2094 in semester 2, 2019. 
Show the average mark with two decimal places. 
Name the output column as “Average Mark”. */
SELECT TO_CHAR(ofyear,'YYYY') As "year", semester,
AVG(mark) AS "average mark"



/* 2. List the average mark for each offering of FIT9136. 
In the listing, include the year and semester number. 
Sort the result according to the year then the semester.*/



/* 3. Find the number of students enrolled in FIT1045 in the year 2019, 
under the following conditions (note two separate selects are required):
      a. Repeat students are counted each time
      b. Repeat students are only counted once
*/

-- a. Repeat students are counted each time


-- b. Repeat students are only counted once



/* 4. Find the total number of prerequisite units for FIT5145. */




/* 5. Find the total number of prerequisite units for each unit. 
In the list, include the unitcode for which the count is applicable. 
Order the list by unit code.*/



/*6. Find the total number of students 
whose marks are being withheld (grade is recorded as 'WH') 
for each unit offered in semester 1 2020. 
In the listing include the unit code for which the count is applicable. 
Sort the list by descending order of the total number of students 
whose marks are being withheld, then by the unit code.*/



/* 7. For each prerequisite unit, calculate how many times 
it has been used as a prerequisite (number of times used). 
In the listing include the prerequisite unit code, 
the prerequisite unit name and the number of times used. 
Sort the output by unit name. */



/*8. Display unit code and unit name of units 
which had at least 1 student who was granted deferred exam 
(grade is recorded as 'DEF') in semester 1 2020. 
Order the list by unit code.*/



/* 9. Find the unit/s with the highest number of enrolments 
for each offering in the year 2019. 
Sort the list by semester then by unit code. */




/* 10. Find all students enrolled in FIT3157 in semester 1, 2020 
who have scored more than the average mark for FIT3157 in the same offering? 
Display the students' name and the mark. 
Sort the list in the order of the mark from the highest to the lowest 
then in increasing order of student name.*/





