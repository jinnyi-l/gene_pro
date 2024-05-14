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

flye_assembly="/home/jili2251/gene_pro/data/assembly/PacBio_assembly/assembly.fasta"
miniasm_assembly="/home/jili2251/gene_pro/data/highergrade/assembly2/assembly.fasta"


output_dir="/home/jili2251/gene_pro/data/highergrade/comparison_flye_miniasm"


quast.py -o ${output_dir} \
         -l "Flye,Miniasm" \
         ${flye_assembly} \
         ${miniasm_assembly}



