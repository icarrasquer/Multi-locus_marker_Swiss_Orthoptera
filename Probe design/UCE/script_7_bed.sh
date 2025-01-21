# !/bin/bash

for i in ../alignments/all/*.bam; do echo $i; bedtools bamtobed -i $i -bed12 > `basename $i`.bed; done

#Sort the converted BEDs
for i in *.bed; do echo $i; bedtools sort -i $i > ${i%.*}.sort.bed; done

#Merge overlapping regions
for i in *.bam.sort.bed; do echo $i; bedtools merge -i $i > ${i%.*}.merge.bed; done

#Remove repetitive intervals
for i in *.sort.merge.bed;
    do
        phyluce_probe_strip_masked_loci_from_set \
            --bed $i \
            --twobit ../genomes/Teleo_oc/Teleo_oc.2bit \
            --output ${i%.*}.strip.bed \
            --filter-mask 0.25 \
            --min-length 80
    done

for i in `ls *.strip.bed` ; do  echo `echo $i | awk -F "-" '{print $1}'`":"$i >> bed-files.conf ;done

sed -i '1 i\[beds]' bed-files.conf

