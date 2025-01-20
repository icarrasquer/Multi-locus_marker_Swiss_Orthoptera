#! /bin/bash
#Folder probes-design

#Aligments are not as good as after the insilo capture, script depreciated

source /local/anaconda3/bin/activate /home/jeremy/local/envphyluce


#These are the complete UCE sequences of EACH genome--> not aligned
#Extract complete sequence (flank 10) around conserved loci from exemplar genomes
mkdir -p orthoptera-genome-fasta-flank-10
 \
    --conf orthoptera-genome.conf \
    --lastz orthoptera-genome-lastz \
    --flank 10 \
    --name-pattern "Teleo_oc+7.temp-DUPE-SCREENED.probes_v_{}.lastz.clean" \
    --output orthoptera-genome-fasta-flank-10

#Extract complete sequence (flank 10) around conserved loci from exemplar genomes
mkdir orthoptera-genome-fasta-flank-0
phyluce_probe_slice_sequence_from_genomes \
    --conf orthoptera-genome.conf \
    --lastz orthoptera-genome-lastz \
    --flank 0 \
    --name-pattern "Teleo_oc+7.temp-DUPE-SCREENED.probes_v_{}.lastz.clean" \
    --output orthoptera-genome-fasta-flank-0


cat Teleo_oc+7-back-to-7.conf | sed -e '1,3d' | awk '{print $0"|"}'> list_UCE_to_keep

cd orthoptera-genome-fasta-flank-0

cp ../list_UCE_to_keep .

for i in ache_do.fasta apte_asa.fasta gri_bi.fasta laupa_ko.fasta locus_mi.fasta teleo_oc.fasta vandi_vi.fasta xeno_bra.fasta
    do 
    name=`echo $i | sed -e 's/.fasta//g'`
    grep -f list_UCE_to_keep "$i" | sed -e 's/>//g'> "$name"_list
    /home/ines/bin/fastaselect.pl "$i" "$name"_list > "$name"_UCE.fasta
    done

source /local/anaconda3/bin/activate /home/ines/envmafft/

while read a
    do
    uce=`echo $a | sed -e 's/|//g'`
    for i in ache_do.fasta apte_asa.fasta gri_bi.fasta laupa_ko.fasta locus_mi.fasta teleo_oc.fasta vandi_vi.fasta xeno_bra.fasta
        do
        sample=`echo $i | sed -e 's/.fasta//g'`
        grep -A 1 "$a" "$i"  | sed -e "s/>/>$sample/" | sed -e "s/>/>$uce/"   >> "$uce".fasta
        done
    mafft --preservecase --auto --adjustdirection "$uce".fasta > "$uce"_genome_align.fasta
    rm "$uce".fasta
    mv "$uce"_genome_align.fasta alignments/
    done < list_UCE_to_keep1
