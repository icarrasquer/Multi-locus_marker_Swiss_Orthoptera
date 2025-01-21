#! /bin/bash

for i in `ls *.fna`
        do
        name=`echo $i | sed -e 's/.fna//g'`
        mafft --auto "$i" > "$name"_align.fasta
        done