#! /bin/bash
#Folder probes-design-test/taxon-sets/insilico-incomplete

source /local/anaconda3/bin/activate /home/jeremy/local/envphyluce


#Get the UCE fasta
cd taxon-sets/insilico-incomplete
mkdir -p log
phyluce_assembly_get_fastas_from_match_counts \
    --contigs ../../orthoptera-genome-fasta \
    --locus-db ../../in-silico-lastz/probe.matches.sqlite \
    --match-count-output insilico-incomplete.conf \
    --output insilico-incomplete.fasta \
    --incomplete-matrix insilico-incomplete.incomplete \
    --log-path log

#Align the conserved locus data

phyluce_align_seqcap_align \
    --fasta insilico-incomplete.fasta \
    --output mafft \
    --taxa 7 \
    --incomplete-matrix \
    --cores 12 \
    --no-trim \
    --output-format fasta \
    --log-path log

#Trim the conserved locus alignment

phyluce_align_get_gblocks_trimmed_alignments_from_untrimmed \
    --alignments mafft \
    --output mafft-gblocks \
    --b1 0.5 \
    --b4 8 \
    --cores 12 \
    --log log

#Remove the locus names from each alignment

phyluce_align_remove_locus_name_from_nexus_lines \
    --alignments mafft-gblocks \
    --output mafft-gblocks-clean \
    --cores 12 \
    --log-path log

#GET STATS ACROSS THE ALIGNED LOCI

python ~/git/phyluce/bin/align/phyluce_align_get_align_summary_data \
    --alignments mafft-gblocks-clean \
    --cores 12 \
    --log-path log