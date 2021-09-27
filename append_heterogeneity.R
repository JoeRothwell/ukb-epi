# Heterogeneity tests for CRC-appendectomy project

library(tidyverse)
library(readxl)
library(broom)

### Meta-analysis of 3 cohorts: CRC and appendectomy (Y/N)
t2 <- read_xlsx("CRC-appendectomy meta-analysis.xlsx") %>% 
  arrange(fct_inorder(subsite), fct_inorder(group), fct_inorder(cohort)) %>% 
  mutate(std.err = ((ci.upper-ci.lower)/2)/qnorm(0.975))


# Perform meta-analyses on groups with nest
library(metafor)
mas <- t2 %>% group_by(subsite, group) %>% nest() %>% 
  mutate(mods = lapply(data, function(df) rma(hr, sei = std.err, data=df, method="REML")))
ll1 <- mas$mods


# Heterogeneity tests for sex, age, colon vs rectal, proximal vs distal
# Appendectomy Y/N
results1 <- map_df(ll1, tidy)

# Hetergeneity by sex
crc <- rma(yi = estimate, sei = std.error, dat = results1, #method="FE", 
           subset = 2:3)
col <- rma(yi = estimate, sei = std.error, dat = results1, #method="FE", 
           subset = 5:6)
prox <- rma(yi = estimate, sei = std.error, dat = results1, #method="FE", 
            subset = 8:9)
dist <- rma(yi = estimate, sei = std.error, dat = results1, #method="FE", 
            subset = 11:12)
rect <- rma(yi = estimate, sei = std.error, dat = results1, #method="FE", 
            subset = 14:15)

# Colon vs rectal, prox vs distal
colrec <- rma(yi = estimate, sei = std.error, dat = results1, #method="FE", 
              subset = c(4,13))
proxdist <- rma(yi = estimate, sei = std.error, dat = results1, #method="FE", 
                subset = c(7,10))
proxdistrec <- rma(yi = estimate, sei = std.error, dat = results1, #method="FE", 
                   subset = c(7,10,13))

# Age at appendectomy
t4 <- read_xlsx("CRC-appendectomy meta-analysis.xlsx", sheet = 3) %>% 
  arrange(fct_inorder(subsite), fct_inorder(group), fct_inorder(cohort)) %>% 
  mutate(std.err = ((ci.upper-ci.lower)/2)/qnorm(0.975))

# Perform meta-analyses (only 13 due to non-estimable men in EPIC)
mas <- t4 %>% group_by(subsite, group) %>% nest() %>% 
  mutate(mods = lapply(data, function(df) rma(hr, sei = std.err, data=df, method="REML")))
ll2 <- mas$mods

# Young vs old categories
results3 <- map_df(ll2, tidy)
crc1 <- rma(yi = estimate, sei = std.error, dat = results3, #method="FE", 
            subset = 1:2)
col1 <- rma(yi = estimate, sei = std.error, dat = results3, #method="FE", 
            subset = 3:4)
prox1 <- rma(yi = estimate, sei = std.error, dat = results3, #method="FE", 
             subset = 5:6)
dist1 <- rma(yi = estimate, sei = std.error, dat = results3, #method="FE", 
             subset = 7:8)
rect1 <- rma(yi = estimate, sei = std.error, dat = results3, #method="FE", 
             subset = 9:10)

malist <- list(crc, col, prox, dist, rect, colrec, proxdist, proxdistrec, 
               crc1, col1, prox1, dist1, rect1)

output <- lapply(malist, "[", c("QEp", "I2"))
phets <- do.call(rbind, output)

het.test <- c("Sex CRC", "Sex Colon", "Sex prox", "Sex dist", "Sex rectal", 
              "Col vs Rec", "Prox vs Dist", "Prox vs Dist vs Rec",
              "Age CRC", "Age Colon", "Age prox", "Age dist", "Age rectal")

phets1 <- cbind(het.test, phets)

# Copy and paste output into appendectomy summary excel sheet
# Note, only I2 for col vs rec and prox vs dist change if using FE instead of REL