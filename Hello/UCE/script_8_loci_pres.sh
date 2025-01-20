#! /bin/bash
#Folder: bed

source /local/anaconda3/bin/activate /home/jeremy/local/envphyluce

#DETERMINING LOCUS PRESENCE IN MULTIPLE GENOMES
phyluce_probe_get_multi_merge_table \
    --conf bed-files.conf \
    --base-taxon Teleo_oc\
    --output orthoptera-to-Teleo_oc.sqlite

phyluce_probe_query_multi_merge_table \
        --db orthoptera-to-Teleo_oc.sqlite  \
        --base-taxon Teleo_oc

#Extract them

phyluce_probe_query_multi_merge_table \
        --db  orthoptera-to-Teleo_oc.sqlite \
        --base-taxon Teleo_oc \
        --output Teleo_oc+5.bed \
        --specific-counts 5

phyluce_probe_get_genome_sequences_from_bed \
        --bed Teleo_oc+5.bed  \
        --twobit ../genomes/Teleo_oc/Teleo_oc.2bit \
        --buffer-to 160 \
        --output Teleo_oc+5.fasta

#Design a temporary bait set from the base taxon
phyluce_probe_get_tiled_probes \
    --input Teleo_oc+5.fasta \
    --probe-prefix "uce-" \
    --design orthoptera-v1 \
    --designer faircloth \
    --tiling-density 3 \
    --two-probes \
    --overlap middle \
    --masking 0.25 \
    --remove-gc \
    --output Teleo_oc+5.temp.probes

#Remove duplicates
phyluce_probe_easy_lastz \
    --target Teleo_oc+5.temp.probes \
    --query Teleo_oc+5.temp.probes \
    --identity 50 --coverage 50 \
    --output Teleo_oc+5.temp.probes-TO-SELF-PROBES.lastz

phyluce_probe_remove_duplicate_hits_from_probes_using_lastz \
    --fasta Teleo_oc+5.temp.probes  \
    --lastz Teleo_oc+5.temp.probes-TO-SELF-PROBES.lastz \
    --probe-prefix=uce-