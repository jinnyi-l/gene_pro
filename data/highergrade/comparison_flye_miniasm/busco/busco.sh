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
module load BUSCO/5.5.0

flye_assembly="/home/jili2251/gene_pro/data/assembly/PacBio_assembly/assembly.fasta"
miniasm_assembly="/home/jili2251/gene_pro/data/highergrade/assembly2/assembly.fasta"

output_dir="/home/jili2251/gene_pro/data/highergrade/comparison_flye_miniasm/busco"
busco_output_dir_flye="${output_dir}/busco_flye"
busco_output_dir_miniasm="${output_dir}/busco_miniasm"

# Specify the path to the BUSCO lineage dataset appropriate for your organism
lineage="/sw/bioinfo/BUSCO/v5_lineage_sets/lineages/embryophyta_odb10"

# Run BUSCO for Flye assembly
busco -i ${flye_assembly} \
      -o busco_flye \
      -l ${lineage} \
      -m genome \
      --out_path ${busco_output_dir_flye} \
      --cpu 8

# Run BUSCO for Miniasm assembly
busco -i ${miniasm_assembly} \
      -o busco_miniasm \
      -l ${lineage} \
      -m genome \
      --out_path ${busco_output_dir_miniasm} \
      --cpu 8

