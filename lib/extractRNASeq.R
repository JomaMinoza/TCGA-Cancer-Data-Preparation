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
  EXPR_DATA <- assay(SKCM_EXPR)
  write.csv(EXPR_DATA, file_name)
  
}
