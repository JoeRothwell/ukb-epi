library(gsheet)
library(tidyverse)
library(readxl)

# Data and layout sheet
url <- "https://docs.google.com/spreadsheets/d/1K1GtAu-d8K-iUr97hJPdlKX22SVsrrZIxCVzbu9SPGo/edit?usp=sharing"
url2 <- "https://docs.google.com/spreadsheets/d/1dGPH_94p19Bs94tGR5_IZbSD8kd3hLIwGh793QHcqYs/edit?usp=sharing"

t2 <- gsheet2tbl(url, sheetid = 1) %>% arrange(fct_inorder(subsite), fct_inorder(group), fct_inorder(cohort)) %>% 
  mutate(std.err = ((ci.upper-ci.lower)/2)/qnorm(0.975))

t3 <- gsheet2tbl(url2, sheetid = 1) %>% arrange(fct_inorder(subsite), fct_inorder(group), fct_inorder(cohort)) %>% 
  mutate(std.err = ((ci.upper-ci.lower)/2)/qnorm(0.975))

ly <- read_xlsx("digestive_cancers.xlsx", sheet = 3)

# Appendectomy Y/N

library(metafor)
df <- data.frame(t2[, c(1,9)])

# Perform meta-analyses
ma1 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 1:3)
ma2 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 4:6)
ma3 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 7:8)
ma4 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 9:11)
ma5 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 12:14)
ma6 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 15:16)
ma7 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 17:19)
ma8 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 20:22)
ma9 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 23:24)
ma10 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 25:27)
ma11 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 28:30)
ma12 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 31:32)
ma13 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 33:35)
ma14 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 36:38)
ma15 <- rma(hr, sei = std.err, data=t2, method="REML", subset = 39:40)

ll <- list(ma15,ma14,ma13,ma12,ma11,ma10,ma9,ma8,ma7,ma6,ma5,ma4,ma3,ma2,ma1)
#rowvec <- c(-0.5,4.5,10.5,16.5,21.5,27.5,33.5,38.5,44.5,50.5,55.5,61.5,67.5,72.5,78.5)
rowvec <- c(-0.5,4.5,10.5, 17.5,22.5,28.5, 35.5,40.5,46.5, 53.5,58.5,64.5, 71.5,76.5,82.5)

# Extract data for table
results <- lapply(rev(ll), "[", c("b", "ci.lb", "ci.ub", "I2", "QEp"))
append.yn <- do.call(rbind, results) %>% as_tibble


# Complex plot with spacings
par(mar=c(5,4,1,2), mgp = c(2,0.5,0))
li <- c(-2.1, -2.8)
forest(t2$hr, ci.lb = t2$ci.lower, ci.ub = t2$ci.upper, xlab = "Hazard ratio", pch = 18, 
       rows = na.omit(ly$row.lev3), ylim = c(0, 90), 
       alim = c(0, 2), efac = 0.5,
       psize = 1.5, header = c("Subsite", "HR (95% CI)"), xlim = c(-4, 3.5),
       ilab = df, cex = 0.7, slab = t2$subsite1,
       ilab.pos = 4, ilab.xpos = li, refline = 1)

# Add meta-analyses and text in a loop
for(ind in 1:15) addpoly(ll[[ind]], rowvec[ind], efac = 0.8, mlab = NA, cex = 0.7, col = "grey")

#for(ind in 1:15) { 
#  text(li[1], rowvec[ind], paste("RE model:", "I2 =", 
#  round(ll[[ind]]$I2, 1), "%, p =", round(ll[[ind]]$QEp, 2)) , cex = 0.7, pos = 4) 
#  }

text(li, 89, c("Cohort", "Group"), pos = 4, cex = 0.7)

# Positions of p-het and I2 are 22 and 25
I2s <- round(unlist(sapply(ll, "[", 25)), 1)
phets <- round(unlist(sapply(ll, "[", 22)), 2)
plabs <- function(x, y) as.expression(bquote("RE model"~I^2 * "=" ~ .(x)* "%" * ", p ="~ .(y) ))
# Function name comes first in mapply (opposite to sapply)
text(li[1], rowvec, labels = mapply(plabs, I2s, phets), cex = 0.7, pos = 4)


