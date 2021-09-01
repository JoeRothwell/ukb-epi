# Forest plots oesophageal and stomach cancers (slightly different layout to others)
# Read data from first and layout from second sheet
library(readxl)
library(tidyverse)

# March 2021: remove diabetes and pre-diabetes
t2 <- read_xlsx("forest_data_metS.xlsx", sheet = 3) %>% filter(included == TRUE)
ly1 <- read_xlsx("forest_data_metS.xlsx", sheet = 4) %>% filter(inclusion2 == TRUE)

#jpeg("Figure3.jpg", units="in", width=11.5, height=5.5, res=300)
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
