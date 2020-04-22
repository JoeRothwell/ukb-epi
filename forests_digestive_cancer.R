# Forest plots for digestive cancers manuscript

library(readxl)
library(tidyverse)
t2 <- read_xlsx("digestive_cancers.xlsx")
# Set row order for groupings. First calculate no rows needed, then start from highest number
# There are 6 groups of 3. 21 lines + 6 gaps = 27
rowvec <- c(26:24, 22:20, c(18,14,10), c(17,13,9), c(16,12,8), 6:1)

par(mfrow=c(1,6))
library(metafor)
# Plot for rownames
plot(1, type="n", axes = F, ann = F, ylim=c(0,29), xlim = c(1,1.25))
text(1.03, c(7,19,23,27), c("MetS Components", "MetS", "Pre-diabetes", "Diabetes"), cex = 0.8)

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "colorectal_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,29), 
       xlab="HR [95% CI]", psize= rep(1.5, nrow(t2)),
       cex=0.8, slab = t2$group.lab, ilab = t2$subgroup.lab, ilab.xpos = 0.3, ilab.pos = 4, pch = 18)

forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "colon_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,29), 
       xlab="HR [95% CI]", psize= rep(1.5, nrow(t2)),
       cex=0.8, slab = t2$group.lab, ilab = t2$subgroup.lab, ilab.xpos = 0.3, ilab.pos = 4, pch = 18)

forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, subset = t2$subsite == "rectal_inc",
       refline=1, efac = 0, rows = rowvec, ylim=c(0,29), 
       xlab="HR [95% CI]", psize= rep(1.5, nrow(t2)),
       cex=0.8, slab = t2$group.lab, ilab = t2$subgroup.lab, ilab.xpos = 0.3, ilab.pos = 4, pch = 18)

