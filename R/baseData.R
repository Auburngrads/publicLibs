#' Build data sets for US Public Libraries
#'
#' @details This functions scrapes data from http://www.publiclibraries.com, recording the name, address, zipcode, latitude, and longitude for each public library in \code{state}.
#'
#' The resulting data is stored as a .txt file in the extdata directory and an .rda file in the data/ directory.
#'
#'
#' @param state Which state
#' @param geocode Should geocode data be provided?
#' @param ... more options for ggmap::geocode
#'
#' @importFrom XML htmlParse
#' @importFrom XML readHTMLTable
#' @import datasets
#' @importFrom utils write.table
#' @export

baseData <- function(...) {

  base.url <- 'http://www.thefullwiki.org/List_of_United_States_Air_Force_bases'


tables <- httr::GET(base.url)
base.xml1 <- XML::htmlParse(tables)
base.xml2 <- XML::readHTMLTable(base.xml1)

bases <- data.frame(base.xml2[[3]], stringsAsFactors = F)
bases <- as.character(bases[,1])
bases <- data.frame(bases, stringsAsFactors = F)
base.list <- list()

for(i in 1:nrow(bases))  {

    base.list[[i]] <- ggmap::geocode(bases[i,1], source = 'google',...)

}

xml7 <- matrix(unlist(base.list),ncol = 2, byrow = T)

bases <- data.frame(bases, xml7)

colnames(bases) <- c('Base','Longitude','Latitude')

txt.name <-  paste(c('inst/','extdata/','Base_Locations.txt'),collapse = '')

  write.table(bases, file = txt.name, row.names = F)

  rda.name <- paste(c('Base_Locations'),collapse = '')

  assign(rda.name, bases, envir = environment())

  save(list = rda.name, file = paste(c("data/",tolower(rda.name),'.rda'), collapse = ''))


}
