set PAGESIZE 100
spool employee_partb.txt
set echo on

--
-- PART B PAYROLL REVISION

-- Q1. Display for all employees their number, name, job, monthly salary, their current annual salary (not including commission) 
-- and what their annual salary would be if they were given a 10% pay rise.
SELECT
    empno,
    empname,
    empjob,
    empmsal,
    empmsal * 12 AS annual_salary,
    empmsal * 12 * 1.1 AS ann_sal_with_rise
FROM
    payroll.employee
ORDER BY empno;

-- Q2. Display the name of all employees, their birthdate and their age in years.
SELECT
    empname,
    TO_CHAR(empbdate,'DD-Mon-YYYY') AS birthdate,
    floor(months_between(SYSDATE,empbdate) / 12) AS "Age in Yrs"
FROM
    payroll.employee
ORDER BY empname;

--Q3. Display for all employees, their number, name, job, monthly salary, commission and their current annual salary (including commission).
SELECT
    empno,
    empname,
    empjob,
    empmsal,
    empcomm,
    ( empmsal + nvl(empcomm,0) ) * 12 AS total_salary
FROM
    payroll.employee
ORDER BY empno;

--Q4. Display all employees details in the following format: EMPLOYEE N. Smith IS A Trainer AND WORKS IN THE Training DEPARTMENT.
SELECT
    'EMPLOYEE '
     || empinit
     || '. '
     || initcap(empname)
     || ' IS A '
     || initcap(empjob)
     || ' AND WORKS IN THE '
     || initcap(deptname)
     || ' DEPARTMENT.' as empdetails
FROM
    payroll.employee e
    JOIN payroll.department d ON (
        e.deptno = d.deptno
    )
ORDER BY empname;

SELECT
    'EMPLOYEE '
     || empinit
     || '. '
     || initcap(empname)
     || ' IS A '
     || initcap(nvl(empjob,'----'))
     || ' AND WORKS IN THE '
     || initcap(nvl(deptname,'----'))
     || ' DEPARTMENT.' as empdetails
FROM
    payroll.employee e
    left outer JOIN payroll.department d ON (
        e.deptno = d.deptno
    )
ORDER BY empname;

--Q5. Display the name of all employees, their birthdate and their age in months.
SELECT
    empname,
    TO_CHAR(empbdate,'dd-Mon-yyyy') AS birthdate,
    round(
        months_between(SYSDATE,empbdate),
        1
    ) AS age_in_months
FROM
    payroll.employee
ORDER BY empname;

--Q6. Display the name and birthdate of all employees who were born in February.
SELECT
    empname,
    TO_CHAR(empbdate,'dd-Mon-yyyy') AS birthdate
FROM
    payroll.employee
WHERE
    EXTRACT(MONTH FROM empbdate) = 2
ORDER BY empname;

--Q7. Display the employee name, salary and commission (using the GREATEST function) for those employees 
-- who earn more commission than their monthly salary.

SELECT
    empname,
    empmsal,
    empcomm
FROM
    payroll.employee
WHERE
    empcomm = greatest(empcomm,empmsal)
ORDER BY empname;

--Q8. Display the name of all employees and their birthdate in the following format: 
-- EMPLOYEE N. Smith was born on FRIDAY the 17 of DECEMBER , 1982

SELECT
    'EMPLOYEE '
     || empinit
     || '. '
     || initcap(empname)
     || ' was born on '
     || rtrim(TO_CHAR(empbdate,'DAY') )
     || ' the '
     || EXTRACT(DAY FROM empbdate)
     || ' of '
     || rtrim(TO_CHAR(empbdate,'MONTH') )
     || ','
     || EXTRACT(YEAR FROM empbdate) as "EMP DOB Details"
FROM
    payroll.employee
ORDER BY empname;

--Q9. Display the number and name of the employees who have registered for a course and the 
-- number of times they have registered.
SELECT
    e.empno,
    e.empname,
    COUNT(*) AS nbr_registrations
FROM
    payroll.employee e
    JOIN payroll.registration r ON (
        e.empno = r.empno
    )
GROUP BY
    e.empno,
    e.empname
ORDER BY empname;

--Q10. Who is the oldest employee? Show the empployye number, name and date of birth
SELECT
    empno,
    empname,
    TO_CHAR(empbdate,'DD-Mon-YYYY')
