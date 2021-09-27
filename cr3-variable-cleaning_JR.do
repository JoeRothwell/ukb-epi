*! DO FILE FOR BOOK KEEPING AND RENAMING OF VARIABLES
clear all
set more off
capture log close
///log using "D:\UK Biobank\analyses2019\log setup\LOG - cr3-variable-cleaning.smcl", replace
***************************************************
// data
use "tempukb_working_organised1.dta", clear

*===========================================================================================

*-------------------------------------------------------------------------------------------
* UkBiobank 
*
* File Name:			cr3-variable-organisation.do 
*
* Purpose:		 		Data cleaning 
*
*===========================================================================================
**********************************************************************************************************************
sort id 
count


**********************************************************************************************************************
// exclude those with missing value for weight, height, bmi, or waist 
drop if (weight_m==. | height_m==. | bmi_m == . | waist_c==.) // 




******************************************************************************** 
**Labelling and cleaning variables**********************************************
********************************************************************************
********************************************************************************
********************************************************************************
**********************************************************************************************************************
*** impose eligibiltiy criteria  
*** 1 ) exclude those who withdrew consent 
**drop participants who have withdrawn from study and requested that data not used - from email dated 7th April 2016
drop if id==1517999
drop if id==1550677
drop if id==1750901
drop if id==1853931
drop if id==2103497
drop if id==2114338
drop if id==2315547
drop if id==2750734
drop if id==2791325
drop if id==2882920
drop if id==3056716
drop if id==3517988
drop if id==3680183
drop if id==4249574
drop if id==4399357
drop if id==4668204
drop if id==4675405
drop if id==4677940
drop if id==4952489
drop if id==5031985
drop if id==5837627

**drop participants who have withdrawn from study and requested that data not used - from email dated 26th July 2017
drop if id==1502462
drop if id==2023229
drop if id==2069890
drop if id==2217189
drop if id==2373848
drop if id==2532542
drop if id==2676165
drop if id==3053951
drop if id==3350605
drop if id==3606435
drop if id==3721079
drop if id==4282005
drop if id==4963797
drop if id==5021275
drop if id==5178224
drop if id==5308816
drop if id==6013344

**drop participants who have withdrawn from study and requested that data not used - from email dated 8th August 2017
drop if id==1043310
drop if id==1245590
drop if id==1414077
drop if id==1517999
drop if id==1549909
drop if id==1550677
drop if id==1750901
drop if id==1803197
drop if id==1853931
drop if id==1990446
drop if id==2103497
drop if id==2114338
drop if id==2315547
drop if id==2401122
drop if id==2713693
drop if id==2750734
drop if id==2758853
drop if id==2791325
drop if id==2882920
drop if id==3056716
drop if id==3066786
drop if id==3111909
drop if id==3295341
drop if id==3444997
drop if id==3517988
drop if id==3680183
drop if id==3969995
drop if id==4034323
drop if id==4056843
drop if id==4249574
drop if id==4331927
drop if id==4399357
drop if id==4421962
drop if id==4509597
drop if id==4633489
drop if id==4668204
drop if id==4675405
drop if id==4677940
drop if id==4952489
drop if id==5031985
drop if id==5323308
drop if id==5340537
drop if id==5668411
drop if id==5837627
drop if id==5963727

**drop participants who have withdrawn from study and requested that data not used - from email dated 11th May 2018
drop if id==1311206
drop if id==1502462
drop if id==2023229
drop if id==2069890
drop if id==2217189
drop if id==2373848
drop if id==2532542
drop if id==2676165
drop if id==3053951
drop if id==3350605
drop if id==3606435
drop if id==3721079
drop if id==4282005
drop if id==4388266
drop if id==4785863
drop if id==4963797
drop if id==5021275
drop if id==5178224
drop if id==5308816
drop if id==6013344

**drop participants who have withdrawn from study and requested that data not used - from email dated 23rd Oct 2018
drop if id==1245564
drop if id==1280308
drop if id==1311206
drop if id==1456981
drop if id==1502462
drop if id==1513685
drop if id==1517086
drop if id==1653601
drop if id==1795927
drop if id==1865625
drop if id==1883947
drop if id==1897061
drop if id==1920223
drop if id==2007054
drop if id==2023229
drop if id==2069890
drop if id==2144388
drop if id==2204518
drop if id==2217005
drop if id==2217189
drop if id==2286833
drop if id==2347723
drop if id==2358315
drop if id==2373848
drop if id==2443306
drop if id==2532542
drop if id==2661582
drop if id==2666478
drop if id==2672150
drop if id==2676165
drop if id==2723804
drop if id==2748205
drop if id==2791053
drop if id==2900304
drop if id==2917495
drop if id==3008079
drop if id==3053951
drop if id==3227800
drop if id==3235702
drop if id==3323690
drop if id==3344863
drop if id==3350605
drop if id==3353556
drop if id==3410573
drop if id==3435246
drop if id==3491372
drop if id==3567152
drop if id==3606435
drop if id==3632038
drop if id==3657652
drop if id==3721079
drop if id==3722131
drop if id==3793073
drop if id==3880258
drop if id==4057543
drop if id==4068282
drop if id==4241972
drop if id==4278967
drop if id==4282005
drop if id==4321654
drop if id==4354836
drop if id==4388266
drop if id==4492941
drop if id==4493175
drop if id==4538782
drop if id==4586233
drop if id==4685137
drop if id==4785863
drop if id==4937976
drop if id==4963797
drop if id==5020382
drop if id==5021275
drop if id==5035526
drop if id==5178224
drop if id==5194492
drop if id==5243459
drop if id==5308816
drop if id==5321478
drop if id==5401199
drop if id==5448810
drop if id==5485463
drop if id==5496344
drop if id==5501844
drop if id==5607180
drop if id==5667277
drop if id==5902769
drop if id==5915395
drop if id==5915655
drop if id==5935739
drop if id==5944539
drop if id==5958048
drop if id==5965055
drop if id==6013344

count 

******************************************************************************** 
*******************************demographics*************************************
********************************************************************************
**sex
ta sex 
label define selb 0"Female" 1"Male"
label value sex selb
tab sex male 

**townsend deprivation index at 
codebook dpr_index
xtile dpr_index_q5 = dpr_index, nq(5)
tab dpr_index_q5
replace dpr_index_q5 = 9 if dpr_index_q5==.
tab dpr_index_q5

xtile dpr_index_q4 = dpr_index, nq(4)
tab dpr_index_q4
replace dpr_index_q4 = 9 if dpr_index_q4==.
tab dpr_index_q4

xtile dpr_index_q3 = dpr_index, nq(3)
tab dpr_index_q3
replace dpr_index_q3 = 9 if dpr_index_q3==.
tab dpr_index_q3

* ethnic background
codebook ethnic
gen ethnic_cat = ethnic 
recode ethnic_cat -1=9 -3=9 .=9 1=1 1001=1 2001=1 3001=1 4001=1 2=2 1002=2 2002=2 3002=2 4002=2 ///
3=3 1003=3 2003=3 3003=3 4003=3 4=4 2004=4 3004=4 5=5 6=6 
lab define ethnic_lab 1"white" 2"mixed" 3"asian" 4"black" 5"Chinese" 6"Other" 9"missing"
lab value ethnic_cat ethnic_lab 
ta ethnic_cat, m  

******************************************************************************** 

**education - qualifications
gen qual = qual_0
codebook qual
gen qualif = .
replace qualif = 1 if qual==-7
replace qualif = 2 if qual==3 | qual==4
replace qualif = 3 if qual==2 | qual==5
replace qualif = 4 if qual==6
replace qualif = 5 if qual==1
replace qualif = 9 if qual==-3 | qual==.
label define quallb 1"None of the above" 2"CSEs/O-levels/GCSEs or equivalent" 3"NVQ/HND/HNC/A-levels/AS-levels or equivalent" 4"Other professional quals. (eg nurse/teach)" 5"College/uni degree" 9"prefer not to answer/missing"
label value qualif quallb
tab qualif colorectal_inc, m col

gen education_max = . 
replace education_max = max(qual_0,qual_1,qual_2,qual_3,qual_4,qual_5)

gen education_cat = .
replace education_cat = 1 if education_max==-7
replace education_cat = 2 if education_max==3 | education_max==4
replace education_cat = 3 if education_max==2 | education_max==5
replace education_cat = 4 if education_max==6
replace education_cat = 5 if education_max==1
replace education_cat = 9 if education_max==-3 | education_max==.
label value education_cat quallb
tab qualif education_cat, m col 

drop qualif qual 

*Age
***Generate an age at recruitment variable (AGE1) in 1 year categories (LEN1 equivalent)
sum age_recr, de
codebook age_recr

**Generating an age category variable, 5 year categories - for stratifying in Cox models
egen age_cat5 = cut(age_recr), at (30, 45, 50, 55, 60, 65, 150) icodes
label define agecat5L 0 "<45" 1 "45-49" 2 "50-54" 3 "55-59" 4 "60-64" 5 "65-73" 
label values age_cat5 agecat5L
tab age_cat5
tabstat age_recr, by(age_cat5) stat(min max)

*Age - categorical - 3 cats
summ age_recr, d 
generate age_cat3=recode(age_recr,54,64,73)
label define agecat3L 54"<55 yrs" 64"55 to <65 yrs" 73"65 yrs + "
label value age_cat3 agecat3L
tabstat age_recr, by(age_cat3) stat(min max)
ta age_cat3, m 

*Age - categorical - 3 cats younger 
generate age_cat3_young=recode(age_recr,44,59,73) 
label define agecat3youngL 44"<45 yrs" 59"45 to <60 yrs" 73"60 yrs +"
label value age_cat3_young agecat3youngL
tabstat age_recr, by(age_cat3_young) stat(min max)
ta age_cat3_young, m 

**age cats to adjust for age in incidence**
summ age_recr, d 
generate age_cat_adj=recode(age_recr,44,49,54,59,64,69) 
label define age_catadjlb  44"<44.9" 49"45-49.9" 54"50-54.9" 59"55-59.9" 64"60-64.9" 69"65 +"  
label value age_cat_adj age_catadjlb
tabstat age_recr, by(age_cat_adj) stat(min max)
ta age_cat_adj, m 

********************************************************************************
********************************************************************************
***************************BODY SIZE MEASURES **********************************
********************************************************************************
********************************************************************************
**BMI
codebook bmi_m
gen bmi_cat=. 
replace bmi_cat = 0 if bmi_m>=18.5 & bmi_m<25
replace bmi_cat = 1 if bmi_m>=25 & bmi_m<30
replace bmi_cat = 2 if bmi_m>=30 & bmi_m<. 
replace bmi_cat = 3 if bmi_m<18.5 
replace bmi_cat = 9 if bmi_m==. 
label define bmilb 3"underweight" 0"normal" 1"overweight" 2"obese" 9"missing"
label value bmi_cat bmilb
tabstat bmi_m, by(bmi_cat) stat(min max)
tab bmi_cat colorectal_inc, m col

**BMI harv 
gen bmi_harv=. 
replace bmi_harv = 0 if bmi_m<22
replace bmi_harv = 1 if bmi_m>=22 & bmi_m<25
replace bmi_harv = 2 if bmi_m>=25 & bmi_m<30 
replace bmi_harv = 3 if bmi_m>=30 & bmi_m<35 
replace bmi_harv = 4 if bmi_m>=35 & bmi_m<. 
replace bmi_harv = 9 if bmi_m==. 
label define bmilbharv 0"<22" 1"22-24.9" 2"25-29.9" 3"30-34.9" 4"35+" 9"missing"
label value bmi_harv bmilbharv
tabstat bmi_m, by(bmi_harv) stat(min max)
tab bmi_harv colorectal_inc, m col

* sex specific BMI quintiles 
xtile bmi_q5_f = bmi_m if male==0, nq(5)
xtile bmi_q5_m = bmi_m if male==1, nq(5)
gen bmi_q5 = . 
replace bmi_q5 = bmi_q5_f if male==0
replace bmi_q5 = bmi_q5_m if male==1
replace bmi_q5 = bmi_q5 - 1 
replace bmi_q5 = 9 if bmi_m==9 

tab bmi_q5 colorectal_inc, m col

* sex specific BMI quartile  
xtile bmi_q4_f = bmi_m if male==0, nq(4)
xtile bmi_q4_m = bmi_m if male==1, nq(4)
gen bmi_q4 = . 
replace bmi_q4 = bmi_q4_f if male==0
replace bmi_q4 = bmi_q4_m if male==1
replace bmi_q4 = bmi_q4 - 1 
replace bmi_q4 = 9 if bmi_m==9 

tab bmi_q4 colorectal_inc, m col

* sex specific BMI tertile 
xtile bmi_q3_f = bmi_m if male==0, nq(3)
xtile bmi_q3_m = bmi_m if male==1, nq(3)
gen bmi_q3 = . 
replace bmi_q3 = bmi_q3_f if male==0
replace bmi_q3 = bmi_q3_m if male==1
replace bmi_q3 = bmi_q3 - 1 
replace bmi_q3 = 9 if bmi_m==9 

tab bmi_q3 colorectal_inc, m col

gen bmi_c2 = bmi_m/2.5
lab variable bmi_c2 "bmi per 2.5 units"
gen bmi_c5 = bmi_m/5
lab variable bmi_c5 "bmi per 5 units"


