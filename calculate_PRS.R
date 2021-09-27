# Calculate polygenic risk scores for CRC and pancreatic cancers in UK Biobank

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
snpdat <- left_join(snpdat, snps, by = "id") 

# Get SNPs where the risk allele is the reference allele
RA_ref <- snpdat$A1 == as.character(snpdat$Risk.Allele)
table(RA_ref) # Ref allele is risk allele for 71

# Where the reference SNP is the risk, subtract the genotype from 2
genmat.risk <- apply(genmat, 2, function(x) 2 - x)

# Make copy of original genotype matrix and assign 2-x to TRUE cols
genmat0 <- genmat
genmat[, RA_ref] <- genmat.risk[, RA_ref]

# Multiply each column by the PRS-IV weight
weightmat <- sweep(genmat, 2, snpdat$PRS.IV.Weight, "*")

# Get PRS for colorectal and pancreatic cancer
peddat$PRS_crc <- rowSums(weightmat[, snpdat$Cancer == "Colon/rectum"], na.rm = T)
peddat$PRS_pan <- rowSums(weightmat[, snpdat$Cancer == "Pancreas"], na.rm = T)

# write to a .dta
write.dta(peddat1, "UKB_PRS_CRC_panc.dta")


### Compute PRS from SNP dosages (see connect_server.sh)

# Get df of SNPs and subset 
library(snpStats)
dosages <- read_tsv("ukb22828_125SNPs.traw")
#dosages <- read_tsv("ukb22828_Bil_SNPs.traw")
colnames(dosages)

# Remove first 6 columns and 127 individuals and transpose
snpmat <- t(dosages[, -c(1:6)])
colnames(snpmat) <- dosages$SNP

# Get UKB id from rownames
ids <- tibble(id = rownames(snpmat)) %>% separate(id, into = c("fid", "id"), sep = "_")

# Put SNPs in correct order
snpmat1 <- snpmat[, colnames(genmat)]

# Where the reference SNP is the risk, subtract the dosage from 2
snpmat.risk <- apply(snpmat1, 2, function(x) 2 - x)

# Make copy of original genotype matrix and assign 2-x to TRUE cols
snpmat0 <- snpmat1
snpmat1[, RA_ref] <- snpmat.risk[, RA_ref]

# Multiply each column by the PRS-IV weight
weightmat <- sweep(snpmat1, 2, snpdat$PRS.IV.Weight, "*")

# Put person matrix (peddat) into the order of the results
# Create vector with rows in the correct order
vec <- ids$id
peddat <- peddat %>% slice(match(vec, id))

# Get PRS for colorectal and pancreatic cancer
peddat$PRS_crc <- rowSums(weightmat[, snpdat$Cancer == "Colon/rectum"], na.rm = T)
peddat$PRS_pan <- rowSums(weightmat[, snpdat$Cancer == "Pancreas"], na.rm = T)

# save to .rds
saveRDS(peddat, "UKB_prs.rds")

# write to a .dta
write.dta(peddat, "UKB_PRS_CRC_panc_dos.dta")
