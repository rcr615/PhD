source("~/Documents/Gries_bootcamp/stats/2019-08_STG_bootcamp-stat/helpers/explorer.num.r")
library(nnet)
library(mlogit)
library(MNLpred)
library(scales)
####multinomial logistic regression CEFR outcome variable
#sample 78 obs from each CEFR level
set.seed(5)
B1_sample <- as.numeric(sample(row.names(cnavt_data[!is.na(cnavt_data$Geslaagd) & cnavt_data$Geslaagd==1 & cnavt_data$cefr=="B1" & !is.na(cnavt_data$amod_mi_mean_A2_nobt) & !is.na(cnavt_data$TTR_dobj_A2),]),78))
B2_sample <- as.numeric(sample(row.names(cnavt_data[!is.na(cnavt_data$Geslaagd) & cnavt_data$Geslaagd==1 & cnavt_data$cefr=="B2" & !is.na(cnavt_data$amod_mi_mean_A2_nobt) & !is.na(cnavt_data$TTR_dobj_A2),]),78))
C1 <- as.numeric(row.names(cnavt_data[!is.na(cnavt_data$Geslaagd) & cnavt_data$Geslaagd==1 & cnavt_data$cefr=="C1",]))
cnavt_cefr <- cnavt_data[c(B1_sample,B2_sample,C1),]
row.names(cnavt_cefr) <- c(1:nrow(cnavt_cefr))
#plot complexity measures across CEFR levels
#MI trans NP w/ topic
ggplot(cnavt_cefr, aes(x = cefr, y = transitive_NP_MI_A2)) + geom_boxplot(aes(fill = topic_A2), position = position_dodge(0.9), notch = FALSE) + scale_fill_manual(values = c("#5E8D99", "#666668", "#77C977", "#D13D93", "#5F3DD1", "#CAD13D")) + ggtitle("transitive_NP_MI_A2")
#MI trans NP w/o topic
ggplot(cnavt_cefr, aes(x = cefr, y = transitive_NP_MI_A2)) + geom_boxplot(position = position_dodge(0.9), notch = FALSE) + ggtitle("transitive_NP_MI_A2")
#MI intrans w/ topic
ggplot(cnavt_cefr, aes(x = cefr, y = intransitive_MI_A2)) + geom_boxplot(aes(fill = topic_A2), position = position_dodge(0.9), notch = FALSE) + scale_fill_manual(values = c("#5E8D99", "#666668", "#77C977", "#D13D93", "#5F3DD1", "#CAD13D")) + ggtitle("intransitive_MI_A2")
#MI intrans w/o topic
ggplot(cnavt_cefr, aes(x = cefr, y = intransitive_MI_A2)) + geom_boxplot(position = position_dodge(0.9), notch = FALSE) + ggtitle("intransitive_MI_A2")
#MI all VAC w/ topic
ggplot(cnavt_cefr, aes(x = cefr, y = VAC_MI_NOBT_A2)) + geom_boxplot(aes(fill = topic_A2), position = position_dodge(0.9), notch = FALSE) + scale_fill_manual(values = c("#5E8D99", "#666668", "#77C977", "#D13D93", "#5F3DD1", "#CAD13D")) + ggtitle("VAC_MI_A2")
#MI all VAC w/o topic
ggplot(cnavt_cefr, aes(x = cefr, y = VAC_MI_NOBT_A2)) + geom_boxplot(position = position_dodge(0.9), notch = FALSE) + ggtitle("VAC_MI_A2")
#Entropy all VAC w/ topic
ggplot(cnavt_cefr, aes(x = cefr, y = VAC_Entropy_A2)) + geom_boxplot(aes(fill = topic_A2), position = position_dodge(0.9), notch = FALSE) + scale_fill_manual(values = c("#5E8D99", "#666668", "#77C977", "#D13D93", "#5F3DD1", "#CAD13D")) + ggtitle("VAC_Entropy_A2")
#Entropy all VAC w/o topic
ggplot(cnavt_cefr, aes(x = cefr, y = VAC_Entropy_A2)) + geom_boxplot(position = position_dodge(0.9), notch = FALSE) + ggtitle("VAC_Entropy_A2")
#Composite all VAC w/ topic
ggplot(cnavt_cefr, aes(x = cefr, y = VAC_Eucl_dist_origin_MI_Entropy_Freq_A2)) + geom_boxplot(aes(fill = topic_A2), position = position_dodge(0.9), notch = FALSE) + scale_fill_manual(values = c("#5E8D99", "#666668", "#77C977", "#D13D93", "#5F3DD1", "#CAD13D")) + ggtitle("VAC_Eucl_dist_origin_MI_Entropy_Freq_A2")
#Composite all VAC w/o topic
ggplot(cnavt_cefr, aes(x = cefr, y = VAC_Eucl_dist_origin_MI_Entropy_Freq_A2)) + geom_boxplot(position = position_dodge(0.9), notch = FALSE) + ggtitle("VAC_Eucl_dist_origin_MI_Entropy_Freq_A2")
#VAC MI coll high w/ topic
ggplot(cnavt_cefr, aes(x = cefr, y = VAC_MI_coll_high_A2)) + geom_boxplot(aes(fill = topic_A2), position = position_dodge(0.9), notch = FALSE) + scale_fill_manual(values = c("#5E8D99", "#666668", "#77C977", "#D13D93", "#5F3DD1", "#CAD13D")) + ggtitle("VAC_MI_coll_high_A2")
#VAC MI coll high w/o topic
ggplot(cnavt_cefr, aes(x = cefr, y = VAC_MI_coll_high_A2)) + geom_boxplot(position = position_dodge(0.9), notch = FALSE) + ggtitle("VAC_MI_coll_high_A2")
#VAC TTR w/ topic
ggplot(cnavt_cefr, aes(x = cefr, y = TTR_VAC_A2)) + geom_boxplot(aes(fill = topic_A2), position = position_dodge(0.9), notch = FALSE) + scale_fill_manual(values = c("#5E8D99", "#666668", "#77C977", "#D13D93", "#5F3DD1", "#CAD13D")) + ggtitle("TTR_VAC_A2")
#VAC TTR w/o topic
ggplot(cnavt_cefr, aes(x = cefr, y = TTR_VAC_A2)) + geom_boxplot(position = position_dodge(0.9), notch = FALSE) + ggtitle("TTR_VAC_A2")
#VAC DP w/ topic
ggplot(cnavt_cefr, aes(x = cefr, y = VAC_DP_A2)) + geom_boxplot(aes(fill = topic_A2), position = position_dodge(0.9), notch = FALSE) + scale_fill_manual(values = c("#5E8D99", "#666668", "#77C977", "#D13D93", "#5F3DD1", "#CAD13D")) + ggtitle("VAC_DP_A2")
#VAC DP w/o topic
ggplot(cnavt_cefr, aes(x = cefr, y = VAC_DP_A2)) + geom_boxplot(position = position_dodge(0.9), notch = FALSE) + ggtitle("VAC_DP_A2")
#explore normality
#all VAC MI
hist(cnavt_cefr$VAC_MI_NOBT_A2) #looks ok
plot(sort(cnavt_cefr$VAC_MI_NOBT_A2), type="h"); grid()       
plot(ecdf(cnavt_cefr$VAC_MI_NOBT_A2), verticals=TRUE); grid() 
explorer.num(cnavt_cefr$VAC_MI_NOBT_A2)
#all VAC Entropy
hist(cnavt_cefr$VAC_Entropy_A2) #looks ok
plot(sort(cnavt_cefr$VAC_Entropy_A2), type="h"); grid()       
plot(ecdf(cnavt_cefr$VAC_Entropy_A2), verticals=TRUE); grid() 
explorer.num(cnavt_cefr$VAC_Entropy_A2)
#TTR_VAC_A2
hist(cnavt_cefr$TTR_VAC_A2) #looks ok
plot(sort(cnavt_cefr$TTR_VAC_A2), type="h"); grid()       
plot(ecdf(cnavt_cefr$TTR_VAC_A2), verticals=TRUE); grid() 
explorer.num(cnavt_cefr$TTR_VAC_A2)
#VAC_DP_A2
hist(cnavt_cefr$VAC_DP_A2) #left skewed
plot(sort(cnavt_cefr$VAC_DP_A2), type="h"); grid()       
plot(ecdf(cnavt_cefr$VAC_DP_A2), verticals=TRUE); grid() 
explorer.num(cnavt_cefr$VAC_DP_A2)
hist(log(cnavt_cefr$VAC_DP_A2+1,2))
hist(sqrt(cnavt_cefr$VAC_DP_A2)) #looks best
#correlations
cor_mat <- cor(cnavt_cefr[,c(161,163,165,181,183,185,243,247,273)], method = "pearson")
#regression modeling
cnavt_cefr$cefr2 <- relevel(cnavt_cefr$cefr, ref = "B2")
mult_df <- mlogit.data(cnavt_cefr, choice = "cefr2", shape = "wide")
model_all <- mlogit(cefr2 ~ 1 | dobj_mi_mean_A2_nobt + amod_mi_mean_A2_nobt + advmod_mi_mean_A2_nobt + TTR_dobj_A2 + TTR_amod_A2 + TTR_advmod_A2 + VAC_MI_NOBT_A2 + VAC_Entropy_A2 + TTR_VAC_A2, data = mult_df, na.action = na.omit, reflevel = "B2")
odds_ratios_model_all <- data.frame(exp(model_all$coefficients))
head(pp <- fitted(model_all))
#std coeff
cnavt_cefr_std <- sapply(cnavt_cefr[,colnames(cnavt_cefr)[c(161,163,165,181,183,185,243,247,273)], drop = FALSE], scale)
cnavt_cefr_std <- data.frame(cnavt_cefr_std, cnavt_cefr$cefr)
cnavt_cefr_std$cefr2 <- relevel(cnavt_cefr_std$cnavt_cefr.cefr, ref = "B2")
mult_df_std <- mlogit.data(cnavt_cefr_std, choice = "cefr2", shape = "wide")
model_all_std <- mlogit(cefr2 ~ 1 | dobj_mi_mean_A2_nobt + amod_mi_mean_A2_nobt + advmod_mi_mean_A2_nobt + TTR_dobj_A2 + TTR_amod_A2 + TTR_advmod_A2 + VAC_MI_NOBT_A2 + VAC_Entropy_A2 + TTR_VAC_A2, data = mult_df_std, na.action = na.omit, reflevel = "B2")
#80/20 training/test
#training set
set.seed(5)
B1_sample <- as.numeric(sample(row.names(cnavt_cefr[cnavt_cefr$cefr=="B1",]),62))
B2_sample <- as.numeric(sample(row.names(cnavt_cefr[cnavt_cefr$cefr=="B2",]),62))
C1_sample <- as.numeric(sample(row.names(cnavt_cefr[cnavt_cefr$cefr=="C1",]),62))
cnavt_train <- cnavt_cefr[c(B1_sample,B2_sample,C1_sample),]
cnavt_train$cefr2 <- relevel(cnavt_train$cefr, ref = "B2")
model_train <- multinom(cefr2 ~ dobj_mi_mean_A2_nobt + TTR_dobj_A2 + VAC_MI_NOBT_A2 + VAC_Entropy_A2 + TTR_VAC_A2, data = cnavt_train)
#predict model test
cnavt_test <- cnavt_cefr[-c(B1_sample,B2_sample,C1_sample),]
predict(model_train,newdata = cnavt_test)
table(cnavt_test$cefr,predict(model_train,newdata = cnavt_test))
#plots
#effect plots
advmod_MI <- cnavt_cefr
advmod_MI_num <- advmod_MI[,c(161,163,181,183,185,243,247,273)]
advmod_MI_num <- lapply(advmod_MI_num,function(x){
  return(rep(mean(x),length(x)))
})
advmod_MI_num <- bind_rows(advmod_MI_num)
advmod_MI_num <- cbind(advmod_MI_num,advmod_MI[,c(2,165)])
pp <- predict(model_nnet,type = "probs",newdata = advmod_MI_num)
advmod_MI_num[,c(11:13)] <- pp
advmod_mi_mean <- data.frame(c(advmod_MI_num$V11,advmod_MI_num$V12,advmod_MI_num$V13),c(rep("B1",234),rep("B2",234),rep("C1",234)),rep(advmod_MI_num$advmod_mi_mean_A2_nobt,3))
advmod_mi_mean <- data.frame(c(cnavt_cefr$B1,cnavt_cefr$B2,cnavt_cefr$C1),c(rep("B1",234),rep("B2",234),rep("C1",234)),rep(cnavt_cefr$advmod_mi_mean_A2_nobt,3))
colnames(advmod_mi_mean) <- c("pp","CEFR","advmod_MI_mean")
ggplot(advmod_mi_mean, aes(x = advmod_MI_mean, y = pp, color = CEFR)) + geom_smooth(method = "lm") + scale_color_manual(values=c("#5E8D99", "#707070", "#700F5B")) + xlab("PMI Mean Adverbial Modifier") + ylab("Predicted Probability")

