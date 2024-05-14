#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH --time=12:00:00 
#SBATCH -J flye_assembly
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=flye_assembly.%j.out
#SBATCH --output=flye_assembly.%j.err


module load bioinfo-tools
module load Flye/2.9.1

flye --pacbio-raw /proj/uppmax2024-2-7/Genome_Analysis/4_Tean_Teh_2017/pacbio_data/SRR6037732_scaffold_06.fq.gz \
--out-dir /home/jili2251/gene_pro/data/assembly/PacBio_assembly \
--genome-size 27.36g \
--threads 4 


