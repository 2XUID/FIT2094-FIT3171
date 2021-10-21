/*
    Q1. List the doctor title, first name, last name and contact phone number for all doctors who specialise
in the area of "ORTHOPEDIC SURGERY" (this is the specialisation description). Order the list by
the doctors' last name and within this, if two doctors have the same last name, order them by their
respective first names
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT
    d.doctor_title,
    d.doctor_fname,
    d.doctor_lname,
    d.doctor_phone
FROM
    cgh.doctor              d
    JOIN cgh.doctor_speciality   ds ON ds.doctor_id = d.doctor_id
    JOIN cgh.speciality          s ON s.spec_code = ds.spec_code
WHERE
    UPPER(spec_description) LIKE 'ORTHOPEDIC SURGERY'
ORDER BY
    doctor_lname,
    doctor_fname;

/*
    Q2. List the item code, item description, item stock and the cost centre title which provides these items
for all items which have a stock greater than 50 items and include the word 'disposable' in their item
description. Order the output by the item code.
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon (;)
-- at the end of this answer
SELECT
    i.item_code,
    i.item_description,
    i.item_stock,
    c.cc_title
FROM
         cgh.item i
    JOIN cgh.costcentre c
    ON i.cc_code = c.cc_code
WHERE
    i.item_description LIKE '%Disposable%'
    AND i.item_stock > 50
ORDER BY
    i.item_code;
/*
    Q3. List the patient id, patient's full name as a single column called 'Patient Name', admission date
and time and the supervising doctor's full name (including title) as a single column called 'Doctor
Name' for all those patients admitted between 10 AM on 11th of September and 6 PM on the 14th of
September 2021 (inclusive). Order the output by the admission time with the earliest admission first.

*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon (;)
-- at the end of this answer
SELECT
    p.patient_id,
    p.patient_fname
    || ' '
    || p.patient_lname                                             AS "Patient Name",
    d.doctor_id,
    to_char(a.adm_date_time, 'dd-MONTH-yyyy HH12:MI:SS AM')        AS "Admission Date",
    d.doctor_title
    || ' '
    || d.doctor_fname
    || ' '
    || d.doctor_lname                                              AS "Doctor Name"
FROM
         cgh.patient p
    JOIN cgh.admission    a
    ON a.patient_id = p.patient_id
    JOIN cgh.doctor       d
    ON d.doctor_id = a.doctor_id
WHERE
    a.adm_date_time BETWEEN TO_DATE('11-September-2021 10AM', 'dd-MONTH-yyyy HH12 AM') AND TO_DATE('14-September-2021 6PM', 'dd-MONTH-yyyy HH12 AM')
ORDER BY
    a.adm_date_time;
/*
    Q4. List the procedure code, name, description, and standard cost where the procedure is less
expensive than the average procedure standard cost. The output must show the most expensive
procedure first. The procedure standard cost must be displayed with two decimal points and a
leading $ symbol, for example as $120.54
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon (;)
-- at the end of this answer
SELECT
    p.proc_code,
    p.proc_name,
    p.proc_description,
    to_char(p.proc_std_cost, '$9999999.99') AS proc_std_cost
FROM
    cgh.procedure p
WHERE
    p.proc_std_cost < (
        SELECT
            AVG(proc_std_cost)
        FROM
            cgh.procedure
    )
ORDER BY
    proc_std_cost DESC;
/*
    Q5. List the patient id, last name, first name, date of birth and the number of times the patient has
been admitted to the hospital where the number of admissions is greater than 2. The output should
show patients with the most number of admissions first and for patients with the same number of
admissions, show the patients in their date of birth order.

*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon (;)
-- at the end of this answer
SELECT
    p.patient_id,
    p.patient_lname,
    p.patient_fname,
    to_char(p.patient_dob, 'dd-Mon-yyyy')        AS dob,
    COUNT(a.patient_id)                          AS number_of_admissions
FROM
         cgh.patient p
    JOIN cgh.admission a
    ON a.patient_id = p.patient_id
GROUP BY
    p.patient_id,
    p.patient_fname,
    p.patient_lname,
    p.patient_dob
HAVING
    COUNT(a.patient_id) > 2
ORDER BY
    number_of_admissions DESC,
    p.patient_dob;
/*
    Q6. List the admission number, patient id, first name, last name and the length of their stay in the
hospital for all patients who have been discharged and who were in the hospital longer than the
average stay for all discharged patients. The length of stay must be shown in the form 10 days 2.0
hrs where hours are rounded to one decimal digit. The output must be ordered by admission
number.

*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon (;)
-- at the end of this answer
SELECT
    a.adm_no,
    p.patient_id,
    p.patient_fname,
    p.patient_lname,
    trunc(adm_discharge - adm_date_time, 0)
    || ' Days'
    || ' '
    || decode(((adm_discharge - adm_date_time - floor(adm_discharge - adm_date_time)) * 24), 0, '0.0', ltrim(TRIM(to_char((adm_discharge -
    adm_date_time - floor(adm_discharge - adm_date_time)) * 24, '999999.9')), '0'))
    || ' Hours' AS adm_date_length
FROM
         cgh.patient p
    JOIN cgh.admission a
    ON a.patient_id = p.patient_id
WHERE
    adm_discharge - adm_date_time > (
        SELECT
            AVG(to_char(adm_discharge - adm_date_time, '99.99'))
        FROM
            cgh.admission a
        WHERE
            ( adm_discharge - adm_date_time ) IS NOT NULL
    )
ORDER BY
    adm_no;
/*
    Q7. Given a doctor may charge more or less than the standard charge for a procedure carried out
during an admission procedure, the hospital administration is interested in finding out what variations
on the standard price have been charged. The hospital terms the difference between the average
actual charged procedure cost which has been charged to patients for all such procedures which
have been carried out the procedure standard cost as the "Procedure Price Differential". For all
procedures which have been carried out on an admission determine the procedure price differential.
The list should show the procedure code, name, description, standard time, standard cost and the
procedure price differential in procedure code order.
For example procedure 15509 "X-ray, Right knee" has a standard cost of $70.00, it may have been
charged to admissions on average across all procedures carried out for $75.00 - the price differential
here will be 75 - 70 that is a price differential +5.00. If the average charge had been say 63.10 the
price differential will be -6.90.
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon (;)
-- at the end of this answer
SELECT
    p.proc_code,
    p.proc_name,
    p.proc_description,
    p.proc_time,
    to_char(AVG(a.adprc_pat_cost), '999999.99')                                   AS "Standard Cost",
    to_char((p.proc_std_cost - AVG(a.adprc_pat_cost)), '999999.99')               AS "Procedure Price Differential"
FROM
         cgh.procedure p
    JOIN cgh.adm_prc a
    ON p.proc_code = a.proc_code
GROUP BY
    p.proc_code,
    p.proc_name,
    p.proc_description,
    p.proc_time,
    proc_std_cost
ORDER BY
    proc_code;
/*
    Q8. For every procedure, list the items which have been used and the maximum number of those
items used when the procedure was carried out on an admission. Your list must show the procedure
code, procedure name, item code and item description and the maximum quantity of this item used
for the given procedure.
For example, Vascular Surgery may require one standard anaesthetic pack, and then a number of
Bupivacaine injections; sometimes one has been used sometimes two - the required listing will
show:
43556 Vascular surgery AN002 Std Anaesthetic Pack 1
43556 Vascular surgery BI500 Bupivacaine Inj .5% 10ml Steriamp 2
If the procedure has not been carried out on any admission or has not used any items then the item
code, item description and maximum quantity columns must show "---". The output must be in
procedure name order and within a procedure in item code order.
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon (;)
-- at the end of this answer
SELECT
    p.proc_code,
    p.proc_name,
    nvl(i.item_code, '---')                          AS item_code,
    nvl(i.item_description, '---')                   AS item_description,
    nvl(to_char(MAX(it_qty_used)), '---')            AS max_quantity_used
FROM
    cgh.procedure         p
    LEFT JOIN cgh.adm_prc           a
    ON p.proc_code = a.proc_code
    LEFT JOIN cgh.item_treatment    t
    ON a.adprc_no = t.adprc_no
    LEFT JOIN cgh.item              i
    ON t.item_code = i.item_code
GROUP BY
    p.proc_code,
    p.proc_name,
    i.item_code,
    i.item_description
ORDER BY
    proc_name,
    item_code;
/*
    Q9a (FIT2094 only) or Q9b (FIT3171 only)
For each procedure carried out in admissions, find the person/s who charged the maximum cost for
that procedure (the person who charged the patient was the person who performed the procedure).
Note that some procedures were carried out by the technicians.
As an example, say we have the following "dummy" data (note these are just representative
numbers, they do not reflect the data you have access to):
proc_code adprc_pat_cost perform_dr_id
5000 550 1021
5000 524.50 1021
5000 575 1001
5000 530 ----
In this dummy data, the procedure 5000 has been carried out four times. The maximum cost of
procedure 5000 was $575 and it was carried out by doctor 1001.
Your report must show the procedure code, the procedure name, performing doctor’s id, performing
doctor's full name (including title) as a single column called 'Doctor Name' and the maximum cost for
the procedure. The maximum procedure cost must be displayed with two decimal points and a
leading $ symbol, for example as $575.00. If the procedure was carried out by a technician, then the
perform doctor id column must show “----” and the ‘Doctor Name’ column must show “Technician”.
The output should be in procedure code order, and within a procedure in doctor id order.
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon (;)
-- at the end of this answer
SELECT DISTINCT
    p.proc_code,
    p.proc_name,
    CASE
        WHEN a.perform_dr_id IS NULL THEN
            '----'
        ELSE
            to_char(a.perform_dr_id)
    END                                              AS doctor_id,
    CASE
        WHEN a.perform_dr_id IS NULL THEN
            'Technician'
        ELSE
            (
                SELECT
                    d.doctor_title
                FROM
                    cgh.doctor d
                WHERE
                    d.doctor_id LIKE a.perform_dr_id
            )
            || ' '
            || (
                SELECT
                    d.doctor_fname
                FROM
                    cgh.doctor d
                WHERE
                    d.doctor_id LIKE a.perform_dr_id
            )
            || ' '
            || (
                SELECT
                    d.doctor_lname
                FROM
                    cgh.doctor d
                WHERE
                    d.doctor_id LIKE a.perform_dr_id
            )
    END                                              AS "Doctor Name",
    to_char(MAX(adprc_pat_cost), '$9999.99')         AS "Maximum Procedure Cost"
FROM
         cgh.adm_prc a
    JOIN cgh.procedure    p
    ON p.proc_code = a.proc_code
    JOIN cgh.admission    ad
    ON ad.adm_no = a.adm_no
    JOIN cgh.doctor       d
    ON d.doctor_id = ad.doctor_id
GROUP BY
    p.proc_code,
    p.proc_name,
    d.doctor_id,
    a.perform_dr_id,
    d.doctor_title,
    d.doctor_fname,
    d.doctor_lname
HAVING
    ( p.proc_code, MAX(adprc_pat_cost) ) IN (
        SELECT
            p.proc_code, MAX(a.adprc_pat_cost)
        FROM
                 cgh.adm_prc a
            JOIN cgh.procedure p
            ON p.proc_code = a.proc_code
        GROUP BY
            p.proc_code
    )
ORDER BY
    proc_code,
    doctor_id;
