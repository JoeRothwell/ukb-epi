# Extract data from Stata log files. Amino acids analysis and other metabolite analyses
cd /Users/joe/Documents/Stata

# Amino acids, all CRC subsites (last updated after correction of 2019 results)
egrep "ent:|ala|gl|his|leu| iso| val|phe|tyr" LOG_crc_amino_fast2021a.txt > CRC_amino2021.txt

# Categorical ref Q1
#egrep "ent:|ala|Igl|his|leu|iso|val|phe|tyr" LOG_CRC_amino_cat2021.txt > CRC_amino_cat.txt
egrep "ent:|ala|Igl|his|iso|leu|val|phe|tyr" LOG_crc_amino_cat1.txt

# Trend test (same model but without i. in Stata)
egrep "ent:|ala_|gln_|gly_|his_|iso_|leu_|val_|phe_|tyr_" LOG_crc_amino_trend2021a.txt

# Exclude early diagnoses (no exclusions and 2-year lag)
egrep "ent:|ala|gl|his|leu|iso| val|phe|tyr" LOG_amino_exclude_early2021a.txt
egrep "failures" LOG_amino_exclude_early2021a.txt

# Continuous fasting only (not used)
egrep "ent:|ala|gl|his|leu| val|phe|tyr" LOG_CRC_amino_fast.txt > CRC_amino_fast.txt

# ICCs
egrep "id " LOG_ICC_metabo.txt | egrep -v "Number of groups" > ICC_168metab.txt
egrep "id " LOG_ICC_bm.txt | egrep -v "Number of groups" > ICC_bm.txt

# ICCs (fasting)
egrep "id " LOG_ICC_metabo_fast.txt | egrep -v "Number of groups" > ICC_168metab_fast.txt

# Amino acids, case-control study matched 1:5
egrep "ent:|ala|gl|his|leu|iso|val |phe|tyr " LOG_aminoacid_case_control.txt
egrep "ent:|ala|gl|his|leu|iso|val_|phe|tyr" LOG_aminoacid_case_control_cat.txt

# Trend test
egrep "ent:|ala_|gln_|gly_|his_|iso_|leu_|val_|phe_|tyr_" LOG_aminoacid_case_control_trend.txt

# Update 2022

# Amino acids, all CRC subsites (updated after update to England follow-up). Note isoleucine now ile
egrep "ent:|ala|gl|his|leu|ile| val|phe|tyr" LOG_crc_amino.txt
# Exclude early diagnoses (no exclusions and 2-year lag)
egrep "ent:|ala|gl|his|leu|ile| val|phe|tyr" LOG_crc_amino_lag.txt
egrep "failures" LOG_crc_amino_lag.txt

# Categorical and trend test
egrep "ent:|ala|Igl|his|ile|leu|val|phe|tyr" LOG_crc_amino_cat.txt
egrep "ent:|ala_|gln_|gly_|his_|ile_|leu_|val_|phe_|tyr_" LOG_crc_amino_trend.txt

egrep "ent:|ala|gln|gly|his|ile|leu| val|phe|tyr" LOG_crc_amino_sex2022.txt
