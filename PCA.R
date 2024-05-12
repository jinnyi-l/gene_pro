
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


directory <- getwd()  # Current directory where count files are located
sampleFiles <- sample_info$fileName

# Function to read count data
read_counts <- function(filename) {
  read.table(file.path(directory, filename), header=TRUE, row.names=1)
}

# Read all files into a list
countDataList <- lapply(sampleFiles, read_counts)

# Combine all count data into a matrix
countDataMatrix <- do.call(cbind, countDataList)

# Create DESeqDataSet
dds <- DESeqDataSetFromMatrix(countData = countDataMatrix,
                              colData = sample_info,
                              design = ~ sampleName)

# Normalize data
dds <- DESeq(dds)

# PCA analysis
rld <- rlogTransformation(dds)
pcaData <- plotPCA(rld, intgroup="sampleName", returnData=TRUE)
percentVar <- round(100 * attr(pcaData, "percentVar"))

# Plotting PCA
ggplot(pcaData, aes(PC1, PC2, color=sampleName)) +
  geom_point(size=3) +
  xlab(paste("PC1: ", percentVar[1], "% variance")) +
  ylab(paste("PC2: ", percentVar[2], "% variance")) +
  ggtitle("PCA of RNA-Seq Data")
