source("/Users/rachelrubin/Documents/study2/R/functions_VAC.R")
library(entropy)
#read in VACs from text file
lassy_vacs <- read.table(file = "/Users/rachelrubin/Documents/study2/VAC_Xquery/VACs_WR-P-E-E.txt", na.strings = c(""), sep = "|", row.names = NULL, header = FALSE, col.names = paste0("V",1:25), fill = TRUE, quote = "")
#run function to format VACs into table
lassy_vacs_labels <- VAC_label_nop2(lassy_vacs)
#Freq tables
Structure_freq <- as.character(lassy_vacs_labels[grepl("\\|",lassy_vacs_labels[,length(lassy_vacs_labels)-3])==FALSE,length(lassy_vacs_labels)])
Verb_freq <- gsub("(.*):verb","\\1",lassy_vacs_labels[grepl("\\|",lassy_vacs_labels[,length(lassy_vacs_labels)-3])==FALSE,length(lassy_vacs_labels)-4])
VAC_freq <- paste0(Structure_freq,"<>",Verb_freq,"<>")
save(VAC_freq, file = "~/Documents/study2/R/Lassy_vacs_freq_tables/VAC_freq2.Rdata")
save(Structure_freq, file = "~/Documents/study2/R/Lassy_vacs_freq_tables/Structure_freq2.Rdata")
save(Verb_freq, file = "~/Documents/study2/R/Lassy_vacs_freq_tables/Verb_freq2.Rdata")
#format for NSP input
lassy_vacs_labels <- NSP_format(lassy_vacs_labels)
colnames(lassy_vacs_labels) <- c(1:(length(lassy_vacs_labels)-9),"sc","sentid", "combined", "structure","VAC","Freq_VAC","Freq_structure","Freq_verb","NSP")
lassy_vacs_labels <- lassy_vacs_labels[grepl("\\|",lassy_vacs_labels$sc)==FALSE,]
lassy_vacs_labels <- lassy_vacs_labels[lassy_vacs_labels$structure!="none",]
NSP_input <- lassy_vacs_labels$NSP
#read in MI & Fisher values for VACs
VAC_mi <- read.table(file = "/Users/rachelrubin/Documents/study2/VACs3.mi", quote = "", sep = " ", skip = 1)
VAC_mi$V6 <- gsub("(.*<>.*<>)[0-9]+","\\1",VAC_mi$V1)
VAC_mi$V7 <- gsub(".*<>.*<>([0-9]+)","\\1",VAC_mi$V1)
colnames(VAC_mi) <- c("VAC/rank","MI","joint_freq","structure_freq","verb_freq","VAC","rank")
VAC_fisher <- read.table(file = "/Users/rachelrubin/Documents/study2/VACs3.fisher", quote = "", sep = " ", skip = 1)
VAC_fisher$V6 <- gsub("(.*<>.*<>)[0-9]+","\\1",VAC_fisher$V1)
VAC_fisher$V7 <- gsub(".*<>.*<>([0-9]+)","\\1",VAC_fisher$V1)
colnames(VAC_fisher) <- c("VAC/rank","fisher","joint_freq","structure_freq","verb_freq","VAC","rank")
Lassy_VAC_measures <- data.frame(VAC_mi$VAC,VAC_mi$MI)
colnames(Lassy_VAC_measures) <- c("VAC","MI")
Lassy_VAC_measures$Fisher <- VAC_fisher$fisher[match(Lassy_VAC_measures$VAC,VAC_fisher$VAC)]
Lassy_VAC_measures[] <- lapply(Lassy_VAC_measures,as.character)
Lassy_VAC_measures <- cbind(seq(1,nrow(Lassy_VAC_measures)),Lassy_VAC_measures)
#VAC dispersion
VAC_dispersion_all <- data.frame(lassy_vacs_labels$sentid,lassy_vacs_labels$VAC)
VAC_dispersion_all$corpus_part <- gsub("([A-Z]{2,2}-[A-Z]-[A-Z]-[A-Z])-[0-9]+\\..*:sentid","\\1",VAC_dispersion_all$sentid)
VAC_dispersion_all$VAC <- as.character(VAC_dispersion_all$VAC)
#VAC_dispersion_all <- VAC_dispersion_all[grepl("none",VAC_dispersion_all$VAC)==FALSE,]
corpus_parts <- as.data.frame(table(VAC_dispersion_all$corpus_part))
corpus_parts$percentage <- corpus_parts$Freq/sum(corpus_parts$Freq)
DP_VAC <- apply(Lassy_VAC_measures,1,function(x) {
  print(x[[1]])
  disp_table <- VAC_dispersion_all[VAC_dispersion_all$VAC==x[[2]],]
  disp_table[] <- lapply(disp_table,as.character)
  disp_table_VAC <- as.data.frame(table(disp_table$corpus_part,disp_table$VAC))
  compute_df <- corpus_parts[corpus_parts$percentage>.000001,]
  compute_df$VAC_freq <- rep(NA,nrow(compute_df))
  disp_table_VAC[] <- lapply(disp_table_VAC, as.character)
  compute_df[] <- lapply(compute_df, as.character)
  compute_df$VAC_freq <- disp_table_VAC$Freq[match(compute_df$Var1,disp_table_VAC$Var1)]
  compute_df$VAC_freq[is.na(compute_df$VAC_freq)] <- 0
  compute_df$obs_percentage <- as.numeric(compute_df$VAC_freq)/sum(as.numeric(compute_df$VAC_freq))
  compute_df$abs_dif <- abs(as.numeric(compute_df$percentage)-as.numeric(compute_df$obs_percentage))
  sum_diff <- sum(compute_df$abs_dif)
  DP <- sum_diff/2
  return(DP)
})
Lassy_VAC_measures$DP <- DP_VAC
VAC_dispersion_all$structure <- gsub("(.*)<>.*<>","\\1",VAC_dispersion_all$VAC)
VAC_dispersion_all$verb <- gsub(".*<>(.*)<>","\\1",VAC_dispersion_all$VAC)
entropy_matrix <- as.data.frame(table(VAC_dispersion_all$structure,VAC_dispersion_all$verb))
entropy_matrix <- reshape(entropy_matrix,idvar = "Var2",timevar = "Var1", direction = "wide")
row.names(entropy_matrix) <- c(1:nrow(entropy_matrix))
Lassy_VAC_measures$Entropy <- apply(Lassy_VAC_measures,1,function(x){
  entropy <- entropy(as.numeric(entropy_matrix[match(gsub(".*<>(.*)<>","\\1",x[[2]]),entropy_matrix$Var2),c(2:8)]),method="ML",unit="log2")
  return(entropy)
})
VAC_freq_table <- as.data.frame(table(VAC_freq))
Lassy_VAC_measures$Frequency <- VAC_freq_table$Freq[match(Lassy_VAC_measures$VAC,VAC_freq_table$VAC_freq)]
Lassy_VAC_measures$MI <- as.numeric(Lassy_VAC_measures$MI)
Lassy_VAC_measures$Fisher <- as.numeric(Lassy_VAC_measures$Fisher)
#Norm measures for composite measures
Lassy_VAC_measures$MI_norm <- (Lassy_VAC_measures$MI-min(Lassy_VAC_measures$MI))/(max(Lassy_VAC_measures$MI)-min(Lassy_VAC_measures$MI))
Lassy_VAC_measures$Entropy_norm <- (Lassy_VAC_measures$Entropy-min(Lassy_VAC_measures$Entropy))/(max(Lassy_VAC_measures$Entropy)-min(Lassy_VAC_measures$Entropy))
Lassy_VAC_measures$Frequency_norm <- (Lassy_VAC_measures$Frequency-min(Lassy_VAC_measures$Frequency))/(max(Lassy_VAC_measures$Frequency)-min(Lassy_VAC_measures$Frequency))
Lassy_VAC_measures <- Lassy_VAC_measures[!is.na(Lassy_VAC_measures$DP),]
#composite measures
Lassy_VAC_measures$Eucl_dist_origin_MI_DP_Entropy_Freq <- sqrt(Lassy_VAC_measures$DP^2+Lassy_VAC_measures$MI_norm^2+Lassy_VAC_measures$Entropy_norm^2+Lassy_VAC_measures$Frequency_norm^2)
Lassy_VAC_measures$Eucl_dist_origin_Fisher_DP_Entropy_Freq <- sqrt(Lassy_VAC_measures$DP^2+Lassy_VAC_measures$Fisher^2+Lassy_VAC_measures$Entropy_norm^2+Lassy_VAC_measures$Frequency_norm^2)
Lassy_VAC_measures$Eucl_dist_origin_MI_Entropy_Freq <- sqrt(Lassy_VAC_measures$MI_norm^2+Lassy_VAC_measures$Entropy_norm^2+Lassy_VAC_measures$Frequency_norm^2)
Lassy_VAC_measures$Eucl_dist_origin_Fisher_Entropy_Freq <- sqrt(Lassy_VAC_measures$Fisher^2+Lassy_VAC_measures$Entropy_norm^2+Lassy_VAC_measures$Frequency_norm^2)
#finalize & save
colnames(Lassy_VAC_measures) <- c("index",colnames(Lassy_VAC_measures[2:length(colnames(Lassy_VAC_measures))]))
save(Lassy_VAC_measures,file = "~/Documents/study2/R/Lassy_VAC_measures3.Rdata")