**weight
* sex specific weight quintiles 
xtile weight_q5_f = weight_m if male==0, nq(5)
xtile weight_q5_m = weight_m if male==1, nq(5)
gen weight_q5 = . 
replace weight_q5 = weight_q5_f if male==0
replace weight_q5 = weight_q5_m if male==1
replace weight_q5 = weight_q5 - 1 
replace weight_q5 = 9 if weight_m==9 

tab weight_q5 colorectal_inc, m col

* sex specific weight quartile  
xtile weight_q4_f = weight_m if male==0, nq(4)
xtile weight_q4_m = weight_m if male==1, nq(4)
gen weight_q4 = . 
replace weight_q4 = weight_q4_f if male==0
replace weight_q4 = weight_q4_m if male==1
replace weight_q4 = weight_q4 - 1 
replace weight_q4 = 9 if weight_m==9 


tab weight_q4 colorectal_inc, m col

* sex specific weight tertile 
xtile weight_q3_f = weight_m if male==0, nq(3)
xtile weight_q3_m = weight_m if male==1, nq(3)
gen weight_q3 = . 
replace weight_q3 = weight_q3_f if male==0
replace weight_q3 = weight_q3_m if male==1
replace weight_q3 = weight_q3 - 1
replace weight_q3 = 9 if weight_m==9 

ta weight_q3 colorectal_inc, m col 

gen weight_c5 = weight_m/5
lab variable weight_c5 "weight per 5 units"

**height
* sex specific height quintiles 
xtile height_q5_f = height_m if male==0, nq(5)
xtile height_q5_m = height_m if male==1, nq(5)
gen height_q5 = . 
replace height_q5 = height_q5_f if male==0
replace height_q5 = height_q5_m if male==1
replace height_q5 = height_q5 - 1 
replace height_q5 = 9 if height_m==9 

ta height_q5 colorectal_inc, m col 
 
* sex specific height quartile  
xtile height_q4_f = height_m if male==0, nq(4)
xtile height_q4_m = height_m if male==1, nq(4)
gen height_q4 = . 
replace height_q4 = height_q4_f if male==0
replace height_q4 = height_q4_m if male==1
replace height_q4 = height_q4 - 1 
replace height_q4 = 9 if height_m==9 

ta height_q4 colorectal_inc, m col 

* sex specific height tertile 
xtile height_q3_f = height_m if male==0, nq(3)
xtile height_q3_m = height_m if male==1, nq(3)
gen height_q3 = . 
replace height_q3 = height_q3_f if male==0
replace height_q3 = height_q3_m if male==1
replace height_q3 = height_q3 - 1
replace height_q3 = 9 if height_m==9 

ta height_q3 colorectal_inc, m col 

gen height_c10 = height_m/10
lab variable height_c10 "height per 10 units"

**waist circumfernece 
codebook waist_c
gen waist_cat = .
replace waist_cat = 0 if (waist_c <=80 & male==0) | (waist_c <=94 & male==1)
replace waist_cat = 1 if (waist_c >80 & waist_c<=88 & male==0) | (waist_c >94 & waist_c <=102 & male==1)
replace waist_cat = 2 if (waist_c >88 & waist_c<. & male==0) | (waist_c >102 & waist_c<. & male==1)
replace waist_cat = 9 if waist_c == . 
tabstat waist_c if male==0, by(waist_cat) stat(min max) 
tabstat waist_c if male==1, by(waist_cat) stat(min max) 
lab define waistcatlab 0"<=80 F <=94 M" 1"<=88 F <=102 M" 2">88 F >102 M" 9"missing"
lab value waist_cat waistcatlab 
ta waist_cat colorectal_inc, m col

* sex specific waist quintiles 
xtile waist_q5_f = waist_c if male==0, nq(5)
xtile waist_q5_m = waist_c if male==1, nq(5)
gen waist_q5 = . 
replace waist_q5 = waist_q5_f if male==0
replace waist_q5 = waist_q5_m if male==1
replace waist_q5 = waist_q5 - 1 
replace waist_q5 = 9 if waist_c==. 

tab waist_q5 colorectal_inc, m col

* sex specific waist quartile  
xtile waist_q4_f = waist_c if male==0, nq(4)
xtile waist_q4_m = waist_c if male==1, nq(4)
gen waist_q4 = . 
replace waist_q4 = waist_q4_f if male==0
replace waist_q4 = waist_q4_m if male==1
replace waist_q4 = waist_q4 - 1 
replace waist_q4 = 9 if waist_c==. 


tab waist_q4 colorectal_inc, m col

* sex specific waist tertile 
xtile waist_q3_f = waist_c if male==0, nq(3)
xtile waist_q3_m = waist_c if male==1, nq(3)
gen waist_q3 = . 
replace waist_q3 = waist_q3_f if male==0
replace waist_q3 = waist_q3_m if male==1
replace waist_q3 = waist_q3 - 1
tab waist_q3 colorectal_inc, m col
replace waist_q3 = 9 if waist_c==. 


gen waist_c5 = waist_c/5
lab var waist_c5 "waist per 5 cm"
gen waist_c10 = waist_c/10
lab var waist_c10 "waist per 10 cm"

    
**hip circumference
* sex specific hip quintiles 
xtile hip_q5_f = hip_c if male==0, nq(5)
xtile hip_q5_m = hip_c if male==1, nq(5)
gen hip_q5 = . 
replace hip_q5 = hip_q5_f if male==0
replace hip_q5 = hip_q5_m if male==1
replace hip_q5 = hip_q5 - 1 
replace hip_q5 = 9 if hip_c==. 

ta hip_q5 colorectal_inc, m col

* sex specific hip quartile  
xtile hip_q4_f = hip_c if male==0, nq(4)
xtile hip_q4_m = hip_c if male==1, nq(4)
gen hip_q4 = . 
replace hip_q4 = hip_q4_f if male==0
replace hip_q4 = hip_q4_m if male==1
replace hip_q4 = hip_q4 - 1 
replace hip_q4 = 9 if hip_c==. 
tab hip_q4 colorectal_inc, m col

* sex specific hip tertile 
xtile hip_q3_f = hip_c if male==0, nq(3)
xtile hip_q3_m = hip_c if male==1, nq(3)
gen hip_q3 = . 
replace hip_q3 = hip_q3_f if male==0
replace hip_q3 = hip_q3_m if male==1
replace hip_q3 = hip_q3 - 1
replace hip_q3 = 9 if hip_c==. 

tab hip_q3 colorectal_inc, m col

gen hip_c5 = hip_c/5
lab variable hip_c5 "hip per 5 cm"
gen hip_c10 = hip_c/10
lab variable hip_c10 "hip per 10 cm"

**waist-to-hip ratio
* sex specific whr quintiles 
gen whr_c = waist_c / hip_c 
xtile whr_q5_f = whr_c if male==0, nq(5)
xtile whr_q5_m = whr_c if male==1, nq(5)
gen whr_q5 = . 
replace whr_q5 = whr_q5_f if male==0
replace whr_q5 = whr_q5_m if male==1
replace whr_q5 = whr_q5 - 1 
replace whr_q5 = 9 if whr_c==. 

tab whr_q5 colorectal_inc, m col

* sex specific whr quartile  
xtile whr_q4_f = whr_c if male==0, nq(4)
xtile whr_q4_m = whr_c if male==1, nq(4)
gen whr_q4 = . 
replace whr_q4 = whr_q4_f if male==0
replace whr_q4 = whr_q4_m if male==1
replace whr_q4 = whr_q4 - 1 
replace whr_q4 = 9 if whr_c==. 

tab whr_q4 colorectal_inc, m col

* sex specific whr tertile 
xtile whr_q3_f = whr_c if male==0, nq(3)
xtile whr_q3_m = whr_c if male==1, nq(3)
gen whr_q3 = . 
replace whr_q3 = whr_q3_f if male==0
replace whr_q3 = whr_q3_m if male==1
replace whr_q3 = whr_q3 - 1
replace whr_q3 = 9 if whr_c==. 

tab whr_q3 colorectal_inc, m col
tabstat whr_c if male==0, by(whr_q3) stat(min max) 
tabstat whr_c if male==1, by(whr_q3) stat(min max) 

**whr circumfernece 

gen whr_c25 = whr_c/0.25
lab variable whr_c25 "WHR per 0.25"

