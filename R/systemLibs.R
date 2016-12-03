data <- "C:\\Users\\Corey\\OneDrive\\Documents\\Corey's Documents\\School\\Graduate School of Engineering and Management\\Thesis Research - P4\\Data\\Aditional Data\\Library_Systems__FY_2014_Public_Libraries_Survey_Modified.xlsx"

data2 <- readxl::read_excel(data)

data2$CollectionSpace <- (13*(data2$`PRINT MATERIALS`+data2$`AUDIO MATERIALS`+data2$`VIDEO MATERIALS`+data2$`PRINT SERIALS`)) + (45*data2$COMPUTERS)

data2$seatsPer <- 0

for(i in 1:nrow(data2)){
  if(data2[i, 6] < 1000) data2[i, 87] = 22.50
  if(data2[i, 6] >= 1000 & data2[i, 6] < 2500) data2[i,87] = 14.25
  if(data2[i, 6] >= 2500 & data2[i, 6] < 5000) data2[i,87] = 10.00
  if(data2[i, 6] >= 5000 & data2[i, 6] < 10000) data2[i,87] = 7.00
  if(data2[i, 6] >= 10000 & data2[i, 6] < 25000) data2[i,87] = 4.50
  if(data2[i, 6] >= 25000 & data2[i, 6] < 50000) data2[i,87] = 3.00
  if(data2[i, 6] >= 50000) data2[i,87] = 2.25
}


data2$WorkSpace <- (150*data2$`TOTAL STAFF`) + (30*data2$seatsPer*(data2$`SERVICE AREA POPULATION`/1000))

data2$Size <- data2$WorkSpace + data2$CollectionSpace

for(j in 1:nrow(data2)){
  if(data2[j, 9] == 0 & data2[j, 10] == 0){
     geo <- ggmap::geocode(as.character(data2[j,8]), source = "google")
     data2[j, 9] <- geo[1,2]
     data2[j, 10] <- geo[1,1]
  }

}

txt.name1 <-  paste(c('inst/','bigdata/','System_Libraries_Full.txt'),collapse = '')

write.table(data2, file = txt.name1, row.names = F)

data.rda <- data2

rda.name <- 'System_libs_full'

assign(rda.name, data.rda, envir = environment())

save(list = rda.name, file = paste(c("data/",tolower(rda.name),'.rda'), collapse = ''),
     compress = 'xz',
     compression_level = 9)



data3 <- data2
data3 <- data2[-which(data2$`TOTAL STAFF` <= 0),]
data3 <- data3[-which(data3$`PRINT MATERIALS` < 0),]
data3 <- data3[-which(data3$`AUDIO MATERIALS` < 0),]
data3 <- data3[-which(data3$`PRINT SERIALS` < 0),]


txt.name2 <-  paste(c('inst/','bigdata/','System_Libraries_Modified.txt'),collapse = '')

write.table(data3, file = txt.name2, row.names = F)

data.rda <- data3

rda.name <- 'System_libs_modified'

assign(rda.name, data.rda, envir = environment())

save(list = rda.name, file = paste(c("data/",tolower(rda.name),'.rda'), collapse = ''),
     compress = 'xz',
     compression_level = 9)



