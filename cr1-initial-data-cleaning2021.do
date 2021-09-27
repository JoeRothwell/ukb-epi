*! DO FILE FOR BOOK KEEPING AND RENAMING OF VARIABLES
clear all
set more off
capture log close
//log using "LOG_cr1-initial-data-cleaning.smcl", replace
***************************************************
// data
use "D:/ukb37026_1565var.dta", clear
***************************************************

*===========================================================================================
*-------------------------------------------------------------------------------------------
* UK Biobank 
*
* File Name:			cr1-initial-data-cleaning.do 
*
* Purpose:		 		Initial cleaning of recruitment, cancer, and death data 
*
*===========================================================================================

//JR Note: drop prevalent cancers is line 247 (if need to look at these)

	
*********************************************************************************
*** Recruitment data 
********************************************************************************* 
	rename n_eid id  
* sex 
	rename n_31_0_0 sex 
	gen male = sex 
	lab define male_lab 0"female" 1"male"
	lab value male male_lab 
	ta male 

* age 
	rename n_21022_0_0 age_recr  
	rename n_34_0_0  birth_yr 
	rename ts_53_0_0 recruit_dte 

* socioeconomic position 
	rename n_189_0_0 dpr_index 
		
* assessment centre  
	rename n_54_0_0 assess_cen 

* Region 
** derived from UK Biobank assessment centre - needed here due to the different censoring dates between England and Scotland
recode assess_cen (11012=1) (11018=1) (11020=1) (11022=2) (11023=2) (11003=2) (10003=3) (11001=3) (11016=3) (11008=3) (11009=4) (11017=4) (11010=5) (11014=5) (11006=6) (11021=6) (11013=7) (11002=8) (11007=8) (11011=9) (11004=10) (11005=10), gen (region)
label define region_lab 1 "London" 2 "Wales" 3 "North-West England" 4 "North-East England" 5 "Yorkshire" 6 "West Midlands" 7 "East Midlands" 8 "South-East England" 9 "South-West England" 10 "Scotland"
label values region region_lab
ta region

recode region 1/9=1 10=0, gen(region_bin)
lab define region_bin_lab 1"England & Wales" 0"Scotland"
lab value region_bin region_bin_lab 
ta region_bin 

* Censoring date for cancer data: http://biobank.ctsu.ox.ac.uk/crystal/exinfo.cgi?src=Data_providers_and_dates  
//gen cens_dte = mdy(03, 31, 2016) if region_bin==1 
//replace cens_dte = mdy(10, 31, 2015) if region_bin==0  

//Update: Censoring date now July 2019
gen cens_dte = mdy(06, 30, 2019)
format cens_dte  %dM_d,_CY

//order n_eid sex male recruit_dte age_recr assess_cen dpr_index region region_bin cens_dte 
//Drop old cancer follow-up data
drop s_40001_0_0-n_40019_16_0 //ts_191_0_0 n_190_0_0
 
******************************************************************************** 
*** Variables and their codings for Death and Cancer register data  
********************************************************************************

merge 1:1 id using "D:/ukb48208_127var.dta", nogenerate

*** JR note: had to replace renvars with rename for Stata 16/17

* Reported occurrences of cancer 
rename n_40009_0_0 ca_total_reported

* Type of Cancer ICD-10 
//renvars s_40006_* , subst(s_40006_  ca_icd10_) 
rename s_40006_* ca_icd10_* 

* Type of Cancer ICD-9 
rename s_40013_* ca_icd9_* 

* Age at Cancer Diagnosis 
rename n_40008_* ca_dx_age_* 

* Date of Cancer Diagnosis 
rename ts_40005_* ca_dx_dte_* 

* Behaviour of cancer tumour 
rename n_40012_* ca_bhv_* 

lab define can_bhv_lab 0 "Benign" 1"Uncertain benign/malignant" 2"in situ" ///
					   -1 "Malignant" 3"Malignant primary" 6"Malignant metastatic" ///
					   9 "Malignant uncertain primary or metastatic" 
