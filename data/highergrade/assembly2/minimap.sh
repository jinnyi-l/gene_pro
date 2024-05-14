#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH --time=72:00:00 
#SBATCH -J miniasm_assembly
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=miniasm_assembly.%j.out
#SBATCH --error=miniasm_assembly.%j.err


module load bioinfo-tools
module load Miniasm/0.3-r179-20191007-ce615d1
module load minimap2


minimap2 -x ava-pb -t4 /proj/uppmax2024-2-7/Genome_Analysis/4_Tean_Teh_2017/pacbio_data/SRR6037732_scaffold_06.fq.gz /proj/uppmax2024-2-7/Genome_Analysis/4_Tean_Teh_2017/pacbio_data/SRR6037732_scaffold_06.fq.gz > reads.paf

miniasm -f /proj/uppmax2024-2-7/Genome_Analysis/4_Tean_Teh_2017/pacbio_data/SRR6037732_scaffold_06.fq.gz reads.paf > /home/jili2251/gene_pro/data/highergrade/assembly2/assembly.gfa

awk '/^S/{print ">"$2"\n"$3}' /home/jili2251/gene_pro/data/highergrade/assembly2/assembly.gfa > /home/jili2251/gene_pro/data/highergrade/assembly2/assembly.fasta
