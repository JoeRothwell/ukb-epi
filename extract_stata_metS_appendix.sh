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

# Re-analysis April 2021 (diabetics not considered in definitions, not excluded)
cat LOG_metS_crc.txt LOG_metS_GI.txt | \
egrep "ent:|arm_1|CEP_1|IDF2_1|obes_1|hdl_1|hb_1|bp_1|tryg_1|alth_[123]" > metS_main.txt

# Cases within 2 years excluded
cat LOG_metS_crc_excl2yr.txt LOG_metS_GI_excl2yr.txt | \
egrep "ent:|arm_1|CEP_1|IDF2_1" > metS_main_excl2yr.txt

# PRS
egrep "ent:|arm_1|CEP_1|IDF2_1" LOG_metS_PRS1.txt > metS_PRS1.txt
egrep "failures|ent:|_It" LOG_metS_PRS1.txt

# Re-analysis May 2021 adding medications to definitions
cat LOG_metS_crc_med1.txt LOG_metS_GI_med1.txt | \
egrep "ent:|arm_1|CEP_1|IDF2_1|obes_1|hdl_1|hb_1|bp_1|tryg_1|alth_[123]" > metS_main_med1.txt

# Cases within 2 years excluded
cat LOG_metS_crc_excl2yr_med1.txt LOG_metS_GI_excl2yr_med1.txt | \
egrep "ent:|arm_1|CEP_1|IDF2_1" > metS_excl2yr_med1.txt

# PRS
egrep "ent:|arm_1|CEP_1|IDF2_1" LOG_metS_PRS_med1.txt > metS_PRS_med1.txt
egrep "failures|ent:|_It" LOG_metS_PRS_med1.txt

# Pancreatic metS components by sex
egrep "ent:|arm_1|CEP_1|IDF2_1|obes_1|hdl_1|hb_1|bp_1|tryg_1|alth_[123]" LOG_metS_panc_sex.txt

# Thyroid cancer Therese
egrep "ent:|arm_1|CEP_1|IDF2_1|obes_1|hdl_1|hb_1|bp_1|tryg_1|alth_[123]" LOG_metS_thyroid.txt > metS_thyroid.txt

# Gastrointestinal cancers by smoking status
egrep "ent:|arm_1|CEP_1|IDF2_1|obes_1|hdl_1|hb_1|bp_1|tryg_1|alth_[123]" LOG_metS_GI_smoke1.txt

# Case-control sensitivity analysis
egrep "ent:|arm_1|CEP_1|IDF2_1|obes_1|hdl_1|hb_1|bp_1|tryg_1|alth_[123]" LOG_metS_case_control.txt



### Appendectomy, myopia and flu vaccine

# Change to Stata working directory and change back
cd ~/Documents/Stata
#cd ~/ukb-epi

# Appendectomy only, CRC, male and female
egrep "appendic|CANCER" LOG_crc_appendectomy.txt | egrep -v "stcox"
egrep "appendic|CANCER" LOG_crc_appendectomy.txt | egrep -v "stcox" > appendectomy.txt

# Age at appendectomy (5 cats)
# Use complement -v to get rid of stcox lines
egrep "appen_*" LOG_crc_append_age.txt | egrep -v "stcox" > age_append.txt
# Append results for 2 cats
egrep "appen_*" LOG_crc_append_age1.txt | egrep -v "stcox" >> age_append.txt

# 2 cats stratified sex
egrep "_appen_*|Haz" LOG_crc_ageappend_2cat.txt | egrep -v "stcox|coded" | \
sort -u > age_append_sex.txt

egrep "_appen_*|Haz" LOG_crc_ageappend_2cat_sex.txt | egrep -v "stcox|coded" | \
sort -u > age_append_sex.txt

egrep "_appen_*" LOG_crc_ageappend_2cat_sex.txt | egrep -v "stcox|coded" > age_append_sex.txt


# Myopia
egrep "myopia_*" LOG_crc_myopia.txt | egrep -v "stcox" > crc_myopia.txt

# Flu vaccine
egrep "flu_vaccine" LOG_crc_flu.txt | egrep -v "stcox" > crc_flu_vaccine.txt

