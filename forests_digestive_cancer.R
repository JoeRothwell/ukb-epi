# Forest plots for digestive cancers manuscript

library(readxl)
library(tidyverse)
t2 <- read_xlsx("digestive_cancers.xlsx", sheet = 1)
ly <- read_xlsx("digestive_cancers.xlsx", sheet = 2)
# Set row vectors from layout sheet
rowvec <- na.omit(ly$rowvec)
labs.lev1 <- na.omit(ly$labs.lev1)
labs.lev2 <- na.omit(ly$labs.lev2)
labs.lev3 <- na.omit(ly$labs.lev3)
rows.lev1 <- na.omit(ly$row.lev1)
rows.lev2 <- na.omit(ly$row.lev2)
rows.lev3 <- na.omit(ly$row.lev3)

# Colorectal cancer
par(mfrow=c(1,4))

# Plot for rownames
par(mar=c(5,0,0,1))
plot(1, type="n", axes = F, ann = F, ylim=c(0,35), xlim = c(0,10))
text(3, rows.lev1, labs.lev1, cex = 1.2, pos = 4)
text(4, rows.lev2, labs.lev2, cex = 1.2, pos = 4)
text(5, rows.lev3, labs.lev3, cex = 1.2, pos = 4)
abline(h = 33)

# Plot points with no rownames
library(metafor)
par(mar=c(5,0,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "colorectal_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", 
       psize= 1.5, cex=1.2, slab = NA, pch = 18, xlim = c(0.8, 2.5), cex.lab = 0.8, header = "Colorectal")

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "colon_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.8, 3), cex.lab = 0.8, header = "Colon")

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "rectal_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.5, 4), cex.lab = 0.8, header = "Rectal")


# Oesophageal cancer
par(mfrow=c(1,3))

# Plot for rownames
par(mar=c(5,0,0,1))
plot(1, type="n", axes = F, ann = F, ylim=c(0,32), xlim = c(0,10))
text(2, rows.lev1, labs.lev1, cex = 1.2, pos = 4)
text(4, rows.lev2, labs.lev2, cex = 1.2, pos = 4)
text(6, rows.lev3, labs.lev3, cex = 1.2, pos = 4)
abline(h = 30)

# Plot points with no rownames
library(metafor)
par(mar=c(5,0,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "oesophad_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", header = "Adenocarcinoma",
       psize= 1.5, cex=1.2, slab = NA, pch = 18, xlim = c(0.8, 5), cex.lab = 0.8)

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "oesophsq_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.8, 9), cex.lab = 0.8, header = "Squamous")


# Stomach cancer
par(mfrow=c(1,3))

# Plot for rownames
par(mar=c(5,0,0,1))
plot(1, type="n", axes = F, ann = F, ylim=c(0,32), xlim = c(0,10))
text(3, rows.lev1, labs.lev1, cex = 1.2, pos = 4)
text(4, rows.lev2, labs.lev2, cex = 1.2, pos = 4)
text(5, rows.lev3, labs.lev3, cex = 1.2, pos = 4)
abline(h = 30)
abline(h = 27)

# Plot points with no rownames
par(mar=c(5,0,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "cardstomach_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", header = "Cardia",
       psize= 1.5, cex=1.2, slab = NA, pch = 18, xlim = c(0.8, 5), cex.lab = 0.8)

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "noncardstomach_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.8, 9), cex.lab = 0.8, header = "Non-cardia")


# HCC, pancreatic, bile duct
par(mfrow=c(1,4))

# Plot for rownames
par(mar=c(5,0,0,1))
plot(1, type="n", axes = F, ann = F, ylim=c(0,32), xlim = c(0,10))
text(3, rows.lev1, labs.lev1, cex = 1.2, pos = 4)
text(4, rows.lev2, labs.lev2, cex = 1.2, pos = 4)
text(5, rows.lev3, labs.lev3, cex = 1.2, pos = 4)
abline(h = 30)
abline(h = 27)

# Plot points with no rownames
par(mar=c(5,0,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "hcc_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", header = "HCC",
       psize= 1.5, cex=1.2, slab = NA, pch = 18, xlim = c(0.8, 2.5), cex.lab = 0.8)

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "pancreas_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.8, 3), cex.lab = 0.8, header = "Pancreas")

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "ibdc_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.5, 4), cex.lab = 0.8, header = "Bile duct")


