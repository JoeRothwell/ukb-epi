# ICCs in UKB
library(tidyverse)
# Test with BMI. Variables needed: eID, sex, age_assess, 
UKBss <- UKB_final %>% select(f.eid, f.21003.0.0, f.21003.1.0, f.21003.1.0, f.30770.0.0, f.30770.1.0, 
                              f.21001.0.0, f.21001.1.0, f.21001.2.0, f.31.0.0)

saveRDS(UKBss, file = "UKB_for_ICC.rds")

# Translation of ICC_metS.do into R
readRDS(ukb, "UKB_for_ICC.rds")
ukb %>% rename(id = f.eid,
               age_assess1 = f.21003.0.0, age_assess2 = f.21003.1.0, age_assess3 = f.21003.2.0,
               bmi_1 = f.21001.0.0, bmi_2 = f.21001.1.0, bmi_3 = f.21001.2.0,
               igf_1 = f.30770.0.0, igf_2 = f.30770.1.0, sex = f.31.0.0)
