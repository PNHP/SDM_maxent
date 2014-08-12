#---------------------------------------------------------------------------------------------
# Name: Correlation2.R
# Purpose: correlation script for enviromental data for SDM work
# Author: Christopher Tracey
# Created: 2014-08-12
# Updated: 2014-08-12
#
# Updates:
# insert date and info
# 
#
# To Do List/Future Ideas:
# *eliminate ones critical values for the same variable
#---------------------------------------------------------------------------------------------


# set the working directory to wherever you put all of your data files for r to work on. 
# This should also be the directory where you want r to put your results files.

# reads in environmental data organized in columns
CorData = read.csv("corre.csv")

# Correlation proceedure
y <- cor(CorData,use="complete.obs")
write.csv(y,"CorrelationResults.csv")

# set a critical threshold (below) to look for correlations as large, or larger, in magnitude (ignoring any negative signs) 
# than a particular value. I have it set to "0.8", but you could change it

critical <- 0.8
critical_vector <- NULL

for(i in 1:ncol(y)) {
  critical_vector <- c(critical_vector, paste(colnames(y)[i], names(which(abs(y[,i]) >= critical)), sep=" vs "))
}
file1 <- paste("CriticalTreshhold_ge",critical,".csv", sep="")
write.csv(critical_vector,file1)
