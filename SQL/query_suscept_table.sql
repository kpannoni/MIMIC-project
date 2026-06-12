/* The cohort table is defined in the file "cohort_definition".
Cohort includes patients with a positive culture of the most common gram-negative bacteria.
Data has been filtered to remove patients without admissions data or antibody susceptibility data.

This query will extract the relevant susceptibility data for the cohort from microbiologyevents,
which will be used to assess multi drug resistance (in Python)*/

CREATE TABLE susept_results AS
SELECT c.subject_id, c.hadm_id, c.micro_specimen_id, c.org_itemid, c.org_name,
    m.ab_name, m.interpretation
FROM cohort c
INNER JOIN mimiciv_hosp.microbiologyevents m
    ON m.micro_specimen_id = c.micro_specimen_id
WHERE m.ab_name IS NOT NULL;