#! /usr/bin/python

from Bio import SeqIO
import wget

#Orthoptera
with open('Acheta_domesticus_genome.fna', 'rU') as infile:
    with open('Ache_do.fasta', 'w') as outf:
        for seq in SeqIO.parse(infile, 'fasta'):
            seq.name = ''
            seq.description = ''
            outf.write(seq.format('fasta'))


with open('Laupala_kohalensis_genome.fna', 'rU') as infile:
    with open('Laupa_ko.fasta', 'w') as outf:
        for seq in SeqIO.parse(infile, 'fasta'):
            seq.name = ''
            seq.description = ''
            outf.write(seq.format('fasta'))

#with open('Locusta_migratoria_genome.fna', 'rU') as infile:
#       with open('Locus_mi.fasta', 'w') as outf:
#                for seq in SeqIO.parse(infile, 'fasta'):
#                        seq.name = ''
#                        seq.description = ''
#                        outf.write(seq.format('fasta'))




Locus_mi.fasta= wget.download('http://www.insect-genome.com/data/genome_download/Locusta_migratoria/Locusta_migratoria_genomic.fasta.gz')


with open('Teleogryllus_occipitalis_genome.fna', 'rU') as infile:
    with open('Teleo_oc.fasta', 'w') as outf:
        for seq in SeqIO.parse(infile, 'fasta'):
            seq.name = ''
            seq.description = ''
            outf.write(seq.format('fasta'))

with open('Xenocatantops_brachycerus_genome.fna', 'rU') as infile:
    with open('Xeno_bra.fasta', 'w') as outf:
        for seq in SeqIO.parse(infile, 'fasta'):
            seq.name = ''
            seq.description = ''
            outf.write(seq.format('fasta'))

with open('Vandiemenella_viatica_genome.fna', 'rU') as infile:
    with open('Vandi_vi.fasta', 'w') as outf:
        for seq in SeqIO.parse(infile, 'fasta'):
            seq.name = ''
            seq.description = ''
            outf.write(seq.format('fasta'))

with open('Apteronemobius_asahinai_genome.fna', 'rU') as infile:
    with open('Apte_asa.fasta', 'w') as outf:
        for seq in SeqIO.parse(infile, 'fasta'):
            seq.name = ''
            seq.description = ''
            outf.write(seq.format('fasta'))

with open('Gryllus_bimaculatus_genome.fna', 'rU') as infile:
    with open('Gri_bi.fasta', 'w') as outf:
        for seq in SeqIO.parse(infile, 'fasta'):
            seq.name = ''
            seq.description = ''
            outf.write(seq.format('fasta'))

###Outgroup

with open('Coptotermes_formosanus_genome_out.fna', 'rU') as infile:
    with open('Copto_for_out.fasta', 'w') as outf:
        for seq in SeqIO.parse(infile, 'fasta'):
            seq.name = ''
            seq.description = ''
            outf.write(seq.format('fasta'))


with open('Timema_monikensis_genome_out.fna', 'rU') as infile:
    with open('Copto_for_out.fasta', 'w') as outf:
        for seq in SeqIO.parse(infile, 'fasta'):
            seq.name = ''
            seq.description = ''
            outf.write(seq.format('fasta'))