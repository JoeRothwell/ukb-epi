# Forest plots for digestive cancers manuscript
# Read data from first and layout from second sheet
library(readxl)
library(tidyverse)

# March 2021: remove diabetes and pre-diabetes
t2 <- read_xlsx("forest_crc_wcrf.xlsx", sheet = 2) %>% filter(included == TRUE)
ly <- read_xlsx("forest_crc_wcrf.xlsx", sheet = 3) #%>% filter(inclusion1 == TRUE)

# Layout for oesophageus and stomach only, no women:
#ly1 <- read_xlsx("forest_data_metS.xlsx", sheet = 2) %>% filter(inclusion2 == TRUE)

# Set row vectors from layout sheet
rowvec <- rev(which(rev(ly$rowvec)))
labs.lev1 <- na.omit(ly$labs.lev1)
labs.lev2 <- na.omit(ly$labs.lev2)
labs.lev3 <- na.omit(ly$labs.lev3)
rows.lev1 <- rev(which(rev(ly$row.lev1)))
rows.lev2 <- rev(which(rev(ly$row.lev2)))
rows.lev3 <- rev(which(rev(ly$row.lev3)))

# Four columns
par(mfrow=c(1,6))

# Plot for rownames
par(mar=c(5,0,0,1))
limm <- nrow(ly)
plot(0.5, type="n", axes = F, ann = F, ylim=c(0, limm + 2), xlim = c(0, 10))
text(3, rows.lev1, labs.lev1, cex = 1.5, pos = 4, font = 1)
text(3.5, rows.lev2, labs.lev2, cex = 1.5, pos = 4)
text(4, rows.lev3, labs.lev3, cex = 1.5, pos = 4)
abline(h = limm + 1)

# Colorectal cancer: plot points with no rownames
library(metafor)
par(mar=c(5,0,0,1))
forest(x = t2$hr, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "Colorectal",
       refline=1, efac = 0, rows = rowvec, ylim=c(0, limm + 2), 
       xlab="HR (95% CI)", annosym = c(" (", "-", ")"),
       psize= 1.6, cex=1.5, 
       top = 2,
       slab = NA, pch = 18, xlim = c(1, 4), 
       cex.lab = 1, 
       header = c("Colorectal cancer", ""))
# Number of cases
#text(2.2, c(4,8, limm), c("n = 1,441 cases", "n = 998 cases", "n = 2,439 cases"), cex = 1.5, pos = 2)

par(mar=c(5,4,0,1))
forest(x = t2$hr, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "Colon",
       refline=1, efac = 0, rows = rowvec, ylim=c(0, limm + 2), 
       xlab="HR (95% CI)", annosym = c(" (", "-", ")"),
       psize= 1.6, cex=1.5, 
       top = 2,
       slab = NA, pch = 18, xlim = c(1, 4), 
       cex.lab = 1, 
       header = c("Colon cancer", ""))
# Number of cases
#text(2.2, c(4,8, limm), c("n = 1,441 cases", "n = 998 cases", "n = 2,439 cases"), cex = 1.5, pos = 2)

par(mar=c(5,4,0,1))
forest(x = t2$hr, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "Proximal colon",
       refline=1, efac = 0, rows = rowvec, ylim=c(0, limm + 2), 
       xlab="HR (95% CI)", annosym = c(" (", "-", ")"),
       psize= 1.6, cex=1.5, 
       top = 2, alim = c(0,2),
       slab = NA, pch = 18, xlim = c(1, 4), 
       cex.lab = 1, 
       header = c("Proximal colon", ""))
# Number of cases
#text(2.2, c(4,8, limm), c("n = 1,441 cases", "n = 998 cases", "n = 2,439 cases"), cex = 1.5, pos = 2)

par(mar=c(5,4,0,1))
forest(x = t2$hr, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "Distal colon",
       refline=1, efac = 0, rows = rowvec, ylim=c(0, limm + 2), 
       xlab="HR (95% CI)", annosym = c(" (", "-", ")"),
       psize= 1.6, cex=1.5, 
       top = 2,
       slab = NA, pch = 18, xlim = c(1, 4), 
       cex.lab = 1, 
       header = c("Distal colon", ""))
# Number of cases
#text(2.2, c(4,8, limm), c("n = 1,441 cases", "n = 998 cases", "n = 2,439 cases"), cex = 1.5, pos = 2)

# Rectal
ly <- read_xlsx("forest_crc_wcrf.xlsx", sheet = 3) %>% filter(inclusion1 == TRUE)
# Set new vectors from layout sheet
rowvec <- rev(which(rev(ly$rowvec)))
labs.lev1 <- na.omit(ly$labs.lev1)
labs.lev2 <- na.omit(ly$labs.lev2)
labs.lev3 <- na.omit(ly$labs.lev3)
rows.lev1 <- rev(which(rev(ly$row.lev1)))
rows.lev2 <- rev(which(rev(ly$row.lev2)))
rows.lev3 <- rev(which(rev(ly$row.lev3)))

par(mar=c(5,4,0,1))
forest(x = t2$hr, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "Rectal",
       refline=1, efac = 0, rows = rowvec, ylim=c(0, limm + 2), 
       xlab="HR (95% CI)", annosym = c(" (", "-", ")"),
       psize= 1.6, cex=1.5, 
       top = 2,
       slab = NA, pch = 18, xlim = c(1, 4), 
       cex.lab = 1, 
       header = c("Rectal cancer", ""))
# Number of cases
#text(2.2, c(4,8, limm), c("n = 1,441 cases", "n = 998 cases", "n = 2,439 cases"), cex = 1.5, pos = 2)