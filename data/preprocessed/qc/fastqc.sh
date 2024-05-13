#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH --time=5:00:00
#SBATCH -J FastQC_analysis
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=FastQC_job.%j.out

module load bioinfo-tools
module load FastQC/0.11.9  # Ensure that FastQC module is loaded, adjust version as necessary

# Path to the directory with raw and trimmed data
DATA_PATH="/proj/uppmax2024-2-7/Genome_Analysis/4_Tean_Teh_2017/illumina_data"
TRIMMED_PATH="/home/jili2251/gene_pro/data/preprocessed/trimmed_Illumina"

# Output directory for FastQC results
FASTQC_PATH="/home/jili2251/gene_pro/data/preprocessed/qc"

# Run FastQC on untrimmed data
fastqc -o $FASTQC_PATH -t 4 \
  $DATA_PATH/SRR6058604_scaffold_06.1P.fastq.gz \
  $DATA_PATH/SRR6058604_scaffold_06.2P.fastq.gz

# Run FastQC on trimmed data
fastqc -o $FASTQC_PATH -t 4 \
  $TRIMMED_PATH/SRR6058604_scaffold_06.1P.trimmed.fastq.gz \
  $TRIMMED_PATH/SRR6058604_scaffold_06.2P.trimmed.fastq.gz

