# !/bin/bash


cat blast_output.xml | grep "<Iteration_query-def>\|<Hit_def>" | sed -e 's/  <Iteration_query-def>/@/g' | tr '\n' '\t' | tr '@' '\n' | tr ' ' '_' | sed -e 's/__<Hit_def>//g' -e 's/<\/Hit_def>//g' -e 's/<\/Iteration_query-def>//g' > BLAST_all