#!/bin/bash
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH --time=12:00:00 
#SBATCH -J flye_assembly
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=blast.%j.out
#SBATCH --error=blast.%j.err

module load blast/2.10.0+

ASSEMBLY_PATH="/home/jili2251/gene_pro/data/assembly/PacBio_assembly_corrected/PacBio_assembly_corrrected/corrected_assembly.fasta"
REFERENCE_PATH="/home/jili2251/gene_pro/data/assembly/chromosome_6.fasta"

makeblastdb -in $REFERENCE_PATH -dbtype nucl -out ref_db

# Run BLASTn
blastn -query $ASSEMBLY_PATH -db ref_db -outfmt 6 -out blast_results.txt -num_threads 8

echo "BLAST search completed."

