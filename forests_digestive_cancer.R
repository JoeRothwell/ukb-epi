library(readxl)
t1 <- read_xlsx("digestive_cancers.xlsx")

library(metafor)
t2 <- t1[1:21, ]

par(mar=c(5,4,0,1))
forest(x = t2$estimate, ci.ub = t2$ci.high, ci.lb = t2$ci.low, #rows = rowvec, ylim=c(1,27), 
       refline=1, efac = 0,
       xlab="HR [95% CI]", #cex.lab = 0.8, 
       psize= rep(1.5, nrow(t2)), top = 2,
       cex=1, 
       #subset=14:26,
       slab = t2$Model, 
       pch = 18, header = T)
