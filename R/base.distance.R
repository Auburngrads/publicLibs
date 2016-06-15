#' Calulate the distance from a US Air Force Base to a service
#'
#' @param base The name of a USAF base COUNS
#' @param service The type of service for which a distance is desired
#' @param ... Extra stuff
#'
#' @importFrom fields rdist.earth.vec
#' @importFrom data.table data.table
#' @importFrom utils read.table
#' @export

base.distance <- function(base = NULL,service = 'libraries',...) {

  if(tolower(service)=='libraries') { services <- US_Libs ; suffix <- '_Libs' }

  Base_Locations <- read.table(system.file('extdata','Base_Locations.txt',
                                           package = 'publicLibs'),
                               header = TRUE)

  for(j in 1:nrow(Base_Locations)) {

  b.row <- which(sapply(Base_Locations, match, Base_Locations[j,3], nomatch = 0)==1)%%nrow(Base_Locations)

  if(b.row[1]==0) { b.row = nrow(Base_Locations) } else { b.row = b.row[1] }

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
  service.locs <- data.table::data.table(unlist(places),
                                         unlist(distances),
                                         services$Latitude,
                                         services$Longitude)
  colnames(service.locs) <- c('location','miles','latitude','longitude')
  service.locs <- service.locs[order(`miles`)]
  service.locs <- subset(service.locs,service.locs[,`miles`]<=100)

  txt.name <-  paste(c('inst/','extdata/','base_libs/',Base_Locations[j,]$`Base (Abbreviation)`,'_Libs.txt'),collapse = '')

  write.table(service.locs, file = txt.name, row.names = F)

  rda.name <- paste(c(Base_Locations[j,]$`Base (Abbreviation)`,'_Libs'),collapse = '')

  assign(rda.name, service.locs, envir = environment())

  save(list = rda.name, file = paste(c("data/",tolower(rda.name),'.rda'), collapse = ''),
       compress = 'xz',
       compression_level = 9)
  }
}
