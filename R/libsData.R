#' Build data sets for US Public Libraries
#'
#' @details This functions scrapes data from http://www.publiclibraries.com, recording the name, address, zipcode, latitude, and longitude for each public library in \code{state}.
#'
#' The resulting data is stored as a .txt file in the extdata directory and an .rda file in the data/ directory.
#'
#'
#' @param state Which state
#' @param ... more options for ggmap::geocode


libsData <- function(state = NULL, geocode = TRUE,...) {

  if(!(tolower(state)%in%tolower(state.abb) | tolower(state)%in%tolower(state.name))) {

    stop('State argument not recognized, check your spelling')

  } else {

    lib.state <- ifelse(tolower(state)%in%tolower(state.name),
                        state.abb[match(tolower(state),tolower(state.name))],
                        toupper(state))
  }

  URL <- paste(c('http://www.publiclibraries.com/',
                 tolower(state.name[match(tolower(lib.state),tolower(state.abb))]),
                 '.htm'),
               collapse = '')

  xml1 <- XML::htmlParse(URL)
  xml2 <- XML::readHTMLTable(xml1)

  lib.name  <- data.frame(xml2$libraries$Library, stringsAsFactors = F)
  lib.city  <- data.frame(xml2$libraries$City,    stringsAsFactors = F)

  xml3 <- data.frame(lib.name,xml2$libraries$Address,lib.city,lib.state,xml2$libraries$Zip, stringsAsFactors = F)
  xml3[,2] <- as.character(xml3[,2])
  xml3[,3] <- as.character(xml3[,3])
  xml3[,5] <- as.character(xml3[,5])

  duplicates <- which(duplicated(xml3[,2]))

    if(!is.na(duplicates[1])) xml3 <- xml3[-duplicates,]

  blanks <- which(xml3[,2]=='')

    if(!is.na(blanks[1])) xml3 <- xml3[-blanks,]

  xml4 <- list()
  for(i in 1:nrow(xml3))  {

    xml4[[i]] <- paste(c(xml3[i,2],xml3[i,3],xml3[i,4]), collapse = ', ')

  }

  xml5 <- data.frame(unlist(xml4), stringsAsFactors = F)

  if(!geocode) {  return(xml5)

    } else {

  xml6 <- list()
  for(i in 1:nrow(xml5))  {

    xml6[[i]] <- publicLibs::jkf.geocode(xml5[i,1], source = 'google',...)

  }

  xml7 <- matrix(unlist(xml6),ncol = 2, byrow = T)

  xml8 <- data.frame(xml3,xml7)
  colnames(xml8) <- c('Library Name','Address','City','State','ZIP Code','Latitude','Longitude')

  txt.name <-  paste(c('inst/','extdata/',lib.state,'_Libs.txt'),collapse = '')

  write.table(xml8, file = txt.name, row.names = F)

  rda.name <- paste(c(lib.state,'_Libs'),collapse = '')

  assign(rda.name, xml8, envir = environment())

  save(list = rda.name, file = paste(c("data/",tolower(rda.name),'.rda'), collapse = ''))

}
}
