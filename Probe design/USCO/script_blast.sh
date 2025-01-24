#! /bin/bash


for i in `ls *_genome.fna`
       do
       makeblastdb -in "$i" -out "$i" -dbtype nucl
       done

for i in `ls *t.fasta`
        do
        for j in `ls *_genome.fna`
                do
                blastn -query "$i" -db "$j" -evalue 1e-2 -max_target_seqs 10 -out blastn_"$i"_on_"$j".tab -num_threads 4 -outfmt 6
                done
        done