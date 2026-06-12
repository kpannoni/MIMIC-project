/* Cohort Attrition Summary
------------------------------------
Unique patients in microbiologyevents: 222,313
Patients with positive gram-negative blood culture (first episode): 3,809
Excluded for missing hospital admission ID: 2,102
Excluded for missing susceptibility data: 213
Final cohort: 1,494 patients
*/

/* Inspect the full cohort table */
SELECT *
FROM cohort

/* How many patients in the original dataset? */
-- 222,313 unique patients in the microbiologyevents table
SELECT count(DISTINCT subject_id)
FROM mimiciv_hosp.microbiologyevents

/* How many patients are in our final cohort? */
-- After filtering for missing data, 1,494 patients left in the cohort.
SELECT count(*)
FROM cohort

/* Check that each subject_ID in the cohort only appears once. 
If no IDs repeat, the query should return empty. And it does! */

SELECT subject_id, count(*) as N
FROM cohort
WHERE row_n = 1
GROUP BY subject_id
HAVING count(*) > 1;

/* Check whether any patient is missing an associated admission ID or admission date/time 
2462 patients in the cohort were missing a hospital admission ID.
These have been excluded now in the cohort definition. */

-- Missing admission links? This query should return 0 now.
SELECT COUNT(*) FROM cohort WHERE hadm_id IS NULL;

-- Is there missing time information in the original dataset?
SELECT COUNT(*) 
FROM mimiciv_hosp.microbiologyevents
WHERE charttime IS NULL AND chartdate IS NULL;

/* Look at the distribution of the 12 gram negative organisms in the cohort. 
Note if any are particularly low or if the rank order looks off. */
SELECT org_name, COUNT(*) as n
FROM cohort
GROUP BY org_name
ORDER BY n DESC;

/* Check whether each positive culture has associated antibody succeptability results.
If not, we can't classify multi drug resistence in those patients. 
This requires going back to the microbiologyevents table to get all rows 
for the given specimen that have an antibody ID */
-- 365 patients in the cohort have a positive culture but no succeptibility data.
-- These have been removed from the cohort now.

SELECT COUNT(DISTINCT subject_id) 
FROM cohort c
WHERE NOT EXISTS (
    SELECT 1 FROM mimiciv_hosp.microbiologyevents m
    WHERE m.subject_id = c.subject_id
    AND m.ab_name IS NOT NULL
    AND m.micro_specimen_id = c.micro_specimen_id
);