# Connect to remove server

# https://stackoverflow.com/questions/17347450/how-do-you-connect-to-a-remote-server-with-ssh-in-r
library(RCurl)

scp("193.52.231.13", "/home2/DATA_UKBB/PRS_pour_Joe/1_Final_PRS_Data/ukb22828_125SNPs", 
    "R0th!94GHz$", user="rothwell")

library(snpStats)
read.table(pipe('ssh 193.52.231.13 -l rothwell remotehost "cat //home2/DATA_UKBB/PRS_pour_Joe/1_Final_PRS_Data/ukb22828_125SNP"'))
#user@remotehost's password: # type password here

pipe('ssh 193.52.231.13 -l rothwell remotehost "cat //home2/DATA_UKBB/PRS_pour_Joe/1_Final_PRS_Data/ukb22828_125SNP"')


pathM <- paste("home2/DATA_UKBB/PRS_pour_Joe/1_Final_PRS_Data/ukb22828_125SNPs", c(".bed", ".bim", ".fam"), sep = "")