********************************************************************************
**recode and categorise all other body size variables**
**body fat% - bioimp
* sex specific bfpct quintiles 
/* xtile bs_bfpct_q5_f = fat_pctge if male==0, nq(5)
xtile bs_bfpct_q5_m = fat_pctge if male==1, nq(5)
gen bs_bfpct_q5 = . 
replace bs_bfpct_q5 = bs_bfpct_q5_f if male==0
replace bs_bfpct_q5 = bs_bfpct_q5_m if male==1
replace bs_bfpct_q5 = bs_bfpct_q5 - 1 

tab bs_bfpct_q5 colorectal_inc, m col

* sex specific bfpct quartile  
xtile bs_bfpct_q4_f = fat_pctge if male==0, nq(4)
xtile bs_bfpct_q4_m = fat_pctge if male==1, nq(4)
gen bs_bfpct_q4 = . 
replace bs_bfpct_q4 = bs_bfpct_q4_f if male==0
replace bs_bfpct_q4 = bs_bfpct_q4_m if male==1
replace bs_bfpct_q4 = bs_bfpct_q4 - 1 

tab bs_bfpct_q4 colorectal_inc, m col

* sex specific bfpct tertile 
xtile bs_bfpct_q3_f = fat_pctge if male==0, nq(3)
xtile bs_bfpct_q3_m = fat_pctge if male==1, nq(3)
gen bs_bfpct_q3 = . 
replace bs_bfpct_q3 = bs_bfpct_q3_f if male==0
replace bs_bfpct_q3 = bs_bfpct_q3_m if male==1
replace bs_bfpct_q3 = bs_bfpct_q3 - 1
tab bs_bfpct_q3 colorectal_inc, m col

gen bs_bfpct_c5 = fat_pctge/5
lab variable bs_bfpct_c5 "body fat % per 5 units"


**body fat mass - bioimp
* sex specific fatm quintiles 
xtile bs_fatm_q5_f = fat_mass if male==0, nq(5)
xtile bs_fatm_q5_m = fat_mass if male==1, nq(5)
gen bs_fatm_q5 = . 
replace bs_fatm_q5 = bs_fatm_q5_f if male==0
replace bs_fatm_q5 = bs_fatm_q5_m if male==1
replace bs_fatm_q5 = bs_fatm_q5 - 1 

tab bs_fatm_q5 colorectal_inc, m col

* sex specific fatm quartile  
xtile bs_fatm_q4_f = fat_mass if male==0, nq(4)
xtile bs_fatm_q4_m = fat_mass if male==1, nq(4)
gen bs_fatm_q4 = . 
replace bs_fatm_q4 = bs_fatm_q4_f if male==0
replace bs_fatm_q4 = bs_fatm_q4_m if male==1
replace bs_fatm_q4 = bs_fatm_q4 - 1 

tab bs_fatm_q4 colorectal_inc, m col

* sex specific fatm tertile 
xtile bs_fatm_q3_f = fat_mass if male==0, nq(3)
xtile bs_fatm_q3_m = fat_mass if male==1, nq(3)
gen bs_fatm_q3 = . 
replace bs_fatm_q3 = bs_fatm_q3_f if male==0
replace bs_fatm_q3 = bs_fatm_q3_m if male==1
replace bs_fatm_q3 = bs_fatm_q3 - 1
tab bs_fatm_q3 colorectal_inc, m col

gen bs_fatm_c5 =  fat_mass/5
lab variable bs_fatm_c5  "body fat mass per 5 units"

**Whole body fat-free mass - bioimp
* sex specific fatfreem quintiles 
xtile bs_fatfreem_q5_f = fatfree_mass if male==0, nq(5)
xtile bs_fatfreem_q5_m = fatfree_mass if male==1, nq(5)
gen bs_fatfreem_q5 = . 
replace bs_fatfreem_q5 = bs_fatfreem_q5_f if male==0
replace bs_fatfreem_q5 = bs_fatfreem_q5_m if male==1
replace bs_fatfreem_q5 = bs_fatfreem_q5 - 1 

tab bs_fatfreem_q5 colorectal_inc, m col 

* sex specific fatfreem quartile  
xtile bs_fatfreem_q4_f = fatfree_mass if male==0, nq(4)
xtile bs_fatfreem_q4_m = fatfree_mass if male==1, nq(4)
gen bs_fatfreem_q4 = . 
replace bs_fatfreem_q4 = bs_fatfreem_q4_f if male==0
replace bs_fatfreem_q4 = bs_fatfreem_q4_m if male==1
replace bs_fatfreem_q4 = bs_fatfreem_q4 - 1 

tab bs_fatfreem_q4 colorectal_inc, m col 

* sex specific fatfreem tertile 
xtile bs_fatfreem_q3_f = fatfree_mass if male==0, nq(3)
xtile bs_fatfreem_q3_m = fatfree_mass if male==1, nq(3)
gen bs_fatfreem_q3 = . 
replace bs_fatfreem_q3 = bs_fatfreem_q3_f if male==0
replace bs_fatfreem_q3 = bs_fatfreem_q3_m if male==1
replace bs_fatfreem_q3 = bs_fatfreem_q3 - 1
tab bs_fatfreem_q3 colorectal_inc, m col 


gen bs_fatfreem_c5 = fatfree_mass /5
lab variable bs_fatfreem_c5   "body fat free mass 5 units"

**Trunk fat percentage - bioimp
* sex specific tfpct quintiles 
xtile bs_tfpct_q5_f = trunkfat_pctge if male==0, nq(5)
xtile bs_tfpct_q5_m = trunkfat_pctge if male==1, nq(5)
gen bs_tfpct_q5 = . 
replace bs_tfpct_q5 = bs_tfpct_q5_f if male==0
replace bs_tfpct_q5 = bs_tfpct_q5_m if male==1
replace bs_tfpct_q5 = bs_tfpct_q5 - 1 

tab bs_tfpct_q5 colorectal_inc, m col 

* sex specific tfpct quartile  
xtile bs_tfpct_q4_f = trunkfat_pctge if male==0, nq(4)
xtile bs_tfpct_q4_m = trunkfat_pctge if male==1, nq(4)
gen bs_tfpct_q4 = . 
replace bs_tfpct_q4 = bs_tfpct_q4_f if male==0
replace bs_tfpct_q4 = bs_tfpct_q4_m if male==1
replace bs_tfpct_q4 = bs_tfpct_q4 - 1 

tab bs_tfpct_q4 colorectal_inc, m col 

* sex specific tfpct tertile 
xtile bs_tfpct_q3_f = trunkfat_pctge if male==0, nq(3)
xtile bs_tfpct_q3_m = trunkfat_pctge if male==1, nq(3)
gen bs_tfpct_q3 = . 
replace bs_tfpct_q3 = bs_tfpct_q3_f if male==0
replace bs_tfpct_q3 = bs_tfpct_q3_m if male==1
replace bs_tfpct_q3 = bs_tfpct_q3 - 1
tab bs_tfpct_q3 colorectal_inc, m col 

gen bs_tfpct_c5 = trunkfat_pctge/5
lab variable bs_tfpct_c5    "Trunk fat % 5 units"


**Trunk fat mass - bioimp
* sex specific tfatm quintiles 
xtile bs_tfatm_q5_f = trunkfat_mass if male==0, nq(5)
xtile bs_tfatm_q5_m = trunkfat_mass if male==1, nq(5)
gen bs_tfatm_q5 = . 
replace bs_tfatm_q5 = bs_tfatm_q5_f if male==0
replace bs_tfatm_q5 = bs_tfatm_q5_m if male==1
replace bs_tfatm_q5 = bs_tfatm_q5 - 1 

tab bs_tfatm_q5 colorectal_inc, m col 

* sex specific tfatm quartile  
xtile bs_tfatm_q4_f = trunkfat_mass if male==0, nq(4)
xtile bs_tfatm_q4_m = trunkfat_mass if male==1, nq(4)
gen bs_tfatm_q4 = . 
replace bs_tfatm_q4 = bs_tfatm_q4_f if male==0
replace bs_tfatm_q4 = bs_tfatm_q4_m if male==1
replace bs_tfatm_q4 = bs_tfatm_q4 - 1 

tab bs_tfatm_q4 colorectal_inc, m col 

* sex specific tfatm tertile 
xtile bs_tfatm_q3_f = trunkfat_mass if male==0, nq(3)
xtile bs_tfatm_q3_m = trunkfat_mass if male==1, nq(3)
gen bs_tfatm_q3 = . 
replace bs_tfatm_q3 = bs_tfatm_q3_f if male==0
replace bs_tfatm_q3 = bs_tfatm_q3_m if male==1
replace bs_tfatm_q3 = bs_tfatm_q3 - 1

tab bs_tfatm_q3 colorectal_inc, m col 

gen bs_tfatm_c5 = trunkfat_mass/5
lab variable bs_tfatm_c5   "Trunk fat mass 5 units"
 

**Trunk fat-free mass - bioimp
* sex specific tfatfreem quintiles 
xtile bs_tfatfreem_q5_f = trunkfatfree_mass if male==0, nq(5)
xtile bs_tfatfreem_q5_m = trunkfatfree_mass if male==1, nq(5)
gen bs_tfatfreem_q5 = . 
replace bs_tfatfreem_q5 = bs_tfatfreem_q5_f if male==0
replace bs_tfatfreem_q5 = bs_tfatfreem_q5_m if male==1
replace bs_tfatfreem_q5 = bs_tfatfreem_q5 - 1 

tab bs_tfatfreem_q5 colorectal_inc, m col 

* sex specific tfatfreem quartile  
xtile bs_tfatfreem_q4_f = trunkfatfree_mass if male==0, nq(4)
xtile bs_tfatfreem_q4_m = trunkfatfree_mass if male==1, nq(4)
gen bs_tfatfreem_q4 = . 
replace bs_tfatfreem_q4 = bs_tfatfreem_q4_f if male==0
replace bs_tfatfreem_q4 = bs_tfatfreem_q4_m if male==1
replace bs_tfatfreem_q4 = bs_tfatfreem_q4 - 1 

tab bs_tfatfreem_q4 colorectal_inc, m col 

* sex specific tfatfreem tertile 
xtile bs_tfatfreem_q3_f = trunkfatfree_mass if male==0, nq(3)
xtile bs_tfatfreem_q3_m = trunkfatfree_mass if male==1, nq(3)
gen bs_tfatfreem_q3 = . 
replace bs_tfatfreem_q3 = bs_tfatfreem_q3_f if male==0
replace bs_tfatfreem_q3 = bs_tfatfreem_q3_m if male==1
replace bs_tfatfreem_q3 = bs_tfatfreem_q3 - 1

tab bs_tfatfreem_q3 colorectal_inc, m col 

gen bs_tfatfreem_c5 = trunkfatfree_mass/5
lab variable bs_tfatfreem_c5   "Trunk fat free mass 5 units"

drop *q5_m *q5_f *q4_m *q4_f *q3_m *q3_f */


**MRI measurments




********************************************************************************
********************************************************************************
*************************SMOKING STATUS **************************************** 
********************************************************************************
********************************************************************************
**smoking status 
label define m_0090 9 "", add
label define m_0090 9 "Prefer not to answer/missing", modify
replace smoke_stat=9 if smoke_stat==-3 | smoke_stat==.
tab smoke_stat

**current smoking intensity variable - making those who smoked <1/day be numeric by assigning the value 0.5
replace smoke_curr_intens=.5 if smoke_curr_intens==-10
replace smoke_curr_intens=. if smoke_curr_intens==-3 | smoke_curr_intens==-1

**Create joint smoking status and intensity variable
gen smoke_intensity = .
replace smoke_intensity = 0 if smoke_stat==0
replace smoke_intensity = 1 if smoke_stat==1
replace smoke_intensity = 2 if smoke_stat==2 & smoke_curr_intens<15
replace smoke_intensity = 3 if smoke_stat==2 & smoke_curr_intens>=15
replace smoke_intensity = 4 if smoke_stat==2 & smoke_curr_intens==.
replace smoke_intensity = 9 if smoke_stat==9
tab smoke_intensity
label define smkintlb 0"never" 1"previous" 2"current <15/day" 3"current 15+/day" 4"current-intensity unknown" 9"missing/prefer not to answer"
label value smoke_intensity smkintlb
tab smoke_intensity smoke_stat
tab smoke_intensity colorectal_inc, m col

**smoking current
gen smoke_curr1 = .
replace smoke_curr1 = 0 if smoke_curr==0
replace smoke_curr1 = 1 if smoke_curr==2
replace smoke_curr1 = 2 if smoke_curr==1 
replace smoke_curr1 = 9 if smoke_curr==-3 | smoke_curr==.
tab smoke_curr1
label define smkclb 0"No" 1"Only occasionally" 2"Yes, on most or all days" 9"Prefer not to answer/missing"
label value smoke_curr1 smkclb
label variable smoke_curr1 "Current tobacco smoking"
drop smoke_curr
rename smoke_curr1 smoke_curr
tab smoke_curr, m 
ta smoke_curr smoke_intensity 
 

**smoking past
gen smoke_past1 = .
replace smoke_past1 = 0 if smoke_past==4
replace smoke_past1 = 1 if smoke_past==3
replace smoke_past1 = 2 if smoke_past==2
replace smoke_past1 = 3 if smoke_past==1
replace smoke_past1 = 9 if smoke_past==-3 | smoke_past==. | smoke_past==-1                                                                                                                                   
tab smoke_past1
label define smkpslb 0"I have never smoked" 1"Just tried once or twice" 2"Smoked occasionally" 3"Smoke on most or all days" 9"Prefer not to answer/missing"
label value smoke_past1 smkpslb
label variable smoke_past1 "Past tobacco smoking"
drop smoke_past
rename smoke_past1 smoke_past
tab smoke_past, m 
ta smoke_past smoke_intensity 
********************************************************************************

********************************************************************************
********************************************************************************
*************************PHYSICAL ACTIVITY**************************************
********************************************************************************
********************************************************************************
**Each category was assigned the following MET hour values: 3.3
**for walking, 4.0 for moderate physical activity, and 8.0 for vigorous
**physical activity [11]. Because individuals are estimated to expend 1
**MET/h sitting quietly, we report physical activity as excess METs
**[13]. Excess METs were calculated by subtracting one from the MET
**value multiplier for each category, giving values of 2.3 for walking,
**3.0 for moderate physical activity, and 7.0 for vigorous physical
**activity.
**walking MET hour value=2.3

**walking - number of days/week walked 10+ minutes
codebook pa_walk_days 
tab pa_walk_days
replace pa_walk_days = . if pa_walk_days==-3 | pa_walk_days==-1
replace pa_walk_days = 0 if pa_walk_days==-2
tab pa_walk_days colorectal_inc, m col 

**walking PA - duration - minutes/day
codebook pa_walk_dur
tab pa_walk_dur, m
replace pa_walk_dur = . if pa_walk_dur==-3 | pa_walk_dur==-1
tab pa_walk_dur, m 
replace pa_walk_dur = 0 if pa_walk_days == 0 
ta pa_walk_dur, m 
summ pa_walk_dur,d  

**generate how many minutes walking each week and then MET hours walking/week
gen pa_walk = . 
replace pa_walk = 0 if pa_walk_days==0
replace pa_walk = 0 if pa_walk_dur==0 
replace pa_walk = pa_walk_dur * pa_walk_days if pa_walk==. 
gen pa_walk_mets = (pa_walk/60) * 2.3
codebook pa_walk_mets 

**moderate MET hour value=3.0
**moderate PA - number of days/week
tab pa_mod_days
replace pa_mod_days = . if pa_mod_days==-3 | pa_mod_days==-1
tab pa_mod_days 

**moderate PA - duration - minutes/day
tab pa_mod_dur
replace pa_mod_dur = . if pa_mod_dur==-3 | pa_mod_dur==-1
replace pa_mod_dur = 0 if pa_mod_days==0 
summ pa_mod_dur, d 

**generate how many minutes moderate activity each week and then MET hours walking/week
gen pa_mod = . 
replace pa_mod = 0 if pa_mod_days==0
replace pa_mod = 0 if pa_mod_dur==0  
replace pa_mod = pa_mod_dur * pa_mod_days if pa_mod==. 
gen pa_mod_mets = (pa_mod/60) * 3
codebook pa_mod_mets 

**vigorous MET hour value=8.0
**vigorous PA - number of days/week
tab pa_vig_days
replace pa_vig_days = . if pa_vig_days==-3 | pa_vig_days==-1
tab pa_vig_days 

**vigorous PA - duration - minutes/day
tab pa_vig_dur
replace pa_vig_dur = . if pa_vig_dur==-3 | pa_vig_dur==-1
replace pa_vig_dur = 0 if pa_vig_days==0 
summ pa_vig_dur, d 

**generate how many minutes vigorous activity each week and then MET hours walking/week
gen pa_vig = . 
replace pa_vig = 0 if pa_vig_days==0
replace pa_vig = 0 if pa_vig_dur==0  
replace pa_vig = pa_vig_dur * pa_vig_days if pa_vig==. 
gen pa_vig_mets = (pa_vig/60) * 7
codebook pa_vig_mets 

**generate a total physical activity variable - MET hours/week
gen pa_tag = 999 if pa_walk_mets==. & pa_mod_mets==. & pa_vig_mets==.
replace pa_walk_mets = 0 if pa_walk_mets==. & pa_tag!=999
replace pa_mod_mets = 0 if pa_mod_mets==. & pa_tag!=999
replace pa_vig_mets = 0 if pa_vig_mets==. & pa_tag!=999
gen pa_total_mets = pa_walk_mets + pa_mod_mets + pa_vig_mets
label variable pa_total_mets "Total physical activity level (MET hr/week)"
codebook pa_total_mets 

// generate total PA variable (NOT excess METs)////
///////////////////////////////////////////////////
**Each category was assigned the following MET hour values: 3.3
**for walking, 4.0 for moderate physical activity, and 8.0 for vigorous
**physical activity [11]. 
**walking MET hour value=3.3
**generate how many minutes walking each week and then MET hours walking/week
gen pa_walkT = pa_walk_dur * pa_walk_days
replace pa_walkT = 0 if pa_walk_days==0 
replace pa_walkT = 0 if pa_walk_dur==0 
gen pa_walk_metsT = (pa_walkT/60) * 3.3

**moderate MET hour value=4.0
gen pa_modT = pa_mod_dur * pa_mod_days
replace pa_modT = 0 if pa_mod_days==0 
replace pa_modT = 0 if pa_mod_dur==0 
gen pa_mod_metsT = (pa_modT/60) * 4

**vigorous MET hour value=8.0
gen pa_vigT = pa_vig_dur * pa_vig_days
replace pa_vigT = 0 if pa_vig_days==0 
replace pa_vigT = 0 if pa_vig_dur==0 
gen pa_vig_metsT = (pa_vigT/60) * 8

