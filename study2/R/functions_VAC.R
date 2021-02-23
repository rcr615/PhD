library(parallel)
library(dplyr)
#format VAC table with parallelization
VAC_label <- function(i, pc = TRUE) {
  df <- i
  df <- cbind(c(1:nrow(df)),df)
  df[] <- lapply(df, as.character)
  cl <- makeCluster(7)
  df <- parApply(cl, df, 1, function(x) {
    print(paste0("processing line: ",x[1]))
    x[] <- lapply(x, as.character)
    tempx <- x[!is.na(x)]
    x[length(x)] <- tempx[length(tempx)]
    x[length(x)-1] <- tempx[length(tempx)-1]
    x[length(x)-2] <- tempx[length(tempx)-2]
    x[length(tempx)] <- NA
    x[length(tempx)-1] <- NA
    x[length(tempx)-2] <- NA
    return(rbind(x))
  })
  df <- as.data.frame(do.call(rbind, df))
  df <- df[,colSums(is.na(df)) != nrow(df)]
  df <- parApply(cl, df, 1, function(x) {
    x$label <- "none"
    x$label <- unlist(ifelse(sum(x[c(1:length(x))] %in% c("obj1","obj2"))==1 & grepl("copula",x[length(x)-2])==FALSE,"transitive_NP",x[length(x)]))
    x$label <- unlist(ifelse(sum(x[c(1:length(x))] %in% c("obj1","obj2"))==0 & grepl("copula",x[length(x)-2])==FALSE & sum(x[c(1:length(x))] %in% c("vc"))==0,"intransitive",x[length(x)]))
    x$label <- unlist(ifelse(sum(x[c(1:length(x))] %in% c("obj1","obj2"))==0 & grepl("copula",x[length(x)-2])==FALSE & grepl("passive",x[length(x)-2])==FALSE & grepl("aux",x[length(x)-2])==FALSE & sum(x[c(1:length(x))] %in% c("vc"))>=1,"transitive_VC",x[length(x)]))
    x$label <- unlist(ifelse(sum(x[c(1:length(x))] %in% c("obj1"))>=1 & sum(x[c(1:length(x))] %in% c("obj2"))>=1 & grepl("copula",x[length(x)-2])==FALSE,"ditransitive_NP_NP",x[length(x)]))
    x$label <- unlist(ifelse(sum(x[c(1:length(x))] %in% c("obj1","obj2"))==1 & grepl("copula",x[length(x)-2])==FALSE & grepl("passive",x[length(x)-2])==FALSE & grepl("aux",x[length(x)-2])==FALSE & grepl("aci",x[length(x)-2])==FALSE & sum(x[c(1:length(x))] %in% c("vc"))>=1,"ditransitive_NP_VC",x[length(x)]))
    x$label <- unlist(ifelse(sum(x[c(1:length(x))] %in% c("obj1","obj2"))==0 & grepl("passive",x[length(x)-2])==TRUE & grepl("no_passive",x[length(x)-2])==FALSE & grepl("te_passive",x[length(x)-2])==FALSE,"passive",x[length(x)]))
    return(rbind(x))
  })
  stopCluster(cl)
  df <- as.data.frame(do.call(rbind, df))
  return(df)
}

