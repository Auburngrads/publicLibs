Base_Locations <- read.table("inst/extdata/Base_Locations.txt", header = TRUE, stringsAsFactors = F)
CONUS_Locations <- Base_Locations[-c(2, 19, 21, 28),]

for(i in 1:nrow(CONUS_Locations)){
  abbr <- CONUS_Locations[i, 3]
  x <- read.table(paste(c("inst/extdata4/Drive Distance/", abbr, "_Libs.txt"), collapse = ""), header = TRUE, stringsAsFactors = F)
  x <- x[, -c(1:3, 5, 7, 11, 14:17, 19:38, 40, 42, 44:47, 49:63, 65:85)]
  colnames(x) <- c("Library Name", "Service Area Population", "Address", "Latitude", "Longitude",
                   "Central Libraries", "Branch Libraries", "Total Staff", "Print Materials",
                   "Audio Materials", "Video Materials", "Print Serials", "Computers", "Collection Space",
                   "Seats Per", "Work Space", "Size", "Distance", "Weight", "SizeWeight", "Drive Distance", "Drive Weight", "Drive SizeWeight")
  write.table(x, file = paste(c("inst/extdata4/App Data/Base Libs/", abbr, "_Libs.txt"), collapse = ""), row.names = FALSE)
}
