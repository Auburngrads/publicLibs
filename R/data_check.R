Base_Locations <- read.table(system.file('extdata','Base_Locations.txt',
                                         package = 'publicLibs'),
                             header = TRUE,
                             stringsAsFactors = F)

base <- Base_Locations[1, 3]
file.name <- paste(c("inst/extdata4/Straight Distance/", base, "_Libs.txt"), collapse = "")
mydata <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)


for(i in 2:nrow(Base_Locations)){
  base <- Base_Locations[i, 3]
  file.name <- paste(c("inst/extdata4/Straight Distance/", base, "_Libs.txt"), collapse = "")
  location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
  mydata <- rbind(mydata, location)
}

nrow(mydata)

base <- Base_Locations[1, 3]
file.name <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
mydata <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)


for(i in 2:nrow(Base_Locations)){
  base <- Base_Locations[i, 3]
  file.name <- paste(c("inst/extdata4/Drive Distance/", base, "_Libs.txt"), collapse = "")
  location <- read.table(file.name, header = TRUE, stringsAsFactors = FALSE)
  mydata <- rbind(mydata, location)
}

nrow(mydata)

count <- 0

for(i in 1:nrow(mydata)){
  if(mydata$DriveDistance <= mydata$Distance) count <- count + 1

}

count
nrow(mydata)

# mydata <- mydata[-c(1271, 1736, 4238),]
# View(mydata[which.min(mydata$DriveDistance),])

# a <- read.table("inst/extdata4/Drive Distance/elmn_Libs.txt", header = TRUE, stringsAsFactors = FALSE)
# a <- a[-12,]
# file.name1 <- paste(c("inst/extdata4/Drive Distance/elmn_Libs.txt"), collapse = "")
# write.table(a, file.name1, row.names = FALSE)

# a <- read.table("inst/extdata4/Drive Distance/otis_Libs.txt", header = TRUE, stringsAsFactors = FALSE)
# a <- a[-206,]
# file.name1 <- paste(c("inst/extdata4/Drive Distance/otis_Libs.txt"), collapse = "")
# write.table(a, file.name1, row.names = FALSE)

# a <- read.table("inst/extdata4/Drive Distance/hnsc_Libs.txt", header = TRUE, stringsAsFactors = FALSE)
# a <- a[-208,]
# file.name1 <- paste(c("inst/extdata4/Drive Distance/hnsc_Libs.txt"), collapse = "")
# write.table(a, file.name1, row.names = FALSE)
#
# test <- read.table("inst/extdata4/Drive Distance/hnsc_Libs.txt", header = TRUE, stringsAsFactors = FALSE)
# x <- mydata[1736, 4]
# y <- test[which(test[, 4] == x), ]
# x
# y
# View(test[208,])