**generate a total physical activity variable - MET hours/week
gen pa_tagT = 999 if pa_walk_metsT==. & pa_mod_metsT==. & pa_vig_metsT==.
replace pa_walk_metsT = 0 if pa_walk_metsT==. & pa_tagT!=999
replace pa_mod_metsT = 0 if pa_mod_metsT==. & pa_tagT!=999
replace pa_vig_metsT = 0 if pa_vig_metsT==. & pa_tagT!=999
gen pa_total_metsT = pa_walk_metsT + pa_mod_metsT + pa_vig_metsT
label variable pa_total_metsT "Total physical activity level (MET hr/week)"
codebook pa_total_metsT

gen pa_met_10c= pa_total_mets/10
lab variable pa_met_10c "Total physical activity level (MET hr/week) per 10" 
gen pa_metT_10c = pa_total_metsT/10
lab variable pa_metT_10c "Total physical activity NOT Excess METS (MET hr/week) per 10" 

// predefined categories - excess PA
gen pa_met_cat=. 
replace pa_met_cat = 0 if pa_total_mets<10 
replace pa_met_cat = 1 if pa_total_mets>=10 & pa_total_mets<20 
replace pa_met_cat = 2 if pa_total_mets>=20 & pa_total_mets<40 
replace pa_met_cat = 3 if pa_total_mets>=40 & pa_total_mets<60 
replace pa_met_cat = 4 if pa_total_mets>=60 & pa_total_mets<. 
replace pa_met_cat = 9 if pa_total_mets==. 
label define pametlb 0"<10 MET hr/wk" 1"10-<20 MET hr/wk" 2"20-<40 MET hr/wk" 3"40-<60 MET hr/wk" 4"60+ MET hr/wk" 9"missing"
label value pa_met_cat pametlb
tabstat pa_total_mets, by(pa_met_cat) stat(min max)
tab pa_met_cat colorectal_inc

// predefined categories - total PA
gen pa_met_total_cat=pa_total_metsT
replace pa_met_total_cat = 0 if pa_total_metsT<10 
replace pa_met_total_cat = 1 if pa_total_metsT>=10 & pa_total_metsT<20 
replace pa_met_total_cat = 2 if pa_total_metsT>=20 & pa_total_metsT<40 
replace pa_met_total_cat = 3 if pa_total_metsT>=40 & pa_total_metsT<60 
replace pa_met_total_cat = 4 if pa_total_metsT>=60 & pa_total_mets<. 
replace pa_met_total_cat = 9 if pa_total_metsT==. 
label define pametTlb 0"<10 MET hr/wk" 1"10-<20 MET hr/wk" 2"20-<40 MET hr/wk" 3"40-<60 MET hr/wk" 4"60+ MET hr/wk" 9"missing"
label value pa_met_total_cat pametTlb
tabstat pa_total_metsT, by(pa_met_total_cat) stat(min max)
tab pa_met_total_cat colorectal_inc

// cohort wide overall activity quintiles - NOT sex-specific
xtile pa_met_q5 = pa_total_mets, nq(5)
tab pa_met_q5  colorectal_inc

**generate a vigorous-to-total physical activity variable - MET hours
gen pa_vig_total = pa_vig_mets/pa_total_mets
label variable pa_vig_total "Ratio of vigorous-to-total physical activity"

// cohort wide ratio of vig to overall activity fourth - NOT sex-specific
// make those participants with zero ratio - the ref category and combine with fourths
// of activity
xtile pa_vig_tot_q4 = pa_vig_total if pa_vig_total !=0, nq(4)
tab pa_vig_tot_q4
replace pa_vig_tot_q4 = 0 if pa_vig_total==0
tab pa_vig_tot_q4 colorectal_inc
tabstat pa_vig_total, statistics( min max ) by(pa_vig_tot_q4) 

// categorical variables for vigorous to total ratio variable
gen pa_vigtot_cat=. 
replace  pa_vigtot_cat = 0 if pa_vig_total==0 
replace  pa_vigtot_cat = 1 if pa_vig_total>0 &  pa_vig_total<0.3 
replace  pa_vigtot_cat = 2 if pa_vig_total>=0.3 &  pa_vig_total<0.6  
replace  pa_vigtot_cat = 3 if pa_vig_total>=0.6 &  pa_vig_total<.   
label define vigtotlb 0"no vigorous activty" 1">0 to <30%" 2"30-<60%" 3"60%+"
label value pa_vigtot_cat vigtotlb
tabstat pa_vig_total, by(pa_vigtot_cat ) stat(min max)
tab pa_vigtot_cat colorectal_inc

// generate a continuous vig:total PA variable
gen pa_vig_tot_2 = pa_vig_total/0.2
lab variable pa_vig_tot_2 "vigorous to total PA ratio per 0.2"

// sedentary activity variables
// time spent watching TV on a typical day (hrs/day)
tab tvtime
replace tvtime=. if tvtime==-1 | tvtime==-3 
replace tvtime=0.5 if tvtime==-10    // <hour/d coded as -10 - change to 0.5
tab tvtime

// tv time categories
summ tvtime, d
gen tv_cat = tvtime
recode tv_cat min/1=0 2/3=1 4/5=2 6/max=3
label define tvcatlb 0"1 hour and less/d" 1"2-3 hr/d" 2"4-5 hr/d" 3"6+ hr/d"
label value tv_cat tvcatlb
tab tv_cat
tabstat tvtime, by(tv_cat) stat(min max)

// tv time continuous - per 2 hrs/day
gen tvtime_c2 = tvtime/2
lab variable tvtime_c2 "TV time per 2 hrs/day"

// total TV/computer time on a typical day (hrs/day)
tab comptime
replace comptime=. if comptime==-1 | comptime==-3 
replace comptime=0.5 if comptime==-10    // <hour/d coded as -10 - change to 0.5
tab comptime

// comp time categories
gen comp_cat = comptime
recode comp_cat 0=0 min/1=1 2/3=2 4/max=3
label define compcatlb 0"none" 1"0.1-1 hr/d" 2"2-3 hr/d" 3"4+ hr/d"
label value comp_cat compcatlb
tab comp_cat colorectal_inc
tabstat comptime, by(comp_cat) stat(min max)

// comp time continuous - per 2 hrs/day
gen comptime_c2 = comptime/2
lab variable comptime_c2 "Computer time per 2 hrs/day"

**overall acceleration  - not sex specific - similar distributions between men and women
xtile accel_q5 = pa_accel, nq(5)

xtile accel_q4 = pa_accel, nq(4)

xtile accel_q3 = pa_accel, nq(3)

**generate continuous 
gen pa_accel_c5 = pa_accel/5

**generate proportion (%) of acceleration above 125 milli-gravity - as per correspondence with Soren
gen accel_125overprop = (1 - pa_accel_less125)*100
codebook accel_125overprop
xtile accel125_q4 = accel_125overprop, nq(4)
xtile accel125_q3 = accel_125overprop, nq(3)
**generate continuous variable per 2%
gen accel_125overprop_c2 = accel_125overprop/2

**convert greater than 125 milligravity variable into minutes/per day spent above this level
**of acceleration intensity - 1440 minutes in each day
gen accel_125over_mins = (accel_125overprop/100)*1440
codebook accel_125over_mins
xtile accel125mins_q4 = accel_125over_mins, nq(4)
xtile accel125mins_q3 = accel_125over_mins, nq(3)
**generate continuous variable per 25 minutes
gen accel_125overmins_c25 = accel_125over_mins/25

**generate proportion (%) of acceleration above 125 milli-gravity - more conservative cut-point for moderate-intense activity
**taken from the Whitehall II study of healthy obesity a objective PA (Bell et al., 2015 AJCN)
gen accel_100overprop = (1 - pa_accel_less100)*100
codebook accel_100overprop
xtile accel100_q4 = accel_100overprop, nq(4)
xtile accel100_q3 = accel_100overprop, nq(3)
**generate categories**generate continuous variable per 2%
gen accel_100overprop_c2 = accel_100overprop/2

**convert greater than 100 milligravity variable into minutes/per day spent above this level
**of acceleration intensity - 1440 minutes in each day
gen accel_100over_mins = (accel_100overprop/100)*1440
codebook accel_100over_mins
xtile accel100mins_q4 = accel_100over_mins, nq(4)
xtile accel100mins_q3 = accel_100over_mins, nq(3)
**generate continuous variable per 25 minutes
gen accel_100overmins_c25 = accel_100over_mins/25

******************************************************************************** 

**ever had bowel cancer screening
label define m_100349 9 "", add
label define m_100349 9 "Prefer not to answer/do not know/missing", modify
replace crc_screen=9 if crc_screen==-3 | crc_screen==-1 | crc_screen==.
tab crc_screen

********************************************************************************
********************************************************************************
**************************ALCOHOL INTAKE**************************************** 
********************************************************************************

