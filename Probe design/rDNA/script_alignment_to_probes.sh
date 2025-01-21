#! /bin/bash
#Script cuting genes into probes of 130 bp including the T7 promoter

# $1 fasta file of complete sequences (genes + intergenic seq) 
FASTA=$(echo $1 | sed -e 's/.fasta//')
sed $'s/[^[:print:]\t]//g' "$1" > temp.fasta
cat temp.fasta > "$1"

# $2 gff file of annotated genes in the $1 sequences
GFF=`echo $2 | sed -e 's/.gff//'`
sed $'s/[^[:print:]\t]//g' "$2" > temp.gff
cat temp.gff > "$2"
# $3 list of genes to cut

#Transform the gff file to include the gene name
cut -f 1,2 "$2" > temp1
cut --complement -f 1,2,3 "$2" > temp3
awk -F "Name=" '{print $2}' "$2" | awk -F ";" '{print $1}' > temp2
paste temp1 temp2 temp3 > "$GFF"_CDS.gff
rm temp*

bedtools getfasta -name -fi "$1" -bed "$GFF"_CDS.gff -fo "$FASTA"_CDS.fasta

echo "Gene" "Length" "Nb probes" > "$FASTA"_probes_summary 
while read a
    do
    #extract the genes for all sequences
    grep -w "$a" "$FASTA"_CDS.fasta | sed 's/>//g'> temp

    fastaselect.pl "$FASTA"_CDS.fasta temp  > "$FASTA"_CDS_"$a".fasta
    
    if [ `infoseq "$FASTA"_CDS_"$a".fasta |  awk '{print $6}' | awk 'NR == 8 {print; exit}'` -gt 200 ]
        #BIG genes
        then
        
        #Prepare index for probes cut
        cp "$FASTA"_CDS_"$a".fasta temp_ref.fasta

        java -jar /home/ines/envpicard/share/picard-2.22.1-0/picard.jar CreateSequenceDictionary R=temp_ref.fasta O=temp_ref.dict
        samtools faidx temp_ref.fasta
        awk -v FS="\t" -v OFS="\t" '{print $1 FS "0" FS ($2-1)}' temp_ref.fasta.fai > temp_ref.bed
        awk -F ":" '{print $3"_"$1}' temp_ref.bed > temp_colnames
        paste temp_ref.bed temp_colnames > temp_ref2.bed
        
        #Cut of probes and addition of promoter T7 (5' -3' CCCTATAGTGAGTCGTATTA)
        java -jar /home/ines/envpicard/share/picard-2.22.1-0/picard.jar BedToIntervalList I=temp_ref2.bed SD=temp_ref.dict O=temp_ref.interval_list
        java -jar /home/ines/envpicard/share/picard-2.22.1-0/picard.jar BaitDesigner R=temp_ref.fasta T=temp_ref.interval_list DESIGN_NAME="$FASTA"_CDS_"$a"_probes_folder BAIT_SIZE=130 RIGHT_PRIMER=CCCTATAGTGAGTCGTATTA LEFT_PRIMER=null BAIT_OFFSET=130
        
        #Create last probe
        seqkit subseq -r -130:-1 "$FASTA"_CDS_"$a".fasta >  "$FASTA"_CDS_"$a"_last_probe.fasta
        sh ./script_addT7.sh "$FASTA"_CDS_"$a"_last_probe.fasta
        
        grep ">" "$FASTA"_CDS_"$a"_last_probe_ready.fasta  > temp_sample_names_previous
        awk -F ":" '{print $3}' temp_sample_names_previous | awk '{print ">"$1"_""'$a'""_bait#99"}'> temp_sample_names_new
        paste temp_sample_names_previous temp_sample_names_new > temp_name_change
        corresp_fab.pl temp_name_change "$FASTA"_CDS_"$a"_last_probe_ready.fasta > "$FASTA"_CDS_"$a"_last_probe_ready_names.fasta
        
        cat "$FASTA"_CDS_"$a"_last_probe_ready_names.fasta >> "$FASTA"_CDS_"$a"_probes_folder/"$FASTA"_CDS_"$a"_probes_folder.design.fasta
        cat "$FASTA"_CDS_"$a"_probes_folder/"$FASTA"_CDS_"$a"_probes_folder.design.fasta >> "$FASTA"_final_probes.fasta
        
        NB_PB=`grep -c ">" "$FASTA"_CDS_"$a"_probes_folder/"$FASTA"_CDS_"$a"_probes_folder.design.fasta`
        
    else
        #Small genes
        sh ./script_addT7.sh "$FASTA"_CDS_"$a".fasta 
        cat "$FASTA"_CDS_"$a"_ready.fasta >> "$FASTA"_final_probes.fasta
    
        NB_PB=`grep -c ">" "$FASTA"_CDS_"$a"_ready.fasta`

    
    fi
    rm temp_*
    done < "$3"

### Add the T7 promoter
for i in $(ls *fasta)

    do
    sample=$(echo $i | sed -e 's/.fasta//g')
    cat "$i" | seqkit mutate -i 0:GTGACTGGAGTTCAGACG | seqkit mutate -i -1:AGAT > "$sample"_amplification.fasta

    done





