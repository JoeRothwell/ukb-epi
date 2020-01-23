# Preliminary analysis of UKB data (data and method from Neil)
library(haven)
ukb <- read_dta("D://ukb_summanalytical2017.dta") #original data
ukb1 <- read_dta("D://ukb_cox_analyses_2017.dta") #renamed and recoded for cox model

# Data preparation for Cox model (from Neil's do file) ----

# Lifestyle variables used:
#pa_total_mets: total physical activity level (MET hr/week)
#pa_met_cats: category of total physical activity level
#colorectal_inc: incident cancers of the colon and rectum
#pa5cat: median value of total physical activity level for each category

# Time variables:
#age_exit_first: age at exit
#agebirth: 0 for all observations
#age_recr: age at recruitment
  
#saveRDS(ukb, file="D:/UKB Cox dataset.rds")
ukb <- readRDS("UKB_Cox_dataset.rds") #472526 observations

# get dropped IDs from file and filter, also drop diabetes unknown (9) cases (1956)
droppedIDs <- scan("w25897_20180503.csv")

library(tidyverse)
ukb <- ukb %>% filter(!(eID %in% droppedIDs))
ukb <- ukb %>% filter(!(eID %in% droppedIDs) & diabet != 9)
#ukb1 <- ukb1 %>% filter(!(eID %in% droppedIDs))

# assign 6 to PA category unknown
ukb$pa_met_cats[is.na(ukb$pa_met_cats)] <- 6

# list categorical variables to be converted to factors. colorectal_inc stays numeric or produces error
var.list <- c("pa_met_cats", "diabet", "qualif", "alc_freq", "ever_horm", "smoke_intensity", "redprocmeat_cat", 
              "fh_crc", "aspibu_use", "sex", "agecat", "q5town", "region", "bmi")

# remove observations missing derived pa_activity MET variable
ukb <- ukb %>% #filter(!is.na(pa_total_mets)) %>% 
  mutate_at(vars(var.list), as.factor)
      
# Check number of observations and count female (0) and male (1)
#nrow(ukb)
#ukb$sex
#table(ukb$sex) #254846 Women 217700 Men 
#ukb %>% group_by(bmi, diabet, sex) %>% summarise(n = n())

# BMI
#table(ukb1$bmi)
#table(ukb$bmi)
#2443 underweight (1), 153803 normal (2), 200917 overweight (3), 115360 obese (4)
#table(ukb$sex, ukb$bmi)
#table(ukb$sex, ukb$diabet)

# Diabetes
#table(ukb1$diabet) #0 No 1 Yes 9 Missing. 21922 cases, 1956 missing

# get median of total physical activity level for each category
pameds <- tapply(ukb$pa_total_mets, ukb$pa_met_cats, median) %>% as.numeric

# create variable pa5cat with medians from tapply above (also use modify() from purrr?)
ukb$pa5cat <- pameds[as.factor(ukb$pa_met_cats)]

# Cox proportional hazards models ----

# Create the survival object. In stata, age at exit, age at birth, age at recruitment, and CRC yes/no are used
library(survival)
survobj <- Surv(time = ukb$age_recr, time2 = ukb$age_exit_frst, event = ukb$colorectal_inc)

# Base model
fit0 <- coxph(survobj ~ pa_met_cats + height_m + alc_freq + bmi + 
                smoke_intensity + redprocmeat_cat + fh_crc + qualif + aspibu_use + ever_horm + 
                diabet + strata(sex, agecat, q5town, region), data = ukb)

# Run models. 3 observations have exit time < start time. Order roughly by significance of co-variates
# All subjects, female only, male only, normal, overweight, obese.
fit1 <- update(fit0, subset = sex == 0)
fit2 <- update(fit0, subset = sex == 1)
fit3 <- update(fit0, ~. - bmi, subset = bmi == 2)
fit4 <- update(fit0, ~. - bmi, subset = bmi == 3)
fit5 <- update(fit0, ~. - bmi, subset = bmi == 4)

library(broom)
t1 <- map_df(list(fit0, fit1, fit2, fit3, fit4, fit5), tidy) %>% filter(term == "diabet1")

library(metafor)
par(mar=c(5,4,2,2))
forest(t1$estimate, ci.lb = t1$conf.low, ci.ub = t1$conf.high,
       refline = 1, xlab = "Hazard ratio diabetic compared to non-diabetic reference", pch = 18, 
       transf = exp, psize = 1.5, 
       slab = c("All", "Female", "Male", "Normal", "Overweight", "Obese"))
hh <- par("usr")
text(hh[1], 8, "Group", pos = 4)
text(hh[2], 8, "HR [95% CI]", pos = 2)


summary(fit0)

