library(limma)
library(edgeR)

files <- c("Monthong_aril_1Aligned.sortedByCoord.out_counts.txt",
           "Monthong_aril_2Aligned.sortedByCoord.out_counts.txt",
           "Monthong_aril_3Aligned.sortedByCoord.out_counts.txt",
           "Musang_King_aril_1Aligned.sortedByCoord.out_counts.txt",
           "Musang_King_aril_2Aligned.sortedByCoord.out_counts.txt",
           "Musang_King_aril_3Aligned.sortedByCoord.out_counts.txt")

countData <- lapply(files, read.table, header=TRUE, row.names=1)
countData <- do.call(cbind, countData)

y <- DGEList(counts=countData)

y <- calcNormFactors(y)

group <- factor(rep(c("Monthong", "MusangKing"), each=3))
design <- model.matrix(~ 0 + group)

v <- voom(y, design)

fit <- lmFit(v, design)
fit <- contrasts.fit(fit, contrasts=c(-1, 1))
fit <- eBayes(fit)

results <- topTable(fit, n=Inf, adjust="BH", sort.by="P", coef=1)

results$GeneID <- rownames(results)

write.csv(results, "DEG_results.csv")

results <- read.csv("DEG_results.csv", row.names=1)

library(ggplot2)
ggplot(results, aes(x=logFC, y=-log10(P.Value), label=GeneID)) +
  geom_point(aes(color=adj.P.Val < 0.05), alpha=0.5) +
  scale_color_manual(values = c("grey", "red"), labels = c("Not Significant", "Significant")) +
  geom_text(data=subset(results, adj.P.Val < 0.05), vjust=2, hjust=0.5, size=3, check_overlap = TRUE) +
  labs(x = "Log2 Fold Change", y = "-Log10 P-value", color = "Significance") +
  ggtitle("Volcano Plot of Gene Expression") +
  theme_minimal() +
  theme(legend.position = "top")

