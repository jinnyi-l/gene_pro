
library(DESeq2)
library(ggplot2)
library(ggfortify)
library(pheatmap)


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


read_counts <- function(file_name) {
  read.table(file_name, header = TRUE, row.names = 1)
}


count_list <- lapply(sample_info$fileName, read_counts)


count_data <- do.call(cbind, count_list)
colnames(count_data) <- sample_info$sampleName


sample_info$condition <- factor(c("aril", "aril", "aril", "aril", "aril", "aril", "leaf", "root", "stem"))
sample_info$species <- factor(c("Monthong", "Monthong", "Monthong", "Musang_King", "Musang_King", "Musang_King", "Musang_King", "Musang_King", "Musang_King"))


dds <- DESeqDataSetFromMatrix(countData = count_data,
                              colData = sample_info,
                              design = ~ species + condition)

dds <- DESeq(dds)
res <- results(dds)


top_genes <- head(order(res$padj, decreasing = FALSE), 30)


vsd <- vst(dds, blind = FALSE)


vsd_subset <- assay(vsd)[top_genes, ]


pheatmap(vsd_subset)

