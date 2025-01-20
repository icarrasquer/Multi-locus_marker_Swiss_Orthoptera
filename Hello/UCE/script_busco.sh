# !/bin/bash

source /local/anaconda3/bin/activate /home/jeremy/local/envbusco4/

for i in `ls .. | grep -v "BUSCO"`
    do
    ln -s ../"$i"/"$i".fasta .
    busco -i "$i".fasta  -l insecta_odb10 -o "$i"_busco -m genome
    done