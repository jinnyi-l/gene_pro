#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH --time=01:00:00 
#SBATCH -J genome_visualization
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=genome_visualization.%j.out
#SBATCH --error=genome_visualization.%j.err


module load bioinfo-tools
module load Bandage/0.8.1

input_gfa="/home/jili2251/gene_pro/data/assembly/PacBio_assembly/assembly_graph.gfa"
output_image="/home/jili2251/gene_pro/data/assembly/PacBio_assembly/assembly_graph.png"

Bandage image "$input_gfa" "$output_image"

