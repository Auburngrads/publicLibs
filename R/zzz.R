#' Megre state datasets together
#'
#'
#' @export
#' @description This function uses plyr::join to combine the public library data sets for each state into a single dataset for the entire U.S.
#' @importFrom plyr join
#' @import datasets


mergeLibs <- function() {

  which(state.abb==state.name)

  all.libs <- data.frame()

  for(i in 1:length(state.abb)) {

  lib <- eval(parse(text = paste(c(state.abb[i],'_Libs'),collapse = '')))

  all.libs <- plyr::join(all.libs, lib, type = 'full')

  }

  rda.name <- "US_Libs"

  assign(rda.name, all.libs, envir = environment())

  save(list = rda.name, file = paste(c("data/",tolower(rda.name),'.rda'), collapse = ''),
       compress = 'xz',
       compression_level = 9)
}

distance <- function(base = NULL, service = 'libraries',radius = NULL,...) {

  if(tolower(service)=='libraries') services <- US_Libs

  b.row <- which(sapply(Base_Locations, match, base, nomatch = 0)==1)%%nrow(Base_Locations)

  b.row <- ifelse(b.row==0, nrow(Base_Locations), b.row)

  base.point <- matrix(unlist(Base_Locations[b.row,(ncol(Base_Locations)-1):ncol(Base_Locations)]),ncol = 2)

  distances <- list()

  for(i in 1:nrow(services)) {

  service.point <- matrix(unlist(services[i,(ncol(services)-1):ncol(services)]), ncol = 2)

  distances[[i]] <- fields::rdist.earth.vec(base.point, service.point)
  }
  distance.vec <- unlist(distances)
  service.locs <- data.table::data.table(services, distance.vec)
  service.locs <- service.locs[order(distance.vec)]
  colnames(service.locs) <- c(colnames(US_Libs),paste(c('Miles from ', base), collapse = ''))
  return(service.locs)
}
