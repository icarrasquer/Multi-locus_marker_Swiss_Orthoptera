#! /bin/bash

for i in `ls *_align.fasta`
        do
        name=`echo $i | sed -e 's/.fasta//g'`
        sed -e 's/-/N/g' "$i" > temp.fasta
        sed -e 's/:/_/g' "$i" > temp2.fasta
        size=`fastalength temp.fasta | head -n 1 | awk '{print $1}'`
        start=`echo $(($size-119))`
        extractalign temp2.fasta "$name"_extractleft.fasta -regions "1-120"
        extractalign temp2.fasta "$name"_extractright.fasta -regions "$start-$size"
        rm temp*
        done