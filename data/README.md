# Data Sources

## MIMIC-IV version 3.1
**Medical Information Mart for Intensive Care (MIMIC)-IV** is a large deidentified dataset of patients admitted to the emergency department or an intensive care unit at the *Beth Israel Deaconess Medical Center* in Boston, MA. MIMIC-IV contains data for over 65,000 patients admitted to an ICU and over 200,000 patients admitted to the emergency department.

https://mimic.mit.edu/

MIMIC-IV is sourced from two in-hospital database systems: 
1. Custom hospital wide EHR (*hosp*)
2. ICU specific clinical information system (*icu*)

### Citation
Johnson, A., Bulgarelli, L., Pollard, T., Gow, B., Moody, B., Horng, S., Celi, L. A., & Mark, R. (2024). MIMIC-IV (version 3.1). _PhysioNet_. RRID:SCR_007345. [https://doi.org/10.13026/kpb9-mt58](https://doi.org/10.13026/kpb9-mt58)

### Patient-level Data Not Included
**Raw and patient-level data cannot be shared publicly per the MIMIC-IV Data Agreement.**

### How to Obtain Data
1. Make an account to request access at [PhysioNet.org](https://physionet.org)
2. Under https://physionet.org/settings/credentialing, submit your personal information which will be reviewed before you are credentialed.
3. Once credentialed, complete the [CITI Program's "Data or Specimens Only Research"](https://physionet.org/about/citi-course/) training course as instructed.
4. Upload the Completion Report (not certificate) on your PhysioNet account under https://physionet.org/settings/training
5. Once accepted, download the data from [PhysioNet](https://physionet.org/content/mimiciv/3.1/) as a .zip file
6. Unzip the file and extract all. Now you have the raw data to import into SQL.


### Data and Tables Included For Analysis

***hosp***
- patients
- admissions
- diagnoses_icd
- procedures_icd
- emar
- microbiologyevents

***icu***
- icustays
- chartevents
- procedureevents

### Creating Cohort





