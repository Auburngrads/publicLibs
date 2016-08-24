moreLibs <- function(...) {

  url <- 'http://www.public-libraries.org/'
  doc = XML::htmlTreeParse(url, useInternalNodes=T)
  states = XML::xpathSApply(doc,"//a",XML::xmlValue)[10:60]
  state.name <- gsub(' ', '', state.name)
#
# Get the url of each state site of public-libraries.org
#
    for(i in 1:1) { #length(state.abb)

      urlS <- paste(c('library.public-libraries.org/',
                      state.name[i], '/',
                      state.abb[i],'.html'),
                    collapse = '')

      stuff1 <- httr::GET(urlS)
      stuff2 <- httr::content(stuff1, encoding = 'UTF-8')
      docS = XML::htmlTreeParse(stuff2, useInternalNodes=T)
      st  <- XML::xpathSApply(docS,"//a",XML::xmlValue)
      st1 <- st[-c(1:9)]
      stl <- length(st1)
      st2 <- st1[-c((stl-6):stl)]
      st3 <- gsub(" Libraries", '', st2)
      st4 <- gsub(" ", '', st3)

    for(j in 1:2) {  # length(st4)

    url.lib <- paste(c(tolower(state.name[i]),'.public-libraries.org/library/',
                      state.abb[i],'/',
                      st4[j],'.html'),
                    collapse = '')
      dl1 <- httr::GET(url.lib)
      dl2 <- httr::content(dl1, encoding = 'UTF-8')
      doc.lib = XML::htmlTreeParse(dl2, useInternalNodes=T)
      llib <- XML::xpathSApply(doc.lib,"//a",XML::xmlValue)
      llib2 <- llib[-c(1:9)]
      lll <- length(llib2)
      llib3 <- llib2[-c((lll-7):lll)]
      llib4 <- gsub('/', '',llib3)
      llib5 <- gsub(' ', '',llib4)

      for(l in 1:length(llib5)) {

    the.lib <- paste(c('library.public-libraries.org/',
                      state.name[i],'/',
                      st4[j],'/',llib5[l],'.html'),
                    collapse = '')
      tl1 <- httr::GET(the.lib)
      tl2 <- httr::content(tl1, encoding = 'UTF-8')
      tl3 <- XML::htmlTreeParse(tl2, useInternalNodes=T)
      tl4 <- XML::xpathSApply(tl3,'//td[@background="http://www.public-libraries.org/images/back.gif"]',XML::xmlValue); tl4 <- gsub('  ', '', tl4)
      name <- XML::xpathSApply(tl3,'//td[@bgcolor="#6e7b8a"]',XML::xmlValue)
      tl4 <- tl4[-c(1,length(tl4))]
      tl5 <- XML::xpathSApply(tl3,"//table",XML::xmlValue)
      tl6 <- gsub('  ', '', tl5)
      tl7 <- strsplit(tl6, '\\n')
      tl8 <- lapply(tl7, FUN = unlist)
      tl9 <- unlist(lapply(tl8, FUN = function(x) sum(x%in%lapply(tl4, FUN = function(x) x))))
      tl0 <- which(tl9==1)+1
      tl8[tl0[4]][[1]][1] <- paste(c(tl8[tl0[4]][[1]][1:2]), collapse = ' ')
      tl8[tl0[4]][[1]] <- tl8[tl0[4]][[1]][-2]
      tl8[tl0[5]][[1]] <- tl8[tl0[5]][[1]][-c(1,12)]
      tla <- lapply(tl8[tl0], FUN=function(x) matrix(unlist(x), ncol=2, byrow = T))

    }
    }
    }
}
