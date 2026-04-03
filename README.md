# text-analysis-political-speech-linguistic-complexity
Sara Murphy's replication of Schoonvelde et al. (2019) "Liberals lecture, conservatives communicate: Analyzing complexity and ideology in 381,609 political speeches." GitHub includes dataset used, RCode, README file, powerpoint and document outline replication differences and replication autopsy observations. Completed for Computational Text Analysis course, Western University, PS9594A.

# Replication of "Liberals Lecture, conservatives communicate: Analyzing complexity and ideology in 381,609 political speeches"

This repository contains a replication of:

> Schoonvelde, M., Brosius, A., Schumacher, G., Bakker, B. (2019). _Liberals lecture, conservatives communicate: Analyzing complexity and ideology in 381,609 political speeches_. PLOS |ONE.

- A link to the public version of the journal article can be found here: https://pmc.ncbi.nlm.nih.gov/articles/PMC6364865/. PDF copies are found in "docs" folder.
- In-class replication presentation by Sara is found in "presentation" folder.
- Harvard Dataverse data files and Rscripts (from Authors) used in replication are found in "dataverse" folder.
- Code RMarkdowns created by Sara for replication are found in the main branch of the repository.
- Figures and Tables created by Sara for replication are found in "figures and tables" folder.
- Replication report created by Sara, outlining replication process, main differences, replication autopsy and replication extension is found in "report" folder.
---
# Steps

- Download github repository by clicking green "Code" button.
- From Downloads, save zipped folder to desktop, which contains all of the files from the github repository.
- Unzip the folder, which will maintain and reproduce the file and folder structure from the github repository.
- Within RStudio: file --> open --> select one of the Rmarkdown files from the unzipped folder.
- RMarkdown files should run accordingly withour error in RStudio.

# Overview

This project replicates the main findings of the original study using publicly available speech data from European political corpora.

The replication occurs in the following sequence:

- **Phase 1: Reproducing key figures and tables using pre-processed sample data**
- Assessing discrepancies in linguistic measurement
- **Phase 2a: Reconstructing Flesch-Kincaid complexity scores using unprocessed speech data (sample of 4/5 Parliaments)**
- Comparing replicated vs. original complexity measures on word count, sentence count, syllable count
- Reproducing key figures and tables using replicated complexity measures
- Assessing discrepancies in linguistic measurement
- **Phase 2b: Reconstructing Flesch-Kincaid complexity scores using unprocessed speech data (EU speeches and Congress Netherlands speeches)**
- Comparing replicated vs. original complexity measures on word count, sentence count, syllable count
- Reproducing key figures and tables using replicated complexity measures
- Assessing discrepancies in linguistic measurement
  
---

# Data

The replication uses data from:

- Harvard Dataverse: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/S4IZ8K
- Phase 1: Pre-processed full speech data = speeches.RData
- Phase 2a: Unprocessed parliament speech corpora (UK, Germany, Spain, Netherlands) = HouseofCommons_Sample.Rdata, Bundestag_Sample.Rdata, Congresso_Sample.Rdata, TweedeKamer_Sample.Rdata
- Phase 2b: Unprocessed EU speech corpora = EUSPeech_validation.csv (note: file is uploaded as zip file to GitHub due to file size limits. Need to unzip after downloading)
- Phase 2b: Unprocessed congress Netherlands corpora = Congress_Dutch_Validation.csv

Due to licensing restrictions, some raw data may not be redistributed. Instructions for access are provided below.

---

# Code

The code is found within 2 R Markdown files. They will run separately - they do not need to be run in chronological order. However, the "Phase 1" R markdown was created first and correponds with Phase 1 (above).

- Sara's Replication - Phase 1 (RMarkdown)
- Sara's Replication - Phase 2a 2b (RMarkdown)

---

## ⚙️ Requirements

R version ≥ 4.2

Required packages:

```r
install.packages(c(
  "tidyverse",
  "quanteda",
  "quanteda.textstats",
  "ggplot2",
  "gt",
  "webshot2"
))
