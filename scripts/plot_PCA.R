library("DESeq2")

# load deseq2 data
dds <- readRDS(snakemake@input[[1]])

# obtain normalized counts
counts <- rlog(dds, blind=FALSE)
svg(snakemake@output[["PCA_svg"]])
pdf(snakemake@output[["PCA_pdf"]])
plotPCA(counts, intgroup=snakemake@params[["pca_labels"]])
dev.off()