# Create individual IDW tables for document

x <- read.table("inst/extdata4/IDW/Drive.txt", header = TRUE, stringsAsFactors = F)
View(x)
x <- x[, c(1,15)]
x <- as.data.table(x)
x <- x[order(-X50)]
x <- as.data.frame(x)
x[, 2] <- round(x[,2], 3)
colnames(x) <- c("Base Name", "IDW - 50 Miles")
file.name <- "C:/Files/Documents/R/publicLibs/meetings/Tables/IDW_drive.txt"
write.table(x, file.name, row.names = FALSE, sep = ",")

# Create combined IDW table for document

x <- read.table("inst/extdata4/IDW/Drive.txt", header = TRUE, stringsAsFactors = F)
x <- x[, c(1,15)]
x <- as.data.table(x)
x <- x[order(-X50)][,overallRank := 1:.N]
colnames(x) <- c("BaseName", "D_X50", "Overall Rank")

y <- read.table("inst/extdata4/IDW/Straight.txt", header = TRUE, stringsAsFactors = F)
y <- y[, c(1,15)]
y <- as.data.table(y)
y <- y[order(-X50)]
colnames(y) <- c("BaseName", "S_X50")

IDW <- merge(x, y, by = "BaseName")
View(IDW)

