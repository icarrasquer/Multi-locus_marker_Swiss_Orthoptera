# !/bin/bash

for i in `ls *.fastq.gz`
	do
	sample=`echo $i | sed -e 's/demux-//g' -e 's/.fastq.gz//g'`
	/home/ines/envcanu/canu-2.1.1/build/bin/canu -d "$sample" -p "$sample"  -genomeSize=4k -minOverlapLength=250 -contigFilter="2 0 1.0 0.5 0"  -nanopore "$i"
	done

while read a
	do
	sample=`echo $a | awk -F "_" '{print $1"_"$2}'`
	cd "$sample";     sed -e "s/^>.*/>$a/g" "$sample".contigs.fasta > "$sample".fasta; mv "$sample".fasta ../all_assemblies/ ;     cd /data/work/Ortho_SwissBol/rDNA/MinION_ampliconSEQ/AmpliconSEQ_13samples/Analysis_25_05_2021/assembly_canu
	done < samples_name