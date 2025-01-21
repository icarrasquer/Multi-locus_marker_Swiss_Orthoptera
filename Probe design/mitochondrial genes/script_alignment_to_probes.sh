#! /bin/bash

#Subset the fasta and gff3 files of swiss families
grep -Ff query ortho_mito.xml | tr '\n' '\t' | sed 's/<INSDSeq_locus>/+/g' | tr "+" "\n" | grep -Ff list_swiss_families | awk '{print $1}' | sed -e 's/<\/INSDSeq_locus>//g' > list_swiss_families_samples
grep -Ff list_swiss_families_samples  ortho_mito.fasta | sed -e 's/>//g' > list_swiss_families_samples_complete
fastaselect.pl  ortho_mito.fasta list_swiss_families_samples_complete > ortho_mito_swiss.fasta
grep -Ff list_swiss_families_samples ortho_mito.gff3 | grep "CDS" > ortho_mito_swiss.gff3 

#Transform the gff3 file to include the name
cut -f 1,2 ortho_mito_swiss.gff3 > temp1
cut --complement -f 1,2,3 ortho_mito_swiss.gff3 > temp3
awk -F "gene=" '{print $2}' ortho_mito_swiss.gff3 | awk -F ";" '{print $1}' | sed 's/CYT8/CYTB/g'> temp2
paste temp1 temp2 temp3 > ortho_mito_swiss_CDS.gff3
cat temp2 | sort | uniq | sed '1d' > mito_CDS
rm temp*

##Balanced subset of mitocondria after phylogenetic inference

bedtools getfasta -name -fi ortho_mito_swiss.fasta -bed ortho_mito_swiss_CDS.gff3 -fo ortho_mito_swiss_CDS.fasta

#grep -Ff list_mito_balanced_selection  ortho_mito_swiss_CDS.fasta | sed -e 's/>//g' > list_mito_balanced_selection_1

#fastaselect.pl  ortho_mito_swiss_CDS.fasta list_mito_balanced_selection_1 > ortho_mito_swiss_CDS_selection.fasta
grep -Ff list_mito_samples Orthoptera_mito_probes.fasta | sed -e 's/>//g' > list_mito_samples_names
seqtk subseq Orthoptera_mito_probes.fasta list_mito_samples_names


echo "Gene" "Length" "Nb probes" > summary 
while read a
    do
    #extract genes for the selection of species
    grep -w "$a" ortho_mito_swiss_CDS_selection.fasta | sed 's/>//g'> temp


    fastaselect.pl ortho_mito_swiss_CDS_selection.fasta temp  > ortho_mito_swiss_CDS_selection_"$a".fasta

    if [ "$a" != ATP8 ]
        then
        
        #Prepare index for probes cut
        cp ortho_mito_swiss_CDS_selection_"$a".fasta temp_ref.fasta

        java -jar /home/ines/envpicard/share/picard-2.22.1-0/picard.jar CreateSequenceDictionary R=temp_ref.fasta O=temp_ref.dict
        samtools faidx temp_ref.fasta
        awk -v FS="\t" -v OFS="\t" '{print $1 FS "0" FS ($2-1)}' temp_ref.fasta.fai > temp_ref.bed
        awk -F ":" '{print $3"_"$1}' temp_ref.bed > temp_colnames
        paste temp_ref.bed temp_colnames > temp_ref2.bed
        
        #Cut and addition of promoter T7 (5' -3' CCCTATAGTGAGTCGTATTA)
        java -jar /home/ines/envpicard/share/picard-2.22.1-0/picard.jar BedToIntervalList I=temp_ref2.bed SD=temp_ref.dict O=ortho_mito_swiss_CDS_selection_"$a".interval_list
        java -jar /home/ines/envpicard/share/picard-2.22.1-0/picard.jar BaitDesigner R=ortho_mito_swiss_CDS_selection_"$a".fasta T=ortho_mito_swiss_CDS_selection_"$a".interval_list DESIGN_NAME=ortho_mito_swiss_CDS_selection_"$a"_probes_folder BAIT_SIZE=180 RIGHT_PRIMER=CCCTATAGTGAGTCGTATTA LEFT_PRIMER=null BAIT_OFFSET=180
        

        #Create last probe

        seqkit subseq -r -180:-1 ortho_mito_swiss_CDS_selection_"$a".fasta > ortho_mito_swiss_CDS_selection_"$a"_last_probe.fasta
        sh ./script_addT7.sh ortho_mito_swiss_CDS_selection_"$a"_last_probe.fasta
        
        grep ">" ortho_mito_swiss_CDS_selection_"$a"_last_probe_ready.fasta  > temp_sample_names_previous
        awk -F ":" '{print $3}' temp_sample_names_previous | awk '{print ">"$1"_""'$a'""_bait#9"}'> temp_sample_names_new
        paste temp_sample_names_previous temp_sample_names_new > temp_namechange
        corresp_fab.pl temp_namechange ortho_mito_swiss_CDS_selection_"$a"_last_probe_ready.fasta > ortho_mito_swiss_CDS_selection_"$a"_last_probe_ready_names.fasta
        
        cat ortho_mito_swiss_CDS_selection_"$a"_last_probe_ready_names.fasta >> ortho_mito_swiss_CDS_selection_"$a"_probes_folder/ortho_mito_swiss_CDS_selection_"$a"_probes_folder.design.fasta
        cat ortho_mito_swiss_CDS_selection_"$a"_probes_folder/ortho_mito_swiss_CDS_selection_"$a"_probes_folder.design.fasta >> ortho_swiss_mitochondria_probes.fasta
        
        NB_PB=`grep -c ">" ortho_mito_swiss_CDS_selection_"$a"_probes_folder/ortho_mito_swiss_CDS_selection_"$a"_probes_folder.design.fasta`
        
    else

        sh ./script_addT7.sh ortho_mito_swiss_CDS_selection_"$a".fasta
        cat ortho_swiss_mitochondria_probes.fasta ortho_mito_swiss_CDS_selection_"$a"_ready.fasta > ortho_swiss_mitochondria_probes.fasta
    
        NB_PB=`grep -c ">" ortho_mito_swiss_CDS_selection_"$a"_ready.fasta`

    
    fi    

    rm temp_*
    done < mito_CDS

##Problem: if the length of the reference is smaller than 165, no probe is created. It affects ATP8 and the last probe
## Solution:  ATP8 add directly the T7 promoter + modiy the size of the probes to 120 OK
