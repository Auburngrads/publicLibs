base.distance <- function(service = 'libraries',...) {

  if(tolower(service)=='libraries') { services <- US_Libs ; suffix <- '_Libs' }

  for(j in 1:nrow(Base_Locations)) {

  b.row <- which(sapply(Base_Locations, match, Base_Locations[j,3], nomatch = 0)==1)%%nrow(Base_Locations)

  b.row <- ifelse(b.row==0, nrow(Base_Locations), b.row)

  base.point <- matrix(unlist(Base_Locations[b.row,(ncol(Base_Locations)-1):ncol(Base_Locations)]),ncol = 2)

  distances <- list()
  places <- list()

  for(i in 1:nrow(services)) {

  service.point <- matrix(unlist(services[i,(ncol(services)-1):ncol(services)]), ncol = 2)

  places[[i]] <- paste(c(services[i,]$Library.Name,'\n',
                                       services[i,]$Address,'\n',
                                       services[i,]$City,', ',services[i,]$State),
                                     collapse = '')

  distances[[i]] <- fields::rdist.earth.vec(base.point, service.point)


  }
  service.locs <- data.table::data.table(unlist(places), unlist(distances))
  service.locs <- service.locs[order(V2)]
  service.locs <- subset(service.locs,service.locs[,V2]<=100)
  colnames(service.locs) <- c('location','miles')

  txt.name <-  paste(c('inst/','extdata/','base_libs/',Base_Locations[j,]$`Base (Short Name)`,'_Libs.txt'),collapse = '')

  write.table(service.locs, file = txt.name, row.names = F)

  rda.name <- paste(c(Base_Locations[j,]$`Base (Short Name)`,'_Libs'),collapse = '')

  assign(rda.name, service.locs, envir = environment())

  save(list = rda.name, file = paste(c("data/",tolower(rda.name),'.rda'), collapse = ''))
  }
}
