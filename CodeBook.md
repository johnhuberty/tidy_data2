===============================================================
Coursera Getting and cleaning data course project
Version 1.0
===============================================================
Author: John Huberty
===============================================================


The tidy_data.txt file contains a tab separated file without column headers 
provides a consolidation of the UCI HAR Dataset X_test, Y_test, X_train,
Y_train data. The tidy_data dataset is limited to the original variables that 
contain a measurement of either mean or standard deviation. 


===============================================================

Detailed process for creating submitted data

Step 1: Merge the training and test sets into one data set

Step 1: Part A: Download the test data sets and combine into one file
1) The UCI HAR Dataset X_test.txt, Y_test.txt were read into R
2) The X_test and Y_test data sets were merged into a new data 
set that combined the X and Y data
3) Two additional columns were merged onto the data set to 
allow for the future addition of activity and subject. 

Step 1 PArt B: Download the train data sets and combine into one file 
4) he UCI HAR Dataset X_train.txt, Y_train.txt were read into R
5) The X_train and Y_train data sets were merged into a new 
data set that combined the X and Y data
6) Two additional columns were merged onto the data set to 
allow for the future addition of activity and subject. 

Step 1 Part C: download features and activity_labels data set
7)The UCI HAR Dataset features.text was read into R. Variable is
features
8)The UCI HAR Dataset activity_labels.text was read into R. Variable is 
activity labels. 

Step 1 Part D: Combine test and train data sets 
9) Using rbind the test and train data set from steps 3 and 6 
above were combined into one data set. This variable is mergedxy

===============================================================
Step 2 #2 Extracts only the measurements on the mean and 
standard deviation for each measurement


10) Filtered the features.text data set downloaded in step 7 
to limit on variables "MEAN" and STD." This creates a list of 
column numbers that correspond to the colnames we want to keep.This 
variable is features_to_keep


11) Used the column numbers obtained in step 10 to build a list of 
column numbers and corresponding colum names from the features.text 
file downloaded in step 7. This variable is features_mean_std

12) Built a final list of column numbers to keep by combing numbered 
list created in step 10 with column numbers 562, and 563 to allow for 
the addition of "Actiivty and Subject columns". This variable is
columns_to_keep

13) Used numbered columns in step 12 to create a reduced mergedxy 
data set from step 9 that contains only the corresponding oclumsn that are contained 
in step 12

=================================================================
Step 3: Uses descriptive activity names to name the activities in the data set
Step 3 Part A
14) Uses the merge function to combine the mergedxy data set that contains x and y 
data with the data contained in activity labels. Matches the Activity number in 
the y train and test data t the activity number in the Activity_labels data set

15) Due to merge function, the dat set duplicated the activity coolumns in the first column
of the data set. Used subset to remove unnecessary activity column


=================================================================
Step 4: From the dat set in step 4, creates a second, independent tidy data set 
with the average of each variable for each activity and each subject. 

16) creates a tiny_data set with the mean of variables selected in Step 3.
Uses group by to create a tiny_data variable that is grouped by activity and subject
Then uses summarize to calculate mean of variables. 

================================================================
#5 From the dat set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
17) Uses write table to write a tidy_data.txt file to the working directory,
row names are true, and data is tab separated. 

To read data use the following code
sample <- read.table("tidy_data.txt", header = TRUE, sep = "\t")




