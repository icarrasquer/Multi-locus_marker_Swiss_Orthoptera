#! /bin/bash

for i in `ls *.fna`
        do
        busco -i "$i" -o busco_"$i"_busco -m genome -l insecta_odb10 
        done