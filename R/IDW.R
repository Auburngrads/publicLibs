

Base_Locations <- read.table("inst/extdata/Base_Locations.txt", header = TRUE, stringsAsFactors = F)
CONUS_Locations <- Base_Locations[-c(2, 19, 21, 28),]

CONUS_Locations$'5_Miles' <- 0
CONUS_Locations$'Std_5_Miles' <- 0
CONUS_Locations$'10_Miles' <- 0
CONUS_Locations$'Std_10_Miles' <- 0
CONUS_Locations$'15_Miles' <- 0
CONUS_Locations$'Std_15_Miles' <- 0
CONUS_Locations$'20_Miles' <- 0
CONUS_Locations$'Std_20_Miles' <- 0
CONUS_Locations$'25_Miles' <- 0
CONUS_Locations$'Std_25_Miles' <- 0
CONUS_Locations$'30_Miles' <- 0
CONUS_Locations$'Std_30_Miles' <- 0
CONUS_Locations$'35_Miles' <- 0
CONUS_Locations$'Std_35_Miles' <- 0
CONUS_Locations$'40_Miles' <- 0
CONUS_Locations$'Std_40_Miles' <- 0
CONUS_Locations$'45_Miles' <- 0
CONUS_Locations$'Std_45_Miles' <- 0
CONUS_Locations$'50_Miles' <- 0
CONUS_Locations$'Std_50_Miles' <- 0
CONUS_Locations$'55_Miles' <- 0
CONUS_Locations$'Std_55_Miles' <- 0
CONUS_Locations$'60_Miles' <- 0
CONUS_Locations$'Std_60_Miles' <- 0
CONUS_Locations$'65_Miles' <- 0
CONUS_Locations$'Std_65_Miles' <- 0
CONUS_Locations$'70_Miles' <- 0
CONUS_Locations$'Std_70_Miles' <- 0
CONUS_Locations$'75_Miles' <- 0
CONUS_Locations$'Std_75_Miles' <- 0
CONUS_Locations$'80_Miles' <- 0
CONUS_Locations$'Std_80_Miles' <- 0
CONUS_Locations$'85_Miles' <- 0
CONUS_Locations$'Std_85_Miles' <- 0
CONUS_Locations$'90_Miles' <- 0
CONUS_Locations$'Std_90_Miles' <- 0
CONUS_Locations$'95_Miles' <- 0
CONUS_Locations$'Std_95_Miles' <- 0
CONUS_Locations$'100_Miles' <- 0
CONUS_Locations$'Std_100_Miles' <- 0



radius <- c(seq(5, 100, by = 5))

#--------------Straight Distance-----------------------

for(k in 1:length(radius)) {
  rad <- radius[k]


  for(i in 1:nrow(CONUS_Locations)){
    file_name <- paste(CONUS_Locations[i,3], "_Libs.txt", sep = "")
    base_Libs <- read.table(paste("inst/extdata4/Drive Distance/", file_name, sep = ""), header = TRUE, stringsAsFactors = F)
    sizeWeight_sum <- 0
    weight_sum <- 0
    for(j in 1:nrow(base_Libs)){
     if(base_Libs[j, "Distance"] <= rad){
        sizeWeight_sum <- sizeWeight_sum + base_Libs[j, "SizeWeight"]
        weight_sum <- weight_sum + base_Libs[j, "Weight"]
      }
    }
    CONUS_Locations[i, (4+(2*k))] <- sizeWeight_sum/weight_sum

  }

  CONUS_Locations[, (4+(2*k))] <- as.numeric(gsub("NaN", 0, CONUS_Locations[, (4+(2*k))]))
  maxIDW <- as.numeric(max(CONUS_Locations[, (4+(2*k))]))

  # new stuff

  minIDW <- as.numeric(min(CONUS_Locations[, (4+(2*k))]))
  CONUS_Locations[, (5+(2*k))] <- (CONUS_Locations[, (4+(2*k))] - minIDW)/(maxIDW - minIDW)
  #-----

  #CONUS_Locations[, (5+(2*k))] <- CONUS_Locations[, (4+(2*k))]/maxIDW

}


  txt.name <-  paste(c('inst/','extdata4/IDW/Straight1.txt'),collapse = '')
  write.table(CONUS_Locations, file = txt.name, row.names = F)


#---------------------Drive Distance-------------------------

for(k in 1:length(radius)) {
    rad <- radius[k]


    for(i in 1:nrow(CONUS_Locations)){
      file_name <- paste(CONUS_Locations[i,3], "_Libs.txt", sep = "")
      base_Libs <- read.table(paste("inst/extdata4/Drive Distance/", file_name, sep = ""), header = TRUE, stringsAsFactors = F)
      sizeWeight_sum <- 0
      weight_sum <- 0
      for(j in 1:nrow(base_Libs)){
        if(base_Libs[j, "DriveDistance"] <= rad){
          sizeWeight_sum <- sizeWeight_sum + base_Libs[j, "DriveSizeWeight"]
          weight_sum <- weight_sum + base_Libs[j, "DriveWeight"]
        }
      }
      CONUS_Locations[i, (4+(2*k))] <- sizeWeight_sum/weight_sum

    }

    CONUS_Locations[, (4+(2*k))] <- as.numeric(gsub("NaN", 0, CONUS_Locations[, (4+(2*k))]))
    maxIDW <- as.numeric(max(CONUS_Locations[, (4+(2*k))]))

    # new stuff

    minIDW <- as.numeric(min(CONUS_Locations[, (4+(2*k))]))
    CONUS_Locations[, (5+(2*k))] <- (CONUS_Locations[, (4+(2*k))] - minIDW)/(maxIDW - minIDW)
    #-----

    #CONUS_Locations[, (5+(2*k))] <- CONUS_Locations[, (4+(2*k))]/maxIDW

}



  txt.name <-  paste(c('inst/','extdata4/IDW/Drive1.txt'),collapse = '')
  write.table(CONUS_Locations, file = txt.name, row.names = F)


test1 <- read.table("inst/extdata4/IDW/Drive.txt", header = TRUE, stringsAsFactors = FALSE)
View(test1)
