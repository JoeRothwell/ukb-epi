# ICCs in UKB
library(tidyverse)
# Test with BMI. Variables needed: eID, sex, age_assess, 
UKBss <- UKB_final %>% select(f.eid, f.21003.0.0, f.21003.1.0, f.21003.1.0, f.30770.0.0, f.30770.1.0, 
                              f.21001.0.0, f.21001.1.0, f.21001.2.0)

saveRDS(UKBss, file = "UKB_for_ICC.rds")
