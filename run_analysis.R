#Merge the training and the test sets to create one data set.


setwd("E:\\Coursera\\DataCleaning\\UCI HAR Dataset")

#Read training data set and activity labels and features
features = read.table("./features.txt",header=FALSE); #imports features.txt
activity_labels = read.table("./activity_labels.txt",header=FALSE); #imports activity_labels.txt
subject_train = read.table("./train/subject_train.txt",header=FALSE); #imports subject_train.txt
x_train = read.table("./train/x_train.txt",header=FALSE); #imports x_train.txt
y_train = read.table("./train/y_train.txt",header=FALSE); #imports y_train.txt

# Assigin column names
colnames(activity_labels) = c("activityID","activity_labels");
colnames(subject_train) = "subjectID";
colnames(x_train) = features[,2];
colnames(y_train) = "activityID";

# create training data
training_data = cbind(y_train,subject_train,x_train);

# Read in the test data
subject_test = read.table("./test/subject_test.txt",header=FALSE); #imports subject_test.txt
x_test = read.table("./test/x_test.txt",header=FALSE); #imports x_test.txt
y_test = read.table("./test/y_test.txt",header=FALSE); #imports y_test.txt


colnames(subject_test) = "subjectID";
colnames(x_test) = features[,2];
colnames(y_test) = "activityID";


# cbind the x_test, y_test and subject_test data
test_data = cbind(y_test,subject_test,x_test);


# rbind the training and test data set
combined_data = rbind(training_data,test_data);

colNames = colnames(combined_data);


logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));


combined_data = combined_data[logicalVector==TRUE];

combined_data = merge(combined_data,activity_labels,by="activityID",all.x=TRUE);

colNames = colnames(combined_data);

for (i in 1:length(colNames))
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","Dispersion",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","Time",colNames[i])
  colNames[i] = gsub("^(f)","frequency",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Bod",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","accMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyaccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};


colnames(combined_data) = colNames;

#Create a second, independent tidy data set with the average of each variable for each activity and each subject.

combined_data_labels = combined_data[,names(combined_data) != "activity_labels"];


tidy_data = aggregate(combined_data_labels[,names(combined_data_labels) != c("activityID","subjectID")],by=list(activityID=combined_data_labels$activityID,subjectID = combined_data_labels$subjectID),mean);


tidy_data = merge(tidy_data,activity_labels,by="activityID",all.x=TRUE);

# Write tidy data to a text file
write.table(tidy_data, "C:/Users/admin/Documents/GitHub/GettingandCleaningData/tidy_data.txt",row.names=TRUE,sep="\t");
