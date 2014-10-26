================================================================
Coursera getting and cleaning data
Version 1.0
================================================================
John Huberty
================================================================

The datset includes the following files:
================================================================
- 'README.txt'
- 'Codebook.md'
- 'tidy_data': Output data 
- 'run_analysis.R': R file containing code

Source data
================================================================
UCI HAR Dataset can be found at the following link
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

To download tidy data,txt file use the following
================================================================
sample <- read.table("tidy_data.txt", header = TRUE, sep = "\t")

Variable description
================================================================
- 'X_test': X_test.txt data file from UCI HAR Dataset
- 'Y_test': Y_test.txt data file from UCI HAR Dataset
- 'subject_test': subject_test data file from UCI HAR Dataset
- 'mergedxy_test': variable contains join of X_test, Y_test, and subject_test data


- 'X_train': X_train.txt data file from UCI HAR Dataset
- 'Y_train': Y_test.txt data file from UCI HAR Dataset
- 'subject_train': subject_test data file from UCI HAR Dataset
- 'mergedxy_train': variable contains join of X_test, Y_test, and subject_test data

- 'features': features.txt data file from UCI HAR Dataset
- 'activity_labels': activity_labels.txt data file from UCI HAR Dataset
- 'mergedxy': merge of the mergedxy_test and mergedxy_train variables 
- 'features_to_keep_numbers': the numbers corresponding to the filtered std and mean columns from features.txt
- 'features_to_keep_names': the names corresponding to the filtered std and mean columns from features.txt
- 'mergedxy_activity": merged of mergedy data and activity labels to combine activity labels with dataset
- 'tidy_data': mergedxy_activity grouped by activity_name and subject with the mean calculated for each row


Scripts - R code
================================================================
## Project Overview
#1 Merge the training and test sets into one data set
#2 Extracts only the measurements on the mean and standard deviation for each measurement
#3 Uses descriptive activity names to name the activities in the data set
#4 Appropriately labels the data set with descriptive variable names
#5 From the dat set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


#####################################################################
#####################################################################
##Load necessary packages and set working directory
setwd("C:/Users/jhuberty/Desktop/Coursera_data_science/Getting and Cleaning Data")
install.packages(tidyr)
install.packages(dplyr)
library(tidyr)
library(dplyr)


##########################################################
#Step 1 Merge the training and test sets into one data set
##########################################################
#Merge the training and test sets into one data set

#laod required files into R
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
mergedxy_test <- X_test
mergedxy_test[,562] <- Y_test
mergedxy_test[,563] <- subject_test

X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
mergedxy_train <- X_train
mergedxy_train[,562] <- Y_train
mergedxy_train[,563] <- subject_train

features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

#Merge X and Y into one data set
mergedxy <- rbind(mergedxy_test,mergedxy_train)

########################################################################################
#########################################################################################
#2 Extracts only the measurements on the mean and standard deviation for each measurement
########################################################################################
#Find mean and standard deviation in the features table and return corresponding row number
features_to_keep_numbers <- grep("*Mean*|*Std*|*mean*|*std*", features[,2])

#Use corresponding row number in columns_mean_std to create a filter "features" list that only conttains std and mean row numbers
#This table will allow us to give names to the filtered mergedxy data we are creating
features_to_keep_names <- features[features_to_keep_numbers,]
features_to_keep_names <- paste(features_to_keep_names$V2)
features_to_keep_names <- c(features_to_keep_names, "Activity", "Subject")

#add columns 562 and 563 to keep activity and subject
features_to_keep_numbers <- c(features_to_keep_numbers,562,563)

#Now use columns_to_keep table to filter mergedxy list to only required columns
mergedxy <- mergedxy[,features_to_keep_numbers]
colnames(mergedxy) <- features_to_keep_names
  
#########################################################################
#########################################################################
#3 Uses descriptive activity names to name the activities in the data set
#########################################################################

##mergedxy_activity <- merge(mergedxy, activity_labels, by = intersect(names("Activity"), names("V1")))

colnames(activity_labels) <- c("Activity", "Activity_name")
mergedxy_activity <- merge(mergedxy, activity_labels, by.x="Activity", by.y = "Activity")

#########################################################################
#########################################################################
#4 Appropriately labels the data set with descriptive variable names
#########################################################################
#Need to drop Activity number from dataset
mergedxy_activity <- subset(mergedxy_activity, select = -c(1))

#########################################################################
#########################################################################
#4 From the dat set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject. 
#########################################################################

tidy_data <- group_by(mergedxy_activity,Activity_name, Subject) 
tidy_data <- summarise_each(tidy_data, funs(mean))
#               mean(angle_tBodyAccMean_gravity),
#               mean(angle_tBodyAccJerkMean_gravityMean),
#               mean(angle_tBodyGyroMean_gravityMean),
#               mean(angle_tBodyGyroJerkMean_gravityMean),
#               mean(angle_X_gravityMean),
#               mean(angle_Y_gravityMean),
#               mean(angle_Z_gravityMean)
#               )
    

#########################################################################
#########################################################################
#5 From the dat set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
#########################################################################

write.table(tidy_data, "tidy_data.txt", sep="\t", row.names=FALSE)


# Code to read data into R
# sample <- read.table("tidy_data.txt", header = TRUE, sep = "\t")
