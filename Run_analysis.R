#Assignment of the cousera data getting and Clearning
#This assignment cleaning, tidy, merging and generation of the codebook

#loading data
link <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
downloadFolder <- "./dataset/data.zip"
download.file(link, downloadFolder, mode = "wb")
unzip(downloadFolder, exdir = "./dataset")


Preprocess = function (filename,directory) {
  # loading the labeling dataset
  activity_labels<-read.table("activity_labels.txt")
  #loading the column names
  column.names<-read.table("features.txt")
  # selection column index with mean and std from the column names
  column.index<-grep("mean|std", column.names[,2])
  #reading the subject file
  filepath = paste(directory, paste0("subject_", filename, ".txt"),sep='/')
  subjectid= read.table(filepath, col.names = c("subjectid"))
  
  #reading the x files
  filepath = paste(directory, paste0("X_", filename, ".txt"),sep='/')
  x.file = read.table(filepath)
  x.file=x.file[,column.index]
  names(x.file)=column.names[column.index,2]
  
  #reading the y files
  filepath = paste(directory, paste0("y_", filename, ".txt"),sep='/')
  y.file = read.table(filepath)
  # merging file with activity labels
  y.files<-merge(activity_labels, y.file)
  #naming the y files
  names(y.files)<-c("activityid", "activity")
  
  
  data<-data.frame(subjectid, y.files,x.file)
  
  data
}

#process the Train dataset
train<- Preprocess('train','train')

#Processing the Test dataset
test<- Preprocess('test','test')

# final dataset by combining the test and test
data<- rbind(train, test)


# Creating a second, independent tidy data set with the average of each variable for each activity and each subject
#loading library
library(reshape2)
# subseting the variables names
varnames <- colnames(data[,-c(1:3)])

#Melting the data
meltdata<- melt(data, id=c("activityid", "activity",'subjectid'), measure.vars=varnames) 
 
#casting the data to get the means
tidydata<- dcast(meltdata, activity + subjectid ~ variable, mean)


# writing the the tidy dataset
write.table(tidydata, 'tidy.txt')
  
  
  
  
