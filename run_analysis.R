#This script is to Merge test data and train data in data source
#Read Code Book and README for details of data and its attributes
#
#
#
#Load data.table package and reshape2 package as these will be required for analysis
if (!require("data.table")) {
  install.packages("data.table")
}


if (!require("reshape2")) {
  install.packages("reshape2")
}


require("data.table")
require("reshape2")


#Read data table for test
activity_labels<-read.table("activity_labels.txt")
features<-read.table("features.txt")
xtest<-read.table("./test/X_test.txt")
ytest<-read.table("./test/y_test.txt")
subject_test<-read.table("./test/subject_test.txt")

#Add Column Names to xtest from features
colnames(xtest)<-features[, 2]

#separate columns that has mean or standard deviation data
xtestNew<-xtest[, grep("mean|std",names(xtest))]

#Add Activity labels to ytest as new Column
ytest[,2] <- activity_labels[ytest[,1], 2]

# Give names to ytest columns
names(ytest) = c("Activity_ID", "Activity_Label")

#Bind columns of xtestNew, ytest, suject_test
subject_test<-as.data.table(subject_test)
names(subject_test)<-"subject"

data_test<-cbind(xtestNew, ytest, subject_test)

#Read data table for train

xtrain<-read.table("./train/X_train.txt")
ytrain<-read.table("./train/y_train.txt")
subject_train<-read.table("./train/subject_train.txt")

#Add Column Names to xtrain from features
colnames(xtrain)<-features[, 2]

#separate columns that has mean or standard deviation data
xtrainNew<-xtrain[, grep("mean|std",names(xtrain))]

#Add Activity labels to ytrain as new Column
ytrain[,2] <- activity_labels[ytrain[,1], 2]

# Give names to ytrain columns
names(ytrain) = c("Activity_ID", "Activity_Label")

#Bind columns of xtrainNew, ytrain, suject_train
subject_train<-as.data.table(subject_train)
names(subject_train)<-"subject"

data_train<-cbind(xtrainNew, ytrain, subject_train)

#Merge both test and train datasets having Subjects, Activities, Mean and STd Dev Measures

smartdata<-rbind(data_test, data_train)

#Melt data by Activity label, Activity ID and Subject, set rest as measures

IDs<-c("subject", "Activity_ID", "Activity_Label")
rest<-setdiff(colnames(smartdata), IDs)

smartdata_melt<-melt(smartdata, id=IDs, measure.vars=rest)

#dcast data to create tidy data set using function mean

tidy_data<-dcast(smartdata_melt, subject + Activity_Label ~ variable, mean)

# write tidy data in home folder
write.table(tidy_data, file = "./tidy_data.txt")
