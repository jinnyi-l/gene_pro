#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH --time=20:00:00
#SBATCH -J pilon_correction
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=pilon_correction.%j.out

module load bioinfo-tools
module load bwa
module load samtools
module load pilon

# Paths
REF="/home/jili2251/genome_analysis_project/data/assembly/PacBio_assembly/assembly.fasta"
READ1="/home/jili2251/genome_analysis_project/data/preprocessed/trimmed_Illumina/SRR6058604_scaffold_06.1P.trimmed.fastq.gz"
READ2="/home/jili2251/genome_analysis_project/data/preprocessed/trimmed_Illumina/SRR6058604_scaffold_06.2P.trimmed.fastq.gz"
SAM_OUTPUT="/home/jili2251/genome_analysis_project/data/masked-mapping/PacAssem_IlluminaAssem_mapping_BWA/paired_output.sam"
BAM_OUTPUT="/home/jili2251/genome_analysis_project/data/masked-mapping/PacAssem_IlluminaAssem_mapping_BWA/paired_output_sorted.bam"

# Index the reference genome if not already indexed
if [ ! -f ${REF}.bwt ]; then
    bwa index $REF
fi

# Align the reads
bwa mem -t 4 $REF $READ1 $READ2 > $SAM_OUTPUT

# Convert SAM to sorted BAM
samtools view -bS $SAM_OUTPUT | samtools sort -o $BAM_OUTPUT

# Index the BAM file
samtools index $BAM_OUTPUT

# Run Pilon
java -Xmx16G -jar $PILON_HOME/pilon.jar --genome $REF --frags $BAM_OUTPUT --output corrected_assembly --changes
