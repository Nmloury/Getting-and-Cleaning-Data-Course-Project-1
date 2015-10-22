###################################################
### Title: Getting and Cleaning Data Course Project
### Author: Nehemiah Loury
### Course: Getting and Cleaning Data
###################################################

## Load dplyr Package
library(dplyr)

## Download the Data
if(!file.exists("data")){
  dir.create("data")
}

dataurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile(fileext = "zip") # Create temp file
download.file(dataurl, temp)

## Extract the Data
unzip(temp, exdir = "./data")
unlink(temp) # Remove temp file

## Read Feature Data Into R
features <- read.table("./data/UCI HAR Dataset/features.txt", 
                       stringsAsFactors = FALSE)

## Create Suffixes for Duplicate Feature Names
features <- within(features, V2 <- ifelse(duplicated(V2) | duplicated(V2, fromLast = TRUE), 
                  paste(V2, ave(V2, V2, FUN=seq_along), sep='_'), V2))

## Read Testing Data Into R
test_files_loc <- list.files("./data/UCI HAR Dataset/test", pattern = "*.txt", 
                         full.names = TRUE)
test_files <- lapply(test_files_loc,read.table)

## Rename Testing Data to Match File Names
test_files_loc <- gsub("./data/UCI HAR Dataset/test/","",test_files_loc)
test_files_loc <- gsub(".txt","",test_files_loc)
names(test_files) <- test_files_loc

## Create Descriptive Variable Names for Testing Data
names(test_files$X_test) <- features[,2]

## Add Subject and Activity Labels to Testing Data
test_files$X_test$subject <- test_files$subject_test[,1]
test_files$X_test$activity <- test_files$y_test[,1]

## Remove Test Data Lists
testdata <- test_files$X_test
rm(test_files,test_files_loc)

## Read Training Data Into R
train_files_loc <- list.files("./data/UCI HAR Dataset/train", pattern = "*.txt", 
                         full.names = TRUE)
train_files <- lapply(train_files_loc,read.table)

## Rename Training Data to Match File Names
train_files_loc <- gsub("./data/UCI HAR Dataset/train/","",train_files_loc)
train_files_loc <- gsub(".txt","",train_files_loc)
names(train_files) <- train_files_loc

## Create Descriptive Variable Names for Training Data
names(train_files$X_train) <- features[,2]

## Add Subject and Activity Labels to Training Data
train_files$X_train$subject <- train_files$subject_train[,1]
train_files$X_train$activity <- train_files$y_train[,1]

## Remove Training Data Lists
traindata <- train_files$X_train
rm(train_files,train_files_loc)


## Merge Datasets
alldata <- rbind(testdata, traindata)

## Extract Measurements on the Mean and Standard Deviation
alldata <- tbl_df(alldata)
meandata <- select(alldata, contains("mean()"), contains("std()"), subject, activity)

## Rearrange Columns to put Subject and Actiivity First
meandata <- meandata[,c(67,68,1:66)]

## Create Descriptive Names and Factors in Dataset
meandata$activity <- factor(meandata$activity, labels = c("Walking",
                        "Walking Upstairs","Walking Downstairs","Sitting",
                        "Standing","Laying"), ordered = FALSE)
meandata$subject <- factor(meandata$subject)

## Create Tidy Datas with the Average of Each Variable by Activity and Subject
tidydata <- meandata %>% group_by(subject, activity) %>% summarize_each(funs(mean))

## Export Tidy Data Set
write.table(tidydata, file = "./data/tidydata.txt", row.names = FALSE)




