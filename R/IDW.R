

Base_Locations <- read.table("inst/extdata/Base_Locations.txt", header = TRUE, stringsAsFactors = F)
CONUS_Locations <- Base_Locations[-c(2, 19, 21, 28),]
CONUS_Locations$IDW <- 0
radius <- 50



for(i in 1:nrow(CONUS_Locations)){
  file_name <- paste(Base_Locations[i,3], "_Libs.txt", sep = "")
  base_Libs <- read.table(paste("inst/extdata4/", file_name, sep = ""), header = TRUE, stringsAsFactors = F)
  sizeWeight_sum <- 0
  weight_sum <- 0
  for(j in 1:nrow(base_Libs)){
    if(base_Libs[j, "Distance"] <= 50){
      sizeWeight_sum <- sizeWeight_sum + base_Libs[j, "SizeWeight"]
      weight_sum <- weight_sum + base_Libs[j, "Weight"]
    }
  }
  CONUS_Locations[i, "IDW"] <- sizeWeight_sum/weight_sum
}

maxIDW <- max(CONUS_Locations[, "IDW"])
CONUS_Locations$IDW <- CONUS_Locations$IDW/maxIDW

CONUS_Locations <- as.data.table(CONUS_Locations)
CONUS_Locations <- CONUS_Locations[order(-IDW)][,overallRank := 1:.N]


txt.name <-  paste(c('inst/','extdata4/IDW/50mile.txt'),collapse = '')
write.table(CONUS_Locations, file = txt.name, row.names = F)




