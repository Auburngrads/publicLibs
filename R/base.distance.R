base.distance <- function(base = NULL,service = 'libraries',...) {

  if(tolower(service)=='libraries') { services <- US_Libs ; suffix <- '_Libs' }

  #if(!is.null(base)) base_locations <-

  for(j in 1:nrow(base_locations)) {

  b.row <- which(sapply(base_locations, match, base_locations[j,3], nomatch = 0)==1)%%nrow(base_locations)

  if(b.row[1]==0) { b.row = nrow(base_locations) } else { b.row = b.row[1] }

  base.point <- matrix(unlist(base_locations[b.row,(ncol(base_locations)-1):ncol(base_locations)]),ncol = 2)

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
  service.locs <- data.table::data.table(unlist(places),
                                         unlist(distances),
                                         services$Latitude,
                                         services$Longitude)
  service.locs <- service.locs[order(V2)]
  service.locs <- subset(service.locs,service.locs[,V2]<=100)
  colnames(service.locs) <- c('location','miles','latitude','longitude')

  txt.name <-  paste(c('inst/','extdata/','base_libs/',base_locations[j,]$`Base (Abbreviation)`,'_Libs.txt'),collapse = '')

  write.table(service.locs, file = txt.name, row.names = F)

  rda.name <- paste(c(base_locations[j,]$`Base (Abbreviation)`,'_Libs'),collapse = '')

  assign(rda.name, service.locs, envir = environment())

  save(list = rda.name, file = paste(c("data/",tolower(rda.name),'.rda'), collapse = ''),
       compress = 'xz',
       compression_level = 9)
  }
}
