
library(DESeq2)
library(ggplot2)
library(ggfortify)
library(pheatmap)

# Sample Information
sample_info <- data.frame(
  sampleName = c("Monthong_aril_1", "Monthong_aril_2", "Monthong_aril_3",
                 "Musang_King_aril_1", "Musang_King_aril_2", "Musang_King_aril_3",
                 "Musang_King_leaf", "Musang_King_root", "Musang_King_stem"),
  fileName = c("Monthong_aril_1Aligned.sortedByCoord.out_counts.txt",
               "Monthong_aril_2Aligned.sortedByCoord.out_counts.txt",
               "Monthong_aril_3Aligned.sortedByCoord.out_counts.txt",
               "Musang_King_aril_1Aligned.sortedByCoord.out_counts.txt",
               "Musang_King_aril_2Aligned.sortedByCoord.out_counts.txt",
               "Musang_King_aril_3Aligned.sortedByCoord.out_counts.txt",
               "Musang_King_leafAligned.sortedByCoord.out_counts.txt",
               "Musang_King_rootAligned.sortedByCoord.out_counts.txt",
               "Musang_King_stemAligned.sortedByCoord.out_counts.txt")
)

# Function to read count data
read_counts <- function(file_name) {
  read.table(file_name, header = TRUE, row.names = 1)
}

# Read each file and store data in a list
count_list <- lapply(sample_info$fileName, read_counts)

# Combine all count data into one data frame
count_data <- do.call(cbind, count_list)
colnames(count_data) <- sample_info$sampleName

# Create metadata for DESeq2
sample_info$condition <- factor(c("aril", "aril", "aril", "aril", "aril", "aril", "leaf", "root", "stem"))
sample_info$species <- factor(c("Monthong", "Monthong", "Monthong", "Musang_King", "Musang_King", "Musang_King", "Musang_King", "Musang_King", "Musang_King"))

# Create a DESeq2 dataset
dds <- DESeqDataSetFromMatrix(countData = count_data,
                              colData = sample_info,
                              design = ~ species + condition)

dds <- DESeq(dds)
res <- results(dds)

# Order results by p-value and subset the top 30 genes
top_genes <- head(order(res$pvalue, decreasing = FALSE), 30)

# Variance stabilizing transformation
vsd <- vst(dds, blind = FALSE)

# Extract only the top genes for plotting
vsd_subset <- assay(vsd)[top_genes, ]

# Plot heatmap of top 30 differentially expressed genes
pheatmap(vsd_subset)

#Find the gene expression difference between samples
#heatmap: y-axis is the genes, x-axis is the sample name
#vocalno map: any comparison is ok
