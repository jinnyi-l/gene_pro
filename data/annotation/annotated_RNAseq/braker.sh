#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16                   
#SBATCH --time=72:00:00         
#SBATCH -J BRAKER_annotation
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=/home/jili2251/gene_pro/data/annotation/annotated_RNAseq/BRAKER_annotation.%j.out
#SBATCH --error=/home/jili2251/gene_pro/data/annotation/annotated_RNAseq/BRAKER_annotation.%j.err

module load bioinfo-tools
module load star
module load braker
module load augustus

module load perl/5.32.1
module load perl_modules/5.32.1
module load BEDTools/2.31.1
module load HISAT2/2.2.1
module load StringTie/2.2.1
module load gffread/0.12.7
module load samtools/1.19
module load sratools/3.0.7
module load diamond/2.1.9
module load spaln/3.0.3

module load GeneMark-ETP/1.02-20231213-dd8b37b


GENOME_DIR="/home/jili2251/gene_pro/data/masked-mapping/RepeatPac_masking_RepeatMasker"
GENOME_FILE="pilon_masked.fasta.masked"
BAM_FILE="/home/jili2251/gene_pro/data/annotation/annotated_RNAseq/merged.out.bam"  # Single merged BAM file
BRAKER_OUTPUT_BASE="/home/jili2251/gene_pro/data/annotation/annotated_RNAseq/annotated_BRAKER"  # Specific output directory


mkdir -p "$BRAKER_OUTPUT_BASE"


SPECIES_DIR="/home/jili2251/.augustus/species/your_species_name"
if [ -d "$SPECIES_DIR" ]; then
    rm -rf "$SPECIES_DIR"
fi


braker.pl --genome=$GENOME_DIR/$GENOME_FILE \
          --bam=$BAM_FILE \
          --species=your_species_name \
          --softmasking \
          --workingdir=$BRAKER_OUTPUT_BASE

