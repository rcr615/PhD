source("/Users/rachelrubin/Documents/study2/R/functions_VAC.R")
cnavt_vacs <- read.table(file = "/Users/rachelrubin/Documents/study2/CNaVT_VAC_Xquery.txt", na.strings = c(""), sep = "|", row.names = NULL, header = FALSE, col.names = paste0("V",1:25), fill = TRUE, quote = "")
cnavt_vacs_labels <- VAC_label_nop2_learner(cnavt_vacs)
cnavt_vacs_labels$VAC <- paste0(cnavt_vacs_labels$label,"<>",gsub("(.*):verb","\\1",cnavt_vacs_labels$verb),"<>")
cnavt_vacs_labels <- cnavt_vacs_labels[grepl("\\|",cnavt_vacs_labels$sc)==FALSE,]
cnavt_vacs_labels[,c(22:30)] <- Lassy_VAC_measures[match(cnavt_vacs_labels$VAC,Lassy_VAC_measures$VAC),c(3:11)]
cnavt_vacs_labels$id <- gsub("(.*\\.txt)\\.xml:textid","\\1",cnavt_vacs_labels$id)
summary(cnavt_data <- read.csv("/Users/rachelrubin/Documents/study2/R/cnavt_data_full_170221.csv", row.names=1))
cnavt_data$textid_A1 <- as.character(cnavt_data$textid_A1)
cnavt_data$textid_A2 <- as.character(cnavt_data$textid_A2)
#df per VAC
cnavt_vacs_labels_transNP <- cnavt_vacs_labels[cnavt_vacs_labels$label=="transitive_NP",]
cnavt_vacs_labels_transVC <- cnavt_vacs_labels[cnavt_vacs_labels$label=="transitive_VC",]
cnavt_vacs_labels_intrans <- cnavt_vacs_labels[cnavt_vacs_labels$label=="intransitive",]
cnavt_vacs_labels_ditransNP <- cnavt_vacs_labels[cnavt_vacs_labels$label=="ditransitive_NP_NP",]
cnavt_vacs_labels_ditransVC <- cnavt_vacs_labels[cnavt_vacs_labels$label=="ditransitive_NP_VC",]
cnavt_vacs_labels_passive <- cnavt_vacs_labels[cnavt_vacs_labels$label=="passive",]
#MI
cnavt_data$transitive_NP_MI_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transNP$MI[cnavt_vacs_labels_transNP$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$transitive_NP_MI_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transNP$MI[cnavt_vacs_labels_transNP$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$transitive_VC_MI_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transVC$MI[cnavt_vacs_labels_transVC$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$transitive_VC_MI_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transVC$MI[cnavt_vacs_labels_transVC$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$intransitive_MI_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_intrans$MI[cnavt_vacs_labels_intrans$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$intransitive_MI_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_intrans$MI[cnavt_vacs_labels_intrans$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_NP_MI_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransNP$MI[cnavt_vacs_labels_ditransNP$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_NP_MI_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransNP$MI[cnavt_vacs_labels_ditransNP$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_VC_MI_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransVC$MI[cnavt_vacs_labels_ditransVC$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_VC_MI_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransVC$MI[cnavt_vacs_labels_ditransVC$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$passive_MI_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_passive$MI[cnavt_vacs_labels_passive$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$passive_MI_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_passive$MI[cnavt_vacs_labels_passive$id %in% x[34]], na.rm = TRUE)
})
#MI NOBT
cnavt_data$transitive_NP_MI_NOBT_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transNP$MI[cnavt_vacs_labels_transNP$Frequency>5 & cnavt_vacs_labels_transNP$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$transitive_NP_MI_NOBT_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transNP$MI[cnavt_vacs_labels_transNP$Frequency>5 & cnavt_vacs_labels_transNP$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$transitive_VC_MI_NOBT_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transVC$MI[cnavt_vacs_labels_transVC$Frequency>5 & cnavt_vacs_labels_transVC$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$transitive_VC_MI_NOBT_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transVC$MI[cnavt_vacs_labels_transVC$Frequency>5 & cnavt_vacs_labels_transVC$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$intransitive_MI_NOBT_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_intrans$MI[cnavt_vacs_labels_intrans$Frequency>5 & cnavt_vacs_labels_intrans$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$intransitive_MI_NOBT_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_intrans$MI[cnavt_vacs_labels_intrans$Frequency>5 & cnavt_vacs_labels_intrans$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_NP_MI_NOBT_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransNP$MI[cnavt_vacs_labels_ditransNP$Frequency>5 & cnavt_vacs_labels_ditransNP$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_NP_MI_NOBT_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransNP$MI[cnavt_vacs_labels_ditransNP$Frequency>5 & cnavt_vacs_labels_ditransNP$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_VC_MI_NOBT_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransVC$MI[cnavt_vacs_labels_ditransVC$Frequency>5 & cnavt_vacs_labels_ditransVC$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_VC_MI_NOBT_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransVC$MI[cnavt_vacs_labels_ditransVC$Frequency>5 & cnavt_vacs_labels_ditransVC$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$passive_MI_NOBT_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_passive$MI[cnavt_vacs_labels_passive$Frequency>5 & cnavt_vacs_labels_passive$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$passive_MI_NOBT_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_passive$MI[cnavt_vacs_labels_passive$Frequency>5 & cnavt_vacs_labels_passive$id %in% x[34]], na.rm = TRUE)
})
#Fisher
cnavt_data$transitive_NP_Fisher_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transNP$Fisher[cnavt_vacs_labels_transNP$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$transitive_NP_Fisher_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transNP$Fisher[cnavt_vacs_labels_transNP$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$transitive_VC_Fisher_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transVC$Fisher[cnavt_vacs_labels_transVC$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$transitive_VC_Fisher_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transVC$Fisher[cnavt_vacs_labels_transVC$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$intransitive_Fisher_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_intrans$Fisher[cnavt_vacs_labels_intrans$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$intransitive_Fisher_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_intrans$Fisher[cnavt_vacs_labels_intrans$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_NP_Fisher_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransNP$Fisher[cnavt_vacs_labels_ditransNP$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_NP_Fisher_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransNP$Fisher[cnavt_vacs_labels_ditransNP$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_VC_Fisher_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransVC$Fisher[cnavt_vacs_labels_ditransVC$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_VC_Fisher_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransVC$Fisher[cnavt_vacs_labels_ditransVC$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$passive_Fisher_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_passive$Fisher[cnavt_vacs_labels_passive$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$passive_Fisher_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_passive$Fisher[cnavt_vacs_labels_passive$id %in% x[34]], na.rm = TRUE)
})
#Entropy
cnavt_data$transitive_NP_Entropy_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transNP$Entropy[cnavt_vacs_labels_transNP$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$transitive_NP_Entropy_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transNP$Entropy[cnavt_vacs_labels_transNP$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$transitive_VC_Entropy_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transVC$Entropy[cnavt_vacs_labels_transVC$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$transitive_VC_Entropy_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transVC$Entropy[cnavt_vacs_labels_transVC$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$intransitive_Entropy_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_intrans$Entropy[cnavt_vacs_labels_intrans$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$intransitive_Entropy_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_intrans$Entropy[cnavt_vacs_labels_intrans$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_NP_Entropy_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransNP$Entropy[cnavt_vacs_labels_ditransNP$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_NP_Entropy_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransNP$Entropy[cnavt_vacs_labels_ditransNP$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_VC_Entropy_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransVC$Entropy[cnavt_vacs_labels_ditransVC$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_VC_Entropy_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransVC$Entropy[cnavt_vacs_labels_ditransVC$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$passive_Entropy_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_passive$Entropy[cnavt_vacs_labels_passive$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$passive_Entropy_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_passive$Entropy[cnavt_vacs_labels_passive$id %in% x[34]], na.rm = TRUE)
})
#all VACS
cnavt_data$VAC_MI_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels$MI[cnavt_vacs_labels$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$VAC_MI_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels$MI[cnavt_vacs_labels$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$VAC_MI_NOBT_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels$MI[cnavt_vacs_labels$Frequency>5 & cnavt_vacs_labels$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$VAC_MI_NOBT_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels$MI[cnavt_vacs_labels$Frequency>5 & cnavt_vacs_labels$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$VAC_Fisher_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels$Fisher[cnavt_vacs_labels$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$VAC_Fisher_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels$Fisher[cnavt_vacs_labels$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$VAC_Entropy_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels$Entropy[cnavt_vacs_labels$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$VAC_Entropy_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels$Entropy[cnavt_vacs_labels$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$VAC_Eucl_dist_origin_MI_Entropy_Freq_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels$Eucl_dist_origin_MI_Entropy_Freq[cnavt_vacs_labels$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$VAC_Eucl_dist_origin_MI_Entropy_Freq_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels$Eucl_dist_origin_MI_Entropy_Freq[cnavt_vacs_labels$id %in% x[34]], na.rm = TRUE)
})
#composite measures
cnavt_data$transitive_NP_Eucl_dist_origin_MI_Entropy_Freq_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transNP$Eucl_dist_origin_MI_Entropy_Freq[cnavt_vacs_labels_transNP$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$transitive_NP_Eucl_dist_origin_MI_Entropy_Freq_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transNP$Eucl_dist_origin_MI_Entropy_Freq[cnavt_vacs_labels_transNP$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$transitive_VC_Eucl_dist_origin_MI_Entropy_Freq_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transVC$Eucl_dist_origin_MI_Entropy_Freq[cnavt_vacs_labels_transVC$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$transitive_VC_Eucl_dist_origin_MI_Entropy_Freq_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_transVC$Eucl_dist_origin_MI_Entropy_Freq[cnavt_vacs_labels_transVC$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$intransitive_Eucl_dist_origin_MI_Entropy_Freq_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_intrans$Eucl_dist_origin_MI_Entropy_Freq[cnavt_vacs_labels_intrans$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$intransitive_Eucl_dist_origin_MI_Entropy_Freq_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_intrans$Eucl_dist_origin_MI_Entropy_Freq[cnavt_vacs_labels_intrans$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_NP_Eucl_dist_origin_MI_Entropy_Freq_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransNP$Eucl_dist_origin_MI_Entropy_Freq[cnavt_vacs_labels_ditransNP$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_NP_Eucl_dist_origin_MI_Entropy_Freq_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransNP$Eucl_dist_origin_MI_Entropy_Freq[cnavt_vacs_labels_ditransNP$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_VC_Eucl_dist_origin_MI_Entropy_Freq_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransVC$Eucl_dist_origin_MI_Entropy_Freq[cnavt_vacs_labels_ditransVC$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$ditransitive_NP_VC_Eucl_dist_origin_MI_Entropy_Freq_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_ditransVC$Eucl_dist_origin_MI_Entropy_Freq[cnavt_vacs_labels_ditransVC$id %in% x[34]], na.rm = TRUE)
})
cnavt_data$passive_Eucl_dist_origin_MI_Entropy_Freq_A1 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_passive$Eucl_dist_origin_MI_Entropy_Freq[cnavt_vacs_labels_passive$id %in% x[33]], na.rm = TRUE)
})
cnavt_data$passive_Eucl_dist_origin_MI_Entropy_Freq_A2 <- apply(cnavt_data,1,function(x){
  mean(cnavt_vacs_labels_passive$Eucl_dist_origin_MI_Entropy_Freq[cnavt_vacs_labels_passive$id %in% x[34]], na.rm = TRUE)
})
#MI band measures: based on previous research
cnavt_data$VAC_MI_bt_A1 <- apply(cnavt_data,1,function(x){
  nrow(cnavt_vacs_labels[cnavt_vacs_labels$Frequency<5 & cnavt_vacs_labels$label!="none" & cnavt_vacs_labels$id %in% x[33],])/nrow(cnavt_vacs_labels[cnavt_vacs_labels$id %in% x[33] & cnavt_vacs_labels$label!="none",])
})
cnavt_data$VAC_MI_bt_A2 <- apply(cnavt_data,1,function(x){
  nrow(cnavt_vacs_labels[cnavt_vacs_labels$Frequency<5 & cnavt_vacs_labels$label!="none" & cnavt_vacs_labels$id %in% x[34],])/nrow(cnavt_vacs_labels[cnavt_vacs_labels$id %in% x[34] & cnavt_vacs_labels$label!="none",])
})
cnavt_data$VAC_MI_no_coll_A1 <- apply(cnavt_data,1,function(x){
  nrow(cnavt_vacs_labels[cnavt_vacs_labels$MI<3 & cnavt_vacs_labels$Frequency>5 & cnavt_vacs_labels$label!="none" & cnavt_vacs_labels$id %in% x[33],])/nrow(cnavt_vacs_labels[cnavt_vacs_labels$id %in% x[33] & cnavt_vacs_labels$label!="none",])
})
cnavt_data$VAC_MI_no_coll_A2 <- apply(cnavt_data,1,function(x){
  nrow(cnavt_vacs_labels[cnavt_vacs_labels$MI<3 & cnavt_vacs_labels$Frequency>5 & cnavt_vacs_labels$label!="none" & cnavt_vacs_labels$id %in% x[34],])/nrow(cnavt_vacs_labels[cnavt_vacs_labels$id %in% x[34] & cnavt_vacs_labels$label!="none",])
})
cnavt_data$VAC_MI_coll_low_A1 <- apply(cnavt_data,1,function(x){
  nrow(cnavt_vacs_labels[cnavt_vacs_labels$MI>=3 & cnavt_vacs_labels$MI<5 & cnavt_vacs_labels$Frequency>5 & cnavt_vacs_labels$label!="none" & cnavt_vacs_labels$id %in% x[33],])/nrow(cnavt_vacs_labels[cnavt_vacs_labels$id %in% x[33] & cnavt_vacs_labels$label!="none",])
})
cnavt_data$VAC_MI_coll_low_A2 <- apply(cnavt_data,1,function(x){
  nrow(cnavt_vacs_labels[cnavt_vacs_labels$MI>=3 & cnavt_vacs_labels$MI<5 & cnavt_vacs_labels$Frequency>5 & cnavt_vacs_labels$label!="none" & cnavt_vacs_labels$id %in% x[34],])/nrow(cnavt_vacs_labels[cnavt_vacs_labels$id %in% x[34] & cnavt_vacs_labels$label!="none",])
})
cnavt_data$VAC_MI_coll_med_A1 <- apply(cnavt_data,1,function(x){
  nrow(cnavt_vacs_labels[cnavt_vacs_labels$MI>=5 & cnavt_vacs_labels$MI<7 & cnavt_vacs_labels$Frequency>5 & cnavt_vacs_labels$label!="none" & cnavt_vacs_labels$id %in% x[33],])/nrow(cnavt_vacs_labels[cnavt_vacs_labels$id %in% x[33] & cnavt_vacs_labels$label!="none",])
})
cnavt_data$VAC_MI_coll_med_A2 <- apply(cnavt_data,1,function(x){
  nrow(cnavt_vacs_labels[cnavt_vacs_labels$MI>=5 & cnavt_vacs_labels$MI<7 & cnavt_vacs_labels$Frequency>5 & cnavt_vacs_labels$label!="none" & cnavt_vacs_labels$id %in% x[34],])/nrow(cnavt_vacs_labels[cnavt_vacs_labels$id %in% x[34] & cnavt_vacs_labels$label!="none",])
})
cnavt_data$VAC_MI_coll_high_A1 <- apply(cnavt_data,1,function(x){
  nrow(cnavt_vacs_labels[cnavt_vacs_labels$MI>=7 & cnavt_vacs_labels$Frequency>5 & cnavt_vacs_labels$label!="none" & cnavt_vacs_labels$id %in% x[33],])/nrow(cnavt_vacs_labels[cnavt_vacs_labels$id %in% x[33] & cnavt_vacs_labels$label!="none",])
})
cnavt_data$VAC_MI_coll_high_A2 <- apply(cnavt_data,1,function(x){
  nrow(cnavt_vacs_labels[cnavt_vacs_labels$MI>=7 & cnavt_vacs_labels$Frequency>5 & cnavt_vacs_labels$label!="none" & cnavt_vacs_labels$id %in% x[34],])/nrow(cnavt_vacs_labels[cnavt_vacs_labels$id %in% x[34] & cnavt_vacs_labels$label!="none",])
})
#diversity measures
#TTR
cnavt_vacs_labels <- cnavt_vacs_labels[cnavt_vacs_labels$label!="none",]
cnavt_data$TTR_VAC_A1 <- apply(cnavt_data,1,function(x){
  length(unique(cnavt_vacs_labels$VAC[cnavt_vacs_labels$id %in% x[33]]))/length(cnavt_vacs_labels$VAC[cnavt_vacs_labels$id %in% x[33]])
})
cnavt_data$TTR_VAC_A2 <- apply(cnavt_data,1,function(x){
  length(unique(cnavt_vacs_labels$VAC[cnavt_vacs_labels$id %in% x[34]]))/length(cnavt_vacs_labels$VAC[cnavt_vacs_labels$id %in% x[34]])
})
#DP as diversity measure
cnavt_data$VAC_DP_A1[!is.na(cnavt_data$textid_A1)] <- apply(cnavt_data[!is.na(cnavt_data$textid_A1),],1,function(x){
  tempdf <- cnavt_vacs_labels[cnavt_vacs_labels$id %in% x[33] & cnavt_vacs_labels$label!="none",]
  tempdf$exp_per <- 1/nrow(tempdf)
  tempdf$obs_per <- apply(tempdf,1,function(i){
    length(tempdf$VAC[tempdf$VAC==i[[21]]])/nrow(tempdf)
  })
  tempdf$abs_diff <- abs(tempdf$exp_per-tempdf$obs_per)
  DP <- sum(tempdf$abs_diff)/2
  return(DP)
})
cnavt_data$VAC_DP_A2[!is.na(cnavt_data$textid_A2)] <- apply(cnavt_data[!is.na(cnavt_data$textid_A2),],1,function(x){
  print(x[1])
  tempdf <- cnavt_vacs_labels[grepl(x[[1]],cnavt_vacs_labels$id) & grepl("A2",cnavt_vacs_labels$id) & cnavt_vacs_labels$label!="none",]
  if(nrow(tempdf)>0) {
  tempdf$exp_per <- 1/nrow(tempdf)
  tempdf$obs_per <- apply(tempdf,1,function(i){
    length(tempdf$VAC[tempdf$VAC==i[[21]]])/nrow(tempdf)
  })
  tempdf$abs_diff <- abs(tempdf$exp_per-tempdf$obs_per)
  DP <- sum(tempdf$abs_diff)/2
  }
  else{
    DP <- NA
  }
  return(DP)
})
#add extra metadata
cnavt_copy <- cnavt_data
cnavt_meta <- read.csv(file = "/Users/rachelrubin/Documents/CNaVT_corpus_RR_2020/cnavt_meta_clean.csv", row.names = 1)
cnavt_data <- cnavt_data[,-c(12)]
cnavt_data[,c(3:31)] <- lapply(cnavt_data[,c(3:31)],as.character)
for(i in c(1:nrow(cnavt_data))) {
  if(is.na(cnavt_data[i,"Geslaagd"])) {
    cnavt_data[i,c(3:31)] <- lapply(cnavt_meta[match(cnavt_data[i,1],cnavt_meta$speaker_id),c(6,8:28,51:57)],as.character)
  }
  else {
    next
  }
}
cnavt_data[,c(25:31)] <- lapply(cnavt_data[,c(25:31)],as.numeric)
#save
save(cnavt_data,file="~/Documents/study2/R/cnavt_VACs.Rdata")
#plotting
cnavt_geslaagd <- cnavt_data[cnavt_data$Geslaagd==1 & !is.na(cnavt_data$Geslaagd),]
plot1 <- ggplot(cnavt_geslaagd, aes(x =cefr, y = transitive_NP_MI_A2)) + geom_boxplot(aes(fill = topic_A2), position = position_dodge(0.9), notch = FALSE) + scale_fill_manual(values = c("#5E8D99", "#666668", "#77C977", "#D13D93", "#5F3DD1", "#CAD13D")) + ggtitle("transitive_NP_MI_A2")
plot2 <- ggplot(cnavt_geslaagd, aes(x =cefr, y = transitive_NP_Fisher_A2)) + geom_boxplot(aes(fill = topic_A2), position = position_dodge(0.9), notch = FALSE) + scale_fill_manual(values = c("#5E8D99", "#666668", "#77C977", "#D13D93", "#5F3DD1", "#CAD13D")) + ggtitle("transitive_NP_Fisher_A2")
plot3 <- ggplot(cnavt_geslaagd, aes(x =cefr, y = transitive_NP_Entropy_A2)) + geom_boxplot(aes(fill = topic_A2), position = position_dodge(0.9), notch = FALSE) + scale_fill_manual(values = c("#5E8D99", "#666668", "#77C977", "#D13D93", "#5F3DD1", "#CAD13D")) + ggtitle("transitive_NP_Entropy_A2")
plot4 <- ggplot(cnavt_geslaagd, aes(x =cefr, y = MI_A2)) + geom_boxplot(aes(fill = topic_A2), position = position_dodge(0.9), notch = FALSE) + scale_fill_manual(values = c("#5E8D99", "#666668", "#77C977", "#D13D93", "#5F3DD1", "#CAD13D")) + ggtitle("VAC_MI_A2")
plot5 <- ggplot(cnavt_geslaagd, aes(x =cefr, y = Fisher_A2)) + geom_boxplot(aes(fill = topic_A2), position = position_dodge(0.9), notch = FALSE) + scale_fill_manual(values = c("#5E8D99", "#666668", "#77C977", "#D13D93", "#5F3DD1", "#CAD13D")) + ggtitle("VAC_Fisher_A2")
plot6 <- ggplot(cnavt_geslaagd, aes(x =cefr, y = transitive_NP_Eucl_dist_origin_MI_DP_Entropy_Freq_A2)) + geom_boxplot(aes(fill = topic_A2), position = position_dodge(0.9), notch = FALSE) + scale_fill_manual(values = c("#5E8D99", "#666668", "#77C977", "#D13D93", "#5F3DD1", "#CAD13D")) + ggtitle("transitive_NP_Eucl_dist_origin_MI_DP_Entropy_Freq_A2")
plot7 <- ggplot(cnavt_geslaagd, aes(x =cefr, y = TTR_VAC_A2)) + geom_boxplot(aes(fill = topic_A2), position = position_dodge(0.9), notch = FALSE) + scale_fill_manual(values = c("#5E8D99", "#666668", "#77C977", "#D13D93", "#5F3DD1", "#CAD13D")) + ggtitle("TTR_VAC_A2")
plot8 <- ggplot(cnavt_geslaagd, aes(x =cefr, y = Eucl_dist_origin_MI_DP_Entropy_Freq_A2)) + geom_boxplot(aes(fill = topic_A2), position = position_dodge(0.9), notch = FALSE) + scale_fill_manual(values = c("#5E8D99", "#666668", "#77C977", "#D13D93", "#5F3DD1", "#CAD13D")) + ggtitle("Eucl_dist_origin_MI_DP_Entropy_Freq_A2")