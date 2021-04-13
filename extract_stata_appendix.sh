# Appendectomy, myopia and flu vaccine

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
