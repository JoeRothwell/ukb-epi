# Calculate PRS
library(tidyverse)
library(haven)
library(foreign)

snps <- read.csv("snps_crc_pancreas.csv") %>% select(Cancer, Risk.Allele, PRS.IV.Weight, id = rsID)
genmat <- readRDS("genmat.rds")
snpdat <- readRDS("snpdata.rds")
peddat <- readRDS("peddata.rds")

# Check SNP IDs are the same
# intersect(snpdat$id, snps$rsID)

# Join the SNP metadata to the table of PRS SNPs
snpdat <- left_join(snpdat, snps, by = "id") #%>%
# mutate(RA_alternative = ifelse(A2 == as.character(Risk.Allele), 1, 0))

# Get SNPs where the risk allele is the reference allele
RA_altern <- snpdat$A2 == as.character(snpdat$Risk.Allele)
table(RA_altern) # Ref allele is risk allele for 54

# Where the reference SNP is the risk, subtract the genotype from 2
genmat.risk <- apply(genmat, 2, function(x) 2 - x)

# Make copy of original genotype matrix and assign 2-x to TRUE cols
genmat0 <- genmat
genmat[, RA_altern] <- genmat.risk[, RA_altern]

# Multiply each column by the PRS-IV weight
weightmat <- sweep(genmat, 2, snpdat$PRS.IV.Weight, "*")

# Get PRS for colorectal and pancreatic cancer
peddat$PRS_crc <- rowSums(weightmat[, snpdat$Cancer == "Colon/rectum"], na.rm = T)
peddat$PRS_pan <- rowSums(weightmat[, snpdat$Cancer == "Pancreas"], na.rm = T)

peddat1 <- peddat[-(1:127), ]

# write to a .dta
#write_dta(peddat, "UKB_PRS_CRC_panc.dta")
write.dta(peddat1, "UKB_PRS_CRC_panc.dta")
