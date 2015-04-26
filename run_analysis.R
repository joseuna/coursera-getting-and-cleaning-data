
#setting up my working directory
GetClean = '/Users/jose.gutierrez/Documents/DataScientiscCoursera/GettingAndCleaning'
setwd(GetClean)


#Loading required package: data.table
#also installing the dependencies ‘plyr’, ‘Rcpp’, ‘chron’, ‘reshape2’

if (!require("data.table")) {
  install.packages("data.table")
}

#Loading required package: reshape2
if (!require("reshape2")) {
  install.packages("reshape2")
}

#Loading required package: data.table
#package ‘data.table’ was built under R version 3.1.3 
require("data.table")

Loading required package: data.table
require("reshape2")

# Load: activity labels and data column names
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]


# Extract only the measurements on the mean and standard deviation for each measurement.
extract_features <- grepl("mean|std", features)

# Load and process X_test & y_test data.
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(X_test) = features
X_test = X_test[,extract_features]

# Load activity labels
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

# Bind data
testDataSet <- cbind(as.data.table(subject_test), y_test, X_test)

# Load and process X_train & y_train data.
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(X_train) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
X_train = X_train[,extract_features]

#Uses descriptive activity names to name the activities in the data set
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

# Bind data
trainingDataSet <- cbind(as.data.table(subject_train), y_train, X_train)

#Merges the training and the test sets to create one data set
data = rbind(testDataSet, trainingDataSet)

id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

# using dcast function
tidyDataSet   = dcast(melt_data, subject + Activity_Label ~ variable, mean)


##Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#txt file
write.table(tidy_data, "tidy.txt", sep="\t",row.names=FALSE)
#CSV file
write.csv(tidy, "tidy.csv", row.names=FALSE)