#! /bin/bash
#Folder probes-design-test/taxon-sets/insilico-incomplete/mafft-gblocks-clean

source /local/anaconda3/bin/activate /home/jeremy/local/envamas/

for i in `ls *.nexus`
    do

    AMAS.py summary -i $i -f nexus -d dna -o temp 

    NSEQ=$(cat temp | awk '{print $2}' | sed '2q;d')

    LENGHT=$(cat temp | awk '{print $3}' | sed '2q;d')

    VARSITES=$(cat temp | awk '{print $8}' | sed '2q;d')

    echo $i $NSEQ   $LENGHT  $VARSITES >> list_nseq_lenght_varsites
    done


awk '$2 > 5' list_nseq_lenght_varsites | awk '$3 > 119' | awk '$4 < 0.5'  > list_nseq_lenght_varsites_subset
#336 UCE if we do not consider the filter 0.5 variability

#Trim Time_mo and sort 

source /local/anaconda3/bin/activate /home/ines/envgoalign


for i in `ls *.nexus`
    do
    name=`echo $i | sed -e 's/.nexus//g'`
    goalign subset -f ensifera_names -i "$i" --nexus -o "$name"-ensifera-sort.nexus
    goalign subset -f caelifera_names -i "$i" --nexus -o "$name"-caelifera-sort.nexus
    done

#Obtain pairwise matrix and select those UCE with 10% max of divergence within Ensifera ou Caelifera

source /local/anaconda3/bin/activate /home/jeremy/local/envemboss/

for i in `ls *-sort.nexus`
    do
    name=`echo $i | sed -e 's/-sort.nexus//g'`
    distmat -sequence "$i" -outfile "$name"-sort-table -nucmethod 3
    done




while read a
    do
    
    cat "$a"-ensifera-sort-table | sed '1,7d' | awk '{print $3}' | awk '{if(NR==2) print $0}' > temp_en
    cat "$a"-ensifera-sort-table | sed '1,7d' | awk '{print $2}' | sed '1d' | sed '3d' >> temp_en

    n_en=$(awk '$1 < 10' temp_en | wc -l)

    cat "$a"-caelifera-sort-table | sed '1,7d' | awk '{print $3}' | awk '{if(NR==2) print $0}' > temp_ca
    cat "$a"-caelifera-sort-table | sed '1,7d' | awk '{print $2}' | sed '1d' | sed '3d' >> temp_ca

    n_ca=$(awk '$1 < 10' temp_ca | wc -l)

    echo "$a" "$n_en" "$n_ca" >> list_UCE_n10

    done < orthoptera-genome-subset.conf


awk '($2 == 1 && $3 == 1)' list_UCE_n10 | wc -l


#Extract fasta secuences

source /local/anaconda3/bin/activate /home/jeremy/local/envemboss/

for i in `ls *nexus`
    do
    uce=`echo $i | sed -e 's/.nexus//g'`
    seqret -sequence "$i" -outseq temp.fasta
    sed -e 's/-//g' temp.fasta > temp1.fasta
    grep ">" temp1.fasta > temp_names
    cat temp_names | awk '{print $1"\t"$1"-""'$uce'"}' > temp_file
    corresp_fab.pl temp_file temp1.fasta > "$uce".fasta
    rm temp*
    done

#Add T7 promoter

for i in `ls *.fasta`
    do
    uce=`echo $i | sed -e 's/.fasta//g'`
    awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' < "$i" | sed '/^>/ !{s/$/CCCTATAGTGAGTCGTATTA/}' | sed '1d' >> ortho_uce_probes.fasta
    done





