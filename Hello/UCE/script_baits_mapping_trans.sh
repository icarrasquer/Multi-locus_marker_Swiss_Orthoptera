#! /bin/bash
#Folder : probe-design-test-trans

mkdir -p orthoptera-trans-lastz

source /local/anaconda3/bin/activate /home/jeremy/local/envphyluce
phyluce_probe_run_multiple_lastzs_sqlite \
    --probefile /data/work/Ortho_SwissBol/UCE_genomes/Main_nov_2021/probe-design-test0.7_5/taxon-sets/insilico-incomplete/mafft-gblocks-clean/orthoptera_probe_0.7_5_290.probes \
    --scaffoldlist `cat /data/work/Ortho_SwissBol/UCE_genomes/other_analysis/UCE_transcriptomes/transcriptomes/list_swiss_fam-trans` \
    --genome-base-path  /data/work/Ortho_SwissBol/UCE_genomes/other_analysis/UCE_transcriptomes/transcriptomes/ \
    --identity 70 \
    --cores 16 \
    --db orthoptera-290-trans.sqlite \
    --output orthoptera-trans-lastz



cp /data/work/Ortho_SwissBol/UCE_genomes/other_analysis/UCE_transcriptomes/transcriptomes/orthoptera-transcriptome.conf .
sed -e 's/Ortho_SwissBol/Ortho_SwissBol\/UCE_genomes\/other_analysis/g' orthoptera-transcriptome.conf > orthoptera-transcriptome1.conf 
mv orthoptera-transcriptome1.conf orthoptera-transcriptome.conf
grep -Ff sample_list1 orthoptera-transcriptome.conf > orthoptera-transcriptome-mapped.conf 
sed -i '1 i\[scaffolds]' orthoptera-transcriptome-mapped.conf

#Extract sequence (probes 180) around conserved loci from exemplar genomes
mkdir -p orthoptera-trans-fasta
phyluce_probe_slice_sequence_from_genomes \
    --conf orthoptera-transcriptome-mapped.conf \
    --lastz orthoptera-trans-lastz \
    --contig_orient \
    --probes 180 \
    --name-pattern "orthoptera_probe_0.7_5_290.probes_v_{}.lastz.clean" \
    --output orthoptera-trans-fasta



/data/work/Ortho_SwissBol/UCE_genomes/Main_nov_2021/probe-design-test-trans/orthoptera-trans-lastz/orthoptera_probe_0.7_5_290.probes_v_Ach_do_PRJNA286330_trans.lastz.clean 

/data/work/Ortho_SwissBol/UCE_genomes/Main_nov_2021/probe-design-test-trans/orthoptera-trans-lastz/orthoptera_probe_0.7_5_290_v_Ach_do_PRJNA286330_trans.lastz.clean


#Folder: probe-design
source /local/anaconda3/bin/activate /home/jeremy/local/envphyluce

phyluce_probe_get_multi_fasta_table \
    --fastas orthoptera-trans-fasta\
    --output multifastas.sqlite \
    --base-taxon Teleo_oc

phyluce_probe_query_multi_fasta_table \
    --db multifastas.sqlite \
    --base-taxon Teleo_oc

phyluce_probe_query_multi_fasta_table \
    --db multifastas.sqlite \
    --base-taxon Teleo_oc \
    --output Teleo_oc+5-back-to-17.conf \
    --specific-counts 17
