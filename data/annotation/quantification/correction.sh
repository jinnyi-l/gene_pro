#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH --time=20:00:00
#SBATCH -J format_Correction
#SBATCH --mail-type=ALL
#SBATCH --mail-user jinyi.li.2251@student.uu.se
#SBATCH --output=/home/jili2251/gene_pro/data/annotation/quantification/correctt.%j.out
#SBATCH --error=/home/jili2251/gene_pro/data/annotation/quantification/correct.%j.err

module load bioinfo-tools
module load htseq  # Ensure HTSeq is loaded
module load samtools  # Ensure samtools is loaded for any needed operations

INPUT_GTF="/home/jili2251/gene_pro/data/annotation/annotated_RNAseq/annotated_BRAKER/braker.gtf" 
OUTPUT_GTF="/home/jili2251/gene_pro/data/annotation/annotated_RNAseq/annotated_BRAKER/corrected.gtf"  


awk -v output_gtf="$OUTPUT_GTF" 'BEGIN {FS=OFS="\t"} {
    if ($3 == "gene" || $3 == "transcript") {
        split($9, ids, ".");
        gene_id = ids[1];
        transcript_id = $9;
        $9 = "gene_id \"" gene_id "\"; transcript_id \"" transcript_id "\";";
    }
    print > output_gtf;
}' "$INPUT_GTF"



