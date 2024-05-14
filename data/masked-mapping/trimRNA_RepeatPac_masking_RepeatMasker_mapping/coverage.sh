#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1  
#SBATCH --time=01:00:00
#SBATCH -J Compute_Coverage
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=/home/jili2251/gene_pro/data/masked-mapping/trimRNA_RepeatPac_masking_RepeatMasker_mapping/Compute_Coverage.%j.out
#SBATCH --error=/home/jili2251/gene_pro/data/masked-mapping/trimRNA_RepeatPac_masking_RepeatMasker_mapping/Compute_Coverage.%j.err

module load bioinfo-tools
module load samtools  

OUTPUT_DIR="/home/jili2251/gene_pro/data/masked-mapping/trimRNA_RepeatPac_masking_RepeatMasker_mapping"
COVERAGE_FILE="${OUTPUT_DIR}/coverage.txt"

echo -e "Sample\tAverage Coverage" > $COVERAGE_FILE

for BAM_FILE in ${OUTPUT_DIR}/*.bam; do
    if [ -f "$BAM_FILE" ]; then
        SAMPLE_NAME=$(basename $BAM_FILE ".bam")
    
        AVG_COV=$(samtools depth -a $BAM_FILE | awk '{sum+=$3} END {if (NR>0) print sum/NR; else print "NA"}')
        
        echo -e "${SAMPLE_NAME}\t${AVG_COV}" >> $COVERAGE_FILE
    fi
done

echo "Coverage computation complete. Results saved to $COVERAGE_FILE"

