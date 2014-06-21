## getting the zipped file from internet
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url=url, destfile="dataset.zip")
unzip(zipfile="dataset.zip")
## reading train and test data and their corresponding labels
traindata<-read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
testdata<-read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
trainsubject<-read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
testsubject<-read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
trainlabels<-read.table("UCI HAR Dataset/train/Y_train.txt", header=FALSE)
testlabels<-read.table("UCI HAR Dataset/test/Y_test.txt", header=FALSE)

## 1. merge the training and test sets to create one data set
totaltrain<-cbind(trainsubject, traindata, trainlabels)
totaltest<-cbind(testsubject, testdata, testlabels)
totaldata<-rbind(totaltrain, totaltest)
## removing extra data after using them
rm(list=c("traindata", "testdata", "trainsubject", "testsubject", 
          "trainlabels", "testlabels",
          "totaltrain", "totaltest"))

## 4. name each column of data set including the label column
features<-read.table("UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
names(totaldata)<-c("subject_id", gsub(x=features[,2], pattern="[[:punct:]]", replacement="_"), 
                    "activity_id")

## 3. use descriptive activity names to name the activities in the data set
## read the activity descriptive labels
activities<-read.table("UCI HAR Dataset/activity_labels.txt")
## doublecheck for the orders of activities
activities$v2<-factor(activities$V2, c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
totaldata$activity_descriptive_label<-activities$V2[totaldata$activity_id]
## removing extra data after using them
rm(list=c("activities", "features"))

## 2. extract only the measurements that compute mean or standard deviation
## using the names I will extract all columns containing the words "mean"
## or "std" in their names
## plus activity_descriptive_label which is the label of each row
totaldata_meanstd<-totaldata[, sort(c(grep("mean", names(totaldata)),
                                    grep("std", names(totaldata)),
                                    grep("activity_descriptive_label", names(totaldata))))]

## 5. create an independent tidy data set 
## with the average of each variable for each activity and each subject
## first I split totaldata based on "subject_id" and "activity_descriptive_label"
spliteddata<-
  split(totaldata, list(totaldata$subject_id, totaldata$activity_descriptive_label))
## then apply the colmeans function for each of these splited data
tidydata<-sapply(
  spliteddata, 
  function(x) colMeans(x[, -which(names(totaldata) %in% 
                                    c("subject_id", 
                                      "activity_id",
                                      "activity_descriptive_label"))]))
write.table(x=tidydata, file="tidydata.txt")
