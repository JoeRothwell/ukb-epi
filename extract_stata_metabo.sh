# Extract data from Stata log files, reorganised November 2020
# Analyses are now grouped by inclusions (metS, pre-diabetes, diabetes)
cd /Users/joe/Documents/Stata

# Amino acids, all CRC subsites
egrep "ent:|ala|gl|his|leu| iso| val|phe|tyr" LOG_crc_amino_fast2021.txt > CRC_amino2021.txt

# Categorical ref Q1
egrep "ent:|ala|Igl|his|leu|iso|val|phe|tyr" LOG_CRC_amino_cat2021.txt > CRC_amino_cat.txt
egrep "ent:|ala|Igl|his|iso|leu|val|phe|tyr" LOG_crc_amino_cat_fast2021.txt > CRC_amino_cat_fast.txt

# Trend test (same model but without i. in Stata)
egrep "ent:|ala_|gln_|gly_|his_|iso_|leu_|val_|phe_|tyr_" LOG_crc_amino_trend2021.txt

# Continuous fasting
egrep "ent:|ala|gl|his|leu| val|phe|tyr" LOG_CRC_amino_fast.txt > CRC_amino_fast.txt

# Exclude early diagnoses
egrep "ent:|ala|gl|his|leu| val|phe|tyr" LOG_amino_exclude_earlyCRC.txt > CRC_amino_exclude early.txt

# ICCs
egrep "id " LOG_ICC_metabo.txt | egrep -v "Number of groups" > ICC_168metab.txt
egrep "id " LOG_ICC_bm.txt | egrep -v "Number of groups" > ICC_bm.txt

# ICCs (fasting)
egrep "id " LOG_ICC_metabo_fast.txt | egrep -v "Number of groups" > ICC_168metab_fast.txt