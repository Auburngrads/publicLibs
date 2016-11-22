data <- "C:\\Users\\Corey\\OneDrive\\Documents\\Corey's Documents\\School\\Graduate School of Engineering and Management\\Thesis Research - P4\\Data\\Aditional Data\\Library_Systems__FY_2014_Public_Libraries_Survey_Modified.xlsx"

data2 <- readxl::read_excel(data)

data2$CollectionSpace <- (13*(data2$`PRINT MATERIALS`+data2$`AUDIO MATERIALS`+data2$`VIDEO MATERIALS`+data2$`PRINT SERIALS`)) + (45*data2$COMPUTERS)

for(i in 1:length(data2)){
  if(data2[i, 6] < 1000) data2[i, 87] = 22.50
  if(data2[i, 6] >= 1000 & data2[i, 6] < 2500) data2[i,87] = 14.25
  if(data2[i, 6] >= 2500 & data2[i, 6] < 5000) data2[i,87] = 10.00
  if(data2[i, 6] >= 5000 & data2[i, 6] < 10000) data2[i,87] = 7.00
  if(data2[i, 6] >= 10000 & data2[i, 6] < 25000) data2[i,87] = 4.50
  if(data2[i, 6] >= 25000 & data2[i, 6] < 50000) data2[i,87] = 3.00
  if(data2[i, 6] >= 50000) data2[i,87] = 2.25
}


data2$WorkSpace <- (150*data2$`TOTAL STAFF`) + (30*data2$seatsPer*(data2$`SERVICE AREA POPULATION`/1000))

data2$GrossArea <- (data2$CollectionSpace + data2$WorkSpace) * 1.17

data2$Size <- data2$GrossArea * 1.27
