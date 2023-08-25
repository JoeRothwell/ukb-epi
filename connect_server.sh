# Access SNP data on Epithyr server. Putty is needed on PC or Terminal on Mac

# Connect to server with ssh
ssh 193.52.231.13 -l rothwell
# enter password from email

# Navigate to '/home2/DATA_UKBB/PRS_pour_Joe/1_Final_PRS_Data/ukb22828_125SNPs'
cd ../..
cd home2/DATA_UKBB/PRS_pour_Joe/1_Final_PRS_Data/
ls -l

# Update March 2023. Address is now
/home2/DATA_UKBB/1_Analysis/PRS_pour_Joe

# Home directory on the server
cd home1/users/rothwell

# To download a file from my directory on the server. scp then server address then local
# https://unix.stackexchange.com/questions/188285/how-to-copy-a-file-from-a-remote-server-to-a-local-machine
# Don't connect with ssh first (may need to type exit if connected)
scp rothwell@193.52.231.13:~/genmat.rds /Users/joe
scp rothwell@193.52.231.13:/home2/DATA_UKBB/PRS_pour_Joe/1_Final_PRS_Data/ukb22828_125SNPs.traw /Users/joe
scp rothwell@193.52.231.13:/home2/DATA_UKBB/PRS_pour_Joe/2_Scripts/extracte_with_plink.txt /Users/joe/ukb-epi
scp rothwell@193.52.231.13:/home2/DATA_UKBB/PRS_pour_Joe/2_Scripts/merge_traw_files.py /Users/joe

# Microbiome data
cd home2/E3N-E4N/1_Microbiom/0_Raw_data

# Unzip files
unzip -a NUTRIPERSO_1.zip

# To upload a file (putting BC metabolomics data on server)
# Navigate to folder and create new folder for metabolomics data
cd ../../../home2/E3N-E4N
mkdir 4_BCmetabolomics

# Use scp with -r to recursively copy directories
# See http://www.hypexr.org/linux_scp_help.php
scp -r Compressed_files rothwell@193.52.231.13:/home2/E3N-E4N/4_BCmetabolomics
scp X_AlignedCohorteE3NData_cpmg_ssCitPEG_0612.txt rothwell@193.52.231.13:/home2/E3N-E4N/4_BCmetabolomics
scp Users/joe/BC_study_data/Original_data/ rothwell@193.52.231.13:/home2/E3N-E4N/4_BCmetabolomics