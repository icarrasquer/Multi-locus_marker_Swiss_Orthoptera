#!/bin/bash


source /local/anaconda3/bin/activate /home/jeremy/local/envblast29
for i in `ls *.fasta`
    do
    makeblastdb -in "$i" -input_type fasta -dbtype nucl
    done