TTR_dobj <- cnavt_cefr
TTR_dobj_num <- TTR_dobj[,c(161,163,165,183,185,243,247,273)]
TTR_dobj_num <- lapply(TTR_dobj_num,function(x){
  return(rep(mean(x),length(x)))
})
TTR_dobj_num <- bind_rows(TTR_dobj_num)
TTR_dobj_num <- cbind(TTR_dobj_num,TTR_dobj[,c(2,181)])
pp <- predict(model_nnet,type = "probs",newdata = TTR_dobj_num)
TTR_dobj_num[,c(11:13)] <- pp
TTR_dobj_pp <- data.frame(c(TTR_dobj_num$V11,TTR_dobj_num$V12,TTR_dobj_num$V13),c(rep("B1",234),rep("B2",234),rep("C1",234)),rep(TTR_dobj_num$TTR_dobj_A2,3))
colnames(TTR_dobj_pp) <- c("pp","CEFR","TTR_dobj")
ggplot(TTR_dobj_pp, aes(x = TTR_dobj, y = pp, color = CEFR)) + geom_line() + scale_color_manual(values=c("#5E8D99", "#707070", "#700F5B")) + xlab("TTR Direct Object") + ylab("Predicted Probability")

Entropy <- cnavt_cefr
Entropy_num <- Entropy[,c(161,163,165,181,183,185,243,273)]
Entropy_num <- lapply(Entropy_num,function(x){
  return(rep(mean(x),length(x)))
})
Entropy_num <- bind_rows(Entropy_num)
Entropy_num <- cbind(Entropy_num,Entropy[,c(2,247)])
pp <- predict(model_nnet,type = "probs",newdata = Entropy_num)
Entropy_num[,c(11:13)] <- pp
Entropy_pp <- data.frame(c(Entropy_num$V11,Entropy_num$V12,Entropy_num$V13),c(rep("B1",234),rep("B2",234),rep("C1",234)),rep(Entropy_num$VAC_Entropy_A2,3))
colnames(Entropy_pp) <- c("pp","CEFR","Entropy")
ggplot(Entropy_pp, aes(x = Entropy, y = pp, color = CEFR)) + geom_line() + scale_color_manual(values=c("#5E8D99", "#707070", "#700F5B")) + xlab("Verb-argument Structure Entropy Mean") + ylab("Predicted Probability")


