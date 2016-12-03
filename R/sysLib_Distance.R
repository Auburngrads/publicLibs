library(data.table)

Base_Locations <- read.table(system.file('extdata','Base_Locations.txt',
                                         package = 'publicLibs'),
                             header = TRUE,
                             stringsAsFactors = F)

load("~/R/publicLibs/data/system_libs_modified.rda")

data3 <- System_libs_modified

radius <- 100

count <- 0

for(i in 1:nrow(Base_Locations)){
  base <- matrix(c(Base_Locations[i,4], Base_Locations[i,5]), ncol = 2)

  data3$Distance <- 0
  data4 <- data3[1,]


  for(j in 1:nrow(data3)){
    library <- matrix(unlist(c(data3[j,10], data3[j,9])), ncol = 2)
    distance <- fields::rdist.earth.vec(base, library, miles = TRUE)
    if(distance <= radius) {
      data3[j, 90] <- distance
      data4 <- rbind(data4, data3[j,])
      count <- count + 1
    }

  }

  data4 <- data4[-1,]
  data4$Weight <- 1/(data4[, "Distance"]^2)
  data4$SizeWeight <- data4$Size * data4$Weight
  file.name <- paste(c(Base_Locations[i,3], "_Libs.txt"), collapse = '')
  txt.name <-  paste(c('inst/','extdata4/Straight Distance/',file.name),collapse = '')
  write.table(data4, file = txt.name, row.names = F)

}











