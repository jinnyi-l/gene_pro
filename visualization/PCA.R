
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


directory <- getwd() 
sampleFiles <- sample_info$fileName

read_counts <- function(filename) {
  read.table(file.path(directory, filename), header=TRUE, row.names=1)
}

countDataList <- lapply(sampleFiles, read_counts)

countDataMatrix <- do.call(cbind, countDataList)

dds <- DESeqDataSetFromMatrix(countData = countDataMatrix,
                              colData = sample_info,
                              design = ~ sampleName)

dds <- DESeq(dds)


rld <- rlogTransformation(dds)
pcaData <- plotPCA(rld, intgroup="sampleName", returnData=TRUE)
percentVar <- round(100 * attr(pcaData, "percentVar"))


ggplot(pcaData, aes(PC1, PC2, color=sampleName)) +
  geom_point(size=3) +
  xlab(paste("PC1: ", percentVar[1], "% variance")) +
  ylab(paste("PC2: ", percentVar[2], "% variance")) +
  ggtitle("PCA of RNA-Seq Data")
