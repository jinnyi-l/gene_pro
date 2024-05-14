#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH --time=20:00:00
#SBATCH -J repeat_masking
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=/home/jili2251/genome_analysis_project/data/masked-mapping/RepeatPac_masking_RepeatMasker/repeat_masking.%j.out
#SBATCH --error=/home/jili2251/genome_analysis_project/data/masked-mapping/RepeatPac_masking_RepeatMasker/repeat_masking.%j.err

module load bioinfo-tools
module load RepeatMasker
module load hmmer/3.2.1

ASSEMBLY="/home/jili2251/gene_pro/data/assembly/PacBio_assembly_corrrected/corrected_assembly.fasta"
OUTPUT_DIR="/home/jili2251/gene_pro/data/masked-mapping/RepeatPac_masking_RepeatMasker"

RepeatMasker -pa 4 -species plants -gff -engine ncbi -dir $OUTPUT_DIR $ASSEMBLY

