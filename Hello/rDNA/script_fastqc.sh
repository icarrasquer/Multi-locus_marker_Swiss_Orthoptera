# !/bin/bash

source /local/anaconda3/bin/activate /home/ines/envfastq/
for i in `ls *fastq.gz` ; do fastqc "$i" ;done