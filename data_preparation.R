library(stringr)

source("lib/extractRNASeq.R")

cancer_data <- c("SKCM","KIRC", "KIRP", "HNSC", "ESCA", "PRAD", "BRCA", "KICH", "BLCA", "CESC", "HNSC", "SARC", "STAD")

for(cancer in cancer_data){
  project   <- paste0("TCGA-",cancer)
  file_name <-  paste0("data/",cancer,"_EXPR_DATA.csv")
  extractRNASeq(project = project, file_name = file_name)
  GDCquery_clinic(project, type = "clinical", save.csv = TRUE)
}
