# !/bin/bash
#Folder: BLAST
source /local/anaconda3/bin/activate /home/ines/envblast/

blastn -query ../teleo_oc_UCE.fasta -db /data/database/nt -evalue 1e-6 -outfmt 5 -out teleo_oc_blast_output