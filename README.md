Snakemake workflow: Single-end RNAseq: FastQC to DESeq2

This workflow is divided in 3 steps (workflows 1-3) to perform:
1. Quality control (FastQC)
2. Read trimming (Trimmomatic) and subsequent quality control (FastQC)
3. Read mapping (Hisat2) and Differential expression analysis (DESeq2)

Usage

Step 1: Install workflow
Download and extract the latest release.

Note: Modify BASE_DIR accordingly.

Step 2: Activate Snakemake environment

Configure and activate Snakemake environment.

Step 3: Configure workflow

Configure the workflow according to your needs by modifying the config.yaml file.

Modify the samples.tsv file according to your needs.

Step 4a-c: Execute the different workflows

a. Workflow_1: runs FastQC (v0.11.9) on single-end .fastq files and creates a MultiQC (v1.7) report.

Run as: snakemake --use-conda -s FastQC_snk

b. Workflow_2: runs Trimmomatic (v0.39), FastQC (v0.11.9) on the trimmed files and creates a MultiQC (v1.7) report.

Note: Modify trimming options in the Trimm_FastQC_snk file according to 
your needs.

Run as: snakemake --use-conda -s Trimm_FastQC_snk

c. Workflow_3: runs Hisat2-build to index the reference genome file, runs Hisat2 (v2.1.0) to map reads from the trimmed.fastq files to the indexed genome, runs htseq-count (v0.11.1) to calculate the number of reads mapping to a specific feature type and performs differential expression analysis

Note: Provide the reference genome as .fna and .gff in the "Genome" folder

Note: Define the specific feature type for mapping in the beginning of the RNAseq_snk file (under FEATURETYPE = "")

Run as: snakemake --use-conda -s RNAseq_snk

Step 5: Investigate results

After successful execution, you can create a self-contained interactive HTML report with all results via:

Run as: snakemake --report AnalysisReport.html -s RNAseq_snk

Testing

To test the workflow you can use:

- .fastq files:  "raw_data" folder

- reference genome: "Genome" folder
