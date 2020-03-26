library("DESeq2")
library("gplots")
library("RColorBrewer")

dds <- readRDS(snakemake@input[[1]])

contrast <- c("condition", snakemake@params[["contrast"]])
# extracts a result table from a DESeq analysis giving base means across samples, log2 fold changes, standard errors, test statistics, p-values and adjusted p-values
res <- results(dds, contrast=contrast)
# sort by adjusted p-value
res <- res[order(res$padj),]

# plot results - Expression versus significance
svg(snakemake@output[["ma_plot_svg"]])
pdf(snakemake@output[["ma_plot_pdf"]])
plotMA(res, ylim=c(-2,2), main="DESeq2")
dev.off()
# save results in table
write.table(res, file=snakemake@output[["diffexp_table"]], sep="\t", quote = FALSE)
# set a FDR threshold < 0.05 for p-adj
resSig <- subset(res, padj< 0.05)
write.table(resSig, file=snakemake@output[["signdiffexp_table"]], sep ="\t", quote=FALSE)
