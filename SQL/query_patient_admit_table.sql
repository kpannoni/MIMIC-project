/* The cohort table is defined in the file "cohort_definition".
Cohort includes patients with a positive culture of the most common gram-negative bacteria.
Data has been filtered to remove patients without admissions data or antibody susceptibility data.

This query will extract the relevant cohort data from Patients and Admissions and combine into a single table. */

CREATE TABLE patient_admit AS
SELECT c.subject_id, c.hadm_id, c.micro_specimen_id,
    p.gender, p.anchor_age, p.anchor_year,
    a.admittime, a.dischtime, a.admission_type, a.race, a.hospital_expire_flag
FROM cohort c
-- Join the cohort table with patients table
INNER JOIN mimiciv_hosp.patients p
    ON c.subject_id = p.subject_id
-- Then join with the admissions table
INNER JOIN mimiciv_hosp.admissions a
    ON c.hadm_id = a.hadm_id;