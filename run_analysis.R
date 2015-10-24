
library(dplyr)

###############################################################################
# read the tables
x_train <- tbl_df(read.table("./UCI HAR Dataset/train/X_train.txt"))
y_train <- tbl_df(read.table("./UCI HAR Dataset/train/y_train.txt"))
subject_train <- tbl_df(read.table("./UCI HAR Dataset/train/subject_train.txt"))

x_test <- tbl_df(read.table("./UCI HAR Dataset/test/X_test.txt"))
y_test <- tbl_df(read.table("./UCI HAR Dataset/test/y_test.txt"))
subject_test <- tbl_df(read.table("./UCI HAR Dataset/test/subject_test.txt"))

features <- tbl_df(read.table("./UCI HAR Dataset/features.txt"))
features <- setNames(features, c("Feature_Number", "Feature_Name"))

activities <- tbl_df(read.table("./UCI HAR Dataset/activity_labels.txt"))
activities <- setNames(activities, c("Activity_Number", "Activity_Name"))

###############################################################################
# Merge the training and the test sets to create one data set

x_all <- rbind(x_train, x_test)
colnames(x_all) <- features$Feature_Name

y_all <- rbind(y_train, y_test)
colnames(y_all) <- "Activity_Number"

subject_all <- rbind(subject_train, subject_test)
colnames(subject_all) <- "Subject"

complete_data <- cbind(subject_all, y_all, x_all)


###############################################################################
# Extract only the measurements on the mean and standard deviation for each measurement

Mean_Std <- grep("mean\\(\\)|std\\(\\)", features$Feature_Name, value = TRUE)
columns_to_keep <- union(c("Subject", "Activity_Number"), Mean_Std)
data_only_mean_std <- subset(complete_data, select = columns_to_keep)


###############################################################################
# Use descriptive activity names to name the activities in the data set

data_activity_names <- merge(data_only_mean_std, activities, by = "Activity_Number", all.x = TRUE)
data_activity_names$Activity_Name <- as.character(data_activity_names$Activity_Name)


###############################################################################
# Appropriately label the data set with descriptive variable names

names(data_activity_names)<-gsub("mean", "MEAN", names(data_activity_names))
names(data_activity_names)<-gsub("std", "SD", names(data_activity_names))
names(data_activity_names)<-gsub("^t", "Time.", names(data_activity_names))
names(data_activity_names)<-gsub("^f", "Freq.", names(data_activity_names))
names(data_activity_names)<-gsub("Acc", "Accelerometer", names(data_activity_names))
names(data_activity_names)<-gsub("Gyro", "Gyroscope", names(data_activity_names))
names(data_activity_names)<-gsub("Mag", "Magnitude", names(data_activity_names))
names(data_activity_names)<-gsub("BodyBody", "Body", names(data_activity_names))


###############################################################################
# Create a second, independent tidy data set with the average of each variable  for each activity 
# and each subject

Tidy_Data <- aggregate(.~Subject + Activity_Name, data_activity_names, mean)
Tidy_Data <- Tidy_Data[order(Tidy_Data$Subject, Tidy_Data$Activity_Number), ]

write.table(Tidy_Data, file = "./tidy_data.txt", row.name = FALSE)



