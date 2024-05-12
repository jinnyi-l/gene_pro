#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH --time=72:00:00
#SBATCH -J assembly_comparison
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=assembly_comparison.%j.out
#SBATCH --error=assembly_comparison.%j.err

module load bioinfo-tools
module load quast

# Paths to the assembly files
flye_assembly="/home/jili2251/gene_pro/data/assembly/PacBio_assembly/assembly.fasta"
pilon_assembly="/home/jili2251/gene_pro/data/assembly/PacBio_assembly_corrected/PacBio_assembly_corrrected/corrected_assembly.fasta"

# Output directory for QUAST results
output_dir="/home/jili2251/gene_pro/data/assembly/PacBio_assembly_corrrected/quast_comparison"


# Run QUAST
quast.py -o ${output_dir} \
         -l "Flye,Pilon" \
         ${flye_assembly} \
         ${pilon_assembly}

