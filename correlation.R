#set the working directory to wherever you put all of your data files for r to work on. This should also be the directory where you want r to put your results files.

x <- read.csv("catchment_final_revisedtemp.csv", row.names = 1)

numeric.query <- NULL
for(i in 1:ncol(x)){
	numeric.query <- c(numeric.query, class(x[,i]))
}
numeric.query

numeric.query[which(numeric.query != "numeric")]
summary(x[,which(numeric.query != "numeric")])
exclude <- colnames(x)[which(numeric.query != "numeric")]
x2 <- x[,setdiff(colnames(x), exclude)]
for(i in 1:ncol(x2)){
	x2[,i] <- as.numeric(x2[,i])
}

x2 <- as.matrix(x2)

y <- cor(x2, use = "complete.obs")

write.csv(y, "chris_results1.csv")



y <- y[which(!is.na(y[,i])),which(!is.na(y[,i]))]

#set a critical threshold (below) to look for correlations as large, or larger, in magnitude (ignoring any negative signs) than a particular value. I have it set to 7, but you could change it

critical <- 0.9

critical.vector <- NULL
for(i in 1:ncol(y)){
	
	critical.vector <- c(critical.vector, paste(colnames(y)[i], names(which(abs(y[,i]) >= critical)), sep = "_vs_"))
		
}

write.table(critical.vector, paste("A_list_of_correlations_greater_in_abs_val_than_", critical, ".csv", sep = ""), sep = ",", row.names = FALSE, col.names = FALSE)
