# !/bin/bash
#Folder_ alignment

export cores=16
export base=Teleo_oc 
export base_dir=/data/work/Ortho_SwissBol/UCE_genomes/Main/alignment
for critter in Gri_bi Laupa_ko Locus_mi Teleo_oc Time_mo Vandi_vi Xeno_bra;
    do
        export reads=$critter-reads.fq.gz;
        mkdir -p $base_dir/$critter;
        cd $base_dir/$critter;
        stampy.py --maxbasequal 93 -g ../../base/$base -h ../../base/$base \
        --substitutionrate=0.05 -t$cores --insertsize=400 -M \
        ../../reads/$reads | samtools view -Sb - > $critter-to-$base.bam;
    done

