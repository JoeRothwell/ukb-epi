# Forest plots for digestive cancers manuscript
# Read data from first and layout from second sheet
library(readxl)
library(tidyverse)

# March 2021: remove diabetes and pre-diabetes
t2 <- read_xlsx("forest_data_metS.xlsx", sheet = 3) %>% filter(included == TRUE)
ly <- read_xlsx("forest_data_metS.xlsx", sheet = 4) %>% filter(inclusion1 == TRUE)

# Layout for oesophageus and stomach only, no women:
ly1 <- read_xlsx("forest_data_metS.xlsx", sheet = 4) %>% filter(inclusion2 == TRUE)

# Set row vectors from layout sheet
rowvec <- rev(which(rev(ly$rowvec)))
labs.lev1 <- na.omit(ly$labs.lev1)
labs.lev2 <- na.omit(ly$labs.lev2)
labs.lev3 <- na.omit(ly$labs.lev3)
rows.lev1 <- rev(which(rev(ly$row.lev1)))
rows.lev2 <- rev(which(rev(ly$row.lev2)))
rows.lev3 <- rev(which(rev(ly$row.lev3)))

jpeg("Figure2.jpg", units="in", width=11.5, height=6, res=300)

# Four columns
par(mfrow=c(1,4))

# Plot for rownames
par(mar=c(5,0,0,1))
limm <- nrow(ly)
plot(1, type="n", axes = F, ann = F, ylim=c(0, limm + 2), xlim = c(0, 10))
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
       xlab="HR (95% CI)", 
       annosym = c(" (", "-", ")"),
       psize= 1.6, cex=1.5, top = 2,
       slab = NA, pch = 18, xlim = c(1, 2.2), 
       cex.lab = 1, cex.axis = 1.2,
       header = c("Colorectal cancer", ""))
# Number of cases
text(2.2, c(4,8, limm), c("n = 1,448 cases", "n = 1,007 cases", "n = 2,525 cases"), 
     cex = 1.5, pos = 2)

# Colon cancer
par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "colon_inc" & t2$analysis == "normal",
       refline=1, efac = 0, rows = rowvec, ylim=c(0, limm + 2), xlab="HR (95% CI)", 
       psize= 1.6, cex=1.5, cex.axis = 1.2,
       slab = NA, pch = 18, xlim = c(0.8, 2.5), 
       cex.lab = 1, top = 2,
       annosym = c(" (", "-", ")"),
       header = c("Colon cancer", ""))

text(2.5, c(4,8, limm), c("n = 884 cases", "n = 786 cases", "n = 1,670 cases"), cex = 1.5, pos = 2)

# Rectal cancer
par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "rectal_inc" & t2$analysis == "normal",
       refline=1, efac = 0, rows = rowvec, ylim=c(0, limm + 2), xlab="HR (95% CI)", 
       psize= 1.6, cex=1.5, 
       slab = NA, pch = 18, xlim = c(0.5, 2.6), 
       cex.lab = 1, top = 2, cex.axis = 1.2,
       annosym = c(" (", "-", ")"),
       header = c("Rectal cancer", ""))

text(2.6, c(4,8, limm), c("n = 564 cases", "n = 291 cases", "n = 855 cases"), cex = 1.5, pos = 2)
dev.off()
# Now export to pdf with a width of 11x6 inches and crop in Word

jpeg("Figure3.jpg", units="in", width=11.5, height=5.5, res=300)
# Oesophageal and stomach cancer. Use layout with inclusion2 == T
limm1 <- nrow(ly1)
rowvec <- rev(which(rev(ly1$rowvec)))
labs.lev1 <- na.omit(ly1$labs.lev1)
labs.lev2 <- na.omit(ly1$labs.lev2)
labs.lev3 <- na.omit(ly1$labs.lev3)
rows.lev1 <- rev(which(rev(ly1$row.lev1)))
rows.lev2 <- rev(which(rev(ly1$row.lev2)))
rows.lev3 <- rev(which(rev(ly1$row.lev3)))