**alcohol drinking status - recode the prefer not to answer from -3 to 3 (means won't be ref group)
label define m_0090 9 "", add
label define m_0090 9 "Prefer not to answer/missing", modify
replace alc_stat=9 if alc_stat==-3 | alc_stat==.
tab alc_stat

lab define alc_stat_lab 0"Never" 1"Former" 2"Current" 9"missing"
lab value alc_stat alc_stat_lab
ta alc_stat 

**alcohol intake frequency
gen alc_freq = .
replace alc_freq = 0 if alc_int_freq==6
replace alc_freq = 1 if alc_int_freq==5
replace alc_freq = 2 if alc_int_freq==4
replace alc_freq = 3 if alc_int_freq==3
replace alc_freq = 4 if alc_int_freq==2
replace alc_freq = 5 if alc_int_freq==1
replace alc_freq = 9 if alc_int_freq==-3 | alc_int_freq==.
label define alclb 0"never" 1"special occasions only" 2"1-3 times/month" 3"1-2 times/week" 4"3-4 times/week" 5"daily or almost daily" 9"missing/prefer not to answer"
label value alc_freq alclb
tab alc_freq

ta alc_stat alc_freq 

gen alc_freq_new = 0 if alc_stat==0 
replace alc_freq_new = 1 if alc_stat == 1 
replace alc_freq_new = 2 if alc_stat == 2 & (alc_freq==1 | alc_freq==2) 
replace alc_freq_new = 3 if alc_stat == 2 & (alc_freq==3) 
replace alc_freq_new = 4 if alc_stat == 2 & (alc_freq==4) 
replace alc_freq_new = 5 if alc_stat == 2 & (alc_freq==5) 
replace alc_freq_new = 9 if alc_stat == 9 

ta alc_freq_new 
lab define alc_freq_new_lab 0"never" 1"Former" 2"Current occasionally to 1-3 times/month" 3"1-2 times/week" 4"3-4 times/week" 5"daily or almost daily" 9"missing/prefer not to answer"
lab value alc_freq_new alc_freq_new_lab 
ta alc_freq_new 
ta alc_freq_new alc_stat 

**alcohol consumption variables

//JR: these need to be joined from another dataset
*Renaming specific alcohol variables
/*rename n_1588_0_0 beer_wk
rename n_4429_0_0 beer_mo
rename n_1568_0_0 redwine_wk
rename n_4407_0_0 redwine_mo
rename n_1578_0_0 whitewine_wk
rename n_4418_0_0 whitewine_mo
rename n_1608_0_0 port_wk
rename n_4451_0_0 port_mo
rename n_1598_0_0 spirits_wk
rename n_4440_0_0 spirits_mo
rename n_5364_0_0 otheralc_wk
rename n_4462_0_0 otheralc_mo

*Alcohol - code adapted from Georgina
*Grams/day
*Change values to missing for those who answers "do not know" or "prefer not to say" 
foreach var of varlist beer_wk beer_mo redwine_wk redwine_mo whitewine_wk whitewine_mo port_wk port_mo spirits_wk spirits_mo otheralc_wk otheralc_mo {
recode `var' (-3 -1 = -9)
recode `var' (. = -9)
}
*Total drink variables are "unknown" if there are any missing values (apart from other alcohol) 
gen totaldrink_wk=.
replace totaldrink_wk=-9 if (beer_wk==-9 | redwine_wk==-9 | whitewine_wk==-9 | port_wk==-9 | spirits_wk==-9)
gen totaldrink_mo=.
replace totaldrink_mo=-9 if (beer_mo==-9 | redwine_mo==-9 | whitewine_mo==-9 | port_mo==-9 | spirits_mo==-9)
recode otheralc_wk -9=0 
recode otheralc_mo -9=0

*Individual Drink Intake (Per Week & Per Month) in grams
*20 grams per pint of beer, 10 grams for each other drink per glass
gen beer_wk_g=.
replace beer_wk_g=20*beer_wk if beer_wk!=-9
gen beer_mo_g=.
replace beer_mo_g=20*beer_mo if beer_mo!=-9
foreach var of varlist redwine_wk redwine_mo whitewine_wk whitewine_mo port_wk port_mo spirits_wk spirits_mo otheralc_wk otheralc_mo {
gen `var'_g = 10*`var' if `var'!=-9 
}
replace totaldrink_wk=(beer_wk_g+redwine_wk_g+whitewine_wk_g+port_wk_g+spirits_wk_g+otheralc_wk_g)/7 if totaldrink_wk==.
*tab totaldrink_wk, miss
replace totaldrink_mo=(beer_mo_g+redwine_mo_g+whitewine_mo_g+port_mo_g+spirits_mo_g+otheralc_mo_g)/30.4375 if totaldrink_mo==.
*tab totaldrink_mo, miss
gen drinkoverall=.
replace drinkoverall=totaldrink_wk
replace drinkoverall=totaldrink_mo if (drinkoverall==-9 & totaldrink_mo!=-9)


*Generate totals for beer, wine, port, spirits, and other alc as well
*Beer
gen totalbeer_wk=.
replace totalbeer_wk=-9 if (beer_wk==-9)
gen totalbeer_mo=.
replace totalbeer_mo=-9 if (beer_mo==-9)
replace totalbeer_wk = beer_wk_g/7 if totalbeer_wk==.
replace totalbeer_mo=beer_mo_g/30.4375 if totalbeer_mo==.
gen beeroverall=.
replace beeroverall=totalbeer_wk
replace beeroverall=totalbeer_mo if (beeroverall==-9 & totalbeer_mo!=-9)
*Wine
gen totalwine_wk=.
replace totalwine_wk=-9 if (redwine_wk==-9 | whitewine_wk==-9)
gen totalwine_mo=.
replace totalwine_mo=-9 if (redwine_mo==-9 | whitewine_mo==-9)
replace totalwine_wk = (redwine_wk_g + whitewine_wk_g)/7 if totalwine_wk==.
replace totalwine_mo = (redwine_mo_g + whitewine_mo_g)/30.4375 if totalwine_mo==.
gen wineoverall=.
replace wineoverall=totalwine_wk
replace wineoverall=totalwine_mo if (wineoverall==-9 & totalwine_mo!=-9)
*Port
gen totalport_wk=.
replace totalport_wk=-9 if (port_wk==-9)
gen totalport_mo=.
replace totalport_mo=-9 if (port_mo==-9)
replace totalport_wk = port_wk_g/7 if totalport_wk==.
replace totalport_mo=port_mo_g/30.4375 if totalport_mo==.
gen portoverall=.
replace portoverall=totalport_wk
replace portoverall=totalport_mo if (portoverall==-9 & totalport_mo!=-9)
*Spirits
gen totalspirits_wk=.
replace totalspirits_wk=-9 if (spirits_wk==-9)
gen totalspirits_mo=.
replace totalspirits_mo=-9 if (spirits_mo==-9)
replace totalspirits_wk = spirits_wk_g/7 if totalspirits_wk==.
replace totalspirits_mo=spirits_mo_g/30.4375 if totalspirits_mo==.
gen spiritsoverall=.
replace spiritsoverall=totalspirits_wk
replace spiritsoverall=totalspirits_mo if (spiritsoverall==-9 & totalspirits_mo!=-9)
*Other alcohol
gen totalotheralc_wk=.
replace totalotheralc_wk=-9 if (otheralc_wk==-9)
gen totalotheralc_mo=.
replace totalotheralc_mo=-9 if (otheralc_mo==-9)
replace totalotheralc_wk = otheralc_wk_g/7 if totalotheralc_wk==.
replace totalotheralc_mo=otheralc_mo_g/30.4375 if totalotheralc_mo==.
gen otheralcoverall=.
replace otheralcoverall=totalotheralc_wk
replace otheralcoverall=totalotheralc_mo if (otheralcoverall==-9 & totalotheralc_mo!=-9)


*Categorical Variables - Kathryn
gen alcohol_cat=.
replace alcohol_cat=1 if (drinkoverall<1 & drinkoverall!=-9)
replace alcohol_cat=2 if (drinkoverall>=1 & drinkoverall<8)
replace alcohol_cat=3 if (drinkoverall>=8 & drinkoverall<16)
replace alcohol_cat=4 if (drinkoverall>=16 & drinkoverall!=.)
replace alcohol_cat=-9 if drinkoverall==.
label define alcohol_catL 1 "<1g/d" 2 "1-7g/d" 3 "8-15g/d" 4 "16+g/d" 9 "Unknown"
label values alcohol_cat alcohol_catL
tab alcohol_cat
tab alcohol_cat alcohol, miss
*If grams/day are "unknown" but alcohol frequency is "never" or "special occasions" assume grams/day are <1
replace alcohol_cat=1 if (alcohol_cat==-9 & (alc_freq==0 | alc_freq==1))
*78,158 changes made
tab alcohol_cat alcohol, miss
tab alcohol_cat, miss
replace alcohol_cat=9 if alcohol_cat==-9 | alcohol_cat==.
tab alcohol_cat, miss */




******************************************************************************** 

********************************************************************************
********************************************************************************
***************************DIET ************************************************
********************************************************************************
**fresh fruits (pieces/day)
codebook fruit_fresh
replace fruit_fresh = 0.5 if fruit_fresh==-10
replace fruit_fresh = . if fruit_fresh==-1 | fruit_fresh==-3

xtile fruit_f_q5 = fruit_fresh if male==0, nq(5)
xtile fruit_m_q5 = fruit_fresh if male==1, nq(5)
gen fruit_q5 = fruit_f_q5 if male==0
replace fruit_q5 = fruit_m_q5 if male==1
tab fruit_q5
replace fruit_q5 = 9 if fruit_q5==.
tab fruit_q5

xtile fruit_f_q4 = fruit_fresh if male==0, nq(4)
xtile fruit_m_q4 = fruit_fresh if male==1, nq(4)
gen fruit_q4 = fruit_f_q4 if male==0
replace fruit_q4 = fruit_m_q4 if male==1
tab fruit_q4
replace fruit_q4 = 9 if fruit_q4==.
tab fruit_q4

xtile fruit_f_q3 = fruit_fresh if male==0, nq(3)
xtile fruit_m_q3 = fruit_fresh if male==1, nq(3)
gen fruit_q3 = fruit_f_q3 if male==0
replace fruit_q3 = fruit_m_q3 if male==1
tab fruit_q3
replace fruit_q3 = 9 if fruit_q3==.
tab fruit_q3

**cooked vegetables (tablespoons/day)
codebook veg_cooked
replace veg_cooked = 0.5 if veg_cooked==-10
replace veg_cooked = . if veg_cooked==-1 | veg_cooked==-3

xtile veg_cook_f_q5 = veg_cooked if male==0, nq(5)
xtile veg_cook_m_q5 = veg_cooked if male==1, nq(5)
gen veg_cook_q5 = veg_cook_f_q5 if male==0
replace veg_cook_q5 = veg_cook_m_q5 if male==1
tab veg_cook_q5
replace veg_cook_q5 = 9 if veg_cook_q5==.
tab veg_cook_q5

xtile veg_cook_f_q4 = veg_cooked if male==0, nq(4)
xtile veg_cook_m_q4 = veg_cooked if male==1, nq(4)
gen veg_cook_q4 = veg_cook_f_q4 if male==0
replace veg_cook_q4 = veg_cook_m_q4 if male==1
tab veg_cook_q4
replace veg_cook_q4 = 9 if veg_cook_q4==.
tab veg_cook_q4

xtile veg_cook_f_q3 = veg_cooked if male==0, nq(3)
xtile veg_cook_m_q3 = veg_cooked if male==1, nq(3)
gen veg_cook_q3 = veg_cook_f_q3 if male==0
replace veg_cook_q3 = veg_cook_m_q3 if male==1
tab veg_cook_q3
replace veg_cook_q3 = 9 if veg_cook_q3==.
tab veg_cook_q3

**Salad/raw vegetable intake (tablespoons/day)
codebook veg_saladraw
replace veg_saladraw = 0.5 if veg_saladraw==-10
replace veg_saladraw = . if veg_saladraw==-1 | veg_saladraw==-3

xtile vegsal_f_q5 = veg_saladraw if male==0, nq(5)
xtile vegsal_m_q5 = veg_saladraw if male==1, nq(5)
gen vegsal_q5 = vegsal_f_q5 if male==0
replace vegsal_q5 = vegsal_m_q5 if male==1
tab vegsal_q5
replace vegsal_q5 = 9 if vegsal_q5==.
tab vegsal_q5

xtile vegsal_f_q4 = veg_saladraw if male==0, nq(4)
xtile vegsal_m_q4 = veg_saladraw if male==1, nq(4)
gen vegsal_q4 = vegsal_f_q4 if male==0
replace vegsal_q4 = vegsal_m_q4 if male==1
tab vegsal_q4
replace vegsal_q4 = 9 if vegsal_q4==.
tab vegsal_q4

xtile vegsal_f_q3 = veg_saladraw if male==0, nq(3)
xtile vegsal_m_q3 = veg_saladraw if male==1, nq(3)
gen vegsal_q3 = vegsal_f_q3 if male==0
replace vegsal_q3 = vegsal_m_q3 if male==1
tab vegsal_q3
replace vegsal_q3 = 9 if vegsal_q3==.
tab vegsal_q3

**generate combined vegetable intake variable
count if veg_cooked==. & veg_saladraw==.
gen fv_tag = 999 if veg_cooked==. & veg_saladraw==. 
replace veg_cooked = 0 if veg_cooked==.& fv_tag!=999
replace veg_saladraw = 0 if veg_saladraw==. & fv_tag!=999
gen veg_total = veg_cooked + veg_saladraw
label variable veg_total "Total vegetable (cooked and salad) intake (tablespoons/day)"

xtile vegtot_f_q5 = veg_total if male==0, nq(5)
xtile vegtot_m_q5 = veg_total if male==1, nq(5)
gen vegtot_q5 = vegtot_f_q5 if male==0
replace vegtot_q5 = vegtot_m_q5 if male==1
tab vegtot_q5
replace vegtot_q5 = 9 if vegtot_q5==.
tab vegtot_q5

xtile vegtot_f_q4 = veg_total if male==0, nq(4)
xtile vegtot_m_q4 = veg_total if male==1, nq(4)
gen vegtot_q4 = vegtot_f_q4 if male==0
replace vegtot_q4 = vegtot_m_q4 if male==1
tab vegtot_q4
replace vegtot_q4 = 9 if vegtot_q4==.
tab vegtot_q4

xtile vegtot_f_q3 = veg_total if male==0, nq(3)
xtile vegtot_m_q3 = veg_total if male==1, nq(3)
gen vegtot_q3 = vegtot_f_q3 if male==0
replace vegtot_q3 = vegtot_m_q3 if male==1
tab vegtot_q3
replace vegtot_q3 = 9 if vegtot_q3==.
tab vegtot_q3


**generate combined fresh fruit and vegetable intake variable
**firstly convert fruit intake into tablespoons so F&V are equivalent
**http://www.nhs.uk/livewell/5aday/documents/downloads/5aday_portion_guide.pdf
**http://www.convertunits.com/from/gram/to/tablespoon
**one adult portion of fruit = 80g or 5.333 tablespoons
gen fruit_spoon = fruit_fresh * 5.333

**combine tablespoons of fruit and vegetables
count if veg_total==. & fruit_spoon==.
gen fvsp_tag = 999 if veg_total==. & fruit_spoon==. 
replace veg_total = 0 if veg_total==.& fvsp_tag!=999
replace fruit_spoon = 0 if fruit_spoon==. & fvsp_tag!=999
gen fandv = veg_total + fruit_spoon
label variable fandv "Total fruit and vegetable intake (tablespoons/day)"

gen fruitveg_c10 = fandv/10
lab variable  fruitveg_c10 "Fruit and veg intake per 10 tbls/day"

xtile fandv_f_q5 = fandv if male==0, nq(5)
xtile fandv_m_q5 = fandv if male==1, nq(5)
gen fandv_q5 = fandv_f_q5 if male==0
replace fandv_q5 = fandv_m_q5 if male==1
tab fandv_q5
replace fandv_q5 = 9 if fandv_q5==.
tab fandv_q5

xtile fandv_f_q4 = fandv if male==0, nq(4)
xtile fandv_m_q4 = fandv if male==1, nq(4)
gen fandv_q4 = fandv_f_q4 if male==0
replace fandv_q4 = fandv_m_q4 if male==1
tab fandv_q4
replace fandv_q4 = 9 if fandv_q4==.
tab fandv_q4

xtile fandv_f_q3 = fandv if male==0, nq(3)
xtile fandv_m_q3 = fandv if male==1, nq(3)
gen fandv_q3 = fandv_f_q3 if male==0
replace fandv_q3 = fandv_m_q3 if male==1
tab fandv_q3
replace fandv_q3 = 9 if fandv_q3==.
tab fandv_q3

**cheese intake
codebook dairy_cheese

**milk intake
codebook dairy_milk

**spread intake
codebook spreads

**cereal intake
codebook cereal_intake

**cereal intake
codebook cereal_type

**fish - non-oily
label define m_100377 9 "", add
label define m_100377 9 "Prefer not to answer/missing", modify
replace fish_nonoil=9 if fish_nonoil==-3 | fish_nonoil==-1 | fish_nonoil==.
tab fish_nonoil

*generate a new variable with fewer categories
gen fishwhite=.
replace fishwhite=0 if fish_nonoil==0
replace fishwhite=1 if fish_nonoil==1 
replace fishwhite=2 if fish_nonoil==2 
replace fishwhite=3 if fish_nonoil==3 | fish_nonoil==4 | fish_nonoil==5
replace fishwhite=9 if fish_nonoil==9
label define fishwlb 0"Never" 1"Less than once a week" 2"Once/week" 3"More than 2 times/week" 9"Prefer not to answer/missing"
label value fishwhite fishwlb
label variable fishwhite "Fish - nonoily/white intake"
tab fishwhite

**fish - oily
label define m_100377 9 "", add
label define m_100377 9 "Prefer not to answer/missing", modify
replace fish_oil=9 if fish_oil==-3 | fish_oil==-1 | fish_oil==.
tab fish_oil

*generate a new variable with fewer categories
gen fishoily=.
replace fishoily=0 if fish_oil==0
replace fishoily=1 if fish_oil==1 
replace fishoily=2 if fish_oil==2 
replace fishoily=3 if fish_oil==3 | fish_oil==4 | fish_oil==5
replace fishoily=9 if fish_oil==9
label define fisholb 0"Never" 1"Less than once a week" 2"Once/week" 3"More than 2 times/week" 9"Prefer not to answer/missing"
label value fishoily fisholb
label variable fishoily "Fish - oily intake"
tab fishoily

*Meat and fish variables
*Unknown = "9" and collapsing top categores
recode meat_pro  (-3/-1=9 "unknown") (4=3) (5=3), gen(procmeat_cat)
recode meat_beef (-3/-1=9 "unknown") (4=3) (5=3), gen (beef_cat)
recode meat_lamb (-3/-1=9 "unknown") (4=3) (5=3), gen (lamb_cat)
recode meat_pork (-3/-1=9 "unknown") (4=3) (5=3), gen (pork_cat)

*Generating a total red meat variable (beef + lamb + pork)
*Codes will be as follows: Never = 0, < 1/wk = 0.5, 1/wk = 1, 2-4/wk = 3, 5-6/wk = 5.5, 1+ daily = 7.
*Unknown = "99"
recode meat_beef (1=0.5) (2=1) (4=5.5) (5=7) (-3/-1=99), gen (beef_temp)
recode meat_lamb (1=0.5) (2=1) (4=5.5) (5=7) (-3/-1=99), gen (lamb_temp)
recode meat_pork (1=0.5) (2=1) (4=5.5) (5=7) (-3/-1=99), gen (pork_temp)
gen redmeat = beef_temp + lamb_temp + pork_temp
replace redmeat = 99 if beef_temp==99 | lamb_temp==99 | pork_temp==99
*Check
list beef_temp lamb_temp pork_temp redmeat in 1/5
*Creating categories
*Generating quartiles to see where stata cuts the data
xtile redmeat_q4 = redmeat, nq (4)
bysort redmeat_q4: sum redmeat
*Investigating numbers in lowest categories 
sum redmeat if redmeat_q4==1 & redmeat<=1
sum redmeat if redmeat_q4==1 & redmeat>1 & redmeat<2

*Choose cut-points that give approx equal numbers in each group (as far as possible) and that are rounded to nearest whole number
egen redmeat_cat = cut (redmeat), at (0, 1.00, 2.00, 3.00, 99, 150) icodes
recode redmeat_cat 4=9 
tab redmeat_cat
tabstat redmeat, by(redmeat_cat) stat(min max)
label define redmeat_catL 0"<1/wk" 1"1.00-1.99 times/wk" 2"2.00-2.99/wk" 3"3.00+/wk" 9"unknown"
label values redmeat_cat redmeat_catL
tab redmeat_cat
*Check
tabstat redmeat, by(redmeat_cat) stat(min max)

*Generating a total red and processed meat variable
recode meat_pro (1=0.5) (2=1) (4=5.5) (5=7) (-3/-1=99), gen (procmeat_temp)
gen redprocmeat = beef_temp + lamb_temp + pork_temp + procmeat_temp
replace redprocmeat = 99 if beef_temp==99 | lamb_temp==99 | pork_temp==99| procmeat_temp==99
*Check
list beef_temp lamb_temp pork_temp redmeat procmeat_temp redprocmeat in 1/5
*Creating categories
*Generating quartiles to see where stata cuts the data
xtile redprocmeat_q4 = redprocmeat, nq (4)
bysort redprocmeat_q4: sum redprocmeat
*Choose cut-points that give approx equal numbers in each group (as far as possible) and that are rounded to nearest whole number
egen redprocmeat_cat = cut (redprocmeat), at (0, 2.0, 3.0, 4.0, 99, 150) icodes 
recode redprocmeat_cat 4 = 9 
tab redprocmeat_cat 
tabstat redprocmeat, by(redprocmeat_cat) stat(min max)
label define redprocmeat_catL 0 "<2/wk" 1 "2.00-2.99 times/wk" 2 "3.00-3.99/wk" 3 "4.00+/wk" 9 "unknown"
label values redprocmeat_cat redprocmeat_catL
replace redprocmeat_cat=9 if redprocmeat_cat==.
*Check
tabstat redprocmeat, by(redprocmeat_cat) stat(min max) 

********************************************************************************
********************************************************************************
****************************Regular MEDICATION USE *****************************
********************************************************************************
********************************************************************************
***  
gen med_chol = 0 
replace med_chol = 1 if (women_meds_0==1 | women_meds_1==1 | women_meds_2==1 | women_meds_3==1) & male==0  
replace med_chol = 1 if (men_meds_0==1 | men_meds_1==1 | men_meds_2==1) & male==1
replace med_chol = 9 if (women_meds_0==-1 | women_meds_1==-1 | women_meds_2==-1 | women_meds_3==-1) & med_chol!=1 & male==0    
replace med_chol = 9 if (men_meds_0==-1 | men_meds_1==-1 | men_meds_2==-1) & med_chol!=1 & male==1    
replace med_chol = 9 if (women_meds_0==-3 | women_meds_1==-3 | women_meds_2==-3 | women_meds_3==-3) & med_chol!=1 & male==0    
replace med_chol = 9 if (men_meds_0==-3 | men_meds_1==-3 | men_meds_2==-3 ) & med_chol!=1 & male==1    
replace med_chol = 9 if (women_meds_0==. & women_meds_1==. & women_meds_2==. & women_meds_3==.) & male==0  
replace med_chol = 9 if (men_meds_0==. & men_meds_1==. & men_meds_2==.) & male==1   


gen med_bp = 0 
replace med_bp = 1 if (women_meds_0==2 | women_meds_1==2 | women_meds_2==2 | women_meds_3==2) & male==0  
replace med_bp = 1 if (men_meds_0==2 | men_meds_1==2 | men_meds_2==2) & male==1
replace med_bp = 9 if (women_meds_0==-1 | women_meds_1==-1 | women_meds_2==-1 | women_meds_3==-1) & med_bp!=1 & male==0    
replace med_bp = 9 if (men_meds_0==-1 | men_meds_1==-1 | men_meds_2==-1) & med_bp!=1 & male==2    
replace med_bp = 9 if (women_meds_0==-3 | women_meds_1==-3 | women_meds_2==-3 | women_meds_3==-3) & med_bp!=1 & male==0    
replace med_bp = 9 if (men_meds_0==-3 | men_meds_1==-3 | men_meds_2==-3 ) & med_bp!=1 & male==2 
replace med_bp = 9 if (women_meds_0==. & women_meds_1==. & women_meds_2==. & women_meds_3==.) & male==0  
replace med_bp = 9 if (men_meds_0==. & men_meds_1==. & men_meds_2==.) & male==1    

gen med_insulin = 0 
replace med_insulin = 1 if (women_meds_0==3 | women_meds_1==3 | women_meds_2==3 | women_meds_3==3) & male==0  
replace med_insulin = 1 if (men_meds_0==3 | men_meds_1==3 | men_meds_2==3) & male==1
replace med_insulin = 9 if (women_meds_0==-1 | women_meds_1==-1 | women_meds_2==-1 | women_meds_3==-1) & med_insulin!=1 & male==0    
replace med_insulin = 9 if (men_meds_0==-1 | men_meds_1==-1 | men_meds_2==-1) & med_insulin!=1 & male==3    
replace med_insulin = 9 if (women_meds_0==-3 | women_meds_1==-3 | women_meds_2==-3 | women_meds_3==-3) & med_insulin!=1 & male==0    
replace med_insulin = 9 if (men_meds_0==-3 | men_meds_1==-3 | men_meds_2==-3 ) & med_insulin!=1 & male==3    
replace med_insulin = 9 if (women_meds_0==. & women_meds_1==. & women_meds_2==. & women_meds_3==.) & male==0  
replace med_insulin = 9 if (men_meds_0==. & men_meds_1==. & men_meds_2==.) & male==1 

gen med_hrt = 0 
replace med_hrt = 1 if (women_meds_0==4 | women_meds_1==4 | women_meds_2==4 | women_meds_3==4) & male==0  
replace med_hrt = 9 if (women_meds_0==-1 | women_meds_1==-1 | women_meds_2==-1 | women_meds_3==-1) & med_hrt!=1 & male==0    
replace med_hrt = 9 if (women_meds_0==-3 | women_meds_1==-3 | women_meds_2==-3 | women_meds_3==-3) & med_hrt!=1 & male==0    
replace med_hrt = 999 if male == 1 
replace med_hrt = 9 if (women_meds_0==. & women_meds_1==. & women_meds_2==. & women_meds_3==.) & male==0  

gen med_oc = 0 
replace med_oc = 1 if (women_meds_0==5 | women_meds_1==5 | women_meds_2==5 | women_meds_3==5) & male==0  
replace med_oc = 9 if (women_meds_0==-1 | women_meds_1==-1 | women_meds_2==-1 | women_meds_3==-1) & med_oc!=1 & male==0    
replace med_oc = 9 if (women_meds_0==-3 | women_meds_1==-3 | women_meds_2==-3 | women_meds_3==-3) & med_oc!=1 & male==0    
replace med_oc = 999 if male == 1 
replace med_oc = 9 if (women_meds_0==. & women_meds_1==. & women_meds_2==. & women_meds_3==.) & male==0  


gen med_asp = 0 
replace med_asp = 1 if medication_0==1 | medication_1==1 | medication_2==1 | medication_3==1 | medication_4==1 | medication_5==1
replace med_asp = 9 if (medication_0==-3 | medication_1==-3 | medication_2==-3 | medication_3==-3 | medication_4==-3 | medication_5==-3) & med_asp!=1 
replace med_asp = 9 if (medication_0==-1 | medication_1==-1 | medication_2==-1 | medication_3==-1 | medication_4==-1 | medication_5==-1) & med_asp!=1 
replace med_asp = 9 if (medication_0==. & medication_1==. & medication_2==. & medication_3==. & medication_4==. & medication_5==.) & med_asp!=1 

gen med_ib = 0 
replace med_ib = 1 if medication_0==2 | medication_1==2 | medication_2==2 | medication_3==2 | medication_4==2 | medication_5==2
replace med_ib = 9 if (medication_0==-3 | medication_1==-3 | medication_2==-3 | medication_3==-3 | medication_4==-3 | medication_5==-3) & med_ib!=1 
replace med_ib = 9 if (medication_0==-1 | medication_1==-1 | medication_2==-1 | medication_3==-1 | medication_4==-1 | medication_5==-1) & med_ib!=1 
replace med_ib = 9 if (medication_0==. & medication_1==. & medication_2==. & medication_3==. & medication_4==. & medication_5==.) & med_ib!=1 

gen med_par = 0 
replace med_par = 1 if medication_0==3 | medication_1==3 | medication_2==3 | medication_3==3 | medication_4==3 | medication_5==3
replace med_par = 9 if (medication_0==-3 | medication_1==-3 | medication_2==-3 | medication_3==-3 | medication_4==-3 | medication_5==-3) & med_par!=1 
replace med_par = 9 if (medication_0==-1 | medication_1==-1 | medication_2==-1 | medication_3==-1 | medication_4==-1 | medication_5==-1) & med_par!=1 
replace med_par = 9 if (medication_0==. & medication_1==. & medication_2==. & medication_3==. & medication_4==. & medication_5==.) & med_par!=1 

gen med_omep = 0 
replace med_omep = 1 if medication_0==5 | medication_2==5 | medication_2==5 | medication_3==5 | medication_4==5 | medication_5==5
replace med_omep = 9 if (medication_0==-3 | medication_1==-3 | medication_2==-3 | medication_3==-3 | medication_4==-3 | medication_5==-3) & med_omep!=1 
replace med_omep = 9 if (medication_0==-1 | medication_1==-1 | medication_2==-1 | medication_3==-1 | medication_4==-1 | medication_5==-1) & med_omep!=1 
replace med_omep = 9 if (medication_0==. & medication_1==. & medication_2==. & medication_3==. & medication_4==. & medication_5==.) & med_omep!=1 

gen med_aspib = 0 
replace med_aspib = 1 if med_asp==1 | med_ib == 1 
replace med_aspib = 9 if med_asp==9 & med_ib == 9  
ta med_aspib

lab variable med_chol "Regular mediation for high cholesterol"
lab variable med_bp "Regular mediation for high blood pressure"
lab variable med_insulin "Regular mediation for insulin"
lab variable med_hrt "Regular HRT"
lab variable med_oc "Regular OC pill"
lab variable med_asp "Regular aspirin"
lab variable med_ib "Regular ibuprofen"
lab variable med_aspib "Regular aspirin or ibu"
lab variable med_par "Regular paracetamol"
lab variable med_omep "Regular omeprazole"

//Medication at second assessment (added JR)
**Make med_chol_1 and med_bp_1 variables (see Neil's code in cr3)
gen med_chol_1 = 0 
replace med_chol_1 = 1 if (women_meds_rep_0==1 | women_meds_rep_1==1 | women_meds_rep_2==1 | women_meds_rep_3==1) & male==0  
replace med_chol_1 = 1 if (men_meds_rep_0==1 | men_meds_rep_1==1 | men_meds_rep_2==1) & male==1
replace med_chol_1 = 9 if (women_meds_rep_0==-1 | women_meds_rep_1==-1 | women_meds_rep_2==-1 | women_meds_rep_3==-1) & med_chol_1!=1 & male==0    
replace med_chol_1 = 9 if (men_meds_rep_0==-1 | men_meds_rep_1==-1 | men_meds_rep_2==-1) & med_chol_1!=1 & male==1    
replace med_chol_1 = 9 if (women_meds_rep_0==-3 | women_meds_rep_1==-3 | women_meds_rep_2==-3 | women_meds_rep_3==-3) & med_chol_1!=1 & male==0    
replace med_chol_1 = 9 if (men_meds_rep_0==-3 | men_meds_rep_1==-3 | men_meds_rep_2==-3 ) & med_chol_1!=1 & male==1    
replace med_chol_1 = 9 if (women_meds_rep_0==. & women_meds_rep_1==. & women_meds_rep_2==. & women_meds_rep_3==.) & male==0  
replace med_chol_1 = 9 if (men_meds_rep_0==. & men_meds_rep_1==. & men_meds_rep_2==.) & male==1   


gen med_bp_1 = 0 
replace med_bp_1 = 1 if (women_meds_rep_0==2 | women_meds_rep_1==2 | women_meds_rep_2==2 | women_meds_rep_3==2) & male==0  
replace med_bp_1 = 1 if (men_meds_rep_0==2 | men_meds_rep_1==2 | men_meds_rep_2==2) & male==1
replace med_bp_1 = 9 if (women_meds_rep_0==-1 | women_meds_rep_1==-1 | women_meds_rep_2==-1 | women_meds_rep_3==-1) & med_bp_1!=1 & male==0    
replace med_bp_1 = 9 if (men_meds_rep_0==-1 | men_meds_rep_1==-1 | men_meds_rep_2==-1) & med_bp_1!=1 & male==2    
replace med_bp_1 = 9 if (women_meds_rep_0==-3 | women_meds_rep_1==-3 | women_meds_rep_2==-3 | women_meds_rep_3==-3) & med_bp_1!=1 & male==0    
replace med_bp_1 = 9 if (men_meds_rep_0==-3 | men_meds_rep_1==-3 | men_meds_rep_2==-3 ) & med_bp_1!=1 & male==2 
replace med_bp_1 = 9 if (women_meds_rep_0==. & women_meds_rep_1==. & women_meds_rep_2==. & women_meds_rep_3==.) & male==0  
replace med_bp_1 = 9 if (men_meds_rep_0==. & men_meds_rep_1==. & men_meds_rep_2==.) & male==1 


**regular vitamin/mineral supplement use - need to request variable 6155
**vit D suppls
gen vitd_supp = 0 
replace vitd_supp = 1 if suppl_0==4 | suppl_1==4 | suppl_2==4 | suppl_3==4 | suppl_4==4 | suppl_5==4 | suppl_6==4
replace vitd_supp = 9 if (suppl_0==-3 | suppl_1==-3 | suppl_2==-3 | suppl_3==-3 | suppl_4==-3 | suppl_5==-3 | suppl_6==-3) & vitd_supp!=1 
replace vitd_supp = 9 if (suppl_0==-1 | suppl_1==-1 | suppl_2==-1 | suppl_3==-1 | suppl_4==-1 | suppl_5==-1 | suppl_6==-1) & vitd_supp!=1 
replace vitd_supp = 9 if (suppl_0==. & suppl_1==. & suppl_2==. & suppl_3==. & suppl_4==. & suppl_5==. & suppl_6==.) & vitd_supp!=1 

***Calcium supplement intake 
/*gen calc_supp = 0 
replace calc_supp = 1 if mineral_0==3 | mineral_1==3 | mineral_2==3 | mineral_3==3 | mineral_4==3 | mineral_5==3
replace calc_supp = 9 if (mineral_0==-3 | mineral_1==-3 | mineral_2==-3 | mineral_3==-3 | mineral_4==-3 | mineral_5==-3) & calc_supp!=1
replace calc_supp = 9 if (mineral_0==-1 | mineral_1==-1 | mineral_2==-1 | mineral_3==-1 | mineral_4==-1 | mineral_5==-1) & calc_supp!=1
replace calc_supp = 9 if (mineral_0==. & mineral_1==. & mineral_2==. & mineral_3==. & mineral_4==. & mineral_5==.) & calc_supp!=1
lab var calc_supp "Calcium supplement intake"
ta calc_supp , m */

*** folate suppls 
gen fol_supp = 0 
replace fol_supp = 1 if suppl_0==6 | suppl_1==6 | suppl_2==6 | suppl_3==6 | suppl_4==6 | suppl_5==6 | suppl_6==6
replace fol_supp = 9 if (suppl_0==-3 | suppl_1==-3 | suppl_2==-3 | suppl_3==-3 | suppl_4==-3 | suppl_5==-3 | suppl_6==-3) & fol_supp!=1 
replace fol_supp = 9 if (suppl_0==-1 | suppl_1==-1 | suppl_2==-1 | suppl_3==-1 | suppl_4==-1 | suppl_5==-1 | suppl_6==-1) & fol_supp!=1 
replace fol_supp = 9 if (suppl_0==. & suppl_1==. & suppl_2==. & suppl_3==. & suppl_4==. & suppl_5==. & suppl_6==.) & fol_supp!=1 

lab variable vitd_supp "Regular Vitamin D supplement intake"
//lab variable calc_supp "Regular calcium supplement intake"
lab variable fol_supp "Regular folic acid or folate supplement intake"

**antibiotic use child/teenager
/*rename n_21067_0_0  antibkid
codebook antibkid
replace antibkid = 9 if antibkid==-818 | antibkid==-121
tab antibkid*/

********************************************************************************
********************************************************************************
*************************** HORMONES *******************************************
********************************************************************************

*Note JR: in 33929 and 41622 (Update 2021: possibly in 48208)

***Age at menarche 
/*replace age_menarche = . if age_menarche<0 
gen age_menarche_cat = 0 if age_menarche<=13 
replace age_menarche_cat = 1 if age_menarche>13 & age_menarche<. 
lab define age_menarche_lab 0 "<=13 years old" 1 ">13 years old"
lab value age_menarche_cat age_menarche_lab 
tabstat age_menarche, by(age_menarche_cat) stat(min max)
ta age_menarche_cat if male == 0 , m */

***Live births number:
summ lb_no if lb_no!=0 , d 
replace lb_no = . if lb_no<0 

gen lb_cat = . 
replace lb_cat = 0 if lb_no == 0 
replace lb_cat = 1 if lb_no>0 & lb_no<=2 
replace lb_cat = 2 if lb_no>2 & lb_no<.  
ta lb_cat, m 
replace lb_cat = . if male==1 
ta lb_cat if male==0, m 

lab define lb_catlab 0 "0" 1"2 or less" 2"more than 2"
lab value lb_cat lb_catlab 
ta lb_cat if male==0, m 

***Age at first live birth 
summ lb_1st_age, d 
replace lb_1st_age = . if lb_1st_age<0 
summ lb_1st_age if lb_cat!= . & lb_cat!=0 , d 

bysort lb_cat: sum lb_1st_age, d  

gen lb_age_cat = 0 if lb_cat == 0
replace lb_age_cat = 1 if lb_cat>0 & lb_cat<. & lb_1st_age<25 
replace lb_age_cat = 2 if lb_cat>0 & lb_cat<. & lb_1st_age>=25 

gen lb_no_age = . 
replace lb_no_age = 0 if lb_cat == 0 
replace lb_no_age = 1 if lb_cat == 1 & lb_no_age <25 
replace lb_no_age = 2 if lb_cat == 1 & lb_no_age >=25 & lb_no_age<.  
replace lb_no_age = 3 if lb_cat == 2 & lb_no_age <25 
replace lb_no_age = 4 if lb_cat == 2 & lb_no_age >=25 & lb_no_age<.  
 
ta lb_no_age if male==0 , m 
lab define lb_no_agelab 0 "no live births" 1"2 or more; <25 years" 2"2 or less >=25 years" 3"more than 2, <25 years" 4"more than 2, >=25 years" 
lab value lb_no_age lb_no_agelab

***Age at menopause 
summ age_menop
replace age_menop = . if age_menop<0  
summ age_menop if male==0 & menop==1, d 

gen age_menop_cat = 0 if age_menop<50 
replace age_menop_cat = 1 if age_menop==50 
replace age_menop_cat = 2 if age_menop>50 & age_menop<. 
tabstat age_menop, by(age_menop_cat) stat(min max) 
ta  age_menop_cat if male==0 
lab define age_menop_lab 0"<50" 1"50 years" 2">50 years"
lab value age_menop_cat age_menop_lab


**menopause
label define m_100579 9 "", add
label define m_100579 9 "Prefer not to answer/missing", modify
replace menop=9 if menop==-3 | menop==.
replace menop=999 if sex==1
tab menop

lab define menop_lab 0"No" 1"Yes" 2"Not sure had hysterectomy" 3"Not sure other reason" /// 
-3 "Prefer not to answer" 
lab value menop menop_lab 

gen menop_bin = 1 
replace menop_bin = 0 if menop==0 
replace menop_bin = 9 if menop==9 & age_recr<=55 
replace menop_bin = 9 if (menop==2 | menop==3) & age_recr<=55   
replace menop_bin = 999 if male == 1 
ta menop_bin if male==0, m 

ta menop menop_bin
bysort menop: summ age_recr if male==0, d 

* confirm all before recruiment 
gen age_menop_diff = age_recr - age_menop 
summ age_menop_diff if menop_bin==1, d 
list age_menop age_recr menop if menop_bin==1 & age_menop_diff<0 
replace menop_bin = 0 if  menop_bin==1 & age_menop_diff<0
 
**OC - ever use
tab ever_oc
gen oc_ever = .
replace oc_ever = 0 if ever_oc==0
replace oc_ever = 1 if ever_oc==1
replace oc_ever = 9 if ever_oc==-3 | ever_oc==-1 | ever_oc==.
label define oclb22 0"never" 1"ever" 9"prefer not to answer/don't know/missing"
label value oc_ever oclb22
label variable oc_ever "Ever taken oral contraceptive pill"
tab oc_ever if male==0
drop ever_oc 

**OC - age started
codebook age_oc_start

**OC - age last used
codebook age_oc_last
summ age_oc_last, d 
codebook age_oc_last if oc_ever==1 
count if (age_oc_last == -1 | age_oc_last==.) & oc_ever==1
gen oc_curr = . 
replace oc_curr = 1 if oc_ever == 1 & age_oc_last==-11
replace oc_curr = 0 if oc_ever==0 
replace oc_curr = 0 if oc_ever == 1 & age_oc_last!=. & age_oc_last!=-11 & age_oc_last!=-3 
**replace those who did not remember age at last use as non current users 
replace oc_curr = 0 if oc_ever == 1 & age_oc_last==-1 & oc_curr==. 
ta oc_curr if male==0 , m 
ta oc_curr oc_ever, m 

*** confirm all have started before baseline 
count if oc_ever == 1 & age_oc_start!=. & age_oc_start>age_recr

**HRT - ever use
label define m_100349 9 "", add
label define m_100349 9 "Prefer not to answer/missing", modify
replace ever_horm=9 if ever_horm==-3 | ever_horm==-1 | ever_horm==.
replace ever_horm=999 if male==1
tab ever_horm if male==0 
tab ever_horm if male==0 & menop_bin==1 

*** HRT current use 
gen hrt_curr = . 
replace hrt_curr = 1 if ever_horm == 1 & age_horm_last==-11
replace hrt_curr = 0 if ever_horm ==0 
replace hrt_curr = 0 if ever_horm == 1 & age_horm_last!=. & age_horm_last!=-11 & age_horm_last!=-3 
**replace those who did not remember age at last use as non current users 
replace hrt_curr = 0 if ever_horm == 1 & age_horm_last==-1 & hrt_curr==. 

ta hrt_curr, m 
ta hrt_curr if male==0 , m 
 
*** confirm all have started after baseline 
count if ever_horm == 1 & age_horm_start!=. & age_horm_start>age_recr
list ever_horm hrt_curr age_horm_start age_horm_last age_recr if ever_horm == 1 & age_horm_start!=. & age_horm_start>age_recr
replace hrt_curr = . if ever_horm == 1 & age_horm_start!=. & age_horm_start>age_recr
replace ever_horm = . if ever_horm == 1 & age_horm_start!=. & age_horm_start>age_recr

gen age_diff_menop_hrt = (age_horm_start - age_menop) 
summ age_diff_menop_hrt, d 
count if age_horm_start>0 & age_horm_start<30 & age_horm_start!=. & ever_horm==1 & male==0
list age_diff_menop_hrt age_horm_start age_horm_last age_menop age_recr hrt_curr ever_horm if age_horm_start>0 & age_horm_start<30 & age_horm_start!=. & ever_horm==1 & male==0

// male hair balding (in other dataset)
/* codebook manbald
replace manbald = 9 if manbald==-1 | manbald==-3
tab manbald

// male relative age voice broke
codebook manvoice
replace manvoice = 9 if manvoice==-1 | manvoice==-3
tab manvoice

// male relative facial hair
codebook manfacehair
replace manfacehair = 9 if manfacehair==-1 | manfacehair==-3
tab manfacehair */

// generate a vasectomy variable
gen vasect = 0 if sex==1
foreach x of varlist n_20004_0_0-n_20004_0_31 {
replace vasect = 1 if `x'==1218 & sex==1
}
tab vasect


// generate a appendicectomy variable
gen appendic = 0 
foreach x of varlist n_20004_0_0-n_20004_0_31 {
replace appendic = 1 if `x'==1458
}
tab appendic



**illnesses of father (create variable from fh_father list)
gen dad_crc = 0
replace dad_crc = 1 if fh_father_0_0==4 | fh_father_0_1==4 | fh_father_0_2==4 | fh_father_0_3==4 | fh_father_0_4==4 | fh_father_0_5==4 | fh_father_0_6==4 | fh_father_0_7==4 | fh_father_0_8==4 |fh_father_0_9==4
replace dad_crc = 9 if (fh_father_0_0==-11 | fh_father_0_0==-13 | fh_father_0_0==.) & dad_crc!=1 
label define dad_crcL 0 "No CRC in father" 1 "Father history of CRC" 9 "PNA/DNK/missing"
label values dad_crc dad_crcL
label variable dad_crc "FH - dad with CRC"
tab dad_crc

**illnesses of mother (create variable from fh_mother list)
gen mum_crc = 0
replace mum_crc = 1 if fh_mother_0_0==4 | fh_mother_0_1==4 | fh_mother_0_2==4 | fh_mother_0_3==4 | fh_mother_0_4==4 | fh_mother_0_5==4 | fh_mother_0_6==4 | fh_mother_0_7==4 | fh_mother_0_8==4 |fh_mother_0_9==4
replace mum_crc = 9 if (fh_mother_0_0==-11 | fh_mother_0_0==-13 | fh_mother_0_0==.) & mum_crc!=1 
label define mum_crcL 0 "No CRC in mother" 1 "Mother history of CRC" 9 "PNA/DNK/missing"
label values mum_crc mum_crcL
label variable mum_crc "FH - mum with CRC"
tab mum_crc

**illnesses of siblings (create variable from fh_sibling list)
gen sib_crc = 0
replace sib_crc = 1 if fh_sibling_0_0==4 | fh_sibling_0_1==4 | fh_sibling_0_2==4 | fh_sibling_0_3==4 | fh_sibling_0_4==4 | fh_sibling_0_5==4 | fh_sibling_0_6==4 | fh_sibling_0_7==4 | fh_sibling_0_8==4 |fh_sibling_0_9==4
replace sib_crc = 9 if (fh_sibling_0_0==-11 | fh_sibling_0_0==-13 | fh_sibling_0_0==.) & sib_crc!=1 
label define sib_crcL 0 "No CRC in sibling" 1 "Sibling history of CRC" 9 "PNA/DNK/missing"
label values sib_crc sib_crcL
label variable sib_crc "FH - siblings with CRC"
tab sib_crc

**generate joint family history variable (first degree relative)
gen fh_crc = 0
replace fh_crc = 1 if dad_crc==1 | mum_crc==1 | sib_crc==1
replace fh_crc = 9 if dad_crc==9 & mum_crc==9 & sib_crc==9
label variable fh_crc "FH - first degree family member with CRC"
tab fh_crc, m

**prevalent Crohn's disease - 1462	
gen crohns = 0
foreach x of varlist n_20002_0_0-n_20002_0_28 {
replace crohns = 1 if `x'==1462
label variable crohns "Crohn's disease"
}
tab crohns

**prevalent Ulcerative colitis - 1463
gen ulccol = 0
foreach x of varlist n_20002_0_0-n_20002_0_28 {
replace ulccol = 1 if `x'==1463
}
label variable ulccol "Ulcerative colitis"
tab ulccol

**prevelent GORD/reflux - 1138
gen gord = 0
foreach x of varlist n_20002_0_0-n_20002_0_28 {
replace gord = 1 if `x'==1138
}
label variable gord "Gastro-oesophageal reflux (gord) / gastric reflux"
tab gord

**prevelent oesophagitis/barretts oesophagus - 1139
gen barretts = 0
foreach x of varlist n_20002_0_0-n_20002_0_28 {
replace barretts = 1 if `x'==1139
}
label variable barretts "Oesophagitis/barretts oesophagus"
tab barretts

**prevelent GORD and barretts oesophagus 
gen gord_barr = 0
replace gord_barr=1 if gord==1 | barretts==1
label variable gord_barr "GORD/barretts oesophagus"
tab gord_barr

//JR added for appendectomy project
**prevalent endometriosis
gen endomet = 0
foreach x of varlist n_20002_0_0-n_20002_0_28 {
replace endomet = 1 if `x'==1402
label variable endomet "Endometriosis"
}
tab endomet

**prevalent irritable bowel syndrome
gen ibs = 0
foreach x of varlist n_20002_0_0-n_20002_0_28 {
replace ibs = 1 if `x'==1154
label variable ibs "Irritable bowel syndrome"
}
tab ibs

**prevalent gallstones
gen galls = 0
foreach x of varlist n_20002_0_0-n_20002_0_28 {
replace galls = 1 if `x'==1402
label variable galls "Gallstones"
}
tab galls

**testosterone drug/product users****
*************************************
**methyltestosterone product	
**yohimbine/pemoline/methyltestosterone	
**testosterone product	
**ethinylnortestosterone	
**sustanon 100 oily injection
**testotop tts 15mg transdermal patch	
**primoteston depot 250mg/1ml oily injection	
**testoderm 6mg/24hours transdermal patch	
**testogel 50mg gel 5g sachet	**
gen testo_med = 0
foreach x of varlist n_20003_0_0-n_20003_0_47 {
replace testo_med = 1 if `x'==1140857656
replace testo_med = 1 if `x'==1140865136	
replace testo_med = 1 if `x'==1140868532
replace testo_med = 1 if `x'==1140910674
replace testo_med = 1 if `x'==1140868538
replace testo_med = 1 if `x'==1140864502
replace testo_med = 1 if `x'==1140868534
replace testo_med = 1 if `x'==1141166354
replace testo_med = 1 if `x'==1141193272
}
tab testo_med


***prevalent diabetes variable
**T2DM defined on the basis of:
**1)self-reported doctor diagnosis at digital questionnaire (n_2443_0_0) or
**2)self-reported doctor diagnosis at nurse interview (n_20002_0_0-n_20002_0_28) 
**3)age of diagnosis over 36 years 
**4) use of oral anti-diabetic medications (n_20003_0_0 and n_20003_0_47) 
gen diabet=.
*1* if self-reported Dr diagnosed diabetes 
replace diabet=0 if diab_dx==0
replace diabet=1 if diab_dx==1
replace diabet=9 if diab_dx==-1 | diab_dx==-3 | diab_dx==.
tab diabet
label define diabetL 0"No" 1 "Yes" 9 "PNA/DNK/missing"
label values diabet diabetL
label variable diabet "Prevalent Diabetes"
tab diabet


