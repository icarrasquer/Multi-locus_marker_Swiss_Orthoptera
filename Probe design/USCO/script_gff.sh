#! /bin/bash

for i in `ls *.gff`
        do
        name=`echo $i | sed -e 's/.gff//g'`
        grep "exon" "$i" > temp_exons.gff
        for j in `ls *.fna`
                do
                namesp`echo $j | sed -e 's/.fna//g'`
                bedtools getfasta -fi "$j" -bed temp_exons.gff -fo "$name"_exons.fa
                done
        rm temp_*
        done
