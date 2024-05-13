#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1  
#SBATCH --time=01:00:00
#SBATCH -J Compute_Read_Stats
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=/home/jili2251/gene_pro/data/masked-mapping/trimRNA_RepeatPac_masking_RepeatMasker_mapping/Compute_Read_Stats.%j.out
#SBATCH --error=/home/jili2251/gene_pro/data/masked-mapping/trimRNA_RepeatPac_masking_RepeatMasker_mapping/Compute_Read_Stats.%j.err

module load bioinfo-tools
module load samtools  

OUTPUT_DIR="/home/jili2251/gene_pro/data/masked-mapping/trimRNA_RepeatPac_masking_RepeatMasker_mapping"
RESULT_FILE="${OUTPUT_DIR}/read_mapping_stats.txt"


echo -e "Sample\tTotal Reads\tMapped Reads\tPercentage Mapped" > $RESULT_FILE

# Loop through BAM files in the directory and compute stats
for BAM_FILE in ${OUTPUT_DIR}/*Aligned.sortedByCoord.out.bam; do
    if [ -f "$BAM_FILE" ]; then
        
        SAMPLE_NAME=$(basename $BAM_FILE ".Aligned.sortedByCoord.out.bam")

        total_reads=$(samtools view -c $BAM_FILE)

        mapped_reads=$(samtools view -c -F 4 $BAM_FILE)

        # Calculate the percentage of mapped reads
        if [ "$total_reads" -gt 0 ]; then  # Prevent division by zero
            percentage=$(echo "scale=2; $mapped_reads*100/$total_reads" | bc)
        else
            percentage="NA"
        fi

        # Write results to the file
        echo -e "${SAMPLE_NAME}\t$total_reads\t$mapped_reads\t$percentage%" >> $RESULT_FILE
    fi
done

echo "Mapping statistics computed and saved to $RESULT_FILE"

