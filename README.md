# text-analysis-political-speech-linguistic-complexity
Replication of Schoonvelde et al. (2019) "Liberals lecture, conservatives communicate: Analyzing complexity and ideology in 381,609 political speeches." GitHub includes dataset used, RCode, README file, powerpoint and document outline replication differences and replication autopsy observations.

# Replication of "Liberals Lecture, conservatives communicate: Analyzing complexity and ideology in 381,609 political speeches"

This repository contains a replication of:

> Schoonvelde, M., Brosius, A., Schumacher, G., Bakker, B. (2019). _Liberals lecture, conservatives communicate: Analyzing complexity and ideology in 381,609 political speeches_. PLOS |ONE.

A link to the public version of the journal article can be found here: https://pmc.ncbi.nlm.nih.gov/articles/PMC6364865/
---

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
- Phase 1: Pre-processed full speech data =
- Phase 2a: Unprocessed parliament speech corpora (UK, Germany, Spain, Netherlands) =
- Phase 2b: Unprocessed EU speech corpora = 
- Phase 2b: Unprocessed congress Netherlands corpora = 

Due to licensing restrictions, some raw data may not be redistributed. Instructions for access are provided below.

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