*2* if self-reported at nurse interview (UK Biobank coded 1223)
foreach x of varlist n_20002_0_0-n_20002_0_28 {
replace diabet = 1 if `x'==1223

}
tab diabet


*3*if use oral anti_diabetic medications (n_20003_0_0 and n_20003_0_47)
**medication list from diabetes.co.uk https://www.diabetes.org.uk/Guide-to-diabetes/Managing-your-diabetes/Treating-your-diabetes/Tablets-and-medication/
*A*BIGUANIDE (METFORMIN)
foreach x of varlist n_20003_0_0-n_20003_0_47 {
replace diabet = 1 if `x'==1140884600
replace diabet = 1 if `x'==1141189090
}

*B*SULPHONYLUREAS - medications in this drug family:
*Glibenclamide (generic name) or Daonil (brand name) - 1140874718, 1140874724, 1140874726	
*Gliclazide (generic name) or Diamicron (brand name) - 1140874744, 1140874746
*Glipizide (generic name) or Glibenese, Minodiab (brand name) - 1140874646, 1141157284, 1140874650, 1140874652
*Glimepiride (generic name) or	Amaryl (brand name) - 1141152590, 1141156984
*Tolbutamide (generic name) or	Tolbutamide (brand name) - 1140874674
foreach x of varlist n_20003_0_0-n_20003_0_47 {
replace diabet = 1 if `x'==1140874718
replace diabet = 1 if `x'==1140874724	
replace diabet = 1 if `x'==1140874726	
replace diabet = 1 if `x'==1140874744
replace diabet = 1 if `x'==1140874746
replace diabet = 1 if `x'==1140874646
replace diabet = 1 if `x'==1141157284
replace diabet = 1 if `x'==1140874650
replace diabet = 1 if `x'==1140874652
replace diabet = 1 if `x'==1141152590
replace diabet = 1 if `x'==1140874674

}