# Plot for rownames. Rerun rows.lev1-3
par(mfrow=c(1,5))
par(mar=c(5,0,0,1))
plot(1, type="n", axes = F, ann = F, ylim=c(0, limm1 + 3), xlim = c(0,10))
text(2, rows.lev1, labs.lev1, cex = 1.5, pos = 4, font = 1)
text(3, rows.lev2, labs.lev2, cex = 1.5, pos = 4)
text(4, rows.lev3, labs.lev3, cex = 1.5, pos = 4)
abline(h = limm1 + 1)

# Plot points with no rownames. Need to adjust rowvec for omitted values
rowvec1 <- rev(which(rev(ly1$rowvec1)))
library(metafor)
par(mar=c(5,0,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "oesophad_inc" & t2$analysis == "normal",
       refline=1, efac = c(0, 0.5), rows = rowvec1, ylim=c(0, limm1 + 3), 
       xlab="HR (95% CI)", cex.axis = 1.2,
       header = c("adenocarcinoma", ""), 
       annosym = c(" (", "-", ")"),
       psize= 1.6, cex=1.5, slab = NA, pch = 18, xlim = c(0.8, 5.5), #alim = c(0, 3),
       cex.lab = 1)
text(0.5, limm1 + 3, "Esophageal", pos = 4, font = 2, cex = 1.5)
text(5.5, c(4, limm1), c("n = 248 cases", "n = 290 cases"), cex = 1.5, pos = 2)


# efac in combination with alim gives arrow 
rowvec2 <- rev(which(rev(ly1$rowvec2)))
par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "oesophsq_inc" & t2$analysis == "normal",
       refline = 1, efac = c(0, 0.5), 
       rows = rowvec2, ylim=c(0, limm1 + 3), 
       xlab="HR (95% CI)", psize= 1.6, cex=1.5, 
       annosym = c(" (", "-", ")"),
       slab = NA, pch = 18, xlim = c(0.8, 4), #alim = c(0, 3),
       cex.axis = 1.2,
       cex.lab = 1, header = c("cell carcinoma", ""))
par("usr")
text(0.2, limm1 + 3, "Esophageal squamous", pos = 4, font = 2, cex = 1.5)
text(4, limm1, "n = 100 cases", cex = 1.5, pos = 2)

# Stomach cardia
par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "cardstomach_inc" & t2$analysis == "normal",
       refline=1, efac = c(0, 0.5), rows = rowvec2, ylim=c(0, limm1 + 3), xlab="HR (95% CI)", 
       header = c("(Cardia)", ""), annosym = c(" (", "-", ")"), cex.axis = 1.2,
       psize= 1.6, cex=1.5, slab = NA, pch = 18, xlim = c(0.8, 6),  #alim = c(0,3),
       cex.lab = 1)
par("usr")
text(0.5, limm1 + 3, "Stomach cancer", pos = 4, font = 2, cex = 1.5)
text(6, limm1, "n = 111 cases", cex = 1.5, pos = 2)

#rowvec <- rowvec.reset
par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "noncardstomach_inc" & t2$analysis == "normal",
       refline=1, efac = c(0, 0.5), rows = rowvec2, ylim=c(0, limm1 + 3), 
       xlab="HR (95% CI)", psize = 1.6, cex=1.5,
       slab = NA, pch = 18, xlim = c(0.8, 7), #alim = c(0,3),
       annosym = c(" (", "-", ")"), 
       cex.axis = 1.2,
       cex.lab = 1, header = c("(Non-cardia)", ""))
par("usr")
text(0.5, limm1 + 3, "Stomach cancer", pos = 4, font = 2, cex = 1.5)
text(7, limm1, "n = 74 cases", cex = 1.5, pos = 2)

# Save as a pdf, portrait, 11.5 x 5.5 in
dev.off()

