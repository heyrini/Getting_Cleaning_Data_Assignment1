#######################################################################################################
#This code downloads wearable device (Samsung phone) zipped data file, unzips it and merges datasets 
#######################################################################################################

#Load needed libraries
library(plyr)

#Download file
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

temp<-tempfile()
download.file(url,temp)
unzip(temp)
unlink(temp)

setwd("./UCI HAR Dataset")

#####################################################################
#Read in data
#####################################################################
#Read activity annotation
feature.list<-read.table(file="features.txt",header=FALSE)
activities.list<-read.table(file="activity_labels.txt",header=FALSE)

#Read in Train subjects and train data
sub.train<-read.table(file=".\\train\\subject_train.txt",header=FALSE)
X.train<-read.table(file=".\\train\\X_train.txt",header=FALSE)
Y.train<-read.table(file=".\\train\\y_train.txt",header=FALSE)

#Read in Test subjects and test data
sub.test<-read.table(file=".\\test\\subject_test.txt",header=FALSE)
X.test<-read.table(file=".\\test\\X_test.txt",header=FALSE)
Y.test<-read.table(file=".\\test\\y_test.txt",header=FALSE)



#####################################################################
#Combine subject id annotation and activity ids with data
#####################################################################
#Combine annotation subject id and feature id for X.train
colnames(X.train)<-feature.list[,2]
colnames(sub.train)<-c("subject.id")
colnames(Y.train)<-c("activity.id")
annotated.train<-cbind(sub.train$subject.id,Y.train$activity.id,X.train)
colnames(annotated.train)[1]<-"Subject.id"
colnames(annotated.train)[2]<-"activity.id"

#Combine annotation subject id and feature id for X.test
colnames(X.test)<-feature.list[,2]
colnames(sub.test)<-c("subject.id")
colnames(Y.test)<-c("activity.id")
annotated.test<-cbind(sub.test$subject.id,Y.test$activity.id,X.test)
colnames(annotated.test)[1]<-"Subject.id"
colnames(annotated.test)[2]<-"activity.id"

####################################################################
#1. MERGE TRAINING AND TEST SETS TO CREATE ONE DATA SET
####################################################################
full.data<-rbind(annotated.train,annotated.test)

####################################################################
#2. EXTRACT MEASUREMENT ON MEAN AND STANDARD DEVIATION ON EACH DATA SET
####################################################################
data.mean.std<-full.data[,grepl("mean|std",colnames(full.data))]
data.mean.std<-cbind(full.data$Subject.id,full.data$activity.id,data.mean.std)
colnames(data.mean.std)[1:2]<-c("Subject.id","activity.id")

####################################################################
#3. USE DESCRIPTIVE ACTIVITY LABELS
####################################################################
data.mean.std<-merge(data.mean.std,activities.list,by.x="activity.id",by.y="V1")
colnames(data.mean.std)[82] <- "activity.label"

#####################################################################
#4.LABEL DATASET WITH DESCRIPTIVE VARIABLE NAMES
#####################################################################

names(data.mean.std)<-gsub("\\(|\\)","",names(data.mean.std))
names(data.mean.std)<-gsub("^t","TimeDomainSignal_",names(data.mean.std))
names(data.mean.std)<-gsub("^f","FrequencyDomainSignal_",names(data.mean.std))
names(data.mean.std)<-gsub("Acc","Acceleration",names(data.mean.std))
names(data.mean.std)<-gsub("mean","MeanValue",names(data.mean.std))
names(data.mean.std)<-gsub("std","StandardDeviation",names(data.mean.std))
names(data.mean.std)<-gsub("AccJerk","LinearAcceleration",names(data.mean.std))
names(data.mean.std)<-gsub("GyroJerk","AngularVelocity",names(data.mean.std))
names(data.mean.std)<-gsub("Gyro","Gyroscope",names(data.mean.std))
names(data.mean.std)<-gsub("Mag","Magnitude",names(data.mean.std))
names(data.mean.std)<-gsub("Freq","Frequency",names(data.mean.std))


#####################################################################
#5. SECOND INDEPENDENT DATASET WITH MEANS FOR EACH VARIABLE BY SUBJECT AND ACTIVITY
#####################################################################

data.mean.bygroups<-ddply(data.mean.std,.(Subject.id,activity.id),numcolwise(mean))
write.table(data.mean.bygroups,file="Data.mean.by.sub.activity.txt",sep="\t",,row.names=FALSE)
