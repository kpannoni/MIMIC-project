/* The cohort table is defined in the file "cohort_definition".
Cohort includes patients with a positive culture of the most common gram-negative bacteria.
Data has been filtered to remove patients without admissions data or antibody susceptibility data.

This query will extract the relevant cohort data from procedure events for any procedures during the current admission 
or any prior admissions within 30 days before the first positive blood culture.
We will later filter this down in Python to look only at invasive or surgical procedures. 
For now, this includes all procedures. */

CREATE TABLE prior_procedures AS
SELECT c.subject_id, c.hadm_id AS cohort_hadm_id, 
		COALESCE(c.charttime, c.chartdate) AS culture_time,
		p.hadm_id AS procedure_hadm_id, p.chartdate AS procedure_date, p.icd_code, d.long_title
FROM cohort c
INNER JOIN mimiciv_hosp.procedures_icd p
	ON c.subject_id = p.subject_id
-- Join table on the procedure icd dictionary to map the procedure codes
INNER JOIN mimiciv_hosp.d_icd_procedures d
    ON p.icd_code = d.icd_code
    AND p.icd_version = d.icd_version
-- filter for procedures done on or 30 days before the culture date (c.chartdate)
WHERE p.chartdate <= COALESCE(c.charttime, c.chartdate)::date
    AND p.chartdate >= COALESCE(c.charttime, c.chartdate)::date - INTERVAL '30 days'