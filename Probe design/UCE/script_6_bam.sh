#! /bin/bash

for critter in Gri_bi Laupa_ko Locus_mi Teleo_oc Time_mo Vandi_vi Xeno_bra;
    do
    samtools view -h -F 4 -b ./$critter/$critter-to-Teleo_oc.bam > $critter/$critter-to-Teleo_oc-MAPPING.bam;
    ln -s ./$critter/$critter-to-Teleo_oc-MAPPING.bam all/;
    done