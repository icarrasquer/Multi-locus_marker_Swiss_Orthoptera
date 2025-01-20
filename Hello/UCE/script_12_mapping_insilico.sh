#! /bin/bash
#Folder probes-design-test

source /local/anaconda3/bin/activate /home/jeremy/local/envphyluce

#Map
mkdir -p orthoptera-genome-lastz
phyluce_probe_run_multiple_lastzs_sqlite \
    --db Teleo_oc+7-test.sqlite    --output orthoptera-genome-lastz \
    --probefile ../probe-design/orthoptera-v1-master-probe-list-DUPE-SCREENED.fasta \
    --scaffoldlist Gri_bi Laupa_ko Locus_mi Teleo_oc Time_mo Vandi_vi Xeno_bra \
    --genome-base-path ../genomes \
    --identity 80 \
    --cores 16
#Extract contigs
mkdir -p orthoptera-genome-fasta
phyluce_probe_slice_sequence_from_genomes \
    --conf orthoptera-genome.conf \
    --lastz orthoptera-genome-lastz \
    --output orthoptera-genome-fasta \
    --flank 0 --name-pattern "orthoptera-v1-master-probe-list-DUPE-SCREENED.fasta_v_{}.lastz.clean"
#Match contigs to baits
mkdir -p log
phyluce_assembly_match_contigs_to_probes \
    --contigs orthoptera-genome-fasta \
    --probes ../probe-design/orthoptera-v1-master-probe-list-DUPE-SCREENED.fasta \
    --output in-silico-lastz \
    --min-coverage 80 \
    --log-path log

    #Get match count and extract fasta info
mkdir -p taxon-sets/insilico-incomplete/
phyluce_assembly_get_match_counts \
    --locus-db in-silico-lastz/probe.matches.sqlite \
    --taxon-list-config orthoptera-genome-set.conf \
    --taxon-group 'all' \
    --output taxon-sets/insilico-incomplete/insilico-incomplete.conf \
    --log-path log \
    --incomplete-matrix
#orthoptera-genome-set.conf [all] + genome names

#orthoptera-genome-set.conf is the file containing the fasta file names of the genomes (WITHOUT CAPITAL LETTERS!) 
