## Johns Hopkins University / Coursera
## Getting and Cleaning Data
## Programming Assignment
## January 2015
##
## This script implements the activities requested on the class programming assignment:
## 1. Import the training and test data from the UCI Human Activity Recognition (HAR) Dataset, and
##    label the data approriately from the features description file
## 2. Filter the data to include only mean and standard deviation information (determined in this case
##    by looking for 'mean()' or 'std()' in the feature name.
## 3. Replace activity codes with a text description of the activity
## 4. Create a tidy dataset by summarizing to jus the mean of each variable for each user and acitivty.  Note
##    that the standard deviation data is summarized this way as well, rather than to calculate the sum of
##    squares as might be done for combining statistical measure
##
## For more information please see the 'README.md' file, or 'CodeBook.md' for a description of the variables,
## located in the same directory or repository.
## 

## Import data
##
## Check if data is in current directory or in "UCI HAR Dataset" subdirectory (as initially extracted from .zip)
##

if (file.exists("features.txt")) { directory <- "." } else
if (file.exists("UCI HAR Dataset/features.txt")) { directory <- "UCI HAR Dataset" } else { stop ("data not found") }

##
## 1, Read the data files and consolidate into rawdataset
##

##
## 1.a. Read the activity codes and description of variables
## 

activityNames <- read.table (paste0 (directory, "/activity_labels.txt"), col.names = c("code", "activity"))
featureNames <- read.table (paste0 (directory, "/features.txt"), col.names = c("column", "feature"))

##
## 1.b. A function import the measurement data, and
## 3.   Replace the activity codes with text description
##

getdata <- function (path, dataset, activityNames, featureNames)
{
  subjects <- read.table (paste0 (path, "/subject_", dataset, ".txt"), col.names = c("subject"))
  activities <- read.table (paste0 (path, "/y_", dataset, ".txt"), col.names = c("activity"))
  activities <- sapply (activities, function (activity) { activityNames$activity[activity] })
  data <- read.table (paste0 (path, "/X_", dataset, ".txt"), col.names = featureNames[,"feature"])
  data <- data.frame (subjects, activities, data)

}

##
## 1.c. Use the above function to read and combine the test and training data
##

testdata <- getdata (paste0 (directory, "/test"), "test", activityNames, featureNames)
traindata <- getdata (paste0 (directory, "/train"), "train", activityNames, featureNames)

rawdataset <- rbind (traindata, testdata)

##
## 2. Reduce to mean and standard deviation measures
##

cleanColumns = grep ("subject|activity|mean\\.\\.|std\\.\\.", names(rawdataset))
cleandataset <- rawdataset[cleanColumns]
names(cleandataset) <- names(rawdataset)[cleanColumns]

## 
## 4. Create the tidy data set and save to "tidydataset.txt"
##

library (data.table)
tidydataset <- rbindlist (lapply (split (cleandataset, list(cleandataset$subject, cleandataset$activity)), function (x) { summary <- x[1,]; summary[3:length(summary)] <- colMeans(x[,3:length(summary)]); summary}))
tidynames <- names (tidydataset)
tidynames[3:length(tidynames)] <- sapply (tidynames[3:length(tidynames)], function (x) { paste0 ("mean.", x)})
setnames (tidydataset, tidynames)

write.table (tidydataset, "tidydataset.txt", row.names = FALSE)
