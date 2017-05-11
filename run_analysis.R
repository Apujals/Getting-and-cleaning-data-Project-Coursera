library(dplyr)

## Downloading the raw data and decompressing it

nameFile <- "raw_data.zip"

if (!file.exists(nameFile)) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,  nameFile)
  unzip(nameFile)
}

## Step 1. 
## Merge training and test sets to create one data set.

xtrain <- read.table("./UCI HAR Dataset/train/x_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train <- cbind(subjtrain, ytrain, xtrain)

xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjtest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test <- cbind(subjtest, ytest, xtest)

alldata <- rbind(train, test)

## Step 2 & Step 4.
## Extracts only the measurements on the mean and standard deviation for each measurement.
## Appropriately labels the data set with descriptive variable names.

features <- read.table("./UCI HAR Dataset/features.txt", colClasses = "character")

names(alldata) = c("subject", "activity", features$V2)

fwanted <- grep(".*mean.*|.*std.*", names(alldata))

datawanted <- alldata[c(1,2,fwanted)]

##Step 3.
## Uses descriptive activity names to name the activities in the data set.

actlabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

datawanted$subject <- as.factor(datawanted$subject)
datawanted$activity <- factor(datawanted$activity, levels = actlabels$V1, labels = actlabels$V2)

## Step 5.
## From the data set in step 4, creates a second, independent tidy data set with the 
## average of each variable for each activity and each subject.

tidydata <- aggregate(. ~subject + activity, datawanted, mean)
tidydata <- arrange(tidydata, subject, activity)

write.table(tidydata, "./UCI HAR Dataset/mean_tidy_data.txt", row.names = FALSE, quote = FALSE)