TTR_VAC <- cnavt_cefr
TTR_VAC_num <- TTR_VAC[,c(161,163,165,181,183,185,243,247)]
TTR_VAC_num <- lapply(TTR_VAC_num,function(x){
  return(rep(mean(x),length(x)))
})
TTR_VAC_num <- bind_rows(TTR_VAC_num)
TTR_VAC_num <- cbind(TTR_VAC_num,TTR_VAC[,c(2,273)])
pp <- predict(model_nnet,type = "probs",newdata = TTR_VAC_num)
TTR_VAC_num[,c(11:13)] <- pp
TTR_VAC_pp <- data.frame(c(TTR_VAC_num$V11,TTR_VAC_num$V12,TTR_VAC_num$V13),c(rep("B1",234),rep("B2",234),rep("C1",234)),rep(TTR_VAC_num$TTR_VAC_A2,3))
colnames(TTR_VAC_pp) <- c("pp","CEFR","TTR")
ggplot(TTR_VAC_pp, aes(x = TTR, y = pp, color = CEFR)) + geom_line() + scale_color_manual(values=c("#5E8D99", "#707070", "#700F5B")) + xlab("Verb-argument Structure TTR") + ylab("Predicted Probability")
#advmod mi mean
advmod_MI <- cnavt_cefr
advmod_MI_num <- advmod_MI[,c(161,163,181,183,185,243,247,273)]
advmod_MI_num <- lapply(advmod_MI_num,function(x){
  return(rep(mean(x),length(x)))
})
advmod_MI_num <- bind_rows(advmod_MI_num)
advmod_MI_num <- cbind(advmod_MI_num,advmod_MI[,c(2,165)])
advmod_MI$cefr2 <- relevel(advmod_MI_num$cefr, ref = "B2")
model_pred <- multinom(cefr2 ~ dobj_mi_mean_A2_nobt + amod_mi_mean_A2_nobt + advmod_mi_mean_A2_nobt + TTR_dobj_A2 + TTR_amod_A2 + TTR_advmod_A2 + VAC_MI_NOBT_A2 + VAC_Entropy_A2 + TTR_VAC_A2, data = cnavt_cefr)
advmod_MI$PREDS.NUM <- predict(model_pred, newdata = advmod_MI_num)
#MNLpred
cnavt_cefr$cefr2 <- relevel(cnavt_cefr$cefr, ref = "B2")
model_nnet <- multinom(cefr2 ~ dobj_mi_mean_A2_nobt + amod_mi_mean_A2_nobt + advmod_mi_mean_A2_nobt + TTR_dobj_A2 + TTR_amod_A2 + TTR_advmod_A2 + VAC_MI_NOBT_A2 + VAC_Entropy_A2 + TTR_VAC_A2, data = cnavt_cefr, Hess = TRUE)
pred1 <- mnl_pred_ova(model = model_nnet,
                      data = cnavt_cefr,
                      x = "advmod_mi_mean_A2_nobt",
                      by = 1,
                      seed = "random", # default
                      nsim = 100, # faster
                      probs = c(0.025, 0.975))
