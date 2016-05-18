#' Megre state datasets together
#'
#'
#' @export
#' @description This function uses plyr::join to combine the public library data sets for each state into a single dataset for the entire U.S.
#' @importFrom plyr join
#' @import datasets


mergeLibs <- function() {

  which(state.abb==state.name)

  US_Libs <- data.frame()

  for(i in 1:length(state.abb)) {

  lib <- eval(parse(text = paste(c(state.abb[i],'_Libs'),collapse = '')))

  US_Libs <- plyr::join(US_Libs, lib, type = 'full')

  }


}