*C*ALPHA GLUCOSIDASE INHIBITOR - medications in this drug family
*Acarbose (generic name) or	Glucobay (brand name) - 1140868902, 1140868908
foreach x of varlist n_20003_0_0-n_20003_0_47 {
replace diabet = 1 if `x'==1140868902
replace diabet = 1 if `x'==1140868908	

}

*D*PRANDIAL GLUCOSE REGULATOR - medications in this drug family
*Repaglinide (generic name) or Prandin (brand name) - 1141168660
*Nateglinide (generic name)	or Starlix (brand name) - 1141173882, 1141173786	
foreach x of varlist n_20003_0_0-n_20003_0_47 {
replace diabet = 1 if `x'==1141168660
replace diabet = 1 if `x'==1141173882	
replace diabet = 1 if `x'==1141173786

}

*E*THIAZOLIDINEDIONES (GLITAZONES) - medications in this drug family
*Pioglitazone (generic name) or	Actos (brand name) - 1141171646, 1141171652
foreach x of varlist n_20003_0_0-n_20003_0_47 {
replace diabet = 1 if `x'==1141171646
replace diabet = 1 if `x'==1141171652	

}

*ta diabet diab_ins , m 
*ta diabet med_ins, m 
*replace diabet = 1 if med_ins == 1 & diabet !=1 


*F*DPP-4 INHIBITORS (GLIPTINS) - medications in this drug family - no use repoered in UKB
*Sitagliptin(generic name) or Januvia(brand name)
*Sitagliptin + Metformin(generic name) or Janumet(brand name)
*Vildagliptin(generic name) or Galvus(brand name)
*Vildagliptin + Metformin(generic name) or	Eucreas(brand name)
*Saxagliptin(generic name) or Onglyza(brand name)
*Alogliptin(generic name) or Vipidia(brand name)
*Alogliptin + Metformin(generic name) or Vipdomet(brand name)
*Linagliptin(generic name) or Trajenta(brand name)
*Linagliptin + Metformin(generic name) or Jentadueto(brand name)
*Saxagliptin + Metformin(generic name) or Kombolyze(brand name)


*G*SGLT2 INHIBITORS - medications in this drug family - no use repoered in UKB
*Dapagliflozin(generic name) or	Forxiga(brand name)
*Canagliflozin(generic name) or	Invokana(brand name)
*Empagliflozin(generic name) or	Jardiance(brand name)
tab diabet

*4* age at diagnosis (n_2976_0_0)
count if diabet==1 & diab_age<35 

*** generate type 2 diabetes: https://clininf.eu/wp-content/uploads/2017/02/nhs_diabetes_and_rcgp_cod_final_report.pdf : page 33 
gen diabet_typ2 = diabet
replace diabet_typ2 = 99 if  diab_age <35  &  diab_ins==1 
*replace diabet_typ2 = 99 if  diab_age >=35  & med_ins == 1 & diab_ins==1 

**final diabetes variable
tab diabet diabet_typ2 

*** confirm all diagnosed before baseline 
gen age_diab_diff = age_recr - diab_age 
summ age_diab_diff if diabet==1, d

********************************************************************************
//BIOMARKERS
**fasting time set at 4+ hours (in other dataset)
gen fast4 = .
replace fast4 = 0 if fasting0<=3
replace fast4 = 1 if fasting0>=4
tab fast4

//WARNING TAKES A LONG TIME (Perhaps do for needed biomarkers only)
/* foreach var of varlist alb alp alt apoa apob ast dbili urea cal chol cre ///
crp cys ggt glc hba1c hdl igf1 ldl lipoa e2 phos /// 
rheumf shbg tbili testo prot tryg urate vitd {  */
	
	
foreach var of varlist cre crp glc hba1c hdl igf1 ldl e2 testo tryg {	
gen log_`var' = log(`var')

xtile `var'_q5_f = log_`var' if male==0, nq(5)
xtile `var'_q5_m = log_`var' if male==1, nq(5)
gen `var'_q5 = . 
replace `var'_q5 = `var'_q5_f if male==0
replace `var'_q5 = `var'_q5_m if male==1
tab `var'_q5 

xtile `var'_q4_f = log_`var' if male==0, nq(4)
xtile `var'_q4_m = log_`var' if male==1, nq(4)
gen `var'_q4 = . 
replace `var'_q4 =  `var'_q4_f if male==0
replace `var'_q4 = `var'_q4_m if male==1
tab `var'_q4 

xtile `var'_q3_f = log_`var' if male==0, nq(3)
xtile `var'_q3_m = log_`var' if male==1, nq(3)
gen `var'_q3 = . 
replace `var'_q3 = `var'_q3_f if male==0
replace `var'_q3 = `var'_q3_m if male==1
tab `var'_q3 

gen `var'_doub = log_`var'/log(2) 
} 

**SAVE DATASET********************
sort id
save "tempukb_working_cleaned1.dta", replace
************************************************************************************************************************






 

