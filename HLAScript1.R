library(stats)
library(dplyr)
library(ggplot2)
library(ggfortify)
library(gghighlight)
library(tidyverse)
library(ggthemes)
library(mdthemes)
library(rlist)
library(arsenal)

AllSamples <- select(mutations, c(1,13))

AllSamples1 <- na.omit(AllSamples)

SamplesGroup <- group_by(AllSamples1, Tumor_Sample_Barcode)

Allsplit1 <- split(SamplesGroup, SamplesGroup$Tumor_Sample_Barcode)

HLAsplit1 <- list.map(Allsplit1, minrecogn_neo < 2)

HLAsplit2 <- list.map(Allsplit1, minrecogn_neo >= 0)

output1 <- sapply(HLAsplit1, sum)

output2 <- sapply(HLAsplit2, sum)

comparison_df <- data.frame(output1,output2)

comparison2_df <- cbind(Row.Names = rownames(comparison_df), comparison_df)

rownames(comparison2_df) <- NULL

percentcomp <- comparison2_df$output1/comparison2_df$output2*100

percentcomp2 <- data.frame(comparison2_df, percentcomp2)

#A percentcomp3 dataframe alkalmas a kimutatásra

#A comparison2_df készítése elhagyható, a percentcomp3-ból kimutatás
#a comparison_df használatával is működik