#format VAC table with vectorization
VAC_label_nop <- function(i) {
  df <- i
  df <- cbind(c(1:nrow(df)),df)
  df[] <- lapply(df, as.character)
  df <- apply(df, 1, function(x) {
    print(paste0("processing line: ",x[1]))
    x[] <- lapply(x, as.character)
    tempx <- x[!is.na(x)]
    x[length(x)] <- tempx[length(tempx)]
    x[length(x)-1] <- tempx[length(tempx)-1]
    x[length(x)-2] <- tempx[length(tempx)-2]
    x[length(tempx)] <- NA
    x[length(tempx)-1] <- NA
    x[length(tempx)-2] <- NA
    return(rbind(x))
  })
  df <- as.data.frame(do.call(rbind, df))
  df <- df[,colSums(is.na(df)) != nrow(df)]
  df <- apply(df, 1, function(x) {
    print(paste0("processing line: ",x[1]))
    x$label <- "none"
    x$label[sum(x[c(1:length(x))] %in% c("obj1","obj2"))==1 & grepl("copula",x[length(x)-2])==FALSE] <- "transitive_NP"
    x$label[sum(x[c(1:length(x))] %in% c("obj1","obj2"))==0 & grepl("copula",x[length(x)-2])==FALSE & sum(x[c(1:length(x))] %in% c("vc"))==0 & sum(x[c(1:length(x))] %in% c("pc"))==0] <- "intransitive"
    x$label[sum(x[c(1:length(x))] %in% c("obj1","obj2"))==0 & grepl("copula",x[length(x)-2])==FALSE & grepl("passive",x[length(x)-2])==FALSE & grepl("aux",x[length(x)-2])==FALSE & sum(x[c(1:length(x))] %in% c("vc"))>=1] <- "transitive_VC"
    x$label[sum(x[c(1:length(x))] %in% c("obj1"))>=1 & sum(x[c(1:length(x))] %in% c("obj2"))>=1 & grepl("copula",x[length(x)-2])==FALSE] <- "ditransitive_NP_NP"
    x$label[sum(x[c(1:length(x))] %in% c("obj1","obj2"))==1 & grepl("copula",x[length(x)-2])==FALSE & grepl("passive",x[length(x)-2])==FALSE & grepl("aux",x[length(x)-2])==FALSE & grepl("aci",x[length(x)-2])==FALSE & sum(x[c(1:length(x))] %in% c("vc"))>=1] <- "ditransitive_NP_VC"
    x$label[sum(x[c(1:length(x))] %in% c("obj1","obj2"))==0 & grepl("passive",x[length(x)-2])==TRUE & grepl("no_passive",x[length(x)-2])==FALSE & grepl("te_passive",x[length(x)-2])==FALSE] <- "passive"
    return(rbind(x))
  })
  df <- as.data.frame(do.call(rbind, df))
  return(df)
}

VAC_label_nop2 <- function(i) {
  df <- i
  df <- cbind(c(1:nrow(df)),df)
  df[] <- lapply(df, as.character)
  df[,c((length(df)-2):length(df))] <- apply(df[,c(1:length(df))],1,paste0,sep="|",collapse="")
  df[,length(df)] <- gsub(".*\\|(.*:sentid)\\|.*\\|","\\1",df[,length(df)])
  df[,length(df)-1] <- gsub(".*\\|(.*:sc)\\|.*\\|","\\1",df[,length(df)-1])
  df[,length(df)-2] <- gsub(".*\\|(.*verb)\\|.*\\|","\\1",df[,length(df)-2])
  df_begin <- data.frame(lapply(df[,c(1:(length(df)-3))],function(x){
    gsub(".*:sentid","NA",x)
  }))
  df_begin <- data.frame(lapply(df_begin,function(x){
    gsub(".*:sc","NA",x)
  }))
  df_begin <- data.frame(lapply(df_begin,function(x){
    gsub(".*verb","NA",x)
  }))
  df <- cbind(df_begin,df[,c((length(df)-2):length(df))])
  df <- df[,colSums(is.na(df)) != nrow(df)]
  df$combined <- apply(df[,c(1:12)],1,paste0,sep="|",collapse="")
  df$label <- "none"
  colnames(df) <- c(1:(length(df)-5),"verb","sc", "id","combined","label")
  df$label[grepl("obj1",df$combined)==TRUE & grepl("copula",df$sc)==FALSE & grepl("obj2",df$combined)==FALSE & grepl("vc",df$combined)==FALSE] <- "transitive_NP"
  df$label[grepl("obj1",df$combined)==FALSE & grepl("copula",df$sc)==FALSE & grepl("obj2",df$combined)==FALSE & grepl("vc",df$combined)==FALSE & grepl("pc",df$combined)==FALSE] <- "intransitive"
  df$label[grepl("obj1",df$combined)==FALSE & grepl("copula",df$sc)==FALSE & grepl("obj2",df$combined)==FALSE & grepl("vc",df$combined)==TRUE & grepl("aux",df$sc)==FALSE & grepl("passive",df$sc)==FALSE] <- "transitive_VC"
  df$label[grepl("obj1",df$combined)==TRUE & grepl("copula",df$sc)==FALSE & grepl("obj2",df$combined)==TRUE & grepl("aux",df$sc)==FALSE & grepl("passive",df$sc)==FALSE] <- "ditransitive_NP_NP"
  df$label[grepl("obj",df$combined)==TRUE & grepl("copula",df$sc)==FALSE & grepl("aux",df$sc)==FALSE & grepl("passive",df$sc)==FALSE & grepl("vc",df$combined)==TRUE & grepl("aci",df$sc)==FALSE & grepl("pobj",df$combined)==FALSE] <- "ditransitive_NP_VC"
  df$label[grepl("obj",df$combined)==FALSE & grepl("copula",df$sc)==FALSE & grepl("aux",df$sc)==FALSE & grepl("passive",df$sc)==TRUE & grepl("pobj",df$combined)==FALSE & grepl("no_passive",df$sc)==FALSE & grepl("te_passive",df$sc)==FALSE & grepl("vc",df$combined)==TRUE] <- "passive"
  return(df)
}


