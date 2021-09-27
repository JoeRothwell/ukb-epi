*! DO FILE FOR BOOK KEEPING AND RENAMING OF VARIABLES
clear all
set more off
capture log close
//log using "LOG - cr2-variable-organisation.smcl", replace
***************************************************
// data. Use new dataset created by JR 2/6/2021
//use "tempukb_working.dta1", clear
***************************************************
**********************************************************************************************************************
**********************************************************************************************************************
*===========================================================================================
*-------------------------------------------------------------------------------------------
* UK Biobank 
*
* File Name:			cr2-variable-organisation.do 
*
* Purpose:		 		Rename variables for data cleaning  

*===========================================================================================
**********************************************************************************************************************
*** drop variables with missing for all observations 
//dropmiss 
//save "tempukb_working.dta", replace

*Rename variable *********************************
***************************************************************************************************
*************************************************************************************************** 
use "tempukb_working1.dta", clear
*** demographic 
*** sex 
ta sex male 

**education - qualifications
rename n_6138_0* qual* 

**townsend deprivation index at 
summ dpr_index

*** assessment center 
ta assess_cen  

order id sex qual_0-qual_5 dpr_index assess_cen 

*** Age variables 
**age when attended assessment centre
rename n_21003_0_0 age_assess

*** other age variables: 
* age at recruitment 
summ age_recr

* age at exit 
summ age_exit_frst

* age at the time of death 
summ death_age_0_0 
gen age_death = .
replace age_death = death_age_0_0 
replace age_death = death_age_1_0 if age_death==. 
//replace age_death = death_age_2_0 if age_death==. 
//JR note: Death age 2 not found in 2019 data

count if age_death>age_exit & age_death!=. 
list age_death age_exit if age_death>age_exit & age_death!=. in 1/1000 
replace age_death = . if age_death>age_exit & age_death!=. 

* ethnic background
rename n_21000_0_0 ethnic 

*  age at colorectal cancer diagnosis 
gen crc_age = age_exit_frst if colorectal_inc== 1 

* birth year 
codebook birth_yr 

*** Important dates 
rename death_dte dte_death 
codebook dte_exit_frst 
rename first_ca_10_dte dte_frst_ca 
rename recruit_dte dte_recruit
rename cens_dte dte_cens  
rename colorectal_ca_dte dte_crc 
rename lost_followup_dte dte_lost_followup 

order id assess_cen ethnic birth_yr dte_recruit dte_crc dte_frst_ca dte_death dte_lost_followup dte_cens dte_exit_frst followup_yrs /// 
age_assess age_recr age_exit_frst age_death crc_age /// 
dead_followup followup_lost lost_followup_rsn prevalent_10 prevalent_9 prevalent_Dcns   

*************************************************************************************************** 
*** body size measures: 
**weight - measured
rename n_21002_0_0 weight_m

**weight - bioimp
rename n_23098_0_0 weight_bio

**height - standing measured
rename n_50_0_0 height_m

**bmi - measured 
rename n_21001_0_0 bmi_m

**bmi  - bioimp
rename n_23104_0_0 bmi_bio

**wc
rename n_48_0_0 waist_c

**hip circumferece
rename n_49_0_0 hip_c

**body fat% - bioimp
rename n_23099_0_0 fat_pctge

**body fat mass - bioimp
rename n_23100_0_0 fat_mass

**Whole body fat-free mass - bioimp
rename n_23101_0_0 fatfree_mass 

**Leg fat percentage (right) - bioimp
rename n_23111_0_0 rightlegfat_pctge

**Leg fat mass (right) - bioimp
rename n_23112_0_0 rightlegfat_mass

**Leg fat free mass (right) - bioimp
rename n_23113_0_0 rightlegfatfree_mass

**Leg fat percentage (left) - bioimp
rename n_23115_0_0 leftlegfat_pctge

**Leg fat mass (left) - bioimp
rename n_23116_0_0 leftlegfat_mass 

**Leg fat-free mass (left) - bioimp
rename n_23117_0_0  leftlegfatfree_mass

**Arm fat percentage (right) - bioimp
rename n_23119_0_0 rightarmfat_pctge 

**Arm fat mass (right) - bioimp
rename n_23120_0_0 rightarmfat_mass

**Arm fat-free mass (right) - bioimp
rename n_23121_0_0 rightarmfatfree_mass 

**Arm fat percentage (left) - bioimp
rename n_23123_0_0 leftarmfat_pctge 

**Arm fat mass (left) - bioimp
rename n_23124_0_0 leftarmfat_mass

**Arm fat-free mass (left) - bioimp
rename n_23125_0_0 leftarmfatfree_mass 

**Trunk fat percentage - bioimp
rename n_23127_0_0 trunkfat_pctge

**Trunk fat mass - bioimp
rename n_23128_0_0 trunkfat_mass 

**Trunk fat-free mass - bioimp
rename n_23129_0_0 trunkfatfree_mass

**pancreatic fat DICOM - MRI
rename s_20202_2_0 pancfat

