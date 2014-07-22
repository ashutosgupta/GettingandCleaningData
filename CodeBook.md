#Code Book
    
    
#1. Merges the training and the test sets to create one data set.

a. Feature.txt and activity_labels.txt was read whihc were saved outside 'train" and "test" directory.

b.  Data in the "train" directory was read. Appropriate column names were assigned for training data set. Training data set     was created using data frames y_train,subject_train,x_train using cbind command.

c. Data in the "test" directory was read. Appropriate column names were assigned for training data set. Test data set was      created using using data frames y_test,subject_test,x_test using cbind command. 

d. training and Test data set were combined using rbind command.

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 

    
    
# 3. Use descriptive activity names to name the activities in the data set




# 4. Appropriately labels the data set with descriptive variable names. 


# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


