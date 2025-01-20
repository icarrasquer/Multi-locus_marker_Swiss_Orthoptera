#! /bin/bash
#Folder: probe-design
source /local/anaconda3/bin/activate /home/jeremy/local/envphyluce


phyluce_probe_get_tiled_probe_from_multiple_inputs \
    --fastas orthoptera-genome-fasta \
    --multi-fasta-output Teleo_oc+5-back-to-5.conf \
    --probe-prefix "uce-" \
    --designer faircloth \
    --design orthoptera-v1 \
    --tiling-density 3 \
    --overlap middle \
    --masking 0.25 \
    --remove-gc \
    --two-probes \
    --output orthoptera-v1-master-probe-list.fasta

#Remove duplicates from our bait set

phyluce_probe_easy_lastz \
    --target orthoptera-v1-master-probe-list.fasta \
    --query orthoptera-v1-master-probe-list.fasta \
    --identity 50 \
    --coverage 50 \
    --output orthoptera-v1-master-probe-list-TO-SELF-PROBES.lastz

phyluce_probe_remove_duplicate_hits_from_probes_using_lastz \
    --fasta orthoptera-v1-master-probe-list.fasta \
    --lastz orthoptera-v1-master-probe-list-TO-SELF-PROBES.lastz \
    --probe-prefix=uce-