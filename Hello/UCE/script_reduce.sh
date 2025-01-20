
source /local/anaconda3/bin/activate /home/jeremy/local/envemboss


infoseq Orthoptera_USCO_UCE_probes.fasta | awk '{ if ($6 > 200) print $0}' | awk '{print $1}' | awk -F ":" '{print $4}' > list_sequences_to_reduce

source /local/anaconda3/bin/activate /home/ines/envseqtk/
seqtk subseq Orthoptera_USCO_UCE_probes.fasta list_sequences_to_reduce > UCE_to_reduce.fasta

source /local/anaconda3/bin/activate /home/ines/envseqkit/
seqkit subseq -r -200:-1 UCE_to_reduce.fasta > UCE_reduced.fasta

grep -v -Fwf list_sequences_to_reduce1 list_UCE | sed -e 's/>//g '> list_sequences_correct

source /local/anaconda3/bin/activate /home/ines/envseqtk/
seqtk subseq Orthoptera_USCO_UCE_probes.fasta list_sequences_correct > UCE_correct.fasta

cat UCE_reduced.fasta UCE_correct.fasta > Orthoptera_USCO_UCE_probes_200.fasta

infoseq Orthoptera_USCO_UCE_probes_200.fasta  | awk '{print $6}' | sort | uniq -c
