# Forest plots for digestive cancers manuscript
# Read data from first and layout from second sheet
library(readxl)
library(tidyverse)

# March 2021: remove diabetes and pre-diabetes
t2 <- read_xlsx("forest_data_metS.xlsx", sheet = 1) %>% filter(category != "Diabetes")
ly <- read_xlsx("forest_data_metS.xlsx", sheet = 3) %>% slice(1:22)

# Set row vectors from layout sheet
#rowvec <- na.omit(ly$rowvec)
rowvec <- rev(which(rev(ly$rowvec)))

labs.lev1 <- na.omit(ly$labs.lev1)
labs.lev2 <- na.omit(ly$labs.lev2)
labs.lev3 <- na.omit(ly$labs.lev3)

#rows.lev1 <- na.omit(ly$row.lev1)
rows.lev1 <- rev(which(rev(ly$row.lev1)))

#rows.lev2 <- na.omit(ly$row.lev2)
rows.lev2 <- rev(which(rev(ly$row.lev2)))

#rows.lev3 <- na.omit(ly$row.lev3)
rows.lev3 <- rev(which(rev(ly$row.lev3)))

# Four columns
par(mfrow=c(1,4))

# Plot for rownames
par(mar=c(5,0,0,1))
limm <- nrow(ly)
plot(1, type="n", axes = F, ann = F, ylim=c(0, limm + 2), xlim = c(0,10))
text(3, rows.lev1, labs.lev1, cex = 1.5, pos = 4, font = 1)
text(3.5, rows.lev2, labs.lev2, cex = 1.5, pos = 4)
text(4, rows.lev3, labs.lev3, cex = 1.5, pos = 4)
abline(h = limm + 1)

# Colorectal cancer: plot points with no rownames
library(metafor)
par(mar=c(5,0,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "colorectal_inc" & t2$analysis == "normal",
       refline=1, efac = 0, rows = rowvec, ylim=c(0, limm + 2), 
       xlab="HR (95% CI)", annosym = c(" (", ", ", ")"),
       psize= 1.5, cex=1.5, top = 2,
       slab = NA, pch = 18, xlim = c(1, 2.5), cex.lab = 1, 
       header = c("Colorectal cancer", ""))

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "colon_inc" & t2$analysis == "normal",
       refline=1, efac = 0, rows = rowvec, ylim=c(0, limm + 2), xlab="HR (95% CI)", 
       psize= 1.5, cex=1.5, 
       slab = NA, pch = 18, xlim = c(0.8, 3), cex.lab = 1, top = 2,
       annosym = c(" (", ", ", ")"),
       header = c("Colon cancer", ""))

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "rectal_inc" & t2$analysis == "normal",
       refline=1, efac = 0, rows = rowvec, ylim=c(0, limm + 2), xlab="HR (95% CI)", 
       psize= 1.5, cex=1.5, 
       slab = NA, pch = 18, xlim = c(0.5, 4), cex.lab = 1, top = 2,
       annosym = c(" (", ", ", ")"),
       header = c("Rectal cancer", ""))

# Now export to pdf with a width of 11 inches and crop in Word


# Oesophageal and stomach cancer
par(mfrow=c(1,5))

# Plot for rownames
par(mar=c(5,0,0,1))
plot(1, type="n", axes = F, ann = F, ylim=c(0, limm + 3), xlim = c(0,10))
text(2, rows.lev1, labs.lev1, cex = 1.5, pos = 4, font = 1)
text(3, rows.lev2, labs.lev2, cex = 1.5, pos = 4)
text(4, rows.lev3, labs.lev3, cex = 1.5, pos = 4)
abline(h = limm + 1)

# Plot points with no rownames
library(metafor)
par(mar=c(5,0,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "oesophad_inc" & t2$analysis == "normal",
       refline=1, efac = c(0, 0.5), rows = rowvec, ylim=c(0, limm + 3), 
       xlab="HR (95% CI)", 
       header = c("adenocarcinoma", ""), annosym = c(" (", ", ", ")"),
       psize= 1.5, cex=1.5, slab = NA, pch = 18, xlim = c(0.8, 6), alim = c(0, 3),
       cex.lab = 1)
text(0, limm + 3, "Oesophageal", pos = 4, font = 2, cex = 1.5)

# efac in combination with alim gives arrow 
par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "oesophsq_inc" & t2$analysis == "normal",
       refline=1, efac = c(0, 0.5), rows = rowvec, ylim=c(0, limm + 3), xlab="HR (95% CI)", 
       psize= 1.5, cex=1.5, annosym = c(" (", ", ", ")"),
       slab = NA, pch = 18, xlim = c(0.8, 8), alim = c(0, 3),
       cex.lab = 1, header = c("squamous", ""))