VAC_label_nop2_learner <- function(i) {
  df <- i
  df <- cbind(c(1:nrow(df)),df)
  df[] <- lapply(df, as.character)
  df[,c((length(df)-2):length(df))] <- apply(df[,c(1:length(df))],1,paste0,sep="|",collapse="")
  df[,length(df)] <- gsub(".*\\|(.*:textid)\\|.*\\|","\\1",df[,length(df)])
  df[,length(df)-1] <- gsub(".*\\|(.*:sc)\\|.*\\|","\\1",df[,length(df)-1])
  df[,length(df)-2] <- gsub(".*\\|(.*verb)\\|.*\\|","\\1",df[,length(df)-2])
  df_begin <- data.frame(lapply(df[,c(1:(length(df)-3))],function(x){
    gsub(".*:textid","NA",x)
  }))
  df_begin <- data.frame(lapply(df_begin,function(x){
    gsub(".*:sc","NA",x)
  }))
  df_begin <- data.frame(lapply(df_begin,function(x){
    gsub(".*verb","NA",x)
  }))
  df <- cbind(df_begin,df[,c((length(df)-2):length(df))])
  df <- df[,colSums(is.na(df)) != nrow(df)]
  df$combined <- apply(df[,c(1:12)],1,paste0,sep="|",collapse="")
  df$label <- "none"
  colnames(df) <- c(1:(length(df)-5),"verb","sc", "id","combined","label")
  df$label[grepl("obj1",df$combined)==TRUE & grepl("copula",df$sc)==FALSE & grepl("obj2",df$combined)==FALSE & grepl("vc",df$combined)==FALSE] <- "transitive_NP"
  df$label[grepl("obj1",df$combined)==FALSE & grepl("copula",df$sc)==FALSE & grepl("obj2",df$combined)==FALSE & grepl("vc",df$combined)==FALSE & grepl("pc",df$combined)==FALSE] <- "intransitive"
  df$label[grepl("obj1",df$combined)==FALSE & grepl("copula",df$sc)==FALSE & grepl("obj2",df$combined)==FALSE & grepl("vc",df$combined)==TRUE & grepl("aux",df$sc)==FALSE & grepl("passive",df$sc)==FALSE] <- "transitive_VC"
  df$label[grepl("obj1",df$combined)==TRUE & grepl("copula",df$sc)==FALSE & grepl("obj2",df$combined)==TRUE & grepl("aux",df$sc)==FALSE & grepl("passive",df$sc)==FALSE] <- "ditransitive_NP_NP"
  df$label[grepl("obj",df$combined)==TRUE & grepl("copula",df$sc)==FALSE & grepl("aux",df$sc)==FALSE & grepl("passive",df$sc)==FALSE & grepl("vc",df$combined)==TRUE & grepl("aci",df$sc)==FALSE & grepl("pobj",df$combined)==FALSE] <- "ditransitive_NP_VC"
  df$label[grepl("obj",df$combined)==FALSE & grepl("copula",df$sc)==FALSE & grepl("aux",df$sc)==FALSE & grepl("passive",df$sc)==TRUE & grepl("pobj",df$combined)==FALSE & grepl("no_passive",df$sc)==FALSE & grepl("te_passive",df$sc)==FALSE & grepl("vc",df$combined)==TRUE] <- "passive"
  return(df)
}

#format VACs for NSP input
NSP_format <- function(i) {
  df <- i
  df$VAC <- paste0(df[,length(df)],"<>",gsub("(.*):verb","\\1",df[,length(df)-4]),"<>")
  vac_freq <- as.data.frame(table(VAC_freq))
  df$Freq_VAC <- vac_freq[match(df$VAC,as.character(vac_freq$VAC_freq)),2]
  rownames(df) <- c(1:nrow(df))
  structure_freq <- as.data.frame(table(Structure_freq))
  df$Freq_structure <- structure_freq[match(df[,length(df)-2],as.character(structure_freq$Structure_freq)),2]
  verb_freq <- as.data.frame(table(Verb_freq))
  df$Freq_verb <- verb_freq[match(gsub("(.*):verb","\\1",df[,length(df)-7]),as.character(verb_freq$Verb_freq)),2]
  df$NSP <- paste0(df$VAC,df$Freq_VAC," ",df$Freq_structure," ",df$Freq_verb)
  return(df)
}