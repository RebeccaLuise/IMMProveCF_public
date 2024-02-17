# remove sensitive metadata from .rds files
ps_full_IMP <- readRDS("~/Documents/Forschung/IMMProveCF/Manuscript_16S/IMMProveCF_public/ps_full_IMP.rds")

view(sample_data(ps_full_IMP))

data <- as(sample_data(ps_full_IMP), "data.frame")

rm1 <- data[50:76] # this is microbiological results not used in the analysis for sputum
rm2 <- data[84:125] # this is microbiological results not used in the analysis for throat

data_clean <- data %>% 
  select(-c(date_of_birth, diagnosejahr, names(rm1),names(rm2)))

ps_full_IMP <- phyloseq::phyloseq(tax_table(ps_full_IMP), otu_table(ps_full_IMP), sample_data(data_clean))

saveRDS(ps_full_IMP, "~/Documents/Forschung/IMMProveCF/Manuscript_16S/IMMProveCF_public/ps_full_IMP.rds")

# second data set
ps_full_IMP_Run1_23 <- readRDS("~/Documents/Forschung/IMMProveCF/Manuscript_16S/IMMProveCF_public/ps_full_IMP_Run1-23_18102023.rds")

view(sample_data(ps_full_IMP_Run1_23))

data <- as(sample_data(ps_full_IMP_Run1_23), "data.frame")

rm1 <- data[53:79] # this is microbiological results not used in the analysis for sputum
rm2 <- data[87:133] # this is microbiological results not used in the analysis for throat

data_clean <- data %>% 
  select(-c(date_of_birth, diagnosejahr, names(rm1),names(rm2)))

ps_full_IMP_Run1_23 <- phyloseq::phyloseq(tax_table(ps_full_IMP_Run1_23), otu_table(ps_full_IMP_Run1_23), sample_data(data_clean))

saveRDS(ps_full_IMP_Run1_23, "~/Documents/Forschung/IMMProveCF/Manuscript_16S/IMMProveCF_public/ps_full_IMP_Run1-23_18102023.rds")