ggplot(data = pred1$plotdata, aes(x = advmod_mi_mean_A2_nobt, 
                                  y = mean,
                                  ymin = lower, ymax = upper)) +
  geom_ribbon(alpha = 0.1) + # Confidence intervals
  geom_line() + # Mean
  facet_wrap(.~ cefr2, scales = "free_y", ncol = 2) +
  scale_y_continuous(labels = percent_format(accuracy = 1)) + # % labels
  scale_x_continuous(breaks = c(0:10)) +
  theme_bw() +
  labs(y = "Predicted Probabilities",
       x = "PMI Mean Adverbial Modifier")
pred1 <- mnl_pred_ova(model = model_nnet,
                      data = cnavt_cefr,
                      x = "VAC_Entropy_A2",
                      by = 1,
                      seed = "random", # default
                      nsim = 100, # faster
                      probs = c(0.025, 0.975))
ggplot(data = pred1$plotdata, aes(x = advmod_mi_mean_A2_nobt, 
                                  y = mean,
                                  ymin = lower, ymax = upper)) +
  geom_ribbon(alpha = 0.1) + # Confidence intervals
  geom_line() + # Mean
  facet_wrap(.~ cefr2, scales = "free_y", ncol = 2) +
  scale_y_continuous(labels = percent_format(accuracy = 1)) + # % labels
  scale_x_continuous(breaks = c(0:10)) +
  theme_bw() +
  labs(y = "Predicted Probabilities",
       x = "PMI Mean Adverbial Modifier")
#task type plots
Entropy_task <- data.frame(c(cnavt_cefr$VAC_Entropy_A1,cnavt_cefr$VAC_Entropy_A2),c(as.character(cnavt_cefr$topic_A1),as.character(cnavt_cefr$topic_A2)),rep(cnavt_cefr$cefr,2),rep(cnavt_cefr$speaker_id,2))
Entropy_task <- na.omit(Entropy_task)
colnames(Entropy_task) <-c("Entropy","topic","CEFR","speaker")
Entropy_task1 <- Entropy_task[Entropy_task$topic=="toelatingsexamen" | Entropy_task$topic=="Algen",]
Entropy_task1$topic <- as.factor(Entropy_task1$topic)

ggplot(Entropy_task1, aes(x=topic, y=Entropy)) + 
  geom_violin(trim=FALSE, group=topic) + geom_jitter(aes(color=speaker)) + geom_line(aes(color=speaker)) + theme(legend.position = "none") 

ggplot(Entropy_task1, aes(x = topic, y = Entropy)) + 
  geom_violin(aes(group = topic, fill = topic)) +
  geom_point(aes(group = speaker)) +
  geom_line(aes(group = speaker)) + 
  theme(legend.position = "none") + 
  labs(x = "Topic") 