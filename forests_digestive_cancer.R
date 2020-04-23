# Forest plots for digestive cancers manuscript

library(readxl)
library(tidyverse)
t2 <- read_xlsx("digestive_cancers.xlsx")
# Set row order for groupings. First calculate no rows needed, then start from highest number
# There are 6 groups of 3. 21 lines + 6 gaps = 27
rowvec <- c(26:24, 22:20, c(18,14,10), c(17,13,9), c(16,12,8), 6:1) - 1
labs.lev1 <- c("MetS components", "MetS, male", "MetS, female", "MetS, all", "Pre-diabetes", "Diabetes")
labs.lev2 <- c("High tryglycerides", "High blood pressure", "High Hb1Ac", "Low HDL", "Obesity (NCEP)", 
               "Obesity, harmonised", "IDF 2005", "NCEP", "Harmonised", "IDF 2005", "NCEP", "Harmonised",
               "IDF 2005", "NCEP", "Harmonised", "Male", "Female", "All", "Male", "Female", "All")

# Colorectal cancer
par(mfrow=c(1,4))

# Plot for rownames
par(mar=c(5,0,0,1))
plot(1, type="n", axes = F, ann = F, ylim=c(0,29), xlim = c(1,1.25))
text(1.03, c(6,10,14,18,22,26), labs.lev1, cex = 1.2, pos = 4)
text(1.08, c(0:5,7:9,11:13,15:17,19:21,23:25), labs.lev2, cex = 1.2, pos = 4)
abline(h = 27)

# Plot points with no rownames
library(metafor)
par(mar=c(5,0,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "colorectal_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,29), xlab="HR [95% CI]", 
       psize= 1.5, cex=1.2, slab = NA, pch = 18, xlim = c(0.8, 2.5), cex.lab = 0.8)

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "colon_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,29), xlab="HR [95% CI]", psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.8, 3), cex.lab = 0.8)

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "rectal_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,29), xlab="HR [95% CI]", psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.5, 4), cex.lab = 0.8)


# Oesophageal cancer
par(mfrow=c(1,3))

# Plot for rownames
par(mar=c(5,0,0,1))
plot(1, type="n", axes = F, ann = F, ylim=c(0,29), xlim = c(1,1.25))
text(1.03, c(6,10,14,18,22,26), labs.lev1, cex = 1.2, pos = 4)
text(1.08, c(0:5,7:9,11:13,15:17,19:21,23:25), labs.lev2, cex = 1.2, pos = 4)
abline(h = 27)

# Plot points with no rownames
library(metafor)
par(mar=c(5,0,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "oesophad_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,29), xlab="HR [95% CI]", 
       psize= 1.5, cex=1.2, slab = NA, pch = 18, xlim = c(0.8, 5), cex.lab = 0.8)

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "oesophsq_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,29), xlab="HR [95% CI]", psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.8, 9), cex.lab = 0.8)


# Stomach cancer
par(mfrow=c(1,3))

# Plot for rownames
par(mar=c(5,0,0,1))
plot(1, type="n", axes = F, ann = F, ylim=c(0,29), xlim = c(1,1.25))
text(1.03, c(6,10,14,18,22,26), c("MetS Components", "MetS", "MetS, female", "MetS, male", 
                                  "Pre-diabetes", "Diabetes"), cex = 1.2, pos = 4)
abline(h = 27)

# Plot points with no rownames
library(metafor)
par(mar=c(5,0,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "cardstomach_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,29), xlab="HR [95% CI]", 
       psize= 1.5, cex=1.2, slab = NA, pch = 18, xlim = c(0.8, 5), cex.lab = 0.8)

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "noncardstomach_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,29), xlab="HR [95% CI]", psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.8, 9), cex.lab = 0.8)


# HCC, pancreatic, bile duct
par(mfrow=c(1,4))

# Plot for rownames
par(mar=c(5,0,0,1))
plot(1, type="n", axes = F, ann = F, ylim=c(0,29), xlim = c(1,1.25))
text(1.03, c(6,10,14,18,22,26), c("MetS Components", "MetS", "MetS, female", "MetS, male", 
                                  "Pre-diabetes", "Diabetes"), cex = 1.2, pos = 4)
abline(h = 27)

# Plot points with no rownames
library(metafor)
par(mar=c(5,0,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "hcc_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,29), xlab="HR [95% CI]", 
       psize= 1.5, cex=1.2, slab = NA, pch = 18, xlim = c(0.8, 2.5), cex.lab = 0.8)

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "pancreas_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,29), xlab="HR [95% CI]", psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.8, 3), cex.lab = 0.8)

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "ibdc_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,29), xlab="HR [95% CI]", psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.5, 4), cex.lab = 0.8)


