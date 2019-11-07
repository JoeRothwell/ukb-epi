# R program ukb33929.tab created 2019-11-06 by ukb2r.cpp Mar 14 2018 16:01:22

bd <- read.table("C:\\Users\\Rothwell\\Downloads\\UKB\\ukb33929.tab", header=TRUE, sep="\t")
lvl.100402 <- c(-3,1,2,3,4,5,6)
lbl.100402 <- c("Prefer not to answer","Daily or almost daily","Three or four times a week","Once or twice a week","One to three times a month","Special occasions only","Never")
bd$f.1558.0.0 <- ordered(bd$f.1558.0.0, levels=lvl.100402, labels=lbl.100402)
bd$f.1558.1.0 <- ordered(bd$f.1558.1.0, levels=lvl.100402, labels=lbl.100402)
bd$f.1558.2.0 <- ordered(bd$f.1558.2.0, levels=lvl.100402, labels=lbl.100402)
lvl.100291 <- c(-3,-1)
lbl.100291 <- c("Prefer not to answer","Do not know")
lvl.100416 <- c(-6,-3,-1,0,1)
lbl.100416 <- c("It varies","Prefer not to answer","Do not know","No","Yes")
bd$f.1618.0.0 <- ordered(bd$f.1618.0.0, levels=lvl.100416, labels=lbl.100416)
bd$f.1618.1.0 <- ordered(bd$f.1618.1.0, levels=lvl.100416, labels=lbl.100416)
bd$f.1618.2.0 <- ordered(bd$f.1618.2.0, levels=lvl.100416, labels=lbl.100416)
lvl.100417 <- c(-3,-1,1,2,3)
lbl.100417 <- c("Prefer not to answer","Do not know","More nowadays","About the same","Less nowadays")
bd$f.1628.0.0 <- ordered(bd$f.1628.0.0, levels=lvl.100417, labels=lbl.100417)
bd$f.1628.1.0 <- ordered(bd$f.1628.1.0, levels=lvl.100417, labels=lbl.100417)
bd$f.1628.2.0 <- ordered(bd$f.1628.2.0, levels=lvl.100417, labels=lbl.100417)
lvl.100570 <- c(-3,-1,1,2,3)
lbl.100570 <- c("Prefer not to answer","Do not know","Younger than average","About average age","Older than average")
bd$f.2375.0.0 <- ordered(bd$f.2375.0.0, levels=lvl.100570, labels=lbl.100570)
bd$f.2375.1.0 <- ordered(bd$f.2375.1.0, levels=lvl.100570, labels=lbl.100570)
bd$f.2375.2.0 <- ordered(bd$f.2375.2.0, levels=lvl.100570, labels=lbl.100570)
bd$f.2385.0.0 <- ordered(bd$f.2385.0.0, levels=lvl.100570, labels=lbl.100570)
bd$f.2385.1.0 <- ordered(bd$f.2385.1.0, levels=lvl.100570, labels=lbl.100570)
bd$f.2385.2.0 <- ordered(bd$f.2385.2.0, levels=lvl.100570, labels=lbl.100570)
lvl.100572 <- c(-3,-1,1,2,3,4)
lbl.100572 <- c("Prefer not to answer","Do not know","Pattern 1","Pattern 2","Pattern 3","Pattern 4")
bd$f.2395.0.0 <- ordered(bd$f.2395.0.0, levels=lvl.100572, labels=lbl.100572)
bd$f.2395.1.0 <- ordered(bd$f.2395.1.0, levels=lvl.100572, labels=lbl.100572)
bd$f.2395.2.0 <- ordered(bd$f.2395.2.0, levels=lvl.100572, labels=lbl.100572)
lvl.100418 <- c(-3,-1,1,2,3,4,5)
lbl.100418 <- c("Prefer not to answer","Do not know","Illness or ill health","Doctor\'s advice","Health precaution","Financial reasons","Other reason")
bd$f.2664.0.0 <- ordered(bd$f.2664.0.0, levels=lvl.100418, labels=lbl.100418)
bd$f.2664.1.0 <- ordered(bd$f.2664.1.0, levels=lvl.100418, labels=lbl.100418)
bd$f.2664.2.0 <- ordered(bd$f.2664.2.0, levels=lvl.100418, labels=lbl.100418)
lvl.100349 <- c(-3,-1,0,1)
lbl.100349 <- c("Prefer not to answer","Do not know","No","Yes")
bd$f.2674.0.0 <- ordered(bd$f.2674.0.0, levels=lvl.100349, labels=lbl.100349)
bd$f.2674.1.0 <- ordered(bd$f.2674.1.0, levels=lvl.100349, labels=lbl.100349)
bd$f.2674.2.0 <- ordered(bd$f.2674.2.0, levels=lvl.100349, labels=lbl.100349)
lvl.100567 <- c(-10,-3,-1)
lbl.100567 <- c("Less than 1 year ago","Prefer not to answer","Do not know")
bd$f.2694.0.0 <- ordered(bd$f.2694.0.0, levels=lvl.100349, labels=lbl.100349)
bd$f.2694.1.0 <- ordered(bd$f.2694.1.0, levels=lvl.100349, labels=lbl.100349)
bd$f.2694.2.0 <- ordered(bd$f.2694.2.0, levels=lvl.100349, labels=lbl.100349)
lvl.100569 <- c(-10,-3,-1)
lbl.100569 <- c("Less than a year ago","Prefer not to answer","Do not know")
lvl.100579 <- c(-3,0,1,2,3)
lbl.100579 <- c("Prefer not to answer","No","Yes","Not sure - had a hysterectomy","Not sure - other reason")
bd$f.2724.0.0 <- ordered(bd$f.2724.0.0, levels=lvl.100579, labels=lbl.100579)
bd$f.2724.1.0 <- ordered(bd$f.2724.1.0, levels=lvl.100579, labels=lbl.100579)
bd$f.2724.2.0 <- ordered(bd$f.2724.2.0, levels=lvl.100579, labels=lbl.100579)
lvl.100584 <- c(-3)
lbl.100584 <- c("Prefer not to answer")
lvl.100585 <- c(-3,-2,-1)
lbl.100585 <- c("Prefer not to answer","Only had twins","Do not know")
lvl.100586 <- c(-4,-3)
lbl.100586 <- c("Do not remember","Prefer not to answer")
bd$f.2774.0.0 <- ordered(bd$f.2774.0.0, levels=lvl.100349, labels=lbl.100349)
bd$f.2774.1.0 <- ordered(bd$f.2774.1.0, levels=lvl.100349, labels=lbl.100349)
bd$f.2774.2.0 <- ordered(bd$f.2774.2.0, levels=lvl.100349, labels=lbl.100349)
bd$f.2784.0.0 <- ordered(bd$f.2784.0.0, levels=lvl.100349, labels=lbl.100349)
bd$f.2784.1.0 <- ordered(bd$f.2784.1.0, levels=lvl.100349, labels=lbl.100349)
bd$f.2784.2.0 <- ordered(bd$f.2784.2.0, levels=lvl.100349, labels=lbl.100349)
lvl.100595 <- c(-11,-3,-1)
lbl.100595 <- c("Still taking the pill","Prefer not to answer","Do not know")
bd$f.2814.0.0 <- ordered(bd$f.2814.0.0, levels=lvl.100349, labels=lbl.100349)
bd$f.2814.1.0 <- ordered(bd$f.2814.1.0, levels=lvl.100349, labels=lbl.100349)
bd$f.2814.2.0 <- ordered(bd$f.2814.2.0, levels=lvl.100349, labels=lbl.100349)
lvl.100599 <- c(-5,-3,0,1)
lbl.100599 <- c("Not sure","Prefer not to answer","No","Yes")
bd$f.2834.0.0 <- ordered(bd$f.2834.0.0, levels=lvl.100599, labels=lbl.100599)
bd$f.2834.1.0 <- ordered(bd$f.2834.1.0, levels=lvl.100599, labels=lbl.100599)
bd$f.2834.2.0 <- ordered(bd$f.2834.2.0, levels=lvl.100599, labels=lbl.100599)
lvl.100598 <- c(-11,-3,-1)
lbl.100598 <- c("Still taking HRT","Prefer not to answer","Do not know")
bd$f.3591.0.0 <- ordered(bd$f.3591.0.0, levels=lvl.100599, labels=lbl.100599)
bd$f.3591.1.0 <- ordered(bd$f.3591.1.0, levels=lvl.100599, labels=lbl.100599)
bd$f.3591.2.0 <- ordered(bd$f.3591.2.0, levels=lvl.100599, labels=lbl.100599)
lvl.100582 <- c(-6,-3,-1)
lbl.100582 <- c("Irregular cycle","Prefer not to answer","Do not know")
bd$f.3720.0.0 <- ordered(bd$f.3720.0.0, levels=lvl.100349, labels=lbl.100349)
bd$f.3720.1.0 <- ordered(bd$f.3720.1.0, levels=lvl.100349, labels=lbl.100349)
bd$f.3720.2.0 <- ordered(bd$f.3720.2.0, levels=lvl.100349, labels=lbl.100349)
lvl.100352 <- c(-3,0,1)
lbl.100352 <- c("Prefer not to answer","No","Yes")
bd$f.3731.0.0 <- ordered(bd$f.3731.0.0, levels=lvl.100352, labels=lbl.100352)
bd$f.3731.1.0 <- ordered(bd$f.3731.1.0, levels=lvl.100352, labels=lbl.100352)
bd$f.3731.2.0 <- ordered(bd$f.3731.2.0, levels=lvl.100352, labels=lbl.100352)
bd$f.3859.0.0 <- ordered(bd$f.3859.0.0, levels=lvl.100418, labels=lbl.100418)
bd$f.3859.1.0 <- ordered(bd$f.3859.1.0, levels=lvl.100418, labels=lbl.100418)
bd$f.3859.2.0 <- ordered(bd$f.3859.2.0, levels=lvl.100418, labels=lbl.100418)
lvl.100630 <- c(-7,-3,1,2,3,4,5,6)
lbl.100630 <- c("None of the above","Prefer not to answer","Fish oil (including cod liver oil)","Glucosamine","Calcium","Zinc","Iron","Selenium")
bd$f.6179.0.0 <- ordered(bd$f.6179.0.0, levels=lvl.100630, labels=lbl.100630)
bd$f.6179.0.1 <- ordered(bd$f.6179.0.1, levels=lvl.100630, labels=lbl.100630)
bd$f.6179.0.2 <- ordered(bd$f.6179.0.2, levels=lvl.100630, labels=lbl.100630)
bd$f.6179.0.3 <- ordered(bd$f.6179.0.3, levels=lvl.100630, labels=lbl.100630)
bd$f.6179.0.4 <- ordered(bd$f.6179.0.4, levels=lvl.100630, labels=lbl.100630)
bd$f.6179.0.5 <- ordered(bd$f.6179.0.5, levels=lvl.100630, labels=lbl.100630)
bd$f.6179.1.0 <- ordered(bd$f.6179.1.0, levels=lvl.100630, labels=lbl.100630)
bd$f.6179.1.1 <- ordered(bd$f.6179.1.1, levels=lvl.100630, labels=lbl.100630)
bd$f.6179.1.2 <- ordered(bd$f.6179.1.2, levels=lvl.100630, labels=lbl.100630)
bd$f.6179.1.3 <- ordered(bd$f.6179.1.3, levels=lvl.100630, labels=lbl.100630)
bd$f.6179.1.4 <- ordered(bd$f.6179.1.4, levels=lvl.100630, labels=lbl.100630)
bd$f.6179.1.5 <- ordered(bd$f.6179.1.5, levels=lvl.100630, labels=lbl.100630)
bd$f.6179.2.0 <- ordered(bd$f.6179.2.0, levels=lvl.100630, labels=lbl.100630)
bd$f.6179.2.1 <- ordered(bd$f.6179.2.1, levels=lvl.100630, labels=lbl.100630)
bd$f.6179.2.2 <- ordered(bd$f.6179.2.2, levels=lvl.100630, labels=lbl.100630)
bd$f.6179.2.3 <- ordered(bd$f.6179.2.3, levels=lvl.100630, labels=lbl.100630)
bd$f.6179.2.4 <- ordered(bd$f.6179.2.4, levels=lvl.100630, labels=lbl.100630)
bd$f.6179.2.5 <- ordered(bd$f.6179.2.5, levels=lvl.100630, labels=lbl.100630)
lvl.100686 <- c(-3,-1,1,2,3,4,5,6)
lbl.100686 <- c("Prefer not to answer","None of the above","Microval","Micronor","Noriday","Norgeston","Femulen","Cerazette")
bd$f.10132.0.0 <- ordered(bd$f.10132.0.0, levels=lvl.100686, labels=lbl.100686)
lvl.100669 <- c(-3,-1,1,2,3)
lbl.100669 <- c("Prefer not to answer","Do not know","Illness","Financial reasons","Other reason")
bd$f.10818.0.0 <- ordered(bd$f.10818.0.0, levels=lvl.100669, labels=lbl.100669)
bd$f.10853.0.0 <- ordered(bd$f.10853.0.0, levels=lvl.100669, labels=lbl.100669)
lvl.0090 <- c(-3,0,1,2)
lbl.0090 <- c("Prefer not to answer","Never","Previous","Current")
bd$f.20117.0.0 <- ordered(bd$f.20117.0.0, levels=lvl.0090, labels=lbl.0090)
bd$f.20117.1.0 <- ordered(bd$f.20117.1.0, levels=lvl.0090, labels=lbl.0090)
bd$f.20117.2.0 <- ordered(bd$f.20117.2.0, levels=lvl.0090, labels=lbl.0090)
