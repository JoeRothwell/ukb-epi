# Graphical abstract for CGH submission: MetS

#estimate <- c(0.62, 0.51, 0.93)
#conf.low <- c(0.50, 0.29, 0.86)
#conf.high <- c(0.78, 0.90, 1)

#labs <- c("      Endogenous metabolites", 
#          "      Fatty acids", 
#          "      WCRF/AICR score")


library(readxl)
library(tidyverse)
library(metafor)
t2 <- read_xlsx("forest_data_metS.xlsx", sheet = 3) %>% filter(included == TRUE)


# Gastrointestinal cancers. No text, just data points
par(mar=c(3,4,0,2), mgp = c(2,0.5,0))
library(metafor)
forest(t2$estimate, ci.lb = t2$ci.low, ci.ub = t2$ci.high, refline = 1, 
       efac = c(0,0), psize = 1.3,
       subset = 126:118, # MetS (all) and components only
       rows = rev(c(1:6,8:10)), 
       #ylim = c(0,6), alim = c(0.2, 1.2),
       xlim = c(0.95, 1.7),
       #steps = 6,
       slab = NA,
       header = F,
       top = 0,
       xlab = NA, annosym = c(" (", "-", ")"),
       pch = 23, bg = "dodgerblue")

#text(-0.54, c(3,6), c("Metabolic signature of WCRF/AICR score", "Questionnaire-based assessment"), pos=4)

# Save as pdf at 4.44x30.2 in to go into graphical abstract