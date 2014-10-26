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
#col_names <- features[,2]
# Create vector with the column names for mean() & stddev() columns only w/o meanFreq()
#col_names <- (col_names[(grepl("mean()",col_names)| grepl("std()",col_names) | grepl("subject",col_names)| grepl("activity",col_names)) == TRUE])

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