jpeg("Figure4.jpg", units="in", width=11.5, height=6, res=300)
# HCC, pancreatic, IBDC
par(mfrow=c(1,4))

# Plot for rownames
par(mar=c(5,0,0,1))
plot(1, type="n", axes = F, ann = F, ylim=c(0, limm + 2), xlim = c(0, 10))
text(3, rows.lev1-1, labs.lev1, cex = 1.5, pos = 4, font = 1)
text(3.5, rows.lev2-1, labs.lev2, cex = 1.5, pos = 4)
text(4, rows.lev3-1, labs.lev3, cex = 1.5, pos = 4)
abline(h = limm)

# Plot points with no rownames
par(mar=c(5,0,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "pancreas_inc" & t2$analysis == "normal",
       refline=1, efac = 0, rows = rowvec-1, ylim=c(0, limm + 2), xlab="HR (95% CI)", 
       psize= 1.6, cex=1.5, #top = 2, 
       slab = NA, pch = 18, xlim = c(0.8, 4.5), #alim = c(0, 2.5), 
       annosym = c(" (", "-", ")"), 
       cex.axis = 1.2,
       cex.lab = 1, header = c("Pancreatic cancer", ""))
text(4.5, c(3, 7, limm-1), c("n = 265 cases", "n = 213 cases", "n = 478 cases"), cex = 1.5, pos = 2)

rowvec2 <- rev(which(rev(ly$rowvec2)))
par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "hcc_inc" & t2$analysis == "normal",
       refline=1, efac = c(0, 0.5), rows = rowvec2-1, ylim=c(0, limm + 2), xlab="HR (95% CI)", 
       header = c("carcinoma",""), #top = 2,
       annosym = c(" (", "-", ")"), 
       cex.axis = 1.2,
       psize = 1.6, cex = 1.5, slab = NA, pch = 18, xlim = c(0.8, 7.5), #alim = c(0,4),
       cex.lab = 1)
text(0, limm + 2, "Hepatocellular", pos = 4, font = 2, cex = 1.5)
text(7.5, limm-1, "n = 112 cases", cex = 1.5, pos = 2)

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "ibdc_inc" & t2$analysis == "normal",
       refline=1, efac = 0, rows = rowvec2-1, ylim=c(0, limm + 2), xlab="HR (95% CI)", 
       psize= 1.6, cex=1.5, cex.axis = 1.2,
       slab = NA, pch = 18, xlim = c(0.5, 5.5), cex.lab = 1, #top = 2,
       annosym = c(" (", "-", ")"),
       header = c("bile duct cancer", ""))
text(0.5, limm + 2, "Intrahepatic", pos = 4, font = 2, cex = 1.5)
text(5.5, limm - 1, "n = 108 cases", cex = 1.5, pos = 2)


# Save 11 x 6
dev.off()

# All GI cancers. mgp increases space between axis and ticks
tiff("Figure1a.tiff", units="in", width=4, height=5, res=300)

par(mar=c(3,4,0,1), mgp = c(2,0.5,0))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "digestive_inc" & t2$analysis == "normal",
       refline=1, efac = c(0, 1), rows = rowvec-1, 
       ylim=c(0, limm + 1), xlab="HR (95% CI)", 
       header = c("All Gastrointestinal Cancers", "HR (95% CI)"), 
       top = 2, 
       annosym = c(" (", "-", ")"), 
       alim = c(0.8, 1.6),
       psize= 1.6, slab = NA, pch = 18, xlim = c(0, 2.3))

text(0, rows.lev1-1, labs.lev1, pos = 4, font = 1)
text(0.1, rows.lev2-1, labs.lev2, pos = 4)
text(0.2, rows.lev3-1, labs.lev3, pos = 4)
text(2.3, c(3,7, limm-1), c("n = 2,523 cases", "n = 1,715 cases", "n = 4,238 cases"), pos = 2)
# Save at 5x6 inches

dev.off()

