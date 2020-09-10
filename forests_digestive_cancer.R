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
text(3, rows.lev1, labs.lev1, cex = 1.2, pos = 4, font = 2)
text(3.5, rows.lev2, labs.lev2, cex = 1.2, pos = 4)
text(4, rows.lev3, labs.lev3, cex = 1.2, pos = 4)
abline(h = 33)

# Plot points with no rownames
library(metafor)
par(mar=c(5,0,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "colorectal_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", 
       psize= 1.5, cex=1.2, slab = NA, pch = 18, xlim = c(1, 2.5), cex.lab = 0.8, 
       header = c("Colorectal cancer", ""))

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "colon_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.8, 3), cex.lab = 0.8, 
       header = c("Colon cancer", ""))

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "rectal_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.5, 4), cex.lab = 0.8, 
       header = c("Rectal cancer", ""))


# Oesophageal and stomach cancer
par(mfrow=c(1,5))

# Plot for rownames
par(mar=c(5,0,0,1))
plot(1, type="n", axes = F, ann = F, ylim=c(0,35), xlim = c(0,10))
text(2, rows.lev1, labs.lev1, cex = 1.2, pos = 4, font = 2)
text(3, rows.lev2, labs.lev2, cex = 1.2, pos = 4)
text(4, rows.lev3, labs.lev3, cex = 1.2, pos = 4)
abline(h = 33)

# Plot points with no rownames
library(metafor)
par(mar=c(5,0,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "oesophad_inc",
       refline=1, efac = c(0, 0.7), rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", 
       header = c("adenocarcinoma", ""),
       psize= 1.5, cex=1.2, slab = NA, pch = 18, xlim = c(0.8, 6), alim = c(0, 3),
       cex.lab = 0.8)
text(0, 35, "Oesophageal", pos = 4, font = 2, cex = 1.2)

# efac in combination with alim gives arrow 
par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "oesophsq_inc",
       refline=1, efac = c(0, 0.7), rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", 
       psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.8, 8), alim = c(0, 3),
       cex.lab = 0.8, header = c("squamous", ""))
par("usr")
text(0, 35, "Oesophageal", pos = 4, font = 2, cex = 1.2)

#rowvec.reset <- rowvec
#rowvec[20] <- NA
par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "cardstomach_inc",
       refline=1, efac = c(0, 0.7), rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", 
       header = c("Stomach cardia", ""),
       psize= 1.5, cex=1.2, slab = NA, pch = 18, xlim = c(0.8, 10),  alim = c(0,4),
       cex.lab = 0.8)

#rowvec <- rowvec.reset
par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "noncardstomach_inc",
       refline=1, efac = c(0, 0.7), rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.8, 11), alim = c(0,4),
       cex.lab = 0.8, header = c("Stomach non-cardia", ""))

# Save as a pdf, portrait, 10 x 7.35 in


# HCC, pancreatic, bile duct
par(mfrow=c(1,4))

# Plot for rownames
par(mar=c(5,0,0,1))
plot(1, type="n", axes = F, ann = F, ylim=c(0,35), xlim = c(0,10))
text(3, rows.lev1, labs.lev1, cex = 1.2, pos = 4, font = 2)
text(3.5, rows.lev2, labs.lev2, cex = 1.2, pos = 4)
text(4, rows.lev3, labs.lev3, cex = 1.2, pos = 4)
abline(h = 33)

# Plot points with no rownames
par(mar=c(5,0,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "hcc_inc",
       refline=1, efac = c(0, 0.7), rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", 
       header = c("Hepatocellular carcinoma",""),
       psize= 1.5, cex=1.2, slab = NA, pch = 18, xlim = c(0.8, 16), alim = c(0,8),
       cex.lab = 0.8)

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "pancreas_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.8, 6), alim = c(0,4),
       cex.lab = 0.8, header = c("Pancreatic cancer", ""))

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "ibdc_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", psize= 1.5, cex=1.2, 
       slab = NA, pch = 18, xlim = c(0.5, 12), cex.lab = 0.8, 
       header = c("Bile duct cancer", ""))


# All digestive
par(mfrow=c(1,2), mgp = c(2,0.5,0))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "digestive_inc",
       refline=1, efac = c(0, 1), rows = rowvec, ylim=c(0,35), xlab="HR [95% CI]", 
       header = c("All digestive cancers", "HR [95% CI]"),
       psize= 1.5, cex=0.8, slab = NA,
       pch = 18, xlim = c(0, 2.3), 
       #alim = c(0,7),
       cex.lab = 0.8)

text(0, rows.lev1, labs.lev1, cex = 0.8, pos = 4, font = 2)
text(0.1, rows.lev2, labs.lev2, cex = 0.8, pos = 4)
text(0.2, rows.lev3, labs.lev3, cex = 0.8, pos = 4)
