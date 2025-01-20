# !/bin/bash
#Folder: reads


source /local/anaconda3/bin/activate /home/ines/envart
for i in `ls ../genomes`
    do
        art_illumina \
        --paired \
        --in ../genomes/"$i"/"$i".fasta \
        --out "$i"-reads \
        --len 100 --fcov 2 --mflen 200 --sdev 150 -ir 0.0 -ir2 0.0 -dr 0.0 -dr2 0.0 -qs 100 -qs2 100 -na
    done

for critter in `ls ../genomes`
    do
        echo "working on $critter";
        touch $critter-reads.fq;
        cat $critter-reads1.fq > $critter-reads.fq;
        cat $critter-reads2.fq >> $critter-reads.fq;
        rm $critter-reads1.fq;
        rm $critter-reads2.fq;
        gzip $critter-reads.fq;
    done