#' @import datasets

moreLibs <- function(state = 'AL',...) {

  url <- 'http://www.public-libraries.org/'
  doc = XML::htmlTreeParse(url, useInternalNodes=T)
  states = XML::xpathSApply(doc,"//a",XML::xmlValue)[10:60]
  state.name <- gsub(' ', '', datasets::state.name)
#
# Get the url of each state site of public-libraries.org
#
  mat    <- data.frame()
  smalls <- data.frame()

if(nchar(state) < 3) {

  i <- which(tolower(state.abb)%in%gsub(' ','', tolower(state)))

} else {

  i <- which(tolower(state.name)%in%gsub(' ','', tolower(state)))
}

        urlS <- paste(c('library.public-libraries.org/',
                      state.name[i], '/',
                      datasets::state.abb[i],'.html'),
                    collapse = '')

      stuff1 <- httr::GET(urlS)
      stuff2 <- httr::content(stuff1, encoding = 'UTF-8')
      docS = XML::htmlTreeParse(stuff2, useInternalNodes=T)
      st  <- XML::xpathSApply(docS,"//a",XML::xmlValue)
      st1 <- st[-c(1:9)]
      stl <- length(st1)
      st2 <- st1[-c((stl-6):stl)]
      st3 <- gsub(" Libraries", '', st2)
      st3 <- gsub("\\.", '', st3)
      st4 <- gsub(" ", '', st3)
      st4 <- gsub("-", '', st4)
      st4 <- gsub("'", '', st3)

    for(j in 1:length(st4)) {  # length(st4)

    url.lib <- paste(c(tolower(state.name[i]),'.public-libraries.org/library/',
                      datasets::state.abb[i],'/',
                      st4[j],'.html'),
                    collapse = '')
      dl1 <- httr::GET(url.lib)
      dl2 <- httr::content(dl1, encoding = 'UTF-8')
      doc.lib = XML::htmlTreeParse(dl2, useInternalNodes=T)
      llib <- XML::xpathSApply(doc.lib,"//a",XML::xmlValue)
      llib2 <- llib[-c(1:9)]
      lll <- length(llib2)
      llib3 <- llib2[-c((lll-7):lll)]
      llib4 <- gsub('/', '', llib3) # Library Name
      llib5 <- gsub(' ', '', llib4)
      llib5 <- gsub("'", '', llib5)
      llib5 <- gsub('\\.', '', llib5)
      llib5 <- gsub('-', '', llib5)

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

if(length(tl8) < 30) {

  little <- data.frame(library = llib4[l],
                       City = st3[j],
                       State = state.name[i])
  smalls <- plyr::rbind.fill(smalls, little)
} else {

      tl9 <- unlist(lapply(tl8, FUN = function(x) sum(x%in%lapply(tl4, FUN = function(x) x))))
      tl0 <- which(tl9==1)+1
      tl8[tl0[4]][[1]][1] <- paste(c(tl8[tl0[4]][[1]][1:2]), collapse = ' ')
      tl8[tl0[4]][[1]] <- tl8[tl0[4]][[1]][-2]
      tl8[tl0[5]][[1]] <- tl8[tl0[5]][[1]][-c(1,12)]
      tla <- lapply(tl8[tl0], FUN=function(x) matrix(unlist(x), ncol=2, byrow = T))
      tlb <- lapply(tla, FUN = function(x) {matrix(x, ncol = 2, byrow = F)})
      tlc <- rbind(tlb[[1]], tlb[[2]], tlb[[3]],tlb[[4]], tlb[[5]], tlb[[6]])
      tld <- t(tlc)
      colnames(tld) <- c('Relationship','Operated','Area','Population','Visits','Hours','Libraries', 'Branches', 'Bookmobiles','Books','Audio','Video','Subscriptions','Circulation','Loans Provided','Loans Received','ALA Librarians','FT Librarians','Other Full Time','Total Full Time','Children Circulation','Children Attendance','Income-local','Income-state','Income-federal','Income-other','Income-total','Salaries','Benefits','Expenditures-staff','Expenditures-collection','Expenditures-operating-other','Expenditures-operating-total','Expenditures-capital', 'Expenditures-electronic materials','Expenditures-electronic access','Materials electronic format','Access to electronic services','Access to the internet', 'Staff terminals', 'Public Terminals','Weekly Elect Resources')
      tle <- t(data.frame(tld[-1,], stringsAsFactors = F))
      tlf <- gsub('\\$', '',tle)
      tlf <- gsub(',', '',tlf)
      tlf[,c(4:37,40:42)] <- as.numeric(tlf[,c(4:37,40:42)])
      tlg <- data.frame(llib4[l], st3[j],state.name[i],tlf, stringsAsFactors = F)
      colnames(tlg) <- c('Library', 'City', 'State', colnames(tlf))
      mat <- plyr::rbind.fill(mat, tlg)
      }
    }
    }
    mat[,c(7:40,43:45)] <- lapply(X = mat[,c(7:40,43:45)], FUN = function(x) { as.numeric(x) })

    zzz <- list()
    zzz$libs <- mat
    zzz$excluded <- smalls

    txt.name <-  paste(c('inst/','extdata3/',state.abb[i],'_Libs2.txt'),collapse = '')

    write.table(zzz$libs, file = txt.name, row.names = F)

  rda.name <- paste(c(state.abb[i],'_Libs2'),collapse = '')

  assign(rda.name, zzz$libs, envir = environment())

  save(list = rda.name,
       file = paste(c("data/",tolower(rda.name),'.rda'), collapse = ''),
       compress = 'xz',
       compression_level = 9)


    invisible(zzz)
}
