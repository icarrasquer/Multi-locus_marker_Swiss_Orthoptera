#! /bin/bash

source /local/anaconda3/bin/activate /home/ines/envseqkit/


for i in "$@"
    do
    sample=`echo $i | sed -e 's/.fasta//g'`

    cat "$i" | seqkit mutate -i 0:GTGACTGGAGTTCAGACG | seqkit mutate -i -1:AGAT > "$sample"_amplification.fasta

    done