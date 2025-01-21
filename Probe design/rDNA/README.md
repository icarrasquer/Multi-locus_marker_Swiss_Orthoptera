## Ribosomal DNA of the reference genomes

We extracted the rDNA of 6 genomes used for the UCE and USCO identification by BLASTing the few available rDNA sequencenes.

Table 2.
| Reference   genome | Suborder |               Species              | Complete rDNA seq. |    18S   |   5.8S   |   28S   |
|:------------------:|:--------:|:----------------------------------:|:------------------:|:--------:|:--------:|:-------:|
| Vandi_vi           | C        |        *Vandiemenella viatica*     | Y                  |          |          |         |
| Locus mi           | C        |        *Locusta migratoria*        |                    | partial  | complete | partial |
| Xeno_bra           | C        |        *Xenocatantops brachycerus* | Y                  |          |          |         |
| Laupa_ko           | E        | *Laupala kohalensis*               |                    | complete |          | partial |
| Gri_bi             | E        |        *Gryllus bimaculatus*       |                    | complete |          | partial |
| Teleo_oc           | E        |        *Teleogryllus occipitalis*  |                    | complete | complete | partial |

Only the sequences of *Vandiemenella viatica* and *Xenocatantops brachycerus* were complet enough and were kept.

# rDNA probes

Given that only two Caelifera ribosomal sequences were available at the NCBI for Orthoptera, we amplified the complete ribosomal DNA of 35 Orthoptera using the eurakaryote conserved primers  [CHIR_18S_F4 (GGCTACCACATCYAARGAAGGCAGCAG) and CHIR_28S_R8(TCGGCAGGTGAGTYGTTRCACAYTCCT)](https://academic.oup.com/gigascience/article/8/5/giz006/5368330). The primers were designed using alignments of partial 18S and 28S sequences of ∼1,000 species of eukaryotes, with a focus on animals, they target highly conserved regions.

After amplification, We designed a AmpliconSEQ protocol to add our own ILLPCR2_X barcodes and the Oxford Nanopore adapters for sequencing. We sequenced 16 samples using a R9.4.1 MinION flowcell.

![The structure of the reads after the implementation of the AmpliconSEQ protocol](Read_scheme.png)
xxxxxx corresponds to the 6 bp barcode


## Basecalling

We perform the basecalling using Guppy. **script_guppy.sh**

The total number of reads sequenced was 2 476 456. 

## Demultiplexing

We demultiplexed using [cutadapt](https://cutadapt.readthedocs.io/en/stable/guide.html). **script_cutadapt** After demultiplexing 60,1% of reads are kept.

## Removal of contaminants and assembly

1. Retrieval of the ribosomal DNA sequence of *Vandiemenella viatica*. **script_blast_canu.sh**
2. Blast of reads of the against the rDNA sequence of Vandi_vi reference genome. **script_blast_canu.sh**
3. Removal of non-orthoptera sequences according to legnth (700, 1000, 1500) and % of similarity (75, 80, 85). **script_blast_canu.sh**
4. Assembly with [Canu](https://canu.readthedocs.io/en/latest/parameter-reference.html#global-options). **script_blast_canu.sh**
5. Sequences were BLASTed against the rNCBI database and a phylogenetic tree was infered to validate they belonged to Orthoptera. **script_blast_ncbi.sh**

## Probes desing

The sequences were cut into 130 bp probes using a custom script. 
The T7 promoter was added at the 3' end to every probe. **script_alignment_to_probes.sh**


## Results

Table 1.
|    Sample    | Suborder |          Family          |                 Species                 |  Demultiplexed reads  | Assembly |
|:------------:|:--------:|:------------------------:|:---------------------------------------:|:---------------------:|:--------:|
|   Sample 1   |     E    |       Tettigoniidae      |           *Rhacocleis annulata*         |        139 039        |          |
|   Sample 10  |     C    |         Acrididae        |  *Odontopodisma   decipiens insubrica * |         30 562        |          |
|   Sample 14  |     C    |       Tridactylidae      |             *Xya variegata*             |         73 707        |          |
|   Sample 17  |     E    |       Tettigoniidae      |           *Anonconotus alpinus*         |         54 600        |     Y    |
|  Sample 19*  |     C    |         Acrididae        |            *Oedaleus decorus *          |         27 998        |     Y    |
|  Sample 20*  |     E    |       Tettigoniidae      |         *Meconema thalassinum*          |         50 382        |     Y    |
|   Sample 21  |     E    |         Gryllidae        |           *Gryllus campestris*          |        572 748        |     Y    |
|   Sample 22  |     E    |       Trigonidiidae      |       *Pteronemobius lineolatus*        |         58 948        |     Y    |
|   Sample 25  |     C    |         Acrididae        |       *Myrmeleotettix   maculatus*      |         34 818        |          |
|   Sample 27  |     C    |         Acrididae        |        *Epacromius   tergestinus*       |        224 075        |     Y    |
|   Sample 28  |     E    |        Rhaphidophoridae  |          *Troglophilus cavicola*        |         45 671        |     Y    |
|   Sample 29  |     C    |         Acrididae        |          *Aiolopus   strepens*          |         43 814        |     Y    |
|   Sample 3   |     C    |        Tetrigidae        |       *Uvarovitettix   depressus*       |         46 205        |          |
|   Sample 30  |     E    |       Tettigoniidae      |         *Conocephalus   fuscus*         |         29 180        |     Y    |
|   Sample 34  |     C    |         Acrididae        |          *Podismopsis   keisti*         |         22 799        |     Y    |
|  Sample 35*  |     E    |       Tettigoniidae      |        *Leptophyes   albovittata*       |         51 059        |     Y    |
|     TOTAL    |          |                          |                                         |       1 505 605       |          |

Contigs for 11 out of 16 samples.
