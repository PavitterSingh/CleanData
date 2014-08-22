CleanData
=========

This Repo is for the script that runs on data set as defined in Codebook and eos the following:

1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement.
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive activity names.
5.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##There is a script file named run_analysis in this Repo

###How run_analysis.R implements the above steps:

- Require reshapre2 and data.table librareis.
- Load test data
- Load the features and activity labels.
- Extract the mean and standard deviation column names and data.
- Assigns Activity Label and Subject details to data.
- Applies above 4 steps to train data
- Merge both data sets by rows
- Calculates the mean values of all variables by Subject and Activity Label
- Save the tidy data set in working directory

###Steps to work on this dataset

1.	Download the data source and put into a folder on your local drive. You'll have a UCI HAR Dataset folder.
2.	Put run_analysis.R in the UCI HAR Dataset, then set it as your working directory using setwd() function in RStudio.
3.	Run source("run_analysis.R"), then it will generate a new file tidy_data.txt in your working directory.

###Dependencies
run_analysis.R file will help you to install the dependencies automatically. It depends on reshape2 and data.table. 

