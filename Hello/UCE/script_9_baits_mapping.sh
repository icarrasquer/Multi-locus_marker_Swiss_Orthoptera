#! /bin/bash
#Folder: probe-design

mkdir -p orthoptera-genome-lastz

source /local/anaconda3/bin/activate /home/jeremy/local/envphyluce
phyluce_probe_run_multiple_lastzs_sqlite \
    --probefile ../bed/Teleo_oc+5.temp-DUPE-SCREENED.probes \
    --scaffoldlist Gri_bi Laupa_ko Locus_mi Teleo_oc Time_mo Vandi_vi Xeno_bra \
    --genome-base-path ../genomes \
    --identity 70 \
    --cores 16 \
    --db Teleo_oc+5+Copto_for.sqlite \
    --output orthoptera-genome-lastz



cd ../genomes
for i in `ls .` ; do  echo $i":"`pwd`"/"$i"/"$i".2bit" >>orthoptera-genome.conf ;done
sed -i '1 i\[scaffolds]' orthoptera-genome.conf
mv orthoptera-genome.conf ../probe-design
cd ../probe-design

#Extract sequence (probes 180) around conserved loci from exemplar genomes
mkdir -p orthoptera-genome-fasta
phyluce_probe_slice_sequence_from_genomes \
    --conf orthoptera-genome.conf \
    --lastz orthoptera-genome-lastz \
    --contig_orient \
    --probes 180 \
    --name-pattern "Teleo_oc+5.temp-DUPE-SCREENED.probes_v_{}.lastz.clean" \
    --output orthoptera-genome-fasta