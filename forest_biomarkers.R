# Forest plots for digestive cancers manuscript

library(readxl)
library(tidyverse)
library(metafor)

t2 <- read_xlsx("appendix_biomarkers.xlsx", sheet = 1)
df <- data.frame(t2[, c(2,3)])

par(mar=c(5,0,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, 
       refline=1, efac = 0, xlab="Scaled geometric mean [95% CI]", 
       psize= 1.3, digits = 3,
       pch = 18, 
       rows = c(53:0),
       slab = t2$biomarker, 
       ilab = df,
       ilab.xpos = c(0.915, 0.95), ilab.pos = 4,
       xlim = c(0.89, 1.09), 
       header = c("Biomarker", "Scaled GM [95% CI]"),
       cex=0.9)

text(0.95, 56, "Appendectomy", cex = 0.9, pos = 4)

par("usr")

# With ggplot2
t3 <- read_xlsx("appendix_biomarkers.xlsx", sheet = 2)

ggplot(t3, aes(x = estimate, y = fct_inorder(rev(group)), 
               colour = Append, xmin = ci.low, xmax = ci.high)) + 
        geom_pointrange() + theme_bw() +
        geom_errorbar(aes(xmin=ci.low, xmax=ci.high), width=0.5, cex=1) + 
        ylab('Group') + xlab("Geometric mean biomarker concentration") +
        facet_grid(biomarker ~ ., scales = "free_y") +
        ggtitle("Biomarker measurements in appendectomy\nand non-appendectomy groups") +
        theme(axis.title.y =element_blank())
   
