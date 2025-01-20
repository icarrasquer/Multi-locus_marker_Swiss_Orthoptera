grep "sample_35_" Orthoptera_rDNA_probes.fasta | sed 's/>//g'> temp
seqtk subseq Orthoptera_rDNA_probes.fasta temp > Orthoptera_rDNA_probes_sample_35.fasta
cutadapt -a CCCTATAGTGAGTCGTATTACCCTATAGTGAGTCGTATTA Orthoptera_rDNA_probes_sample_35.fasta  -o Orthoptera_rDNA_probes_trimmed


grep "NC_034757" Orthoptera_mito_probes_500.fasta | sed 's/>//g'> temp
seqtk subseq Orthoptera_mito_probes_500.fasta temp > Orthoptera_mito_probes_500_NC_034757.fasta 
cutadapt -a CCCTATAGTGAGTCGTATTACCCTATAGTGAGTCGTATTA Orthoptera_mito_probes_500_NC_034757.fasta  -o Orthoptera_mito_probes_500_NC_034757_trimmed

grep "xeno_bra" Orthoptera_USCO_UCE_probes_200.fasta | sed 's/>//g'> temp
seqtk subseq Orthoptera_USCO_UCE_probes_200.fasta temp > Orthoptera_USCO_UCE_probes_200_xeno_bra.fasta 
cutadapt -a CCCTATAGTGAGTCGTATTACCCTATAGTGAGTCGTATTA Orthoptera_USCO_UCE_probes_200_xeno_bra.fasta -o Orthoptera_USCO_UCE_probes_200_xeno_bra_trimmed
