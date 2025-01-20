#! /bin/bash

while read a
    do
    F1=`echo $a | awk '{print $1}'`
    F2=`echo $a | awk '{print $2}'`
    ./script_blast_canu.sh listsamples "$F1" "$F2" 
    done < test_set


while read a
    do
    sample=`echo $a | sed -e 's/.fastq//g'`
    mkdir "$sample"_contigs 
    cp "$sample"*/*contigs.fasta "$sample"_contigs
    done < listsamples
    