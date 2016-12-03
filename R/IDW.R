

Base_Locations <- read.table("inst/extdata/Base_Locations.txt", header = TRUE, stringsAsFactors = F)
CONUS_Locations <- Base_Locations[-c(2, 19, 21, 28),]

CONUS_Locations$'5' <- 0
CONUS_Locations$'10' <- 0
CONUS_Locations$'15' <- 0
CONUS_Locations$'20' <- 0
CONUS_Locations$'25' <- 0
CONUS_Locations$'30' <- 0
CONUS_Locations$'35' <- 0
CONUS_Locations$'40' <- 0
CONUS_Locations$'45' <- 0
CONUS_Locations$'50' <- 0
CONUS_Locations$'55' <- 0
CONUS_Locations$'60' <- 0
CONUS_Locations$'65' <- 0
CONUS_Locations$'70' <- 0
CONUS_Locations$'75' <- 0
CONUS_Locations$'80' <- 0
CONUS_Locations$'85' <- 0
CONUS_Locations$'90' <- 0
CONUS_Locations$'95' <- 0
CONUS_Locations$'100' <- 0



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
    CONUS_Locations[i, 5+k] <- sizeWeight_sum/weight_sum

  }

  CONUS_Locations[, 5+k] <- as.numeric(gsub("NaN", 0, CONUS_Locations[, 5+k]))
  maxIDW <- as.numeric(max(CONUS_Locations[, 5+k]))
  CONUS_Locations[, 5+k] <- CONUS_Locations[, 5+k]/maxIDW

}


  txt.name <-  paste(c('inst/','extdata4/IDW/Straight.txt'),collapse = '')
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
      CONUS_Locations[i, 5+k] <- sizeWeight_sum/weight_sum

    }

    CONUS_Locations[, 5+k] <- as.numeric(gsub("NaN", 0, CONUS_Locations[, 5+k]))
    maxIDW <- as.numeric(max(CONUS_Locations[, 5+k]))
    CONUS_Locations[, 5+k] <- CONUS_Locations[, 5+k]/maxIDW

  }


  txt.name <-  paste(c('inst/','extdata4/IDW/Drive.txt'),collapse = '')
  write.table(CONUS_Locations, file = txt.name, row.names = F)


test1 <- read.table("inst/extdata4/IDW/Drive.txt", header = TRUE, stringsAsFactors = FALSE)
View(test1)
