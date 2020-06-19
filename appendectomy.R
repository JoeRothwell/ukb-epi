library(gsheet)
library(tidyverse)
library(readxl)

# Data and layout sheet
url <- "https://docs.google.com/spreadsheets/d/1K1GtAu-d8K-iUr97hJPdlKX22SVsrrZIxCVzbu9SPGo/edit?usp=sharing"
url <- "https://docs.google.com/spreadsheets/d/1dGPH_94p19Bs94tGR5_IZbSD8kd3hLIwGh793QHcqYs/edit?usp=sharing"

t2 <- gsheet2tbl(url, sheetid = 1) %>% arrange(fct_inorder(subsite), group, fct_inorder(cohort)) %>% 
  mutate(std.err = ((ci.upper-ci.lower)/2)/qnorm(0.975))

t3 <- gsheet2tbl(url, sheetid = "Age at appendectomy") %>% arrange(fct_inorder(subsite), group, cohort) %>% 
  mutate(std.err = ((ci.upper-ci.lower)/2)/qnorm(0.975))

ly <- read_xlsx("digestive_cancers.xlsx", sheet = 3)

# Appendectomy Y/N

library(metafor)
df <- data.frame(t2[, c(1,9)])

# Basic plot, no meta analyses
par(mar=c(5,4,1,2))
forest(t2$hr, ci.lb = t2$ci.lower, ci.ub = t2$ci.upper, xlab = "Hazard ratio", pch = 18, 
       psize = 1.5, slab = t2$subsite, ilab = df, header = T, xlim = c(-3, 5),
       ilab.pos = 4, ilab.xpos = c(-0.8, -1.8), refline = 1)

par("usr")

# Perform meta-analyses
ma1 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 1:2)
ma2 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 3:5)
ma3 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 6:7)
ma4 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 8:9)
ma5 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 10:12)
ma6 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 13:14)
ma7 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 15:16)
ma8 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 17:19)
ma9 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 20:21)
ma10 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 22:23)
ma11 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 24:26)
ma12 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 27:28)
ma13 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 29:30)
ma14 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 31:33)
ma15 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 34:35)

ll <- list(ma15,ma14,ma13,ma12,ma11,ma10,ma9,ma8,ma7,ma6,ma5,ma4,ma3,ma2,ma1)
rowvec <- c(-0.5,4.5,10.5,16.5,21.5,27.5,33.5,38.5,44.5,50.5,55.5,61.5,67.5,72.5,78.5)

# Complex plot with spacings
par(mar=c(5,4,1,2))
li <- c(-2.1, -2.8)
forest(t2$hr, ci.lb = t2$ci.lower, ci.ub = t2$ci.upper, xlab = "Hazard ratio", pch = 18, 
       rows = na.omit(ly$row.lev3), ylim = c(0, 85), alim = c(0, 2), efac = NA,
       psize = 1.5,header = c("Subsite", "HR (95% CI)"), xlim = c(-4, 3.5),
       ilab = df, cex = 0.7, slab = t2$subsite1,
       ilab.pos = 4, ilab.xpos = li, refline = 1)

addpoly(ma15, row = -0.5, efac = 0.8, mlab = NA, cex = 0.7)
addpoly(ma14, row = 4.5, efac = 0.8, mlab = NA, cex = 0.7)
addpoly(ma13, row = 10.5, efac = 0.8, mlab = NA, cex = 0.7)
addpoly(ma12, row = 16.5, efac = 0.8, mlab = NA, cex = 0.7)
addpoly(ma11, row = 21.5, efac = 0.8, mlab = NA, cex = 0.7)
addpoly(ma10, row = 27.5, efac = 0.8, mlab = NA, cex = 0.7)
addpoly(ma9, row = 33.5, efac = 0.8, mlab = NA, cex = 0.7)
addpoly(ma8, row = 38.5, efac = 0.8, mlab = NA, cex = 0.7)
addpoly(ma7, row = 44.5, efac = 0.8, mlab = NA, cex = 0.7)
addpoly(ma6, row = 50.5, efac = 0.8, mlab = NA, cex = 0.7)
addpoly(ma5, row = 55.5, efac = 0.8, mlab = NA, cex = 0.7)
addpoly(ma4, row = 61.5, efac = 0.8, mlab = NA, cex = 0.7)
addpoly(ma3, row = 67.5, efac = 0.8, mlab = NA, cex = 0.7)
addpoly(ma2, row = 72.5, efac = 0.8, mlab = NA, cex = 0.7)
addpoly(ma1, row = 78.5, efac = 0.8, mlab = NA, cex = 0.7)

for(ind in 1:15) addpoly(ll[[ind]], rowvec[ind], efac = 0.8, mlab = NA, cex = 0.7)

text(li[1], -0.5, paste("RE model", "I2 =", round(ma15$I2, 3), ", p =", round(ma15$QEp, 2)), cex = 0.7, pos = 4)
text(li[1], 4.5, paste("RE model", "I2 =", round(ma14$I2, 1), ", p =", round(ma14$QEp, 2)), cex = 0.7, pos = 4)
text(li[1], 10.5, paste("RE model", "I2 =", round(ma13$I2, 1), ", p =", round(ma13$QEp, 2)), cex = 0.7, pos = 4)
text(li[1], 16.5, paste("RE model", "I2 =", round(ma12$I2, 1), ", p =", round(ma12$QEp, 2)), cex = 0.7, pos = 4)
text(li[1], 21.5, paste("RE model", "I2 =", round(ma11$I2, 1), ", p =", round(ma11$QEp, 2)), cex = 0.7, pos = 4)
text(li[1], 27.5, paste("RE model", "I2 =", round(ma10$I2, 1), ", p =", round(ma10$QEp, 2)), cex = 0.7, pos = 4)
text(li[1], 33.5, paste("RE model", "I2 =", round(ma9$I2, 1), ", p =", round(ma9$QEp, 2)), cex = 0.7, pos = 4)
text(li[1], 38.5, paste("RE model", "I2 =", round(ma8$I2, 1), ", p =", round(ma8$QEp, 2)), cex = 0.7, pos = 4)
text(li[1], 44.5, paste("RE model", "I2 =", round(ma7$I2, 1), ", p =", round(ma7$QEp, 2)), cex = 0.7, pos = 4)
text(li[1], 50.5, paste("RE model", "I2 =", round(ma6$I2, 1), ", p =", round(ma6$QEp, 2)), cex = 0.7, pos = 4)
text(li[1], 55.5, paste("RE model", "I2 =", round(ma5$I2, 1), ", p =", round(ma5$QEp, 2)), cex = 0.7, pos = 4)
text(li[1], 61.5, paste("RE model", "I2 =", round(ma4$I2, 1), ", p =", round(ma4$QEp, 2)), cex = 0.7, pos = 4)
text(li[1], 67.5, paste("RE model", "I2 =", round(ma3$I2, 1), ", p =", round(ma3$QEp, 2)), cex = 0.7, pos = 4)
text(li[1], 72.5, paste("RE model", "I2 =", round(ma2$I2, 1), ", p =", round(ma2$QEp, 2)), cex = 0.7, pos = 4)
text(li[1], 78.5, paste("RE model", "I2 =", round(ma1$I2, 1), ", p =", round(ma1$QEp, 2)), cex = 0.7, pos = 4)

for(ind in 1:15) text(li[1], rowvec[ind], paste("RE model", "I2 =", round(ll[[ind]]$I2, 1), ", p =", round(ll[[ind]]$QEp, 2)) , cex = 0.7, pos = 4)

text(li, 84, c("Group", "Cohort"), pos = 4, cex = 0.7)

# Appendectomy age


