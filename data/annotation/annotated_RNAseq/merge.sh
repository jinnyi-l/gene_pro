#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH --time=20:00:00
#SBATCH -J Merge_BAM
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=/home/jili2251/gene_pro/data/annotation/annotated_RNAseq/Merge_BAM.%j.out
#SBATCH --error=/home/jili2251/gene_pro/data/annotation/annotated_RNAseq/Merge_BAM.%j.err

module load bioinfo-tools
module load samtools


BAM_DIR="/home/jili2251/gene_pro/data/masked-mapping/trimRNA_RepeatPac_masking_RepeatMasker_mapping"


OUTPUT_FILE="/home/jili2251/gene_pro/data/annotation/annotated_RNAseq/merged.out.bam"


cd $BAM_DIR


BAM_FILES=(
"Monthong_aril_1Aligned.sortedByCoord.out.bam"
"Monthong_aril_2Aligned.sortedByCoord.out.bam"
"Monthong_aril_3Aligned.sortedByCoord.out.bam"
"Musang_King_aril_1Aligned.sortedByCoord.out.bam"
"Musang_King_aril_2Aligned.sortedByCoord.out.bam"
"Musang_King_aril_3Aligned.sortedByCoord.out.bam"
"Musang_King_leafAligned.sortedByCoord.out.bam"
"Musang_King_rootAligned.sortedByCoord.out.bam"
"Musang_King_stemAligned.sortedByCoord.out.bam"
)


samtools merge $OUTPUT_FILE "${BAM_FILES[@]}"


samtools index $OUTPUT_FILE

