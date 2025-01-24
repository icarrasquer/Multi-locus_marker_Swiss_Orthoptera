# Design of USCO probes in Orthoptera

We kept the same 7 genomes -3 Ensifera, 3 Caelifera and the Phasmatodea outgroup- used for the definition of UltraConserved Elements (see README of UCE for more details) : 
[*Gryllus bimaculatus*](https://www.ncbi.nlm.nih.gov/genome/?term=txid6999[orgn])
[*Laupala kohalensis*](https://www.ncbi.nlm.nih.gov/genome/?term=txid109027[orgn])
*Locusta migratoria* (ik5) 
[*Teleogryllus occipitalis*](https://www.ncbi.nlm.nih.gov/genome/?term=txid431949[orgn])
[*Timema monikensis*](https://www.ncbi.nlm.nih.gov/genome/82511?genome_assembly_id=609578) (outgroup) 
[*Vandiemenella viatica*](https://www.ncbi.nlm.nih.gov/genome/?term=txid431949[orgn]) 
[*Xenocatantops brachycerus*](https://www.ncbi.nlm.nih.gov/genome/?term=txid227619[orgn])

## BUSCO

The Unique Single Copy Orthologs were identified in each gneome using Busco v4 and the 1 367 loci known for Insecta. **script_busco**
Exon sequences provided by BUSCO were subsequently aligned.  **script_alignment.sh**

## Probe extraction
Probes of a 120 bp were extracted from each end of the alignment. **script_extract.sh**
We BLASTed the probes against the genome to ensure that no introns were included in the sequence. **script_balst.sh**


