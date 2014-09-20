#Readme for the cousera assigment 
this script requires that data should be download extract to the working directory
data for the assigment was downloaded from the below link

A Preprocess() function was created function:
  loading feature.txt,labe.txt, test files and train files

  The activity-label was set as the colum names with was subset to get the column index
  using the grep function to search for label with mean or std
  
  The colum index was to subset the X and Y files in both the train and test to 
  uniform data structure
  
  the files subjectid,x.file and y.file were put together forming a data.frame(data)
#creating the train and test data
  the preprocess function was used to create a dataset for train and test
#merging  
the train and test data were merged using the rbind command for the data

#creating tidy data set
the combine dataset('data') were melted to created three variables: subjectid, activity
and activityid using the melt command in the reshape2 packages
# casting the melted data 
data werre casted to the the average of each variable for each activity and each subject
#writing tidydata as 
final the tidy data were written as test file




