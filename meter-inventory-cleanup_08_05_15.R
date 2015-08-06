# Script for cleanup of Parking Meter Inventory export
# Update all file paths/URLs as needed


require(dplyr)
require(tidyr)
require(utils)

rm(list = ls())
ds <- read.csv("~/CityRequest-6-2-15-MeterInventory.csv",
               stringsAsFactors = F)

ds$RATE <- as.numeric(ds$RATE)
filtered.ds <- ds[!is.na(ds$RATE),]

# fill in blank rows (columns 1-8, 14, 16-20 ONLY) with preceding row's info
blank.lines <- which(filtered.ds[,1]=="")
cols2duplicate <- c(1:8, 14, 16:20)
filtered.ds[(blank.lines),cols2duplicate] <- filtered.ds[(blank.lines-1),cols2duplicate]

# remove tabs from Status column
filtered.ds <- gsub("\\t", "", filtered.ds$ST)

# OPTIONAL filter only rows with letter I in status
# I.status <- filtered.ds[filtered.ds$ST == "I\t\t",  ]

# write the results to file
# write.csv(I.status, file = "Active_Meter_Inventory.csv") // optional export active-only
write.csv(filtered.ds, file = "Meter_Inventory.csv")
