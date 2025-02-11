# IMMProveCF_public
This repository contains all code and data used for the analysis reported in the manuscript:
"Microbiome dynamics are mediated by changes in host physiology in people with cystic fibrosis undergoing CFTR-modulator therapy."

Repository Content:

    .R files – Contain functions used throughout the analysis.
    .Rmd files – Ordered according to the analysis presented in the manuscript. These include code for statistical tests and figure generation to fully reproduce the findings.
    .rds files – Contain annotated but raw count 16S sequencing data combined with clinical metadata as a phyloseq object.
    renv.lock – Captures exact package versions
    renv/settings.json – Stores renv settings
    .Rproj – Helps with project organization

Raw Data Availability:
    Raw sequencing data have been deposited at NCBI BioProject PRJNA1080555.

## Reproducibility Guide:

All statistical analyses were performed in the R environment (v4.1).


### Preparing the Data

Files numbered `00-*` and `01-*` are required to generate phyloseq objects from raw sequencing data and clinical metadata. To replicate the analysis without regenerating these objects, download the `.rds` files and update the file paths accordingly in the scripts.

### Running the Analysis

Each `.Rmd` script begins by loading the necessary phyloseq objects. Ensure all required R packages are installed and loaded before execution.

### Setting Up the Environment
To ensure full reproducibility, this repository includes an `renv.lock` file. Follow these steps to restore the exact package versions used in the analysis:

1. Install `renv` if not already installed:
   ```r
   install.packages("renv")
   ```
2. Restore the project environment:
   ```r
   renv::restore()
   ```

### Running the Scripts
Once dependencies are installed, the `.Rmd` files can be run sequentially to reproduce the full analysis, including all statistical tests and visualizations. Open the `.Rproj` file in RStudio for an organized workflow.

