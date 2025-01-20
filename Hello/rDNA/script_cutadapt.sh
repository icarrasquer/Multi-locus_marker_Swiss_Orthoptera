# !/bin/bash
cat *.fastq > all_reads.fastq
bgzip all_reads.fastq
awk '{print ">"$2"\n"$1}' Barcodes.fasta | sed -e 's/R/sample_/g' -e 's/M/sample_mito_/g' > Barcodes1.fasta

#! /bin/bash

source /local/anaconda3/bin/activate /home/jeremy/local/envcutadapt2/

cutadapt -a ACAAGCAGAAGACGGCATACGAGATATCTCGGTGGTCGCCGTATCATT -o temp_all_reads.fastq.gz  all_reads.fastq.gz
cutadapt -e 0.3 --max-n 0  -q 10  --no-indels -g file:Barcodes1.fasta -o demux-{name}.fastq.gz temp_all_reads.fastq.gz
