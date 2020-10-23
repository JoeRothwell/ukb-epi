library(haven)
library(tidyverse)
library(qwraps2)
options(qwraps2_markup = "markdown")

dat <- read_dta("ukb_metS_table1.dta")
dat <- dat %>% select(-id) %>% 
  mutate_at(vars(digestive_inc, diabet, ever_horm, alc_stat, smoke_stat, sex, diabet, q4_depr, fh_crc, metS_harm, 
                 med_aspib, pre_diabet), as.factor) %>%
  select(digestive_inc, age_assess, sex, bmi_m, waist_c, height_m, pa_total_mets, smoke_stat, alc_stat, q4_depr, dpr_index,
         fh_crc, med_aspib, redprocmeat, bp_systolic, bp_diastolic, hba1c, hdl, tryg, metS_harm)

# Generate table automatically
sumtab <- qsummary(dat, numeric_summaries = list("Mean (SD)" = "~ mean_sd(%s)"),
          n_perc_args = list(digits = 1, show_symbol = T))

summary_table(group_by(dat, metS_harm), sumtab)

lapply(dat, class)




