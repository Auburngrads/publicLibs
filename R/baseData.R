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
#' @importFrom ggmap geocode
#' @importFrom httr GET
#' @export

baseData <- function(state = NULL, geocode = TRUE,...) {

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

bases <- data.frame(bases, xml7, stringsAsFactors = F)

basenames_l <- gsub('\n', ' ', bases[,1])
basenames_l <- gsub('United States Air Force Academy', 'Air Force Academy',basenames_l)
basenames_l <- gsub('Air Force Base', 'AFB',basenames_l)
basenames_l <- gsub('\\.', '', basenames_l)

basenames_s <- gsub(' AFB', '', basenames_l)
basenames_s <- gsub('Air Force Academy', 'USAFA', basenames_s)
basenames_s <- gsub(' City-Base', '', basenames_s)
basenames_s <- gsub('-', ' ', basenames_s)
baseabbr    <- abbreviate(basenames_s, minlength = 4L, strict = T, method = 'both.sides')

bases <- data.frame(basenames_l,
                    tolower(basenames_s),
                    tolower(baseabbr),
                    xml7,
                    stringsAsFactors = F)
bases[3,3] <- 'andw'
bases[5,3] <- 'brkd'
bases[which(bases[,1]%in%'Keesler AFB'),4:5] <- c(-88.923611,30.411389)
bases[which(bases[,1]%in%'Vance AFB'),  4:5] <- c(-97.917222,36.339444)
colnames(bases) <- c('Base (Long Name)','Base (Short Name)','Base (Abbreviation)','Longitude','Latitude')


txt.name <-  paste(c('inst/','extdata/','Base_Locations.txt'),collapse = '')

  write.table(bases, file = txt.name, row.names = F)

  rda.name <- paste(c('Base_Locations'),collapse = '')

  assign(rda.name, bases, envir = environment())

  save(list = rda.name, file = paste(c("data/",tolower(rda.name),'.rda'), collapse = ''),
       compress = 'xz',
       compression_level = 9)

}
