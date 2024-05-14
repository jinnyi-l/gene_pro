#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH --time=12:00:00 
#SBATCH -J map
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=flye_assembly.%j.out
#SBATCH --error=flye_assembly.%j.err


GENOME_FASTA="/home/jili2251/gene_pro/data/masked-mapping/RepeatPac_masking_RepeatMasker/pilon_masked.fasta.masked"
BRAKER_GFF="/home/jili2251/gene_pro/data/annotation/annotated_RNAseq/annotated_BRAKER/braker.gff3"
OUTPUT_PROTEINS="/home/jili2251/gene_pro/data/annotation/map_egg.fasta"
OUTPUT_PREFIX="eggNOG"
NUM_CPUS="8"  

module load bioinfo-tools 
module load eggNOG-mapper/2.1.9

# Pre-build the FASTA index "
samtools faidx "$GENOME_FASTA"

gffread -y "$OUTPUT_PROTEINS" -g "$GENOME_FASTA" "$BRAKER_GFF"



if [ ! -f "$OUTPUT_PROTEINS" ]; then
    echo "Error: Protein extraction failed."
    exit 1
fi



emapper.py -i "$OUTPUT_PROTEINS" --output "$OUTPUT_PREFIX" -m diamond --cpu "$NUM_CPUS"

echo "eggNOG-mapper analysis is complete."

