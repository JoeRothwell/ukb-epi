# Forest plots for appendectomy and GI cancers manuscript

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

# MetS-colorectal cancer and pancreatic cancer by PRS category

t4 <- read_xlsx("appendix_biomarkers.xlsx", sheet = 4) %>% filter(inclusion == T)
df <- data.frame(t4[, c(2,3)])

par(mar=c(5,0,0,1))
forest(x = t4$estimate, ci.ub = t4$ci.high, ci.lb = t4$ci.low, 
       refline=1, efac = 0, xlab="HR [95% CI]", 
       psize= 1.3, #digits = 3,
       pch = 18, 
       rows = c(17:0),
       slab = t4$cancer, 
       ilab = df,
       ilab.xpos = c(-1.5, -0.5), ilab.pos = 4,
       xlim = c(-3, 4.5), 
       #header = c("Biomarker", "Scaled GM [95% CI]"),
       cex=0.9)

text(0.95, 56, "Appendectomy", cex = 0.9, pos = 4)

par("usr")

t4 <- read_xlsx("appendix_biomarkers.xlsx", sheet = 5) %>% filter(inclusion == T)
df <- data.frame(t4[, c(2,3)])
   
# With ggplot2 vertically
library(ggplot2)

#tiff("Figure5.tiff", units="in", width=5, height=3.5, res=300)

ggplot(t4) + 
        geom_hline(yintercept = 1, colour = "grey") +
        geom_pointrange(aes(y=estimate, x= fct_inorder(prs.cat), shape = metS, 
                                 ymin=ci.low, ymax=ci.high, group=metS), 
                        position = position_dodge(width = 0.5)) +
        theme_bw() + xlab("Polygenic risk score category") + 
        ylab("Hazard ratio (95% CI)") +
        #ylim(0.2, 3.5) + 
        scale_y_continuous(limits = c(0.6, 2.8), n.breaks = 6) +
        facet_wrap(. ~ cancer, scales = "free") +
        #facet_grid(cancer ~ ., scales = "free_x") +
        labs(shape = "MetS definition") +
        theme(legend.position = "bottom",
              #strip.background = element_blank(),
              #panel.grid.major = element_blank(),
              panel.grid.minor = element_blank())

#dev.off()

# Horizontally
ggplot(t4) + 
        geom_pointrange(aes(x=estimate, y= fct_inorder(prs.cat), shape = metS, 
                            xmin=ci.low, xmax=ci.high, group=metS), 
                        position = position_dodge(width = 0.5)) +
        scale_x_continuous(n.breaks = 6) +
        geom_vline(xintercept = 1, colour = "grey") +
        theme_bw() + ylab("Polygenic risk score category") + 
        xlab("Hazard ratio (95% CI)") +
        facet_grid(cancer ~ ., scales = "free_y") +
        labs(shape = "MetS definition") +
        theme(legend.position = "bottom") #+
        #annotate("text", label = "n = 0.70", x = 2, y = 3, size = 3)
