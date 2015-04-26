CodeBook
=============================

Data source
-----------
Data set with the full information can be downloaded in the follwoing path:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This dataset is derived from the "Human Activity Recognition Using Smartphones Data Set": 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

How it works 
----------------

All of the relevant data files were read into data frames, appropriate column headers were added, and the training and test sets were combined into a single data set.
All feature columns were removed that did not contain the exact string "mean()" or "std()". This left 66 feature columns, plus the subjectID and activity columns.
The activity column was converted from a integer to a factor, using labels describing the activities.
A tidy data set was created containing the mean of each feature for each subject and each activity. Thus, subject #1 has 6 rows in the tidy data set (one row for each activity), and each row contains the mean value for each of the 66 features for that subject/activity combination. Since there are 30 subjects, there are a total of 180 rows.
The tidy data set was output to a CSV file and text file.

#txt file: write.table(tidy_data, "tidy.txt", sep="\t",row.names=FALSE)
#CSV file: write.csv(tidy, "tidy.csv", row.names=FALSE)

Libraries Used
----------------

The libraries used in this operation are data.table and dplyr. We prefer data.table as it is efficient in handling large data as tables. dplyr is used to aggregate variables to create the tidy data.

library(data.table)
library(dplyr)


How run_analysis.R implements the above steps:
-------------------------------------------------

Require reshapre2 and data.table librareis.
Load both test and train data
Load the features and activity labels.
Extract the mean and standard deviation column names and data.
Process the data. There are two parts processing test and train data respectively.
Merge data set.

