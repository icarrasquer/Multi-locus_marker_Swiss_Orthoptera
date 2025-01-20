# !/bin/bash
source /local/anaconda3/bin/activate /home/ines/envblast/

for i in `ls *fasta`
    do
    sample=`echo $i | sed -e 's/.contigs.fasta//'`
    blastn -query "$i" -db /data/database/nt -evalue 1e-6 -outfmt 5 -out "$sample"_blast_output.txt
    cat "$sample"_blast_output.txt | grep "<Iteration_query-def>\|<Hit_def>" | sed -e 's/  <Iteration_query-def>/@/g' | tr '\n' '\t' | tr '@' '\n' | tr ' ' '_' | sed -e 's/__<Hit_def>//g' -e 's/<\/Hit_def>//g' -e 's/<\/Iteration_query-def>//g' > temp
    awk '{print "'$sample'""\t"$2}' temp > "$i"_blast_output_best_hit.txt
    done
    


