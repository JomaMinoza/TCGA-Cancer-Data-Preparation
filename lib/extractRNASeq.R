library(SummarizedExperiment)
library(TCGAbiolinks)

extractRNASeq <- function(project, file_name){
  RNASeq_QUERY <- GDCquery(project = project, 
                           data.category = "Gene expression",
                           data.type = "Gene expression quantification",
                           platform = "Illumina HiSeq", 
                           file.type  = "normalized_results",
                           experimental.strategy = "RNA-Seq",
                           legacy = TRUE)
  GDCdownload(RNASeq_QUERY)
  EXPR <- GDCprepare(query = RNASeq_QUERY, save = FALSE)

  # get expression matrix
  
  EXPR_DATA <- assay(EXPR)
  expr_file_name <-  paste0(file_name,"_RNASeq.csv")
  write.csv(EXPR_DATA, expr_file_name)

  # get clinical information
  
  EXPR_Clinical <- as.data.frame(colData(EXPR))
  
  DATA_CLINICAL <- GDCquery_clinic(project = project, type = "clinical", save.csv = FALSE)
  DATA_CLINICAL$sample_type <- ""

  
  for(i in rownames(DATA_CLINICAL)){
    DATA_CLINICAL[i, "sample_type"] <- c(EXPR_Clinical[EXPR_Clinical$patient == DATA_CLINICAL[i, "submitter_id"], "sample_type"])[1]
  }
  
  clinical_file_name <-  paste0(file_name,"_Clinical.csv")
  write.csv(DATA_CLINICAL, clinical_file_name)
  
}
  