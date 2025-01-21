# Design of USCO probes in Orthoptera

We kept the same 7 genomes -3 Ensifera, 3 Caelifera and the Phasmatodea outgroup- used for the definition of UltraConserved Elements (see README of UCE for more details) : 
[*Gryllus bimaculatus*](https://www.ncbi.nlm.nih.gov/genome/?term=txid6999[orgn])
[*Laupala kohalensis*](https://www.ncbi.nlm.nih.gov/genome/?term=txid109027[orgn])
*Locusta migratoria* (ik5) 
[*Teleogryllus occipitalis*](https://www.ncbi.nlm.nih.gov/genome/?term=txid431949[orgn])
[*Timema monikensis*](https://www.ncbi.nlm.nih.gov/genome/82511?genome_assembly_id=609578) (outgroup) 
[*Vandiemenella viatica*](https://www.ncbi.nlm.nih.gov/genome/?term=txid431949[orgn]) 
[*Xenocatantops brachycerus*](https://www.ncbi.nlm.nih.gov/genome/?term=txid227619[orgn])

## BUSCO

The Unique Single Copy Orthologs were identified in each gneome using Busco v4 and the 1 367 loci known for Insecta. **script_busco**

## Exon extraction

Using the GFF files produced by BUSCO, exon sequences were extracted from genomes. **script_gff.sh**
Exons were subsequently aligned.  **script_alignment.sh**


# HELP NEEDED HERE
makeblastdb -in all_usco_6sp.fasta -out all_usco_6sp.fasta -dbtype nucl

blastn -query all_uce.fasta -db all_usco_6sp.fasta -evalue 1e-2 -max_target_seqs 10 -out blastn_uce_on_usco_old.tab -num_threads 4 -outfmt 6



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