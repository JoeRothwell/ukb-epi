# Forest plots for WCRF score presentation
# Read data from first and layout from second sheet
library(readxl)
library(tidyverse)

# Read in data sheet and layout sheet
t2 <- read_xlsx("forest_crc_wcrf.xlsx", sheet = 2) %>% filter(included == TRUE) %>%
        arrange(fct_inorder(`Metabolite group`), fct_inorder(Subgroup), fct_inorder(Assessment))

ly <- read_xlsx("forest_crc_wcrf.xlsx", sheet = 3) #%>% filter(inclusion1 == TRUE)

# Set row vectors from layout sheet
rowvec <- rev(which(rev(ly$rowvec)))
labs.lev1 <- na.omit(ly$labs.lev1)
labs.lev2 <- na.omit(ly$labs.lev2)
labs.lev3 <- na.omit(ly$labs.lev3)
rows.lev1 <- rev(which(rev(ly$row.lev1)))
rows.lev2 <- rev(which(rev(ly$row.lev2)))
rows.lev3 <- rev(which(rev(ly$row.lev3)))

# Four columns
par(mfrow=c(1,4))

# Plot for rownames
par(mar=c(5,0,0,1))
limm <- nrow(ly)
plot(0.5, type="n", axes = F, ann = F, ylim=c(0, limm + 2), xlim = c(0, 10))
text(2, rows.lev1, labs.lev1, cex = 1.5, pos = 4, font = 1)
text(3, rows.lev2, labs.lev2, cex = 1.5, pos = 4)
text(4, rows.lev3, labs.lev3, cex = 1.5, pos = 4)
abline(h = limm + 1)

# Colorectal cancer: plot points with no rownames
library(metafor)
par(mar=c(5,0,0,1))
forest(x = t2$hr, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "Colorectal",
       refline=1, efac = 0, rows = rowvec, ylim=c(0, limm + 2), 
       xlab="OR (95% CI)", annosym = c(" (", "-", ")"),
       psize= 1.5, cex=1.5, top = 2,
       slab = NA, pch = 18, xlim = c(1, 4), cex.lab = 1, 
       header = c("Colorectal cancer", ""))
# Number of cases
text(2.3, c(11, 25), c("N = 3,216", "N = 876"), cex = 1.5, pos = 4)

# Colon
par(mar=c(5,4,0,1))
forest(x = t2$hr, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "Colon",
       refline=1, efac = 0, rows = rowvec, ylim=c(0, limm + 2), 
       xlab="OR (95% CI)", annosym = c(" (", "-", ")"), psize= 1.5, cex=1.5, 
       top = 2, slab = NA, pch = 18, xlim = c(1, 4), cex.lab = 1, 
       header = c("Colon cancer", ""))
# Number of cases
text(2.2, c(11, 25), c("N = 2,504", "N = 792"), cex = 1.5, pos = 4)

# Proximal colon
par(mar=c(5,4,0,1))
forest(x = t2$hr, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "Proximal colon",
       refline=1, efac = 0, rows = rowvec, ylim=c(0, limm + 2), 
       xlab="OR (95% CI)", annosym = c(" (", "-", ")"),
       psize= 1.6, cex=1.5, top = 2, alim = c(0, 2),
       slab = NA, pch = 18, xlim = c(1, 6), cex.lab = 1, 
       header = c("Proximal colon", ""))
# Number of cases

# Distal colon
par(mar=c(5,4,0,1))
forest(x = t2$hr, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       subset = t2$subsite == "Distal colon",
       refline=1, efac = 0, rows = rowvec, ylim=c(0, limm + 2), 
       xlab="OR (95% CI)", annosym = c(" (", "-", ")"),
       psize= 1.6, cex=1.5, top = 2, slab = NA, pch = 18, 
       xlim = c(1, 6), cex.lab = 1, 
       header = c("Distal colon", ""))
# Number of cases

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
       xlab="OR (95% CI)", annosym = c(" (", "-", ")"),
       psize= 1.4, cex=1.5, top = 2, slab = NA, pch = 18, xlim = c(1, 3), 
       cex.lab = 1, header = c("Rectal cancer", ""))
# Number of cases
text(1.7, 11, "N = 468", cex = 1.5, pos = 4)

# Summary forest
t3 <- read_xlsx("forest_crc_wcrf.xlsx", sheet = 2) %>% filter(included2 == TRUE) %>%
        map_df(rev)

par(mar=c(5,0,0,1))
forest(x = t3$hr, ci.ub = t3$ci.high, ci.lb = t3$ci.low, 
       refline=1, efac = 0, rows = c(1:3, 6:8), 
       ylim=c(0, 11), 
       xlab="OR (95% CI)", annosym = c(" (", "-", ")"),
       psize= 1.5, #cex=1.5,
       #col = c("red", "blue", "blue", "red", "blue", "blue"),
       top = 2,
       slab = rep(c("         adj. for WCRF/AICR score", "     Metabolic signature", "     WCRF/AICR score"),2), 
       pch = 18, xlim = c(-0.65, 1.7), 
       cex.lab = 1, header = c("Model", "OR (95% CI)"))

par("usr")
text(-0.65, c(4, 9), c("Endogenous metabolites", "Fatty acids"), pos = 4)
