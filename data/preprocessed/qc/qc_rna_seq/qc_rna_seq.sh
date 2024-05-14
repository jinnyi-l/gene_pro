#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH --time=5:00:00
#SBATCH -J FastQC_RNAseq_analysis
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=FastQC_RNAseq_job.%j.out

module load bioinfo-tools
module load FastQC/0.11.9 

UNTRIMMED_PATH="/proj/uppmax2024-2-7/Genome_Analysis/4_Tean_Teh_2017/transcriptome/untrimmed"
TRIMMED_PATH="/home/jili2251/gene_pro/data/preprocessed/trimmed_RNA"

FASTQC_PATH="/home/jili2251/gene_pro/data/preprocessed/qc/qc_rna_seq"

# Run FastQC on untrimmed RNA-seq data
fastqc -o $FASTQC_PATH -t 4 \
  $UNTRIMMED_PATH/SRR6040095_scaffold_06.1.fastq.gz \
  $UNTRIMMED_PATH/SRR6040095_scaffold_06.2.fastq.gz

# Run FastQC on trimmed RNA-seq data
fastqc -o $FASTQC_PATH -t 4 \
  $TRIMMED_PATH/SRR6040095_scaffold_06.1P.trimmed.fastq.gz \
  $TRIMMED_PATH/SRR6040095_scaffold_06.2P.trimmed.fastq.gz

