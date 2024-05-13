#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH --time=5:00:00
#SBATCH -J trimmomatic_Illumina_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=trimmomatic_job.%j.out

module load bioinfo-tools
module load trimmomatic/0.39 

java -jar $TRIMMOMATIC_HOME/trimmomatic-0.39.jar PE \
     -threads 4 \
     /proj/uppmax2024-2-7/Genome_Analysis/4_Tean_Teh_2017/illumina_data/SRR6058604_scaffold_06.1P.fastq.gz \
     /proj/uppmax2024-2-7/Genome_Analysis/4_Tean_Teh_2017/illumina_data/SRR6058604_scaffold_06.2P.fastq.gz \
     /home/jili2251/genome_analysis_project/data/preprocessed/trimmed_Illumina/SRR6058604_scaffold_06.1P.trimmed.fastq.gz \
     /home/jili2251/genome_analysis_project/data/preprocessed/trimmed_Illumina/SRR6058604_scaffold_06.1P.unpaired.fastq.gz \
     /home/jili2251/genome_analysis_project/data/preprocessed/trimmed_Illumina/SRR6058604_scaffold_06.2P.trimmed.fastq.gz \
     /home/jili2251/genome_analysis_project/data/preprocessed/trimmed_Illumina/SRR6058604_scaffold_06.2P.unpaired.fastq.gz \
     ILLUMINACLIP:$TRIMMOMATIC_HOME/adapters/TruSeq3-PE.fa:2:30:10 \
     LEADING:20 TRAILING:20 SLIDINGWINDOW:4:15 MINLEN:36
