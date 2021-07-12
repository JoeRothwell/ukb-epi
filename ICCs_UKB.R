# ICCs in UKB
library(tidyverse)
# Test with BMI. Variables needed: eID, sex, age_assess, 
UKBss <- UKB_final %>% select(f.eid, f.21003.0.0, f.21003.1.0, f.21003.2.0, f.30770.0.0, 
                              f.30770.1.0, f.21001.0.0, f.21001.1.0, f.21001.2.0, f.31.0.0)

saveRDS(UKBss, file = "ukb_icc.rds")

# Translation of ICC_metS.do into R
ukb <- readRDS(file = "ukb_icc.rds")
ukb <- ukb %>% rename(id = f.eid,
               age_assess1 = f.21003.0.0, age_assess2 = f.21003.1.0, age_assess3 = f.21003.2.0,
               bmi_1 = f.21001.0.0, bmi_2 = f.21001.1.0, bmi_3 = f.21001.2.0,
               igf_1 = f.30770.0.0, igf_2 = f.30770.1.0, sex = f.31.0.0)

# Drop people without 3 BMI measurements (Not needed if using irr/icc)
ukb <- ukb %>% filter(!is.na(bmi_1) & !is.na(bmi_2) & !is.na(bmi_3))

# ICCs are calculated using a 2-way mixed method (fixed "raters", and interested in individual
# measurements, not averages)
# Methods: 2-way using the IRR package. Need to subset cols.
library(irr)
icc(ukb[, 7:9], model = "twoway") # ICC = 0.922 (0.919-0.025)
icc(ukb[, 5:6], model = "twoway") # ICC = 0.77 (0.759-0.78)

# Fit models individually
ukblong <- ukb %>% pivot_longer(cols = bmi_1:bmi_3, names_to = "tp", values_to = "bmi")
library(lme4)
lmer(bmi ~ tp + (tp | id), data = ukblong)
