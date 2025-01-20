# Mitocondrial DNA


## Complete mitochondrion available for Orthoptera
07.02.2022
Download 245 orthoptera mitogenomes. 200 belong to Orthoptera 7 families present in Switzerland ( there are 8 Orthoptera families)

Acrididae 126 -> 10 -> 2
Catantopidae 0
Gryllidae 20 -> 10 -> 1
Gryllotalpidae 3 -> 1
Rhaphidophoridae 3
Tetrigidae 6 -> 4
Tettigoniidae 41 -> 10 -> 1
Tridactylidae 1

Initally, we infered the phylogeny of the more abundant families (Acrididae, Gryllidae, Tettigoniidae). For them, we selected 10 mitochondria, prioritising swiss sp or european genus.

At the very end, 
Extract only one per family

| Family           | NCBI Code        |
|------------------|-------------|
| Gryllotalpidae   | NC_006678.1 |
| Rhaphidophoridae | NC_011306.1  |
| Tetrigidae       | NC_018543.1 |
| Tridactylidae    | NC_014488   |
| Gryllidae        | NC_034799.1 |
| Tettigoniidae    | NC_034757.1 |
| Acrididae        | NC_011115.1 |
| Acrididae        | NC_011305.1 |


## Alignment of genes

Extraction of genes (getfasta) and **script_alignment_to_probes.sh**

| Gene     | Length  
|----------|---------|
| ATP6     | 672     | 
| **ATP8** | **156** | 
| COX1     | 1539    | 
| COX2     | 682     | 
| COX3     | 804     | 
| CYTB     | 1135    | 
| ND1      | 945     | 
| ND2      | 1000    | 
| ND3      | 357     | 
| ND4      | 1325    |
| ND4L     | 291     |
| ND5      | 1720    | 
| ND6      | 495     | 
| Total    | 11121   | 

The probes needed to be of 170 bp to not exceed 500 probes, which would imply an increase of the price. 
