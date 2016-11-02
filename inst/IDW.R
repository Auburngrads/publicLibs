library(data.table)
library(publicLibs)
IDW <- as.data.table(Base_Locations[, 1:3])
IDW$index <- "NA"
for (i in 1:nrow(Base_Locations)){

  base <- read.table(file = paste(c(getwd(), "/inst/censusData/", Base_Locations[i,3], "_cens.txt"), collapse = ''), stringsAsFactors = FALSE, header = TRUE)
  IDW[i,4] <- sum(base$fact)/sum(base$weight)


}
IDW <- IDW[order(-index)]
