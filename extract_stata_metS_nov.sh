# Extract data from Stata log files, reorganised November 2020
# Analyses are now grouped by inclusions (metS, pre-diabetes, diabetes)
cd /Users/joe/Documents/Stata

# metS

# Pre-diabetes

# Diabetes and time to diabetes

egrep "failures|ent:|_It" LOG_tdiab.txt | egrep -v "nat|No." > tdiab1.txt
egrep "failures|ent:|_It" LOG_tdiab_BM.txt | egrep -v "nat|No." > tdiab_BM.txt

# Early onset, CRC only
cat LOG_metS_earlyonset_BM.txt LOG_prediab_earlyonset_BM.txt LOG_diab_earlyonset_BM.txt | \
egrep "ent:|diabet?_1|arm_1|CEP_1|IDF2_1" > crc_earlyonset_BM.txt

cat LOG_metS_earlyonset.txt LOG_prediab_earlyonset.txt LOG_diab_earlyonset.txt | \
egrep "ent:|diabet?_1|arm_1|CEP_1|IDF2_1" > crc_earlyonset.txt

# Polygenic risk scores: associations with CRC and pancreatic cancer
egrep "_scale" LOG_assoc_PRS.txt > PRS_assoc.txt
# Adjusted genotyping array and genetic ancestry PCs
egrep "_scale" LOG_PRS_adj.txt > PRS_assoc_adj.txt
 
# PRS stratified models for metS/diabetes
egrep "ent:|diabet?_1|arm_1|CEP_1|IDF2_1|_scale" LOG_metS_PRS.txt > metS_PRS.txt
egrep "ent:|diabet?_1" LOG_prediab_PRS.txt > prediab_PRS.txt
egrep "ent:|diabet?_1" LOG_diab_PRS.txt > diab_PRS.txt

# Biomarker adjusted
egrep "ent:|diabet?_1|arm_1|CEP_1|IDF2_1|_scale" LOG_metS_PRS_bm.txt > metS_PRS_bm.txt
egrep "ent:|diabet?_1" LOG_prediab_PRS_bm.txt > prediab_PRS_bm.txt
egrep "ent:|diabet?_1" LOG_diab_PRS_bm.txt > diab_PRS_bm.txt

# PRS adjusting for genotyping array and 15 genetic ancestry PCs
egrep "ent:|diabet?_1|arm_1|CEP_1|IDF2_1|_scale" LOG_metS_PRS_adj.txt > metS_PRS_adj.txt
egrep "failures|ent:|_It" LOG_metS_PRS_adj.txt

egrep "ent:|diabet?_1|arm_1|CEP_1|IDF2_1|_scale" LOG_metS_PRS_adj.txt > metS_PRS_adj1.txt
egrep "failures|ent:|_It" LOG_metS_PRS_adj.txt
