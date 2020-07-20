#' Get the url for each state on public-libraries.org
#' @import datasets
#' @importFrom httr GET content
#' @importFrom XML htmlTreeParse xpathSApply xmlValue
#' @param state Character string for state name or two-letter abbreviation

state_lib_urls <- function(url = 'http://www.public-libraries.org/') {

# Parse HTML tags from page tree and extract anchor tag values

      get_request <- httr::GET(url)
      get_content <- httr::content(get_request, encoding = 'UTF-8')
      parsed_html <- XML::htmlTreeParse(get_content, useInternalNodes = T)
      raw_anchors <- XML::xpathSApply(parsed_html, "//a", XML::xmlValue)

      fmt_anchors <- tolower(gsub(' ', '', raw_anchors))
      state_names <- tolower(gsub(' ', '', datasets::state.name))

      anchors <- fmt_anchors[fmt_anchors %in% state_names]
      base_url <- 'http://library.public-libraries.org'

      state_urls <- paste(file.path(base_url,anchors, tolower(state.abb)),
                          '.html',
                          sep = '')

      zout <- data.frame(state_name = state.name,
                         state_abb <- tolower(state.abb),
                         url = state_urls,
                         stringsAsFactors = F)

      return(zout)

}

#' Get the url for a local libraries in a state on public-libraries.org
#' @param state Character string for state name or two-letter abbreviation
#' @param base_url Root url for local libraries on public-libraries.org
#' @import datasets

city_lib_urls <- function(state = 'AL',
                          base_url = 'http://library.public-libraries.org')
{

  state <- gsub(' ', '', tolower(state))

  dfs <- data.frame(gsub(' ', '', tolower(state.abb)),
                    gsub(' ', '', tolower(state.name)),
                    stringsAsFactors = F)

  num <- unlist(sapply(dfs,
                       FUN = function(x) grep(state,x)))[[1]]

  state_url <- paste(file.path(base_url, dfs[num,2], dfs[num,1]),
                     '.html',
                     sep = '')

  get_request <- httr::GET(state_url)
  get_content <- httr::content(get_request, encoding = 'UTF-8')
  parsed_html <- XML::htmlTreeParse(get_content, useInternalNodes = T)
  raw_anchors <- XML::xpathSApply(parsed_html, "//a", XML::xmlValue)

  city_anchors <- raw_anchors[grep('Libraries', raw_anchors)]

  city_anchors <- gsub("[[:punct:]]",'', city_anchors)
  city_anchors <- qdap::mgsub(c("Libraries", " "), '', city_anchors)

  city_anchors <- city_anchors[2:(length(city_anchors) - 2)]

  city_urls <- paste('http://',
                     dfs[num,2], '.public-libraries.org/library/',
                     dfs[num,1], '/', tolower(city_anchors),
                     '.html',
                     sep = '')

  zout <- data.frame(state_name = dfs[num,2],
                     state_abb = dfs[num,1],
                     city = tolower(city_anchors),
                     city_url = city_urls,
                     stringsAsFactors = F)

  return(zout)
}

lib_urls <- function(state_name,
                     state_abb,
                     city)
{

  state_name <- tolower(state_name)
  state_abb  <- tolower(state_abb)
  city       <- tolower(city)

  base_url = paste('http://',state_name, '.public-libraries.org/library/',
                   state_abb, '/', city,
                   '.html',
                   sep = '')

  get_request <- httr::GET(base_url)
  get_content <- httr::content(get_request, encoding = 'UTF-8')
  parsed_html <- XML::htmlTreeParse(get_content, useInternalNodes = T)
  raw_anchors <- XML::xpathSApply(parsed_html, "//a", XML::xmlValue)

  start <- max(grep('>>Read more',raw_anchors))
  end   <- grep(paste0(state_name,' libraries'), tolower(raw_anchors))

  lib_anchors <- raw_anchors[(start + 1): (end - 1)]

  lib_anchors <- gsub("[[:punct:]]", '', lib_anchors)
  lib_anchors <- gsub(" ", '', lib_anchors)

  lib_urls <- paste('http://library.public-libraries.org/',
                     state_name, '/',
                     city,  '/',
                     tolower(lib_anchors),
                     '.html',
                     sep = '')

  zout <- data.frame(state_name = state_name,
                     state_abb = state_abb,
                     city = tolower(city),
                     lib = lib_anchors,
                     lib_url = lib_urls,
                     stringsAsFactors = F)

  return(zout)
}


lib_data <- function(lib_url) {


  get_request <- httr::GET(lib_url)
  get_content <- httr::content(get_request, encoding = 'UTF-8')
  parsed_html <- XML::htmlTreeParse(get_content, useInternalNodes = T)

  raw_tables <- XML::xpathSApply(parsed_html,'//td[@background="http://www.public-libraries.org/images/back.gif"]',XML::xmlValue);
  tl4 <- gsub('  ', '', tl4)
  name <- XML::xpathSApply(tl3,'//td[@bgcolor="#6e7b8a"]',XML::xmlValue)
  tl4 <- tl4[-c(1,length(tl4))]
  tl5 <- XML::xpathSApply(tl3,"//table",XML::xmlValue)
  tl6 <- gsub('  ', '', tl5)
  tl7 <- strsplit(tl6, '\\n')
  tl8 <- lapply(tl7, FUN = unlist)


}

















    for(j in 1:length(st4)) {  # length(st4)

    url.lib <- paste(c(tolower(state.name[i]),
                       '.public-libraries.org/library/',
                       datasets::state.abb[i],'/',
                       st4[j],
                       '.html'),
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
