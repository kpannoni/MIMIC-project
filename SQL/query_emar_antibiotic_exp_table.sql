/* The cohort table is defined in the file "cohort_definition".
Cohort includes patients with a positive culture of the most common gram-negative bacteria.
Data has been filtered to remove patients without admissions data or antibody susceptibility data.

This query will extract the relevant cohort data from emar and filter the medications for antibiotics only.
We only want to include antibiotic exposure prior to the first positive blood culture, which we can get from the cohort table.

If we distinguish the current admission ID (cohort_hadm_id) from the admission ID when the antibiotic was given (emar_hadm_id),
We can later filter for current and prior antibiotic exposure. */

CREATE TABLE antibiotic_exp AS
SELECT c.subject_id, c.hadm_id AS cohort_hadm_id, 
	COALESCE(c.charttime, c.chartdate) AS culture_time,
    e.hadm_id AS emar_hadm_id, e.medication, e.charttime AS emar_time
FROM cohort c
INNER JOIN mimiciv_hosp.emar e
	ON c.subject_id = e.subject_id
-- Filter for medications administered before the first positive blood culture
WHERE e.charttime < COALESCE(c.charttime, c.chartdate)
-- Find the antibiotics in the medications
AND e.medication ILIKE ANY(ARRAY[
    '%cillin%', '%cef%', '%penem%', 
    '%floxacin%', '%mycin%', '%cycline%',
    '%aztreonam%', '%metronidazole%',
    '%vancomycin%', '%sulfamethoxazole%',
    '%azole%'
	])
-- Remove medications that are not antibiotics or are not systemic
AND NOT (e.medication ILIKE ANY(ARRAY[
    '%aripiprazole%',
    '%esomeprazole%',
    '%lansoprazole%',
    '%methimazole%',
    '%omeprazole%',
    '%pantoprazole%',
    '%fluconazole%',
    '%clotrimazole%',
    '%ketoconazole%',
    '%miconazole%',
    '%posaconazole%',
    '%terconazole%',
    '%voriconazole%',
    '%ophth%',
    '%topical%',
    '%cream%',
    '%shampoo%',
    '%gel%',
    '%powder%',
    '%otic%',
    '%bacitracin%',
    '%heparin%lock%',
	'%graded challenge%',
	'%solution%',
	'%enema%'
]))