library(gmapsdistance)
library(data.table)

# set.api.key("AIzaSyCleKUDQR1Q0zEmn4jxaLI65dSKGwB79bY")   ----- for driving distance

Base_Locations <- read.table(system.file('extdata','Base_Locations.txt',
                                         package = 'publicLibs'),
                             header = TRUE,
                             stringsAsFactors = F)

radius <- 100

for(i in 1:nrow(Base_Locations)){
  # base <- c(Base_Locations[i,4], Base_Locations[i,5])   ----  for driving distance
  base <- matrix(c(Base_Locations[i,4], Base_Locations[i,5]), ncol = 2)

  data3$Distance <- 0
  data4 <- data3[1,]


  for(j in 1:nrow(data3)){
    # library <- c(data3[j,10], data3[j,9])    ----  for driving distance
    library <- matrix(c(data3[j,10], data3[j,9]), ncol = 2)
    # distance <- as.data.frame(gmapsdistance(origin = base, destination = library, mode = "driving"), stringsAsFactors = FALSE)
    distance <- fields::rdist.earth.vec(base, library, miles = TRUE)
    # distance <- distance[2]
    # distance <- gsub("NA", 0, distance)
    # distance <- as.numeric(distance)
    # distance <- distance/1609.34          # Converts meters to miles
    if(distance <= radius) {
      data3[j, 91] <- distance
      data4 <- rbind(data4, data3[j,])
    }

  }

  data4 <- data4[-1,]
  file.name <- paste(c(Base_Locations[i,3], "_Libs.txt"), collapse = '')
  txt.name <-  paste(c('inst/','extdata4/',file.name),collapse = '')
  write.table(data4, file = txt.name, row.names = F)

}

test <- read.table("inst/extdata4/alts_Libs.txt", header = TRUE, stringsAsFactors = F)
View(test)









