#! /bin/bash
#Folder: probe-design
source /local/anaconda3/bin/activate /home/jeremy/local/envphyluce

phyluce_probe_get_multi_fasta_table \
    --fastas orthoptera-genome-fasta\
    --output multifastas.sqlite \
    --base-taxon Teleo_oc

phyluce_probe_query_multi_fasta_table \
    --db multifastas.sqlite \
    --base-taxon Teleo_oc

phyluce_probe_query_multi_fasta_table \
    --db multifastas.sqlite \
    --base-taxon Teleo_oc \
    --output Teleo_oc+5-back-to-5.conf \
    --specific-counts 5

#Output the list of UCE to keep