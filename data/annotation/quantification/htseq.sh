#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH --time=20:00:00
#SBATCH -J HTSeq_count
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=/home/jili2251/gene_pro/data/annotation/quantification/HTSeq_count.%j.out
#SBATCH --error=/home/jili2251/gene_pro/data/annotation/quantification/HTSeq_count.%j.err

module load bioinfo-tools
module load htseq  
module load samtools  

BAM_DIR="/home/jili2251/gene_pro/data/masked-mapping/trimRNA_RepeatPac_masking_RepeatMasker_mapping"
ANNOTATED_GTF="/home/jili2251/gene_pro/data/annotation/annotated_RNAseq/annotated_BRAKER/corrected.gtf"
OUTPUT_DIR="/home/jili2251/gene_pro/data/annotation/quantification"


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



for BAM_FILE in "${BAM_FILES[@]}"; do
   
    FULL_BAM_PATH="$BAM_DIR/$BAM_FILE"
  
    OUTPUT_COUNTS="$OUTPUT_DIR/${BAM_FILE%.bam}_counts.txt"
    
    echo "Running HTSeq-count on $BAM_FILE..."
    htseq-count -f bam -s no -t exon -i gene_id $FULL_BAM_PATH $ANNOTATED_GTF > $OUTPUT_COUNTS
    
    if [ $? -ne 0 ]; then
        echo "HTSeq-count failed for $BAM_FILE"
        exit 1
    fi
done