# Run again to correct errors:  concatenate all log files and extract data
cat LOG_crc_ageappend_2cat.txt LOG_crc_ageappend_6cat.txt LOG_crc_myopia.txt LOG_crc_flu.txt | \
egrep "appendic|appen_*|myopia_*|flu_vacci_1" | egrep -v "Stata" > append_myopia_flu.txt

# Appendectomy and age at appendectomy again for meta-analysis
wc -l LOG_crc_appendectomy_ma.txt
egrep "appendic|_appen_*|_inc|~c" LOG_crc_appendectomy_ma.txt | \
egrep -v "failure|coded|stcox" > appendic_ma.txt

# Same again corrected age at appendectomy model
wc -l LOG_crc_appendectomy_ma1.txt
egrep "appendic|_appen_*|_inc|~c" LOG_crc_appendectomy_ma1.txt | \
egrep -v "failure|coded|stcox" > appendic_ma1.txt

# Age at appendectomy reference no appendectomy
wc -l LOG_age_append_refnone.txt
egrep "appendic|_appen_*|_inc|~c" LOG_age_append_refnone.txt | \
egrep -v "failure|coded|stcox" > age_append_refnone.txt

# Serological analysis: extract 2 lines after each _at
egrep "log_" LOG_biomarker_means_adj.log | egrep -v "Std"
grep -i -A 2 "_at |" LOG_biomarker_means_adj.log


# Appendectomy with and without adjustment for igf1 (30 models)
wc -l LOG_crc_append_igf1.txt
egrep "appendic|_appen_*|_inc|~c" LOG_crc_append_igf1.txt | \
egrep -v "failure|coded|stcox" > appendic_igf1.txt

# Sensitivity analysis excluding prevalent UC
wc -l LOG_crc_append_ulccol.txt
egrep "appendic|_appen_*|_inc|~c" LOG_crc_append_ulccol.txt | \
egrep -v "failure|coded|stcox" > appendic_ulccol.txt


# Reanalysis Jan 2021 excluding cancers of the appendix: with and without IGF1
wc -l LOG_crc_append_jan.txt
egrep "appendic|_appen_*|_inc|~c" LOG_crc_append_jan.txt | \
egrep -v "failure|coded|stcox" > appendic_jan.txt

# Reanalysis Jan 2021 age at appendectomy reference no appendectomy
wc -l LOG_age_append_jan.txt
egrep "appendic|_appen_*|_inc|~c" LOG_age_append_jan.txt | \
egrep -v "failure|coded|stcox" > age_append_jan.txt

# Biomarker analysis: extract 2 lines after each _at (double hyphen escapes the hyphens)
egrep "log_" LOG_biomarker_means_jan.log | egrep -v "Std" > biomarkers_jan0.txt
grep -i -A 2 "_at |" LOG_biomarker_means_jan.log | egrep -v -- "--" > biomarkers_jan.txt
egrep "_cons" LOG_biomarker_means_jan.log > biomarkers_jan1.txt

# Sensitivity analysis excluding prevalent UC
wc -l LOG_crc_ulccol_jan.txt
egrep "appendic|_appen_*|_inc|~c" LOG_crc_ulccol_jan.txt | \
egrep -v "failure|coded|stcox" > append_ulccol_jan.txt

# Adjusted and basic models for appendix Y/N March 2021
wc -l LOG_crc_basic_adj.txt
egrep "appendic|event:" LOG_crc_basic_adj.txt > append_basic_adj.txt

# Basic models for age at appendectomy
wc -l LOG_age_append_basic.txt
egrep "_Iappendic__1|event:" LOG_age_append_basic.txt > age_append_basic_adj.txt

# Sensitivity analysis excluding UC, endometriosis, IBS, gallstones, GORD, pain
cat LOG_crc_excl_ulcol.txt LOG_crc_excl_endomet.txt LOG_crc_excl_ibs.txt LOG_crc_excl_galls.txt \
LOG_crc_excl_gord.txt LOG_crc_excl_pain.txt | \
egrep "appendic|event|ulcol|endomet|ibs|galls|gord|pain" | egrep -v "stcox" > sensitivity_pain.txt 