//The following variables are in another dataset
merge 1:1 id using "D:/ukb37233_9var.dta", nogenerate
**Liver iron (Fe) - MRI
rename n_22400_0_0 liverFe

**Liver inflammation factor (LIF) - MRI
rename n_22401_0_0 liverLIF 

**Proton density fat fraction (PDFF) - liver fat - MRI
rename n_22402_2_0 liverfat

//Need this reorder?
order id weight_m weight_bio height_m bmi_m bmi_bio waist_c ///
 hip_c fat_pctge fat_mass  fatfree_mass  rightlegfat_pctge  rightlegfat_mass rightlegfatfree_mass ///
 leftlegfat_pctge leftlegfat_mass leftlegfatfree_mass rightarmfat_pctge rightarmfat_mass rightarmfatfree_mass ///
  leftarmfat_pctge leftarmfat_mass leftarmfatfree_mass trunkfat_pctge trunkfat_mass  trunkfatfree_mass ///
  pancfat liverFe liverLIF liverfat ///

 *** lifestyle variables: 
*** smoking: 
**smoking status
rename n_20116_0_0 smoke_stat

**smoking current
rename n_1239_0_0 smoke_curr

**smoking
rename n_3456_0_0 smoke_curr_intens

**smoking past
rename n_1249_0_0 smoke_past

order id-trunkfatfree_mass smoke_stat smoke_curr smoke_curr_intens smoke_past 

*** physical activity 
**walking PA - duration
rename n_874_0_0 pa_walk_dur

**walking - number of days/week walked 10+ minutes
rename n_864_0_0 pa_walk_days

**moderate PA - duration
rename n_894_0_0 pa_mod_dur

**moderate PA - number of days/week
rename n_884_0_0 pa_mod_days

**vigorous PA - duration
rename n_914_0_0 pa_vig_dur

**vigorous PA - number of days/week
rename n_904_0_0 pa_vig_days

**types of PA in last 4 weeks
//renvars n_6164_0*, subst(n_6164_0 pa_type_4wk) 
rename n_6164_0* pa_type_4wk* 

// time spent watching TV on typical day
rename n_1070_0_0 tvtime

// time spent on computer on typical day
rename n_1080_0_0 comptime

**overall acceleration avg
rename n_90012_0_0 pa_accel

**fraction of acceleration <=125 milli-gravities
rename n_90128_0_0 pa_accel_less125

**fraction of acceleration <=100 milli-gravities
rename n_90127_0_0 pa_accel_less100

**date of starting to wear accelerometer
rename ts_90010_0_0 pa_accel_start 

**date of stopping wearing accelerometer
rename ts_90011_0_0 pa_accel_end

order id smoke_past  pa_walk_dur pa_walk_days  pa_mod_dur pa_mod_days /// 
pa_vig_dur pa_vig_days pa_type_4wk* tvtime comptime pa_accel pa_accel_less125 /// 
pa_accel_less100 pa_accel_start pa_accel_end

*** Alcohol drinking 
**alcohol drinking status
rename n_20117_0_0 alc_stat

**alcohol intake frequency
rename n_1558_0_0 alc_int_freq
 
order id pa_accel_end alc_stat alc_int_freq

*** diet 
**fresh fruits (pieces/day)
rename n_1309_0_0 fruit_fresh

**cooked vegetables
rename n_1289_0_0 veg_cooked

**cooked vegetables
rename n_1299_0_0 veg_saladraw

**fish - non-oily
rename n_1339_0_0 fish_nonoil

**fish - oily
rename n_1329_0_0 fish_oil

**beef intake
rename n_1369_0_0 meat_beef

**lamb/mutton intake
rename n_1379_0_0 meat_lamb

**pork intake
rename n_1389_0_0 meat_pork

**cheese intake
rename n_1408_0_0 dairy_cheese

**milk intake
rename n_1418_0_0 dairy_milk

**spread intake
rename n_1428_0_0 spreads

**cereal intake
rename n_1458_0_0 cereal_intake

**cereal intake
rename n_1468_0_0 cereal_type

**processed meat
rename n_1349_0_0 meat_pro

order id alc_int_freq fruit_fresh veg_cooked veg_saladraw fish_nonoil ///
fish_oil meat_beef  meat_lamb meat_pork dairy_cheese dairy_milk spreads ///
cereal_intake cereal_type  meat_pro

*** hormonal factors 
**HRT - ever use
rename n_2814_0_0 ever_horm

**HRT - age started
rename n_3536_0_0 age_horm_start

**HRT - age last used
rename n_3546_0_0 age_horm_last

**age at menarche
//rename n_2714_0_0 age_menarche 

**number of live births
rename n_2734_0_0 lb_no 

***age at first live birth 
rename n_2754_0_0 lb_1st_age 

**age at menopause
rename n_3581_0_0 age_menop

**menopause
rename n_2724_0_0 menop

**OC - ever use
rename n_2784_0_0 ever_oc

