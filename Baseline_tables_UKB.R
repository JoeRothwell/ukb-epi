# Baseline characteristics tables for UKB

library(haven)
library(tidyverse)
library(qwraps2)
options(qwraps2_markup = "markdown")


# For metS paper
dat <- read_dta("ukb_metS_table_med.dta")
dat <- dat %>% select(-id) %>% 
  mutate_at(vars(digestive_inc, ever_horm, alc_stat, smoke_stat, sex, q4_depr, fh_crc, 
                 metS_harm, med_aspib), as.factor) %>%
  select(digestive_inc, age_assess, sex, bmi_m, waist_c, height_m, pa_total_mets, 
         smoke_stat, alc_stat, q4_depr, dpr_index, fh_crc, med_aspib, redprocmeat, 
         bp_systolic, bp_diastolic, hba1c, hdl, tryg, metS_harm, PRS_crc, PRS_pan)

# Generate table automatically
sumtab <- qsummary(dat, numeric_summaries = list("Mean (SD)" = "~ mean_sd(%s)"),
          n_perc_args = list(digits = 1, show_symbol = T))

summary_table(group_by(dat, metS_harm), sumtab)

lapply(dat, class)


# For appendectomy paper
dat <- read_dta("ukb_append_table1_jan.dta")
dat <- dat %>% select(-id) %>% 
  mutate_at(vars(colorectal_inc, alc_stat, smoke_stat, sex, bmi_cat, pa_met_cat, 
                 appendic, appendic_y, appendic_o, education_cat), as.factor) %>%
  #mutate_at(fct_collapse(pa_met_cat, 5 = c("1","2","3"))) %>%
  select(age_assess, appendic, appendic_y, appendic_o, sex, bmi_cat, height_m, smoke_stat, 
         pa_met_cat, education_cat)

# Collapse PA categories to get <10, 10-60, >60 Meth/week (low, medium, high)
dat$pa_met_cat <- fct_collapse(dat$pa_met_cat, A = c("1","2","3"))

# Generate automatic summary
sumtab <- qsummary(dat, numeric_summaries = list("Mean (SD)" = "~ mean_sd(%s)"),
                   n_perc_args = list(digits = 1, show_symbol = T))

# Make grouped summary table
dat %>% group_by(fct_rev(appendic)) %>% summary_table(sumtab)


# For amino acids paper. Read data and convert where necessary to factor
dat <- read_dta("ukb_aminoacid_table2.dta") %>% select(-id) %>% 
  mutate_at(vars(colorectal_inc, alc_stat, smoke_stat, sex, oc_ever, pa_met_cat,
               education_cat), as.factor)

# Collapse PA 2 and 3 to get "moderately inactive" (low, low medium, high medium, high)
# UK Biobank categories were:
dat$pa_met_cat <- fct_collapse(dat$pa_met_cat, A = c("2","3"))

# Check classes
lapply(dat, class)

# Generate automatic summary
sumtab <- qsummary(dat, numeric_summaries = list("Mean (SD)" = "~ mean_sd(%s)"),
                   n_perc_args = list(digits = 1, show_symbol = T))

# Make grouped summary table
dat %>% summary_table(sumtab)


