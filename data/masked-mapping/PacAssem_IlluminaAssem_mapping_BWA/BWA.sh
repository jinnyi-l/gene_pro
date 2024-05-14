#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH --time=10:00:00
#SBATCH -J bwa_alignment
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=bwa_alignment.%j.out

module load bioinfo-tools
module load bwa

REF="/home/jili2251/gene_pro/data/assembly/PacBio_assembly/assembly.fasta"

if [ ! -f ${REF}.bwt ]; then
    bwa index $REF
fi

READ1="/home/jili2251/gene_pro/data/preprocessed/trimmed_Illumina/SRR6058604_scaffold_06.1P.trimmed.fastq.gz"
READ2="/home/jili2251/gene_pro/data/preprocessed/trimmed_Illumina/SRR6058604_scaffold_06.2P.trimmed.fastq.gz"

# Specify the output path for the SAM file
SAM_OUTPUT="/home/jili2251/gene_pro/data/masked-mapping/PacAssem_IlluminaAssem_mapping_BWA/paired_output.sam"

# Align the paired-end reads
bwa mem -t 4 $REF $READ1 $READ2 > $SAM_OUTPUT

