library(XLConnect)
library(data.table)
library(publicLibs)
file2 <- XLConnect::loadWorkbook(file.choose())
file2s <- XLConnect::readWorksheet(file2, sheet = 1)

for(i in 1:nrow(Base_Locations)){

  base.points <- Base_Locations[i,3:5]
  distances <- fields::rdist.earth.vec(base.points[2:3], file2s[,2:3])
  service.locs <- data.frame(file2s, distances)
  colnames(service.locs) <- c('pop','long','lat','miles')
  service.locs <- data.table::as.data.table(service.locs)
  service.locs <- service.locs[order(`miles`)]
  service.locs <- subset(service.locs,`miles`<=50)
  service.locs$weight <- 1/(service.locs$miles^2)
  service.locs$fact <- service.locs$weight * service.locs$pop
  write.table(service.locs, file = paste(c('inst/','censusData/',Base_Locations[i,3],'_cens.txt'), collapse = '' ), row.names = FALSE)
}
