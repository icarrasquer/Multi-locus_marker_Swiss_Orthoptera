#!/bin/bash
#$1 list of samples
#$2 length
#$3 pident

while read a
    do
    sample=`echo $a | sed -e 's/.fastq//g'`
    sed -n '1~4s/^@/>/p;2~4p' "$a" > "$sample".fasta

    blastn -query "$sample".fasta -db rDNA_Vandi_vi_complete.fasta -evalue 1e-6 -outfmt 6  -out "$sample".txt

    awk '{ if($4 >= '"$2"') { print $0}}' "$sample".txt | awk '{ if($3 >= '"$3"') { print $1}}' | sort |uniq > "$sample"_temp_names_"$2"_"$3"

    seqtk subseq "$a" "$sample"_temp_names_"$2"_"$3" > "$sample"_no_conts_"$2"_"$3".fastq
    
    canu -d "$sample"_"$2"_"$3" -p "$sample"_"$2"_"$3" useGrid=false genomeSize=4k -nanopore-raw "$sample"_no_conts_"$2"_"$3".fastq useGrid=false minInputCoverage=0 minReadLength=200 minOverlapLength=100 stopOnLowCoverage=0 -contigFilter="2 0 1.0 0.5 0"
    mkdir CONTIGS_"$2"_"$3"
    cp "$sample"_"$2"_"$3"/"$sample"_"$2"_"$3".contigs.fasta CONTIGS_"$2"_"$3"
    done