**OC - age started
rename n_2794_0_0 age_oc_start

**OC - age last used
rename n_2804_0_0 age_oc_last

//The following 3 variables are in a different dataset (omitted because don't currently use)
//male baldness
//rename n_2395_0_0 manbald

//male voice
//rename n_2385_0_0 manvoice

//male face hair
//rename n_2375_0_0 manfacehair


order id meat_pro ever_horm age_horm_start age_horm_last /*age_menarche*/ lb_no age_menop menop /// 
 lb_1st_age ever_oc age_oc_start age_oc_last ///manbald manvoice manfacehair
 
*** medication use 
**female medication variable
//renvars n_6153_0*, subst(n_6153_0 women_meds)
rename n_6153_0* women_meds*

**male medication variable
rename n_6177_0* men_meds*

**male and female medication variable - including aspirin, ibuprofen, paracetamol, omeprazole.
rename n_6154_0* medication*

**vitamin/mineral supplements 
rename n_6155_0* suppl*

**mineral and other dietary supplements
//rename n_6179_0* mineral*

**Repeat assessment (added JR)
**female medication variable
rename n_6153_1* women_meds_rep*

**male medication variable
rename n_6177_1* men_meds_rep*

**male and female medication variable - including aspirin, ibuprofen, paracetamol, omeprazole.
rename n_6154_1* medication_rep*

order id /*manfacehair*/ women_meds* men_meds* medication* /*mineral**/ suppl* 
 
*** Family history of disease 
**illnesses of father
rename n_20107* fh_father*

**illnesses of mother
rename n_20110* fh_mother*

**illnesses of siblings
rename n_20111* fh_sibling*
order id suppl_6 fh_father* fh_mother* fh_sibling* 

**ever had bowel cancer screening
rename n_2345_0_0 crc_screen


rename n_2443_0_0 diab_dx 
rename n_2976_0_0 diab_age 
rename n_2986_0_0 diab_ins

********************************************************************************
//BIOMARKERS
//Need to join another dataset
merge 1:1 id using "D:/ukb29804_559var.dta", nogenerate

**fasting time
rename n_74_0_0 fasting0

**albumin
rename n_30600_0_0 alb
**alkaline phosphatase
rename n_30610_0_0 alp
**alanine aminotransferase
rename n_30620_0_0 alt
*apolipoprotein A
rename n_30630_0_0 apoa
**apolipoprotein B
rename n_30640_0_0 apob
**aspartate aminotransferase
rename n_30650_0_0 ast
**direct bilirubin
rename n_30660_0_0  dbili
**urea
rename n_30670_0_0 urea
**calcium
rename n_30680_0_0  cal
**cholesterol
rename n_30690_0_0 chol
**creatinine
rename n_30700_0_0 cre
**C-reactive protein
rename n_30710_0_0  crp
**cystatin C
rename n_30720_0_0  cys
**gamma glutamyltransferase
rename n_30730_0_0 ggt
**glucose
rename n_30740_0_0 glc
**Glycated haemoglobin (HbA1c)
rename n_30750_0_0 hba1c
**HDL cholesterol
rename n_30760_0_0 hdl
**IGF-1
rename n_30770_0_0 igf1
**LDL direct
rename n_30780_0_0  ldl
**lipoprotein A
rename n_30790_0_0  lipoa
**oestradiol
rename n_30800_0_0  e2
**phosphate
rename n_30810_0_0 phos
**rheumatoid factor
rename n_30820_0_0  rheumf
**SHBG
rename n_30830_0_0  shbg
**total bilirubin
rename n_30840_0_0 tbili
**testosterone
rename n_30850_0_0  testo
**total protein
rename n_30860_0_0  prot
**triglycerides
rename n_30870_0_0 tryg
**urate
rename n_30880_0_0  urate
**vitamin D
rename n_30890_0_0  vitd


order id diab_ins fasting0 alb alp alt apoa apob ast dbili urea cal chol cre ///
crp cys ggt glc hba1c hdl igf1 ldl lipoa e2 phos /// 
rheumf shbg tbili testo prot tryg urate vitd /// 
crc_screen allcan any_ca ca_total_reported icd10_malign icd9_malign /// 
breast_inc bladder_inc /// 
brain_inc allhaem_inc anal_inc ///
cervix_inc cns_inc colon_inc colorectal_inc digestive_inc dist_colon_inc  ///
kidney_inc leuk_inc liver_inc hcc_inc ibdc_inc  ///
lung_inc melanoma_inc multmyeloma_inc ///
nhl_inc oesoph_inc oesophad_inc oesophsq_inc oral_inc ovary_inc endometrial_inc pancreas_inc ///
prostate_inc prox_colon_inc  ///
rectal_inc region region_bin renal_inc respiratory_inc stomach_inc cardstomach_inc noncardstomach_inc ///
thyroid_inc urinary_inc uterine_inc 
	
sort id
save "tempukb_working_organised2021.dta", replace
************************************************************************************************************************


















