# !/bin/bash
#Folder repeatmasker


source /local/anaconda3/bin/activate /home/ines/envrepeatmasker

for i in `ls *.fasta`
	do
    
	bgzip "$i"
	/home/ines/envrepeatmasker2/RepeatMasker/RepeatMasker -species "Orthoptera" "$i".gz
	bgzip -d "$i".gz
	
    done

conda activate /home/ines/envfaToTwoBit
 
for critter in `ls *masked`; do faToTwoBit ${critter%.*}.fasta ${critter%.*}.2bit; done
