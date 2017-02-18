# Remove objects
rm(list=ls())
# Load library
library(dplyr)

# Download data/unzip
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, "dataset.zip")
if (!file.exists("UCI HAR Dataset")) { 
  unzip("dataset.zip")
}

# Activity Lables
activity_lables <- read.table("UCI HAR Dataset/activity_labels.txt") # read txt to data.frame
# Appropriately labels the data set with descriptive variable names.
names(activity_lables)[1:2] = c("label_id","label")
str(activity_lables)

# Features - List of all features
features <- read.table("UCI HAR Dataset/features.txt") # read txt to data.frame
str(features)

# TEST data
# 'test/X_test.txt': Test set. 
set_test <- read.table("UCI HAR Dataset/test/X_test.txt") # read txt to data.frame
colnames(set_test) = features[,2]
str(set_test)
# 'test/y_test.txt': Test labels.
label_test <- read.table("UCI HAR Dataset/test/y_test.txt")  # read txt to data.frame
names(label_test) <- "label_id"
str(label_test)
# 'test/subject_test.txt': Subject test
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")  # read txt to data.frame
names(subject_test) <- "subject_id"
str(subject_test)
# combine test data
data_test <- cbind(subject_test,label_test,set_test)
data_test_merged <- merge(data_test,activity_lables,by="label_id")
str(data_test_merged)
# Uses descriptive activity names to name the activities in the data set
# Move label as second column and remove label_id
data_test_merged <- data_test_merged[,c(2,564,3:563)] 
str(data_test_merged) # check: 2947 obs. of  563 variables

# TRAIN data
# 'train/X_train.txt': Training set.
set_train <- read.table("UCI HAR Dataset/train/X_train.txt") # read txt to data.frame
colnames(set_train) = features[,2]
str(set_train)
# 'train/X_test.txt': Training labels.
label_train <- read.table("UCI HAR Dataset/train/y_train.txt")  # read txt to data.frame
names(label_train) <- "label_id"
str(label_train)
# 'train/y_test.txt': Training subject
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")  # read txt to data.frame

# Appropriately labels the data set with descriptive variable names.
names(subject_train) <- "subject_id"
str(subject_train)
# combine train data
data_train <- cbind(subject_train,label_train,set_train)
data_train_merged <- merge(data_train,activity_lables,by="label_id")

# Uses descriptive activity names to name the activities in the data set
# Move label as second column and remove label_id
data_train_merged <- data_train_merged[,c(2,564,3:563)] 
str(data_train_merged) # check: 7352 obs. of  563 variables

# Merges the training and the test sets to create one data set.
data_all <- rbind(data_test_merged,data_train_merged)
str(data_all) # check: 10299 obs. of  563 variables

# Extracts only the measurements on the mean and standard deviation for each measurement.
data_all <- data_all[,c(1,2,grep("mean|std",names(data_all)))] #Leave only subject, label and mean/std columns
data_all <- arrange(data_all,subject_id,label) # sort by subject_id and label
str(data_all)
# Appropriately labels the data set with descriptive variable names.
names(data_all) <- sub("Acc","Accelerometer",names(data_all))
names(data_all) <- sub("Gyro","Gyroscope",names(data_all))
names(data_all) <- sub("Mag","Euclidean",names(data_all))
str(data_all)
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- aggregate(. ~subject_id + label, data_all, mean) # aggregate (mean) all measures by subject_id, label
str(data_all)
write.table(tidy_data, file = "tidydata.txt",col.names=FALSE, row.names=FALSE) # save data to txt file (no column/row names)
