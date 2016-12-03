library(gmapsdistance)

set.api.key("AIzaSyCleKUDQR1Q0zEmn4jxaLI65dSKGwB79bY")

Base_Locations <- read.table(system.file('extdata','Base_Locations.txt',
                                         package = 'publicLibs'),
                             header = TRUE,
                             stringsAsFactors = F)
# count <- 0
#
# for(i in 1:1){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }
#
#


# for(i in 2:4){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }

# for(i in 5:8){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }

# for(i in 9:9){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   location <- location[-10,]
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }

# for(i in 10:15){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }
#
# count

#
# for(i in 16:20){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }
#
# count

# for(i in 21:25){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }

# count

# for(i in 26:28){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }
#
# count

# for(i in 29:32){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }
#
# count

# for(i in 33:33){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   location <- location[-c(4,22, 32),]
#     for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }
#
# count

# for(i in 34:45){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }
#
# count

# for(i in 46:50){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }
#
# count

# for(i in 51:52){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }
#
# count

# for(i in 53:53){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   location <- location[-c(7), ]
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }
#
# count

# for(i in 54:56){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }
#
# count

# for(i in 57:57){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   location <- location[-c(7),]
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }
#
# count

# for(i in 58:64){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }
#
# count

# for(i in 65:65){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   location <- location[-c(8), ]
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }
#
# count

# for(i in 66:69){
#   base <- Base_Locations[i, 3]
#   base_cord <- paste(c(Base_Locations[i,5], "+", Base_Locations[i,4]), collapse = "")
#   file.name <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
#   location$DriveDistance <- 0
#   for(j in 1:nrow(location)){
#     library <- paste(c(location[j, 9], "+", location[j, 10]), collapse = "")
#     distance <- as.data.frame(gmapsdistance(origin = base_cord, destination = library, mode = "driving"), stringsAsFactors = FALSE)
#     count <- count + 1
#     distance <- distance[2]
#     distance <- gsub("NA", 0, distance)
#     distance <- as.numeric(distance)
#     distance <- distance/1609.34
#     location[j, "DriveDistance"] <- distance
#   }
#   location$DriveWeight <- 1/(location[, "DriveDistance"]^2)
#   location$DriveSizeWeight <- location$Size * location$DriveWeight
#   file.name1 <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
#   write.table(location, file.name1, row.names = FALSE)
# }
#
# count

test <- read.table("inst/extdata4/Drive Distance/hill_Libs.txt", header = TRUE, stringsAsFactors = FALSE)
View(test)
