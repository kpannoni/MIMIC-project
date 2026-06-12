/* CTE to find blood culture results for the most common gram negative bacteria.
Exclude everything that's not a blood culture, or is a neonatal or post-mortem culture.

This will include only the 12 most common gram negative bacteria in the dataset, not all gram negative bacteria. */
DROP VIEW cohort;
CREATE OR REPLACE VIEW cohort AS
WITH blood_cultures AS (
    SELECT *
	FROM mimiciv_hosp.microbiologyevents
	-- filter for blood culture only
	WHERE spec_type_desc IN (
    	'BLOOD CULTURE',
    	'BLOOD CULTURE ( MYCO/F LYTIC BOTTLE)')
		-- where a common gram neg organism was cultured
		AND org_name IS NOT Null
		AND org_name != 'CANCELLED'
		AND org_name IN (
		    'ESCHERICHIA COLI',
    		'KLEBSIELLA PNEUMONIAE',
    		'PSEUDOMONAS AERUGINOSA',
    		'PROTEUS MIRABILIS',
    		'ENTEROBACTER CLOACAE COMPLEX',
    		'KLEBSIELLA OXYTOCA',
    		'SERRATIA MARCESCENS',
    		'ENTEROBACTER CLOACAE',
    		'CITROBACTER FREUNDII COMPLEX',
    		'ENTEROBACTER AEROGENES',
    		'ACINETOBACTER BAUMANNII COMPLEX',
    		'MORGANELLA MORGANII')
		-- Exclude if no admissions data
		AND hadm_id IS NOT NULL
		-- Exclude if no antibody susceptibility results
		AND EXISTS (
    		SELECT 1 FROM mimiciv_hosp.microbiologyevents m
    		WHERE m.micro_specimen_id = micro_specimen_id
    		AND m.ab_name IS NOT NULL
			)
),

/* For each patient in the data, number the individual instances of 
a positive gram negative culture. */

first_instance AS (
SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY subject_id
		ORDER BY COALESCE(charttime, chartdate)
		) AS row_n
FROM blood_cultures
)

-- Now select the first instance for each patient.

SELECT *
FROM first_instance
WHERE row_n = 1

