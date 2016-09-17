#' Megre state datasets together
#'
#'
#' @export
#' @description This function uses plyr::join to combine the public library data sets for each state into a single dataset for the entire U.S.
#' @importFrom plyr join
#' @import datasets

mergeLibs <- function() {

  state.abb  <- datasets::state.abb
  state.name <- datasets::state.name

  which(state.abb==state.name)

  all.libs <- data.frame(stringsAsFactors = F)

  for(i in 1:length(state.abb)) {

  lib <- eval(parse(text = paste(c(state.abb[i],'_Libs'),collapse = '')))

  all.libs <- plyr::join(all.libs, lib, type = 'full')

  }

  all.libs[,1] <- as.character(all.libs[,1])
  all.libs[,2] <- as.character(all.libs[,2])
  all.libs[,3] <- as.character(all.libs[,3])
  all.libs[,4] <- as.character(all.libs[,4])

  rda.name <- "US_Libs"

  assign(rda.name, all.libs, envir = environment())

  save(list = rda.name, file = paste(c("data/",tolower(rda.name),'.rda'), collapse = ''),
       compress = 'xz',
       compression_level = 9)
}

