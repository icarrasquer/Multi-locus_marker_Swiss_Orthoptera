# Equi-read-arity approach

To improve the capture of UltraConserved Elements and Unique Single Copy Orthologs, single copy orthologs expected to be represent a low percentage of the sample libraries, we perform a read recalibration step before the final sequencing. Samples were distributed in pools with 96 samples each by pooling 2 uL of library per sample. After capturing with the UCE and USCO probes we received the data and followed wit the equi-read-arity approach.

## Assembly and orthology

Samples' reads were demultiplexed and cleaned.  **code_demultiplexing_cleaning** 
We assembled the reads into contigs and identifed those belonging to UCE and USCO using BLAST. **code_spades_orthology**

## Percentage of mapped samples and new pipetting volume

We mapped the samples' reads against their own contigs and calculate the number of reads mapped against UCE and USCO **code_remap**
The logarigm of the percentage of mapped reads was calculated and samples where assigned a new pipetting volume. **code_new_pipetting_volume**