par("usr")
text(0, limm + 3, "Oesophageal", pos = 4, font = 2, cex = 1.5)

# Stomach cardia
par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "cardstomach_inc" & t2$analysis == "normal",
       refline=1, efac = c(0, 0.5), rows = rowvec, ylim=c(0, limm + 3), xlab="HR (95% CI)", 
       header = c("Stomach cardia", ""), annosym = c(" (", ", ", ")"),
       psize= 1.5, cex=1.5, slab = NA, pch = 18, xlim = c(0.8, 10),  alim = c(0,4),
       cex.lab = 1)

#rowvec <- rowvec.reset
par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "noncardstomach_inc" & t2$analysis == "normal",
       refline=1, efac = c(0, 0.5), rows = rowvec, ylim=c(0, limm + 3), xlab="HR (95% CI)", 
       psize = 1.5, cex=1.5,
       slab = NA, pch = 18, xlim = c(0.8, 11), alim = c(0,4),
       annosym = c(" (", ", ", ")"),
       cex.lab = 1, header = c("Stomach non-cardia", ""))

# Save as a pdf, portrait, 11.5 x 7 in


# HCC, pancreatic, IBDC
par(mfrow=c(1,4))

# Plot for rownames
par(mar=c(5,0,0,1))
plot(1, type="n", axes = F, ann = F, ylim=c(0, limm + 2), xlim = c(0,10))
text(3, rows.lev1, labs.lev1, cex = 1.5, pos = 4, font = 1)
text(3.5, rows.lev2, labs.lev2, cex = 1.5, pos = 4)
text(4, rows.lev3, labs.lev3, cex = 1.5, pos = 4)
abline(h = limm + 1)

# Plot points with no rownames
par(mar=c(5,0,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "pancreas_inc" & t2$analysis == "normal",
       refline=1, efac = 0, rows = rowvec, ylim=c(0, limm + 2), xlab="HR (95% CI)", psize= 1.5, cex=1.5, 
       slab = NA, pch = 18, xlim = c(0.8, 6), alim = c(0,4), top = 2,
       annosym = c(" (", ", ", ")"),
       cex.lab = 1, header = c("Pancreatic cancer", ""))

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "hcc_inc" & t2$analysis == "normal",
       refline=1, efac = c(0, 0.5), rows = rowvec, ylim=c(0, limm + 2), xlab="HR (95% CI)", 
       header = c("Hepatocellular carcinoma",""), top = 2,
       annosym = c(" (", ", ", ")"),
       psize= 1.5, cex=1.5, slab = NA, pch = 18, xlim = c(0.8, 16), alim = c(0,8),
       cex.lab = 1)

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "ibdc_inc" & t2$analysis == "normal",
       refline=1, efac = 0, rows = rowvec, ylim=c(0, limm + 2), xlab="HR (95% CI)", 
       psize= 1.5, cex=1.5, 
       slab = NA, pch = 18, xlim = c(0.5, 12), cex.lab = 1, top = 2,
       annosym = c(" (", ", ", ")"),
       header = c("Bile duct cancer", ""))


# Save 11 x 10


# All digestive
par(mar=c(5,4,0,1), mgp = c(2,0.5,0))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "digestive_inc" & t2$analysis == "normal",
       refline=1, efac = c(0, 1), rows = rowvec-1, ylim=c(0, limm + 1), xlab="HR (95% CI)", 
       header = c("All digestive cancers", "HR (95% CI)"), 
       top = 2, annosym = c(" (", ", ", ")"),
       psize= 1.5, slab = NA, pch = 18, xlim = c(0, 2.3))

text(0, rows.lev1-1, labs.lev1, pos = 4, font = 1)
text(0.1, rows.lev2-1, labs.lev2, pos = 4)
text(0.2, rows.lev3-1, labs.lev3, pos = 4)

# Save at 7x5 inches
