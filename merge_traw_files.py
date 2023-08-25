# -*- coding: utf-8 -*-


# library
import os
import sys

###############################
########## exemple : ##########
############################### 
# python /home2/DATA_UKBB/PRS_pour_Joe/2_Scripts/merge_traw_files.py   /home2/DATA_UKBB/PRS_pour_Joe/0_Extracted_SNPs/bgen_format/  /home2/DATA_UKBB/PRS_pour_Joe/1_Final_PRS_Data/ukb22828_125SNPs.traw




###############################
########## Functions ##########
############################### 


def read_traw_file(file, L) :
	###
	# Cette fonction permet de lire le fichier .traw
	# Input : le fichier a lire, une liste contenant les lignes a ecrire dans nouveau fichier .traw
	# Output : la nouvelle liste a ecrire
	###
	print("reading ", file)
	F_traw = open(file, 'r') # open .traw file
	lines_traw = F_traw.readlines()  # read .impute2_info file	
	F_traw.close()
	
	if len(L) == 0 :
		L.append(lines_traw[0])
	
	for i in range(1,len(lines_traw)) :
		if len(lines_traw[i]) > 20 :
			L.append(lines_traw[i])
	return  L




def files(folder) :
	###
	# Cette fonction permet de lire les fichiers .traw d'un dossier
	# Input : le dossier contenant les fichiers dosages (.traw) a merger.
	# Output : une liste des lignes a ecrire
	###
	ll = []
	L = os.listdir(folder) # pour lister les fichiers dans le dossier

	for i in L : # pour les fichiers avec l'extension .traw dans le dossier (maintenant dans la liste)
		if i.split(".")[-1] == 'traw' : # si le fichier a l'extension .traw
			print(i)
			ll = read_traw_file(folder + i, ll) # va dans la fonction pr?c?dente
			print("##################", i, 'finished', '\n')
	return ll

ff = files(sys.argv[1])
print(len(ff))



def write_traw_merge(l, output) :
	###
	# Cette fonction permet d'?crire le fichier de sortie
	# Input : la liste ? ?crire, le fichier sortie.
	# Output : rien. Il ecrit le fichier merged.
	###

	print("writing _traw file in : ", output)
	with open(output, 'w') as fileout :		
		for i in range(len(l)) :
			for j in range(len(l[i])) :
				fileout.write(l[i][j])
	return

write_traw_merge(ff, sys.argv[2])


