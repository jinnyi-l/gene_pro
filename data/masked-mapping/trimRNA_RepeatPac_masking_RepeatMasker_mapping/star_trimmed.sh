#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8  # Increased number of nodes for better performance
#SBATCH --time=20:00:00
#SBATCH -J STAR_alignment
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=/home/jili2251/gene_pro/data/masked-mapping/trimRNA_RepeatPac_masking_RepeatMasker_mapping/STAR_alignment.%j.out
#SBATCH --error=/home/jili2251/gene_pro/data/masked-mapping/trimRNA_RepeatPac_masking_RepeatMasker_mapping/STAR_alignment.%j.err

module load bioinfo-tools
module load star

GENOME_DIR="/home/jili2251/gene_pro/data/masked-mapping/RepeatPac_masking_RepeatMasker"
GENOME_FILE="pilon_masked.fasta.masked"
STAR_OUTPUT="/home/jili2251/gene_pro/data/masked-mapping/trimRNA_RepeatPac_masking_RepeatMasker_mapping"

STAR --runThreadN 8 \
     --runMode genomeGenerate \
     --genomeDir $GENOME_DIR \
     --genomeFastaFiles $GENOME_DIR/$GENOME_FILE \
     --genomeSAindexNbases 12 

# Define array of input and output names
declare -a read1=("/proj/uppmax2024-2-7/Genome_Analysis/4_Tean_Teh_2017/transcriptome/trimmed/SRR6156069_scaffold_06.1.fastq.gz")
declare -a read2=("/proj/uppmax2024-2-7/Genome_Analysis/4_Tean_Teh_2017/transcriptome/trimmed/SRR6156069_scaffold_06.2.fastq.gz")
declare -a output_names=("Monthong_aril_1")

for i in "${!read1[@]}"; do
    READ1="${read1[$i]}"
    READ2="${read2[$i]}"
    OUT_NAME="${output_names[$i]}"
    STAR --runThreadN 8 \
         --genomeDir $GENOME_DIR \
         --readFilesIn $READ1 $READ2 \
         --readFilesCommand zcat \
         --outSAMtype BAM SortedByCoordinate \
         --outFileNamePrefix $STAR_OUTPUT/$OUT_NAME \
         --outSAMunmapped Within  
done

