#' Compress data files
#'
#' @export
#' @description This function uses plyr::join to combine the public library data sets for each state into a single dataset for the entire U.S.
#' @import datasets

compressData <- function() {

for(i in 1:50) {

  lib.state <- state.abb[i]

file <- read.table(paste(c('inst/','extdata/',lib.state,'_Libs.txt'),collapse = ''))

rda.name <- paste(c(lib.state,'_Libs'),collapse = '')

assign(rda.name, file, envir = environment())

save(list = rda.name, file = paste(c("data/",tolower(rda.name),'.rda'), collapse = ''),
     compress = 'xz',
     compression_level = 9)

}
}
