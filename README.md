# MIMIC Project
An independent project using the [MIMIC-IV](https://mimic.mit.edu/) database to predict multidrug resistance in patients with confirmed gram-negative bacteremia given clinical risk factors available at the time of empiric antibiotic selection, before culture results are known.

## Significance

## Dataset

*Source:* MIMIC-IV version 3.1 (hosp & icu datasets)
*Final Dataset:* 

### Cohort Definition
Hospital patients with a positive culture of gram-negative bacteremia (first episode only).

Gram-negative organisms included: 

### Main Outcome
Multidrug resistance (binary): Organism is resistant to 3+ drug classes

*Included antibiotic drug classes:*
- beta-lactam (piperacillin-tazobactam)
- cephalosporins
- carbapenems
- monobactams
- aminoglycosides
- fluoroquinolones

### Key risk factors
- time from admission to blood culture
- prior hospitalization within <90 days
- invasive procedures: central line, urinary catheter, mechanical ventilation, recent surgery (<30 days)
- comorbid diagnoses
- ICU status at time of culture
- number of antibiotic classes exposed (current & <90 days)
- total antibiotic days (current & <90 days)
- high risk antibiotic exposure (carbapenem, fluoroquinolone, 3-4th generation cephalosporin)

***Note:*** Raw and patient-level data cannot be shared publicly per the MIMIC-IV Data Agreement. 
<br>This dataset was obtained with proper PhysioNet credentials. Instructions for requesting access and recreating this dataset can be found in the [data README](data/README.md).

### Final Cohort Summary

## Analysis Overview

## Major Caveats
- Prior antibiotic exposure in this dataset is *inpatient only*, which does not include outpatient antibiotics or antibiotics prescribed at other hospitals. Thus, antibiotic exposure is likely underestimated here.

- Multidrug resistant status was derived from laboratory susceptibility results rather than ICD-10 administrative codes, which are known to substantially underreport resistance. A comparison of both methods is included in the analysis.
 
# Summary of Results

### Key Findings

## Conclusion

## References
Goldberger, A., Amaral, L., Glass, L., Hausdorff, J., Ivanov, P. C., Mark, R., ... & Stanley, H. E. (2000). PhysioBank, PhysioToolkit, and PhysioNet: Components of a new research resource for complex physiologic signals. Circulation [Online]. 101 (23), pp. e215–e220. RRID:SCR_007345.

Johnson, A., Bulgarelli, L., Pollard, T., Gow, B., Moody, B., Horng, S., Celi, L. A., & Mark, R. (2024). MIMIC-IV (version 3.1). _PhysioNet_. RRID:SCR_007345. [https://doi.org/10.13026/kpb9-mt58](https://doi.org/10.13026/kpb9-mt58)

Johnson, A.E.W., Bulgarelli, L., Shen, L. et al. MIMIC-IV, a freely accessible electronic health record dataset. Sci Data 10, 1 (2023). [https://doi.org/10.1038/s41597-022-01899-x](https://doi.org/10.1038/s41597-022-01899-x)

Patolia, S., Abate, G., Patel, N., Patolia, S., & Frey, S. (2018). Risk factors and outcomes for multidrug-resistant Gram-negative bacilli bacteremia. Therapeutic Advances in Infectious Disease, 5(1), 11–18. https://doi.org/10.1177/2049936117727497

