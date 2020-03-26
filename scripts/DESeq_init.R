library("DESeq2")

# colData and countData must have the same sample order, but this is ensured
# by the way we create the count matrix
counts <- read.table(snakemake@input[["counts_matrix"]], header=TRUE, check.names=FALSE)
matrix <- counts[,-1]
# order columns alphabetically (if not done while creating the matrix in snakemake)
matrix <- matrix[,sort(colnames(matrix))]
rownames(matrix) <- counts[,1]

coldata <- read.table(snakemake@params[["samples"]], header=TRUE, row.names="sample", check.names=FALSE)

dds <- DESeqDataSetFromMatrix(countData=matrix,
                              colData=coldata,
                              design=~condition)

# remove uninformative columns (all 0 counts)
dds <- dds[ rowSums(counts(dds)) > 1, ]
# normalization and preprocessing
dds <- DESeq(dds)

saveRDS(dds, file=snakemake@output[[1]])

# make the actual normalization
normalized.counts <- as.data.frame(counts(dds,normalized=TRUE))
# print normalized values to a table
write.table(normalized.counts, file=snakemake@output[[2]], sep="\t", quote=FALSE)