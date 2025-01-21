# !/bin/bash

for i in `ls *.fasta`
	do
    
	bgzip "$i"
	RepeatMasker -species "Orthoptera" "$i".gz
	bgzip -d "$i".gz
	
    done
 
for critter in `ls *masked`; do faToTwoBit ${critter%.*}.fasta ${critter%.*}.2bit; done
