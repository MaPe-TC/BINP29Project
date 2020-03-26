library("DESeq2")
library("gplots")
library("RColorBrewer")

# load deseq2 data
dds <- readRDS(snakemake@input[[1]])

# Expression heatmap for the most  expressed genes
rld <- rlogTransformation(dds, blind=TRUE)
vsd <- varianceStabilizingTransformation(dds, blind=TRUE)
select <- order(rowMeans(counts(dds, normalized=TRUE)),decreasing=TRUE)[1:30]
hmcol <- colorRampPalette(brewer.pal(9, "GnBu"))(100)
svg(snakemake@output[["heatmap_svg"]])
pdf(snakemake@output[["heatmap_pdf"]])
heatmap.2(counts(dds,normalized=TRUE)[select ,], col=hmcol, Rowv=FALSE, Colv=FALSE, scale="none", dendrogram="none", trace="none", margin=c(10,6))
dev.off()

# Heatmap of similarity between replicates
distsRL <- dist(t(assay(rld)))
mat <- as.matrix(distsRL)
rownames(mat) <- colnames(mat) <- with(colData(dds), paste(condition, snakemake@params[["samples"]], sep=" : "))
hc <- hclust(distsRL)
svg(snakemake@output[["replicates_svg"]])
pdf(snakemake@output[["replicates_pdf"]])
heatmap.2(mat, Rowv=as.dendrogram(hc), symm=TRUE, trace="none",col=rev(hmcol), margin=c(13, 13))
dev.off()