# Basic plot, no meta analyses
par(mar=c(5,4,1,2))
forest(t2$hr, ci.lb = t2$ci.lower, ci.ub = t2$ci.upper, xlab = "Hazard ratio", pch = 18, 
       psize = 1.5, slab = t2$subsite, ilab = df, header = T, xlim = c(-3, 5),
       ilab.pos = 4, ilab.xpos = c(-0.8, -1.8), refline = 1)

par("usr")

# Age at appendectomy

df <- data.frame(t3[, c(1,7)])

# Perform meta-analyses (only 13 due to non-estimable men in EPIC)
ma1 <- rma(hr, sei = std.err, data=t3, method="REML", subset = 1:3)
ma2 <- rma(hr, sei = std.err, data=t3, method="REML", subset = 4:6)
ma3 <- rma(hr, sei = std.err, data=t3, method="REML", subset = 7:8)
ma4 <- rma(hr, sei = std.err, data=t3, method="REML", subset = 9:11)
ma5 <- rma(hr, sei = std.err, data=t3, method="REML", subset = 12:14)
#ma6 <- rma(hr, sei = std.err, data=t3, method="REML", subset = 15:16)
ma7 <- rma(hr, sei = std.err, data=t3, method="REML", subset = 17:19)
ma8 <- rma(hr, sei = std.err, data=t3, method="REML", subset = 20:22)
#ma9 <- rma(hr, sei = std.err, data=t3, method="REML", subset = 23:24)
ma10 <- rma(hr, sei = std.err, data=t3, method="REML", subset = 25:27)
ma11 <- rma(hr, sei = std.err, data=t3, method="REML", subset = 28:30)
#ma12 <- rma(hr, sei = std.err, data=t3, method="REML", subset = 31:32)
ma13 <- rma(hr, sei = std.err, data=t3, method="REML", subset = 33:35)
ma14 <- rma(hr, sei = std.err, data=t3, method="REML", subset = 36:38)
ma15 <- rma(hr, sei = std.err, data=t3, method="REML", subset = 39:40)

# Remove extreme point (row 16)
t3[16, c(4:6)] <- NA

ll <- list(ma15,ma14,ma13,   ma11,ma10,  ma8,ma7,  ma5,ma4,ma3,ma2,ma1)
rowvec <- c(-0.5,4.5,10.5,   21.5,27.5, 38.5,44.5,  55.5,61.5, 68.5,73.5,79.5)

# Extract data for table
results <- lapply(rev(ll), "[", c("b", "ci.lb", "ci.ub", "I2", "QEp"))
append.yn <- do.call(rbind, results) %>% as_tibble

# Complex plot with spacings
par(mar=c(5,4,1,2), mgp = c(2,0.5,0))
li <- c(-1, -2.7)
forest(t3$hr, ci.lb = t3$ci.lower, ci.ub = t3$ci.upper, xlab = "Hazard ratio", pch = 18, 
       rows = na.omit(ly$row.lev3), ylim = c(0, 87), 
       alim = c(0, 4), 
       efac = 0.5,
       psize = 1.5, header = c("Subsite", "HR (95% CI)"), xlim = c(-4, 6),
       ilab = df, cex = 0.7, slab = t3$subsite1,
       ilab.pos = 4, ilab.xpos = li, refline = 1)

# Add meta-analyses and text in a loop
for(ind in 1:13) addpoly(ll[[ind]], rowvec[ind], efac = 0.8, mlab = NA, cex = 0.7, col = "grey")
#for(ind in 1:13) { 
#  text(li[2], rowvec[ind], paste("RE model:", "I2 =", 
#  round(ll[[ind]]$I2, 1), "%, p =", round(ll[[ind]]$QEp, 2)) , cex = 0.7, pos = 4) 
#}

I2s <- round(unlist(sapply(ll, "[", 25)), 1)
phets <- round(unlist(sapply(ll, "[", 22)), 2)
plabs <- function(x, y) as.expression(bquote("RE model"~I^2 * "=" ~ .(x)* "%" * ", p ="~ .(y) ))
text(li[2], rowvec, labels = mapply(plabs, I2s, phets), cex = 0.7, pos = 4)

text(li, 86, c("Cohort", "Group"), pos = 4, cex = 0.7)
