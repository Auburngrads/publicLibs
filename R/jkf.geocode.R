jkf.geocode <-
  function (location, output = c("latlon", "latlona", "more", "all"),
            source = c("google", "dsk"), messaging = FALSE,
            force = ifelse(source == "dsk", FALSE, TRUE), sensor = FALSE,
            override_limit = FALSE, client = "", signature = "", key = "",
            nameType = c("long", "short"), data)
{
  if (missing(data))

  stopifnot(is.character(location))
  stopifnot(is.logical(messaging))
  output <- match.arg(output)
  nameType <- match.arg(nameType)
  source <- match.arg(source)
  if (client != "" && signature != "") {
    if (substr(client, 1, 4) != "gme-")
      client <- paste("gme-", client, sep = "")
    userType <- "business"
  }
  else if (client == "" && signature != "") {
    stop("if signature argument is specified, client must be as well.",
         call. = FALSE)
  }
  else if (client != "" && signature == "") {
    stop("if client argument is specified, signature must be as well.",
         call. = FALSE)
  }
  else if (client == "" && signature == "" && key != "") {

    userType <- "business"

  } else {

    userType <- "free"

  }
  if (!missing(data)) {
    warning("This use of geocode is deprecated, use mutate_geocode() instead.",
            call. = FALSE)
    argList <- as.list(match.call()[-1])
    argNames <- names(argList)
    if (output == "all") {
      message("output = \"all\" is not allowed with data; changing to \"more\".")
      output <- "more"
    }
    locs <- eval(substitute(location), data)
    geocodedLocs <- ggmap::geocode(locs, output = output, source = source,
                            messaging = messaging, override_limit = override_limit,
                            sensor = sensor, client = client, signature = signature)
    dataSetName <- as.character(substitute(data))
    message(paste0("overwriting dataset ", dataSetName,
                   "."))
    saveOverCode <- paste0(dataSetName, " <<- data.frame(data, geocodedLocs)")
    eval(parse(text = saveOverCode))
    return(invisible())
  }
  if (length(location) > 1) {
    if (userType == "free") {
      limit <- "2500"
    }
    else if (userType == "business") {
      limit <- "100000"
    }
    s <- paste("google restricts requests to", limit, "requests a day for non-business use.")
    if (length(location) > as.numeric(limit))
      stop(s, call. = F)
    if (length(location) > 200 && messaging)
      message(paste("Reminder", s, sep = " : "))
    if (output == "latlon" || output == "latlona" || output ==
        "more") {
      return(ldply(as.list(location), geocode, output = output,
                   source = source, messaging = messaging))
    }
    else {
      return(llply(as.list(location), geocode, output = output,
                   source = source, messaging = messaging))
    }
  }
  if (location == "")
    return(ggmap:::failedGeocodeReturn(output))
  sensor4url <- paste("sensor=", tolower(as.character(sensor)),
                      sep = "")
  client4url <- paste("client=", client, sep = "")
  signature4url <- paste("signature=", signature, sep = "")
  key4url <- paste("key=", key, sep = "")
  location4url <- chartr(" ", "+", location)
  posturl <- paste(location, sensor4url, sep = "&")
  if (userType == "business")
    posturl <- paste(posturl, ifelse(key == "",paste(client4url, signature4url, sep = '&'), key4url),
                     sep = "&")
  if (source == "google") {
    url_string <- paste("https://maps.googleapis.com/maps/api/geocode/json?address=",
                        posturl, sep = "")
  }
  else if (source == "dsk") {
    url_string <- paste("http://www.datasciencetoolkit.org/maps/api/geocode/json?address=",
                        posturl, sep = "")
  }
  url_string <- URLencode(url_string)
  url_hash <- digest::digest(url_string)
  if (ggmap:::isGeocodedInformationOnFile(url_hash) && force == FALSE) {
    if (messaging)
      message("Using stored information.")
    gc <- get(".GeocodedInformation", envir = .GlobalEnv)[[url_hash]]
  }
  else {
    if (messaging)
      message(paste("contacting ", url_string, "...",
                    sep = ""), appendLF = F)
    if (source == "google") {
      check <- ggmap:::checkGeocodeQueryLimit(url_hash, elems = 1,
                                      override = override_limit, messaging = messaging,
                                      userType = userType)
      if (check == "stop")
        return(ggmap:::failedGeocodeReturn(output))
    }
    message(paste0("Information from URL : ", url_string))
    connect <- url(url_string)
    lines <- try(readLines(connect, warn = FALSE), silent = TRUE)
    close(connect)
    if (class(lines) == "try-error") {
      warning("  geocoding failed for \"", location, "\".\n",
              "  if accompanied by 500 Internal Server Error with using dsk, try google.")
      return(ggmap:::failedGeocodeReturn(output))
    }
    gc <- rjson::fromJSON(paste(lines, collapse = ""))
    if (messaging)
      message(" done.")
    ggmap:::storeGeocodedInformation(url_hash, gc)
  }
  if (output == "all")
    return(gc)
  if (gc$status != "OK") {
    warning(paste("geocode failed with status ", gc$status,
                  ", location = \"", location, "\"", sep = ""), call. = FALSE)
    return(data.frame(lon = NA, lat = NA))
  }
  if (length(gc$results) > 1 && messaging) {
    message(paste("more than one location found for \"",
                  location, "\", using address\n  \"", tolower(gc$results[[1]]$formatted_address),
                  "\"\n", sep = ""))
  }
  NULLtoNA <- function(x) {
    if (is.null(x))
      return(NA)
    x
  }
  gcdf <- with(gc$results[[1]], {
    data.frame(lon = NULLtoNA(geometry$location$lng), lat = NULLtoNA(geometry$location$lat),
               type = tolower(NULLtoNA(types[1])), loctype = tolower(NULLtoNA(geometry$location_type)),
               address = location, north = NULLtoNA(geometry$viewport$northeast$lat),
               south = NULLtoNA(geometry$viewport$southwest$lat),
               east = NULLtoNA(geometry$viewport$northeast$lng),
               west = NULLtoNA(geometry$viewport$southwest$lng))
  })
  if (source == "google") {
    gcdf$address <- tolower(NULLtoNA(gc$results[[1]]$formatted_address))
  }
  if (output == "latlon")
    return(gcdf[, c("lon", "lat")])
  if (output == "latlona")
    return(gcdf[, c("lon", "lat", "address")])
  nameToGrab <- if (nameType == "long")
    "long_name"
  else "short_name"
  outputVals <- vapply(gc$results[[1]]$address_components,
                       function(x) x[[nameToGrab]], character(1))
  outputNames <- vapply(gc$results[[1]]$address_components,
                        function(x) {
                          if (length(x$types) == 0)
                            return("query")
                          x$types[1]
                        }, character(1))
  gcdfMore <- as.data.frame(as.list(outputVals))
  names(gcdfMore) <- outputNames
  data.frame(gcdf, gcdfMore)
}
