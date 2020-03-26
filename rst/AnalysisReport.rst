This workflow performs differential expression analysis on single-end RNA-seq data. 
Quality check with FastQC, trimming of reads using Trimmomatic and subsequent quality check (with FastQC) has 
been previously performed.
In this workflow, indexing of the reference genome is performed using Hisat2-build, and reads were mapped to 
the reference genome using Hisat2.
Integrated normalization and differential expression analysis was conducted with DESeq2.
