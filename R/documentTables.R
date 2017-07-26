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

library(data.table)

x <- read.table("inst/extdata4/IDW/Drive1.txt", header = TRUE, stringsAsFactors = F)
x <- x[, c(1,24,25)]
x[, 2:3] <- round(x[,2:3], 3)
x <- as.data.table(x)
x <- x[order(-Std_50_Miles)][,overallRank := 1:.N]
colnames(x) <- c("BaseName", "D_IDW", "D_IDW_N", "D_Overall Rank")
file.name <- "C:/Files/Documents/R/publicLibs/meetings/Tables/IDW_drive1.txt"
write.table(x, file.name, row.names = FALSE, sep = ",")


y <- read.table("inst/extdata4/IDW/Straight1.txt", header = TRUE, stringsAsFactors = F)
y <- y[, c(1,24, 25)]
y[, 2:3] <- round(y[,2:3], 3)
y <- as.data.table(y)
y <- y[order(-Std_50_Miles)][,overallRank := 1:.N]
colnames(y) <- c("BaseName", "S_IDW", "S_IDW_N", "S_Overall Rank")
file.name <- "C:/Files/Documents/R/publicLibs/meetings/Tables/IDW_straight1.txt"
write.table(y, file.name, row.names = FALSE, sep = ",")

IDW <- merge(x, y, by = "BaseName")

IDW$Diff <- IDW$`S_Overall Rank` - IDW$`D_Overall Rank`
IDW$Diff <- abs(IDW$Diff)




View(IDW)