FROM
    payroll.employee
WHERE
    empbdate = (
        SELECT
            MIN(empbdate)
        FROM
            payroll.employee
    )
ORDER BY empno;

--Q11. For each department list the department number and name, the number of employees, 
-- the minimum and maximum monthly salary, the total monthly salary and the average salary
-- paid to their employees. Name the columns: NbrOfEmployees, MinSalary, MaxSalary, TotalSalary, AvgSalary
SELECT
    d.deptno,
    d.deptname,
    COUNT(e.empno) "NbrOfEmployees",
    MIN(empmsal) "MinSalary",
    MAX(empmsal) "MaxSalary",
    SUM(empmsal) "TotalSalary",
    round(AVG(empmsal),2) "AvgSalary"
FROM
    payroll.employee e
    RIGHT OUTER JOIN payroll.department d ON (
        e.deptno = d.deptno
    )
GROUP BY
    d.deptno,
    d.deptname
ORDER BY deptno;

--Q12. Display the department number, jobs available in that department and the total monthly salary paid for each job.
SELECT
    deptno,
    empjob,
    SUM(empmsal)
FROM
    payroll.employee
GROUP BY
    deptno,
    empjob
ORDER BY deptno,empjob;

--Q13. Which employee earns more than the average salary? Show the employee number, name and monthly salary
SELECT
    empno,
    empname,
    empmsal
FROM
    payroll.employee
WHERE
    empmsal > (
        SELECT
            AVG(empmsal)
        FROM
            payroll.employee
    )
ORDER BY empno;

--Q14. Which department has the greatest average monthly salary? SHow the department no, name and average monthly salary
SELECT
    d.deptno,
    d.deptname,
    round(AVG(empmsal),2) "AvgSalary"
FROM
    payroll.employee e
    JOIN payroll.department d ON (
        e.deptno = d.deptno
    )
GROUP BY
    d.deptno,
    d.deptname
HAVING
    AVG(empmsal) = (
        SELECT
            MAX(AVG(empmsal) )
        FROM
            payroll.employee
        GROUP BY
            deptno
    )
ORDER BY deptno;

--Q15. Which course has the most offerings? Show the course code, description and number of offerings
SELECT
    c.crscode,
    c.crsdesc,
    COUNT(*) "NbrOfferings"
FROM
    payroll.course c
    JOIN payroll.offering o ON (
        c.crscode = o.crscode
    )
GROUP BY
    c.crscode,
    c.crsdesc
HAVING
    COUNT(*) = (
        SELECT
            MAX(COUNT(*) )
        FROM
            payroll.offering
        GROUP BY
            crscode
    )
ORDER BY crscode;

--Q16. Display the name, job and date of birth of employees who perform the same job as SCOTT and were 
-- born in the same year. Do not include SCOTT in the output.
SELECT
    e.empname,
    e.empjob,
    TO_CHAR(empbdate,'dd-Mon-yyyy')
FROM
    payroll.employee e
WHERE
        ( e.empjob,EXTRACT(YEAR FROM empbdate) ) = (
            SELECT
                e.empjob,
                EXTRACT(YEAR FROM empbdate)
            FROM
                payroll.employee e
            WHERE
                upper(empname) = 'SCOTT'
        )
    AND
        upper(e.empname) <> 'SCOTT'
ORDER BY empname;

--Q17. Using the MINUS statement, which employees have never registered in a course. Show their number and name
SELECT
    empno,
    empname
FROM
    payroll.employee
MINUS
SELECT DISTINCT
    e.empno,
    empname
FROM
    payroll.registration r join payroll.employee e on (r.empno = e.empno)
ORDER BY empno;

--Q18. Using the INTERSECT statement, which employees have both registered for 
-- and conducted courses. Show the employees number and name
SELECT DISTINCT
    e.empno AS "TrainerAndStudent",
    empname
FROM
    payroll.offering o join payroll.employee e on (o.empno = e.empno) 
INTERSECT SELECT DISTINCT
    e.empno,
    empname
FROM
    payroll.registration r join payroll.employee e on (r.empno = e.empno)
ORDER BY "TrainerAndStudent";

set echo off
spool off

