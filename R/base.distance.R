#' Calculate the distance from a US Air Force Base to a service
#'
#' @details This function computes the distance between the location of a CONUS
#' US Air Force Base and the location of a service.  The default service
#' type is \code{libraries} as this was the first service considered.  Distance
#' measurements were computed using the \code{rdist.earth.vec} function from the
#' fields package.  Latitude/longitude values were found by submitting the addresses
#' of the service locations to the Google API using \code{ggmap::geocode}.
#'
#' @param base The name of a CONUS USAF base
#' @param service The type of service for which a distance is desired
#'
#' @importFrom fields rdist.earth.vec
#' @importFrom data.table data.table
#' @importFrom utils read.table
#' @export

base.distance <- function(base = NULL,service = 'libraries', radius = 100) {

  if(tolower(service)=='libraries') { services <- US_Libs ; suffix <- '_Libs'

  } else { services = NULL

  }

  Base_Locations <- read.table(system.file('extdata','Base_Locations.txt',
                                           package = 'publicLibs'),
                               header = TRUE,
                               stringsAsFactors = F)

  for(j in 1:nrow(Base_Locations)) {

  b.row <- which(sapply(Base_Locations, match, Base_Locations[j,3], nomatch = 0)==1)%%nrow(Base_Locations)

  if(b.row[1]==0) { b.row = nrow(Base_Locations) } else { b.row = b.row[1] }

  base.point <- matrix(unlist(Base_Locations[b.row,(ncol(Base_Locations)-1):ncol(Base_Locations)]),ncol = 2)

  distances <- list()
  places <- list()

  for(i in 1:nrow(services)) {

  service.point <- matrix(unlist(services[i,(ncol(services)-1):ncol(services)]), ncol = 2)

  places[[i]] <- paste(c(services[i,]$Library.Name,'<br/>',
                                       services[i,]$Address,'<br/>',
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
  service.locs <- subset(service.locs,`miles`<=radius)

  txt.name <-  paste(c('inst/','extdata2/','base_libs/',Base_Locations[j,]$Base..Abbreviation.,'_Libs.txt'),collapse = '')

  write.table(service.locs, file = txt.name, row.names = F)

  rda.name <- paste(c(Base_Locations[j,]$Base..Abbreviation.,'_Libs'),collapse = '')

  assign(rda.name, service.locs, envir = environment())

  save(list = rda.name, file = paste(c("data/",tolower(rda.name),'.rda'), collapse = ''),
       compress = 'xz',
       compression_level = 9)
  }
}