foreach var of varlist ca_bhv_0_0-ca_bhv_16_0 { 
lab value `var' can_bhv_lab 
}    
					   
* Age at the time of death 
rename n_40007_* death_age_* 


* Date of death 
rename ts_40000_* death_dte_* 

* Format date variable 
format *dte* %d
format *dte*  %dM_d,_CY


********************************************************************************
********************************************************************************
********************************************************************************
*ELIGIBLE PARTICIPANTS
********************************************************************************
*1. Define malignant and benign neoplasms reported as icd9 and icd10. Check number of instances (the `i' in ca_icd9_`i') in database with icd9 and icd10
*2. Check how many recorded by both icd9 & icd10 ignoring overlaps, make sure that all malignant are not overriten by D if both were reported	
*3. Select only malignant codes where diagnosed before the recruitment/screening to exclude them from the analysis. Drop prevalent cancers
*4. Generate dates for incident malignant tumours 
*5. Select first cancers
*6. Define cancer incidence by centre and cancer type
*7. Define CRCa incidence and CRCa death
*8. Contributory (secondary) causes of death: ICD10. Colorectal cancer cases included as secondary causes of death [NB: NOT INCLUDING THESE FOR CRC]
*9. Rest of endpoints
*10. Identify those unaffected with CRC who were lost to follow up or died before the end of follow up 
********************************************************************************

 
********************************************************************************
*CODE CANCER CASES
*1. Define malignant and benign neoplasms reported as ICD9 and ICD10 (prevalent and incident)
**************************************************
**REMEMBER TO CHECK IF THERE ARE ADDITIONAL ICD9 AND ICD10 INSTANCES (the `i' in ca_icd9_`i') 
* COMPARED WITH THE PREVIOUS RELEASE OF THE DATASET
******************************************************************************** 
* Define malignant and benign neoplasms reported as ICD9  
	**Malignant and benign neoplasms reported as ICD9 (prevalent and incident):
	* From 140 (Malignant neoplasm of lip) to 208 (Leukemia of unspecified cell type) and not equal to //
	* 173 (Other and unspec malignant neoplasm of skin): Malignant
	* From 209 (Neuroendocrine tumors) to 234 (Carcinoma in situ of other and unspecified sites): Benign or in situ 
	* 173 Non melanoma skin or NSB
	* 153 colon cancer, 154.0 rectosigmoid junction, 154.1 rectum
	* http://www.icd9data.com/2012/Volume1/140-239/150-159/default.htm
	* comands: real: string variable that has only numbers in it and want to convert it to a numeric variable  
	*substr: string variable; the position of the start of the substring; and the length of the substring to be copied

	capture drop icd9_malign prevalent_9
	gen icd9_malign=0
	gen prevalent_9=0
	
	gen ca_icd9_9_0="" 
	gen ca_icd9_13_0="" 
	
	
	forvalues i=0/14 {  
		replace icd9_malign =1 if real(substr(ca_icd9_`i'_0, 1,3))>=140 &  real(substr(ca_icd9_`i'_0, 1,3))<=208  &  real(substr(ca_icd9_`i'_0, 1,3))!=173 
	  	recode icd9_malign 0=2 if real(substr(ca_icd9_`i'_0,1,3)) >= 209 & real(substr(ca_icd9_`i'_0,1,3)) <=234 
		recode icd9_malign 0=3 if real(substr(ca_icd9_`i'_0,1,3))==173
		replace prevalent_9 =1 if (ca_dx_dte_`i'_0 < recruit_dte) & (icd9_malign==1 | icd9_malign==5)
	  }
	  
	  	forvalues i=0/14 {  
	  	recode icd9_malign 1=5 if real(substr(ca_icd9_`i'_0,1,3))==153 | real(substr(ca_icd9_`i'_0,1,4))==1540 | real(substr(ca_icd9_`i'_0,1,4))==1541 
			} 

	  
	 // drop ca_icd9_9_0 ca_icd9_13_0 
ta icd9_malign prevalent_9
***all icd9 malignancies are prevalent. 282 prevalent CRCa and 5,079 other cancer type
******************************************************************************** 
**Malignant and benign neoplasms reported as ICD10 (prevalent and incident):
* C (Malignant neoplasm) and not equal to C44 (Other and unspec malignant neoplasm of skin): Malignant
* D Benign or in situ 
* C44 Non melanoma skin or NSB
* "D32","D33","D352","D42","D43","D443","D444","D445” other benign neoplasm and "D434" (Neoplasm of uncertain or unknown behavior of spinal cord)
   *D32 - Benign neoplasm of meninges
   *D33 - Benign neoplasm of brain and other parts of central nervous system
   *D352 - Benign neoplasm of pituitary gland
   *D42 - Neoplasm of uncertain or unknown behaviour of meninges
   *D43 - Neoplasm of uncertain of unknown behaviour of brain and CNS
   *D443 - Neoplasm of uncertain or unknown behaviour of pituitary gland
   *D444 - Neoplasm of uncertain or unknown behaviour of craniopharyngeal duct
   *D445 - Neoplasm of uncertain or unknown behaviour of pineal gland
* D434 treated as benign (Benign neoplasm of thyroid gland)
* C18-C20 colorectal cancer 

capture drop icd10_malign prevalent_10 prevalent_Dcns
	gen prevalent_10=0
	gen icd10_malign=0
	gen prevalent_Dcns=0 
	
	gen ca_icd10_12_0= ""
	gen ca_icd10_14_0= ""
	
	forvalues i=0/16 {
		   replace icd10_malign=1  if substr(ca_icd10_`i'_0,1,1)=="C" & substr(ca_icd10_`i'_0,1,3)!="C44"
		   recode icd10_malign 0=2 if substr(ca_icd10_`i'_0,1,1)=="D" 
		   recode icd10_malign 0=3 if substr(ca_icd10_`i'_0,1,3)=="C44"
		   replace prevalent_10 =1 if (ca_dx_dte_`i'_0 < recruit_dte) & substr(ca_icd10_`i'_0,1,1)=="C" & substr(ca_icd10_`i'_0,1,3)!="C44"
		recode icd10_malign 2=4 if inlist(ca_icd10_`i'_0,"D32","D33","D352","D42","D43") | inlist(ca_icd10_`i'_0,"D443","D444","D445")
			recode icd10_malign 4=2 if substr(ca_icd10_`i'_0, 1, 4) == "D434"
				replace prevalent_Dcns=1 if (ca_dx_dte_`i'_0 < recruit_dte) & (inlist(ca_icd10_`i'_0,"D32","D33","D352","D42","D43") | inlist(ca_icd10_`i'_0,"D443","D444","D445"))
				recode  prevalent_Dcns 1=0 if substr(ca_icd10_`i'_0, 1, 4) == "D434"
		}

		
forvalues i=0/16 { 
recode icd10_malign 1=5 if substr(ca_icd10_`i'_0,1,3)=="C18" | substr(ca_icd10_`i'_0,1,3)=="C19" | substr(ca_icd10_`i'_0,1,3)=="C20" 
} 
	
ta icd10_malign prevalent_10, m  // *** Prevalent cancers now: 2,532 CRCCa and 21,221 other cancer type
 
	//drop ca_icd10_12_0 ca_icd10_14_0 

**********************************************************************************************************************
**2.Check how many recorded by both icd9 & icd10 ignoring overlaps
	*** create new var (any_ca) with both ICD9 and ICD10 cancers, independently of prevanlent or incident	
	capture drop any_ca
	gen any_ca=. 
	replace any_ca = 5 if icd9_malign ==5 | icd10_malign==5 
	replace any_ca = 1 if any_ca==. & (icd9_malign ==1 | icd10_malign==1 )
	replace any_ca = 2 if any_ca==. & (icd9_malign ==2 | icd10_malign==2 ) 
	replace any_ca = 3 if any_ca==. & (icd9_malign ==3 | icd10_malign==3 ) 
	replace any_ca = 4 if any_ca==. & (icd9_malign ==4 | icd10_malign==4 )  
	replace any_ca = 0 if any_ca==. 

	la de any_ca 0 "None reported" 1 "Malignant" 2 "Benign or in situ" 3 "Non melanoma skin or NSB" 4 "Other neoplasm" 5 "colorectal cancer"
	la val any_ca any_ca
	la var any_ca "1 for all malignant tumours reported"
		
	tab2 any_ca prevalent_10 prevalent_9 prevalent_Dcns
	ta any_ca 
	
********************************************************************************************************************** 		
**3. select only malignant codes where diagnosed before the recruitment to exclude them from the analysis (delete prevalent cancers)
**drop benign CNS (i.e. treat them as if they are malignant)
	capture drop prevalent_ca
	gen prevalent_ca=1 if prevalent_9==1 | prevalent_10==1 | prevalent_Dcns==1
		
	tab2 any_ca prevalent_ca prevalent_10 prevalent_9 prevalent_Dcns
	* 27,036 total prevalent cancers
	ta any_ca if prevalent_ca !=1

	replace prevalent_ca=2 if prevalent_ca==1 & any_ca==5 
	la de prevalent_ca 1 "other prev cancer" 2 "prevalent colorectal ca"  
	la val prevalent_ca prevalent_ca
	la var prevalent_ca "prevalent malignant tumours"
	tab prevalent_ca

	**Drop prevalent cancers: 24,312 other cancers and 2,727 CRCa
//	drop if prevalent_ca==1 | prevalent_ca==2  // 27,036 observations deleted 

tab any_ca
** 3,419 CRCa after excluding prevalent
//8,089 at new follow-up
	
********************************************************************************************************************** 
**4. generate dates for incident malignant tumours. Only icd10 because all icd9 were prevalent and we have dropped them: 
ta icd9_malign, m 
**We treat D codes specified above as malignant
**C44 (Other and unspecified malignant neoplasm of skin)
 count 
 *475,500 
 capture drop cancer_dte_*
 capture drop ca_10*
 
	forvalues i= 0/16  {
	gen cancer_dte_`i'_0 = cond(ca_dx_dte_`i'_0 > recruit_dte & (substr(ca_icd10_`i'_0, 1, 1) == "C" | inlist(ca_icd10_`i'_0,"D32","D33","D352","D42","D43") | inlist(ca_icd10_`i'_0,"D443","D444","D445")) , ca_dx_dte_`i'_0, .) 
	replace cancer_dte_`i'_0 =. if substr(ca_icd10_`i'_0, 1, 4) == "D434"
	replace cancer_dte_`i'_0 =. if substr(ca_icd10_`i'_0, 1, 3) == "C44"
	gen ca_10_`i'_0 = ca_icd10_`i'_0 if cancer_dte_`i'_0!=. 

	} 
		
	sort id

	format *dte* %d 
	
	list id ca_dx_dte_0 cancer_dte_0 ca_icd10_0 ca_10_0 recruit_dte if any_ca>=1 in 100/500

	
forvalues i= 0/16  { 	
list id any_ca ca_dx_dte_`i'_0 cancer_dte_`i'_0 ca_icd10_`i'_0 ca_10_`i'_0 recruit_dte if any_ca>=1 in 100/200
} 

* confirm all cancers coded correctly 
forvalues i= 0/16  { 
list id any_ca ca_dx_dte_`i'_0 cancer_dte_`i'_0 ca_icd10_`i'_0 ca_10_`i'_0 recruit_dte if any_ca==5 in 100/1000
} 
 
*** We have missings in both cancer_dte_* and ca_10_* if tumour type is benign or non melanoma skin or NSB 

**********************************************************************************************************************	
*5. replace first ca diagnosis with earliest date of all primaries reported after the recruitment/screening date 
capture drop first_ca_*

	gen first_ca_10_dte = min(cancer_dte_0_0,cancer_dte_1_0,cancer_dte_2_0, ///
	cancer_dte_3_0,cancer_dte_4_0,cancer_dte_5_0, ///
	cancer_dte_6_0,cancer_dte_7_0,cancer_dte_8_0, ///
	cancer_dte_9_0,cancer_dte_10_0,cancer_dte_11_0, ///
	cancer_dte_12_0,cancer_dte_13_0,cancer_dte_14_0, ///
	cancer_dte_15_0,cancer_dte_16_0)   
	
	format *dte*  %dM_d,_CY

count  if first_ca_10_dte !=. // 29,400 

list first_ca_10_dte cancer_dte_0_0 cancer_dte_1_0 cancer_dte_2_0 ///
	cancer_dte_3_0 cancer_dte_4_0 cancer_dte_5_0  ///
	cancer_dte_6_0 cancer_dte_7_0 cancer_dte_8_0 ///
	cancer_dte_9_0 cancer_dte_10_0 cancer_dte_11_0 ///
	cancer_dte_12_0 cancer_dte_13_0 ///
	in 400/500  if first_ca_10_dte!=. 

ta any_ca if any_ca>=1 & any_ca!=2 & any_ca!=3 // 29,394  
ta any_ca if any_ca>=1 & any_ca!=2 & any_ca!=3 & any_ca!=4 // 29,303  


**current follow up 
//count  if first_ca_10_dte <= mdy(03,31,2016) & region!=10 & first_ca_10_dte!=.
*26,797

//count if first_ca_10_dte <= mdy(10,31,2015) & region==10 & first_ca_10_dte!=.
*2,306 

count  if first_ca_10_dte <= mdy(06,30,2019) & first_ca_10_dte!=.
*31,908

count if first_ca_10_dte <= cens_dte & first_ca_10_dte!=.
*31,908

********************************************************************************************************************** 
**6. Define cancer incidence by centre and cancer type
* based on UKBB we should use the fellowing censoring dates: 03,31,2016 for england and wales and 10,31,2015 for scotland.

//JR NOTE: 5 September 2021: now updated for follow-up until July 2019

* * Censoring date for cancer data: http://biobank.ctsu.ox.ac.uk/crystal/exinfo.cgi?src=Data_providers_and_dates  
	
**censoring:		
		replace first_ca_10_dte=. if first_ca_10_dte >cens_dte // 294 
		format *dte* %d
**Fields cancer_dte_* and ca_* only contain valid malignant incident cancer date and icd10 codes, otherwise empty
	
	
**From all valid dates and diagnoses for incident malignant tumours pick up the earliest date if multiple:
	**gen variable to hold the date of the first primary incident cancer, it will be ca_10* :

	sort first_ca_10_dte
	sum recruit_dte first_ca_10_dte, f

	
	** make sure that only first primary icd10 diagnoses considered further before defining incident cancer's type:
		 forvalues i=0/16 {
		   replace ca_10_`i'_0= "" if cancer_dte_`i'_0!=first_ca_10_dte & first_ca_10_dte !=.
			  }

	*ca_10_*  "" empty fields, no primary cancers
	**count empty fields:
			forvalues i= 0/16 {
			count if ca_10_`i'_0  != ""
			} // 0 to 6 
	
	
***Check if multiple have valid dates:
	list first_ca_10_dte ca_10_0 cancer_dte_0_0 ca_10_1_0 cancer_dte_1_0 ///
	recruit_dte if ca_10_0 !="" & ca_10_1_0 != "" & substr(ca_10_1_0, 1,2 ) != substr(ca_10_0_0, 1, 2)

	list first_ca_10_dte ca_10_0 cancer_dte_0_0 ca_10_2_0 cancer_dte_2_0 ///
	recruit_dte if ca_10_0 !="" & ca_10_2_0 != "" & substr(ca_10_2_0, 1,2 ) != substr(ca_10_0_0, 1, 2)

	list first_ca_10_dte ca_10_0 cancer_dte_0_0 ca_10_3_0 cancer_dte_3_0 ///
	recruit_dte if ca_10_0 !="" & ca_10_3_0 != "" & substr(ca_10_3_0, 1,2 ) != substr(ca_10_0_0, 1, 2) 
	
	list first_ca_10_dte ca_10_0 cancer_dte_0_0 ca_10_4_0 cancer_dte_4_0 ///
	recruit_dte if ca_10_0 !="" & ca_10_4_0 != "" & substr(ca_10_4_0, 1,2 ) != substr(ca_10_0_0, 1, 2) 
	
	count if first_ca_10_dte==. & (any_ca==1 | any_ca==5) & first_ca_10_dte <=cens_dte
	
********************************************************************************************************************** 
** -------- CANCER ENDPOINTS-------- **
* oral cancer
	capture drop oral*
	gen oral=0
	la var  oral "Incident cancers of lip , oral cavity and pharinx[C00/C14]" 
	
* oesophageal cancer
	capture drop oesoph
	gen oesoph=0
	la var oesoph  "Incident cancers of oesophagus [C15]" 
	
* stomach cancer
	capture drop stomach
	gen stomach=0
	la var stomach  "Incident cancers of stomach [C16]"
	
* cardia stomach cancer
	capture drop cardstomach
	gen cardstomach=0
	la var cardstomach  "Incident cancers of cardia stomach [C16.0]"	
	
* non-cardia stomach cancer
	capture drop noncardstomach
	gen noncardstomach=0
	la var noncardstomach  "Incident cancers of non-cardia stomach [C16.1-C16.6]"		

* liver
	capture drop liver
	gen liver=0
	la var liver  "Incident cancers of liver and intrahepatic bile ducts [C22]" 

* hcc - liver
	capture drop hcc
	gen hcc=0
	la var hcc  "Incident cancers of liver carcinoma - HCC [C220]" 

* ibdc - liver	
	capture drop ibdc
	gen ibdc=0
	la var ibdc  "Incident cancers of Intrahepatic bile duct carcinoma [C221]" 
	
* colorectal cancer
	capture drop colorectal
	gen colorectal=0
	la var colorectal "Incident cancers of colon and rectum [C18/C20]"

* colon cancer
	capture drop colon
	gen colon=0
	la var colon "Incident cancers of colon [C18]"
	
*rectal
	capture drop rectal
	gen rectal =0
	la var rectal "Incident rectal cancers [C19/C20]"
	  
*proximal colon
	capture drop prox_colon
	gen prox_colon =0
	la var prox_colon "Incident proximal colon cancers [C180/C185]"
		
*distal colon
	capture drop distal_colon
	gen dist_colon =0
	la var dist_colon "Distal colon cancers [C186/C187]"
    
* appendix 
	capture drop appendix 
	gen appendix =0 
	lab var appendix "appendix cancer [C181]"
	
* pancreatic cancer
	capture drop pancreas
	gen pancreas=0
	la var pancreas "Incident pancreatic cancers  [C25]"

**All digestive organc:
	captur drop digetsive*
	gen digestive=0
	la var digestive "Incident cancers of digestive organs [C15/C26]"
 
* lung cancer
	capture drop lung*
	gen lung=0
	la var lung  "Incident cancers of lung  [C34]"

**All respiratory:
	capture drop respiratory
	gen respiratory=0
	la var respiratory "Incident cancers of respiratory organs [C30/C39]"

* melanoma
	capture drop melanoma
	gen melanoma=0 
	la var melanoma "Incident melanoma [C43]"

 
* breast cancer
	capture drop breast
	gen breast=0
	la var breast "Incident breast cancers  [C50]"

* prostate cancer
	capture drop prostate
	gen prostate =0
	la var prostate "Incident prostate cancers [C61]"
    
* uterine  cancer
	capture drop uterine 
	gen uterine =0 
	la var uterine "Incident uterine cancers  [C55]"
	
    *replace uterine =. if hyster_yn!=2
    
* ovarian cancer
	capture drop ovary
	gen ovary=0
	la var ovary "Incident ovarian cancers [C56]"

    *replace ovary=. if bilat_yn!=2
	
	
* endometrial cancer
	capture drop endometrial
	gen endometrial=0
	la var endometrial "Incident endometrial cancers [C54]"

    
* kidney
	capture drop
	gen kidney=0
	la var kidney "Incident kidney cancers [C64]"

* renal
	capture drop
	gen renal=0
	la var renal  "Incident renal cancers [C650 - C669]"
	
* bladder
	capture drop bladder
	gen bladder=0
	la var bladder  "Incident bladder cancers [C67]"
	
**All Urinary
	 capture drop urinary 
	 gen urinary =0 
	 la var urinary "Incident cancers of urinary tract [C64/C68]"
 
* brain
	capture drop brain
	gen brain=0
	la var brain "Incident cancers of brain [C71]"

* cns
	capture drop cns
	gen cns=0
	la var cns "Incident CNS tumours [C69/C72 D32/D33 D35 D42/D44 ]"
 
* non-Hodgkins lymphoma
	capture drop nhl
	gen nhl=0
	la var nhl "Incident Non Hodhkins lymphoma [C82/C85]"
	
* multiple myeloma
	capture drop multmyeloma
	gen multmyeloma=0
	la var multmyeloma "Incident myeloma [C90]"
 
* leukaemia
	capture drop leuk
	gen leuk=0
	la var leuk "Incident leukemia [C91/C95]"
	
* all haematological
	capture drop allhaem
	gen allhaem=0
	la var allhaem "All haematological/lymphatic [C81/C96]"
 
* anal (because it is only squamous in the lower GI:
	capture drop anal
	gen anal =0
	la var anal "Incident anal cancers [C21]"
  
*cervical
	capture drop cervix
	  gen cervix =0
	  la var cervix "Incident cervical cancers [C53]"
	 
* thyroid cancer
	capture drop thyroid
	gen thyroid=0
	la var thyroid "Incident thyroid cancers  [C73]"

* All cancers
	gen allcan=0
	la var allcan "All incident cancers [C00/C97] excluding [C44]"

format *dte* %d

		
 * to define ca type for all incident cancers regardless of dates, use the first line of the loop:
 **all ca sites defined for incident ca only, prevalent were dropped before 
 ***Define that cancer as the first cancer incidence with global $if

 
	*foreach i of varlist ca_10* {
	forvalues k= 0/16 {
	
		local i ca_10_`k'_0
		global  if =  "& ca_dx_dte_`k'_0 == first_ca_10_dte & first_ca_10_dte !=."
		
		replace oral=1 if `i' >= "C00" & `i' <= "C149" $if
		
		replace oesoph=1 if `i' >="C150" & `i' <= "C159" $if
		
		replace stomach=1 if `i' >="C160" & `i' <= "C169" $if
		replace cardstomach=1 if `i' =="C160" $if
		replace noncardstomach=1 if `i' >="C161" & `i' <= "C166" $if
		
		replace liver=1 if `i' >="C220" & `i' <= "C229" $if 
		replace hcc=1 if `i'=="C220" $if
		replace ibdc=1 if `i'=="C221" $if
		
		replace colorectal=1 if `i' >= "C180" & `i' <= "C209" $if
		replace colorectal=1 if (substr(`i',1,3)=="C18" | substr(`i',1,3)=="C19" | substr(`i',1,3)=="C20") $if
		replace colon = 1 if substr(`i',1,3) == "C18" $if
		replace rectal = 1 if (substr(`i',1,3) =="C19" | substr(`i',1,3)=="C20") $if
		replace prox_colon = 1 if `i' >= "C180" & `i' <= "C185" $if
		replace dist_colon = 1 if `i' >= "C186" & `i' <= "C187" $if
		replace appendix=1 if `i' == "C181" $if
		
		replace anal=1 if  `i' >="C210" & `i' <= "C219" $if
		
		replace pancreas=1 if `i' >="C250" & `i' <= "C259" $if
		
		replace digestive= 1 if `i' >= "C150" & `i' <="C269" $if
		
		replace lung=1 if `i' >="C340" & `i' <= "C349" $if
		
		replace respiratory =1 if `i' >="C300" & `i' <= "C399" $if
		
		replace melanoma=1 if `i' >="C430" & `i' <= "C439" $if
		
		replace breast=1 if `i' >="C500" & `i' <= "C509"  $if
		replace breast =2 if `i' >="D050" & `i' <= "D059" $if
		
		replace cervix=1 if `i' >= "C530" & `i' <= "C539" $if
		replace cervix=1 if substr(`i',1,3) =="C53" $if
		
		replace uterine =1 if `i' >="C540" & `i' <= "C559" $if
		
		replace ovary=1 if `i' >="C560" & `i' <= "C569" $if
		
		replace endometrial=1 if `i' >="C540" & `i' <= "C549" $if

		replace prostate=1 if substr(`i',1,3) =="C61" $if
		
		replace kidney =1 if substr(`i', 1,3) =="C64" $if
		
		replace renal = 1 if `i' >="C650" & `i' <= "C669" $if
		
		replace urinary =1 if `i' >="C640" & `i' <= "C689" $if
		
		
		replace bladder=1 if `i' >="C670" & `i' <= "C679" $if
				
		replace cns =1 if `i' >="C690" & `i' <= "C729" $if
		
		replace cns =1 if (inlist(`i',"D32","D33","D352","D42","D43") | inlist(`i',"D443","D444","D445"))  $if
		recode cns 1=0 if substr(`i',1,4)=="D434"
		
		replace brain =1 if substr(`i',1,3)=="C71" $if
				
		replace thyroid=1 if substr(`i',1,3)=="C73" $if
		
		replace nhl=1 if  `i' >= "C820" & `i' <= "C859" $if
		 
		replace multmyeloma=1 if `i' >="C900" & `i' <= "C909" $if
		
		replace leuk=1 if `i' >="C910" & `i' <= "C959"  $if
		
		replace allhaem=1 if `i' >="C810" & `i' <= "C969" $if
		
		replace allcan=1 if substr(`i',1,1)=="C" $if
		recode allcan 1=0 if substr(`i',1,3)== "C44"
		
		}

	format *dte* %d
	

 **need to recode all zeros in site specific cancers if there is a known cancer of other site:
 
foreach outcome of varlist anal bladder brain breast cervix cns colorectal colon rectal prox_colon dist_colon digestive kidney leuk liver hcc ibdc lung melanoma multmyeloma nhl allhaem oesoph oral ovary endometrial pancreas prostate renal respiratory stomach cardstomach noncardstomach thyroid urinary uterine {
	 rename  `outcome'  `outcome'_inc 
		 }
 

ta any_ca colorectal_inc, m
ta colorectal_inc if first_ca_10_dte <= cens_dte | first_ca_10_dte==.   //  
tab1 ca_icd10_* if cns==1	
	
gen colorectal_ca_dte = . 
forvalues i= 0/16 { 
replace colorectal_ca_dte= ca_dx_dte_`i'_0 if colorectal_ca_dte==. & (substr(ca_icd10_`i'_0,1,3)=="C18" | substr(ca_icd10_`i'_0,1,3)=="C19" | substr(ca_icd10_`i'_0,1,3)=="C20") 
replace colorectal_ca_dte=. if colorectal_ca_dte>cens_dte 
} 
format *dte* %d 



* confirm those not categorised as colorectal_inc have had another primary or were diagnosed after end of followup 
count if (any_ca==5 & colorectal_inc!=1) & colorectal_ca_dte<first_ca_10_dte  

count if (any_ca==5 & colorectal_inc!=1) & colorectal_ca_dte<first_ca_10_dte   

count if colorectal_inc==1 & first_ca_10_dte!=colorectal_ca_dte & ca_total_reported == 1

count  if colorectal_inc==1 & first_ca_10_dte<colorectal_ca_dte & ca_total_reported != 1 
list first_ca_10_dte recruit_dte cens_dte colorectal_inc colorectal_ca_dte ca_10_0_0  if colorectal_inc==1 & first_ca_10_dte!=colorectal_ca_dte & ca_total_reported != 1
replace colorectal_ca_dte = first_ca_10_dte if colorectal_inc==1 & first_ca_10_dte<colorectal_ca_dte


**************************************************************************	**************************************************************************	
// X. Within the dataset there are 22 CRC cases with a colon cancer and rectal cancer diagnosis	****************************************************************************************************	
******* on the same diagnosis date and behaviour (malignant primary site). Need to code these cases  ***********************************************************************************************
******* as either colon or rectal cancer - will arbitrarily code as colon rather than rectal - as the more common cancer
***************************************************************************************************************************************************************************************************	
count if rectal_inc==1 & colon_inc==1
replace rectal_inc=0 if rectal_inc==1 & colon_inc==1
tab colorectal_inc
tab colon_inc
tab rectal_inc
//Now colon cases + rectal cases = colorectal cases


****************************************************************************************************************************************************		
// XX. Need to create two oesoph cancer variables based on histology variables (n_40011_0_0 to n_40011_16_0)
// EA categorized as oesoph_inc==1 & ICD-O morphological codes: 8140, 8141, 8190–8231, 8260–8263, 8310, 8430, 8480–8490, 8560, 8570–8572) 
// ESCC categorized as oesoph_inc==1 & ICD-O morphological codes: 8050–8076
*************************************************************************************************************************************************	***********************************************************************	
gen oesophad_inc = 0 if oesoph_inc !=. 
foreach x of varlist n_40011_0_0 - n_40011_16_0 {
replace oesophad_inc=1 if (`x'>=8140 & `x'<=8141) & oesoph_inc==1
replace oesophad_inc=1 if (`x'>=8190 & `x'<=8231) & oesoph_inc==1
replace oesophad_inc=1 if (`x'>=8260 & `x'<=8263) & oesoph_inc==1
replace oesophad_inc=1 if (`x'==8310) & oesoph_inc==1
replace oesophad_inc=1 if (`x'==8430) & oesoph_inc==1
replace oesophad_inc=1 if (`x'>=8480 & `x'<=8490) & oesoph_inc==1
replace oesophad_inc=1 if (`x'==8560) & oesoph_inc==1
replace oesophad_inc=1 if (`x'>=8570 & `x'<=8572) & oesoph_inc==1
}
tab oesophad_inc
tab oesophad_inc
la var oesophad_inc "Incident cancers esophageal adenocarcinoma"


gen oesophsq_inc = 0 if oesoph_inc !=. 
foreach x of varlist n_40011_0_0 - n_40011_16_0 {
replace oesophsq_inc=1 if oesoph_inc==1 & (`x'>=8050 & `x'<=8076)
}
tab oesophsq_inc
la var oesophsq_inc "Incident cancers esophageal squamous cell carcinoma"



**********************************************************************************************************************  
*7. Define CRCa incidence and CRCa death		
********************************************************************************************************************** 
// Date of colorectal cancer
// any_ca==5
ta colorectal_inc
// 3,255 CRCa cases
//ta colorectal_inc if region !=10 & first_ca_10_dte <= mdy(03,31,2016) | first_ca_10_dte==.   
//ta colorectal_inc if region ==10 & first_ca_10_dte <= mdy(10,31,2015) | first_ca_10_dte==.   
ta colorectal_inc if first_ca_10_dte <= mdy(06,30,2019) | first_ca_10_dte==.  

// Date of panc cancer
// any_ca==5
ta pancreas_inc
// 608 PCa cases
//ta pancreas_inc if region !=10 & first_ca_10_dte <= mdy(03,31,2016) | first_ca_10_dte==.   
//ta pancreas_inc if region ==10 & first_ca_10_dte <= mdy(10,31,2015) | first_ca_10_dte==.   
ta pancreas_inc if first_ca_10_dte <= mdy(06,30,2019) | first_ca_10_dte==.

// Date of stomach cancer
// any_ca==5
ta stomach_inc
// 356 SCa cases
//ta stomach_inc if region !=10 & first_ca_10_dte <= mdy(03,31,2016) | first_ca_10_dte==.   
//ta stomach_inc if region ==10 & first_ca_10_dte <= mdy(10,31,2015) | first_ca_10_dte==.   
ta stomach_inc if first_ca_10_dte <= mdy(06,30,2019) | first_ca_10_dte==.

// Date of liver cancer
// any_ca==5
ta liver_inc
// 302 LCa cases
//ta liver_inc if region !=10 & first_ca_10_dte <= mdy(03,31,2016) | first_ca_10_dte==.   
//ta liver_inc if region ==10 & first_ca_10_dte <= mdy(10,31,2015) | first_ca_10_dte==.   
ta liver_inc if first_ca_10_dte <= mdy(06,30,2019) | first_ca_10_dte==.

// Date of oesoph cancer
// any_ca==5
ta oesoph_inc
// 536 LCa cases
//ta oesoph_inc if region !=10 & first_ca_10_dte <= mdy(03,31,2016) | first_ca_10_dte==.   
//ta oesoph_inc if region ==10 & first_ca_10_dte <= mdy(10,31,2015) | first_ca_10_dte==.   
ta oesoph_inc if first_ca_10_dte <= mdy(06,30,2019) | first_ca_10_dte==.


***********************************************************************
**Death from GI cancer (primary cause)
*40001 has 2 instances (0/1)
*s_40001_0 primary cause of death

//colorectal
ta colorectal_inc  // 3,255  
forvalues i=0/1 { 
	replace colorectal_inc=1 if ((s_40001_`i'>="C18" & s_40001_`i'<="C200") & allcan==0 & (death_dte_`i'<=cens_dte))  
	} 
tab colorectal_inc // 3,258 
tab colorectal_inc if prevalent_ca!=1 & prevalent_ca!=2 // 3,258   
ta colorectal_inc if  (first_ca_10_dte <= cens_dte | first_ca_10_dte==.) & prevalent_ca!=1 & prevalent_ca!=2   //  3,258   
ta colorectal_inc if  first_ca_10_dte <= cens_dte & first_ca_10_dte!=. & prevalent_ca!=1 & prevalent_ca!=2   //  3,255   
ta colorectal_inc appendix, m // 60 cases 	

//colon
ta colon_inc // 2,151
forvalues i=0/1 { 
	replace colon_inc=1 if ((s_40001_`i'>="C18" & s_40001_`i'<="C189") & allcan==0 & (death_dte_`i'<=cens_dte))  
	} 
ta colon_inc //2,152

//proximal colon 
ta prox_colon_inc // 1,115
forvalues i=0/1 { 
	replace prox_colon_inc=1 if ((s_40001_`i'>="C18" & s_40001_`i'<="C185") & allcan==0 & (death_dte_`i'<=cens_dte))  
	} 
ta prox_colon_inc // 1,115

//distal colon 
ta dist_colon_inc // 939
forvalues i=0/1 { 
	replace dist_colon_inc=1 if ((s_40001_`i'>="C186" & s_40001_`i'<="C187") & allcan==0 & (death_dte_`i'<=cens_dte))  
	} 
ta dist_colon_inc // 939

//rectal
ta rectal_inc // 1,104
forvalues i=0/1 { 
	replace rectal_inc=1 if ((s_40001_`i'>="C19" & s_40001_`i'<="C200") & allcan==0 & (death_dte_`i'<=cens_dte))  
	} 
ta rectal_inc // 1,106


//pancreas
ta pancreas_inc // 608 
forvalues i=0/1 { 
	replace pancreas_inc =1 if ((s_40001_`i'>="C25" & s_40001_`i'<="C259") & allcan==0 & (death_dte_`i'<=cens_dte))
} 
ta pancreas_inc 
ta pancreas_inc if prevalent_ca!=1 & prevalent_ca!=2 // 611  



//stomach
ta stomach_inc // 356
forvalues i=0/1 { 
	replace stomach_inc =1 if ((s_40001_`i'=="C16" & s_40001_`i'<="C169") & allcan==0 & (death_dte_`i'<=cens_dte))
} 
ta stomach_inc 
ta stomach_inc if prevalent_ca!=1 & prevalent_ca!=2 // 356  



//oesophageal
ta oesoph_inc // 536
forvalues i=0/1 { 
	replace oesoph_inc =1 if ((s_40001_`i'=="C150" & s_40001_0<="C159") & allcan==0 & (death_dte_`i'<=cens_dte))
} 
ta oesoph_inc 
ta oesoph_inc if prevalent_ca!=1 & prevalent_ca!=2 // 536 



//liver
ta liver_inc // 302
forvalues i=0/1 { 
	replace liver_inc =1 if ((s_40001_`i'=="C220" & s_40001_`i'<="C229") & allcan==0 & (death_dte_`i'<=cens_dte))
} 
ta liver_inc 
ta liver_inc if prevalent_ca!=1 & prevalent_ca!=2 // 302 


*********************************************************************************************************************** 
*8. Identify those lost to follow up or dead before the end of follow-up : will need to exclude for mediation analysis: 
* https://biobank.ctsu.ox.ac.uk/crystal/refer.cgi?id=481516

//Note JR: These variables are in 41622. Need to join that dataset first.
merge 1:1 id using "D:/ukb41622_562var.dta", nogenerate

codebook ts_191_0_0 n_190_0_0
rename n_190_0_0 lost_followup_rsn
rename ts_191_0_0 lost_followup_dte

format *dte* %d 

lab define lost_followup_rsn_lab 1"Death reported by a relative" 2"NHS records indicate lost to follow-up" ///
3"NHS records indicated left the UK" 4"UKB sources report left the UK" 5"Participant withdrawn consent for linkage"
lab var lost_followup_rsn lost_followup_rsn_lab
ta lost_followup_rsn, m 

gen followup_lost = 0 
replace followup_lost  = 1 if lost_followup_rsn!=. & lost_followup_dte<cens_dte & allcan==0 
ta followup_lost, m  // 1,227 lost to followup 

* died before the end of followup 
gen dead_followup = . 

forvalues i=0/1 { 
	replace dead_followup =1 if (colorectal_inc==0 & (death_dte_`i'<cens_dte))
} 
ta dead_followup
* 
replace followup_lost = 1 if dead_followup==1 
ta followup_lost colorectal_inc, m  col // 6,678 (1.4%) lost to followup 

//JR Note: at 2019 update 20,419 (4.06%) were lost to follow-up

sort followup_lost 
*list cens_dte lost_followup_dte  dead_followup death_dte_0 death_dte_1 if followup_lost==1

***********************************************************************************************************************
* generate a single variable for death 
format *dte* %d  

gen death_dte = . 
replace death_dte = death_dte_0_0 
replace death_dte = death_dte_1_0 if death_dte ==. 
count if death_dte_0_0 ~=. & death_dte_1_0 ~=. & death_dte_0_0 ~=death_dte_1_0

********************************************************************************  
* make dte_exit variables based on cancer diagnosis
* date of diagnosis for incidence cancer cases - first_ca_10_dte
* date of follow-up for all participants - dte_exit_frst

* drop incident cancer case if missing date of diagnosis information
ta allcan, m // 29001 
count if allcan==1 & first_ca_10_dte==. // 0 
count if allcan==0 & first_ca_10_dte!=. // 102 
drop if allcan==0 & first_ca_10_dte!=. // 102 

count if colorectal_inc==1 & first_ca_10_dte==. //  3 
count if colorectal_inc==1 & first_ca_10_dte==. & prevalent_ca!=1 & prevalent_ca!=2  //  3 
drop if colorectal_inc==1 & first_ca_10_dte==.  & prevalent_ca!=1 & prevalent_ca!=2 

count if pancreas_inc==1 & first_ca_10_dte==. & prevalent_ca!=1 & prevalent_ca!=2  //  3 
drop if pancreas_inc==1 & first_ca_10_dte==. & prevalent_ca!=1 & prevalent_ca!=2 
 
count if stomach_inc==1 & first_ca_10_dte==. & prevalent_ca!=1 & prevalent_ca!=2  //  0 
 
count if oesoph_inc==1 & first_ca_10_dte==. & prevalent_ca!=1 & prevalent_ca!=2  //  0 
  
count if liver_inc==1 & first_ca_10_dte==. & prevalent_ca!=1 & prevalent_ca!=2  //  0 
 
 
ta colorectal_inc allcan if prevalent_ca!=1 & prevalent_ca!=2 , m  // 3,255 
ta pancreas_inc allcan if prevalent_ca!=1 & prevalent_ca!=2, m // 608
ta stomach_inc allcan if prevalent_ca!=1 & prevalent_ca!=2, m // 356
ta oesoph_inc allcan if prevalent_ca!=1 & prevalent_ca!=2, m // 536
ta liver_inc allcan if prevalent_ca!=1 & prevalent_ca!=2, m // 302


******************************************************************************** 
* generate date exit: age at cancer diagnosis, death, last follow follow up, whichever comes first 
* other incident cancers (non-CRC) are also censored on diagnosis date 
gen dte_exit_frst = min(first_ca_10_dte, death_dte, lost_followup_dte, cens_dte)

** confirm that for CRC cases it is the same as their cancer diagnosis 
count if colorectal_inc==1 & dte_exit_frst!=first_ca_10_dte // 0

* 
count if colorectal_inc==0 & dte_exit_frst == first_ca_10_dte  // 25,746 
count if colorectal_inc==0 & dte_exit_frst == death_dte & dte_exit_frst != first_ca_10_dte // 5,445  
count if colorectal_inc==0 & dte_exit_frst == lost_followup_dte & dte_exit_frst != death_dte & dte_exit_frst != first_ca_10_dte // 1,227
count if colorectal_inc==0 & dte_exit_frst == cens_dte & dte_exit_frst != lost_followup_dte & dte_exit_frst != death_dte & dte_exit_frst != first_ca_10_dte  // 439,719 
*  
* now dte_exit and caseclrt variables reflect: 
* (1) general censoring dates for non-cases
* (2) diagnosis date censoring dates for cases
* (3) death date censoring date for non-cases who died prior to censoring date
* (4) lost to follow up date for non-cases who were lost to follow up prior to censoring date 
* generate censoring/last age at follow-up for all participants 

gen followup = dte_exit_frst - recruit_dte
gen followup_yrs = followup/365.25
gen age_exit_frst = age_recr + followup_yrs
label variable age_exit_frst "Age at exit"

format *dte* %d  

save "tempukb_working2021.dta", replace
***********************************************************************************************************************

* some checks: 

summ dte_exit_frst if colorectal_inc==0 & dte_exit_frst == cens_dte & region_bin==1, f 
summ dte_exit_frst if colorectal_inc==0 & dte_exit_frst == cens_dte & region_bin==0, f  

**CHECK 2 - Incident CRC cases and other cancer cases have diagnosis age/date as censoring/age exit dates
set more off
list age_recr recruit_dte dte_exit_frst age_exit_frst if colorectal_inc==1 in 1/1500
list age_recr recruit_dte dte_exit_frst age_exit_frst if colorectal_inc==0 & allcan==1 in 1/1500

**CHECK 3 - Deaths have death age/date as censoring/age exit
list death_dte dte_exit_frst region in 1/1500

**CHECK 4 - CRC prevalent cases are excluded
count if colorectal_inc==1 & dte_exit_frst<recruit_dte

 
***********************************************************************************************************************
***********************************************************************************************************************
log close

