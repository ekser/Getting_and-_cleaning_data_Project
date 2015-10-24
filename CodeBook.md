# Code Book

## Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 
we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments 
have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, 
where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled 
in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, 
which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body 
acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a 
filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating 
variables from the time and frequency domain.


## Citation

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition 
on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted 
Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


## run_analysis.R

The implementation of the 5 steps described in the course project's definition is in the file run_analysis.R.

1) The train and test data are merged using the rbind() and cbind() functions. The names of each column are taken from features.txt.
2) From all the features variables, we extract only the variables mean and standart deviation for each measurement using grep().
Using subset(), we derive from the whole dataset, the subset with the measurements of the variables that we are interested in. 
3) Using merge(), we have descriptive activity names to name the activities in the data set. 
4) We label the data set with descriptive variable names with the function gsub().
5) Finally, we create a second, independent tidy data set with the average of each variable for each activity and each subject, 
using aggregate(). (Thus, we have 30 subjects * 6 activities = 180 rows)


## Variable Descriptions in Tidy Dataset

- Subject: The ID number of each participant in this expirement
- Activity_Name : Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
- Activity_Number: For each Activity_Name the cooresponding number (WALKING-1, WALKING_UPSTAIRS-2, WALKING_DOWNSTAIRS-3, SITTING-4, 
STANDING-5, LAYING-6)

They are in total 33 measurements (including the 3 dimensions - the X,Y, and Z axes).
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

time.BodyAccelerometer-XYZ
time.GravityAccelerometer-XYZ
time.BodyAccelerometerJerk-XYZ
time.BodyGyroscopic-XYZ
time.BodyGyroscopicJerk-XYZ
time.BodyAccelerometerMagnitude
time.GravityAccelerometerMagnitude
time.BodyAccelerometerJerkMagnitude
time.BodyGyroscopicMagnitude
time.BodyGyroscopicJerkMagnitude
frec.BodyAccelerometer-XYZ
frec.BodyAccelerometerJerk-XYZ
frec.BodyGyroscopic-XYZ
frec.BodyAccelerometerMagnitude
frec.BodyAccelerometerJerkMagnitude
frec.BodyGyroscopicMagnitude
frec.BodyGyroscopicJerkMagnitude

The set of variables that were estimated from these signals are: 

MEAN(): Mean value of a measurement 
SD(): Standard deviation of a measurement 

The Tidy Dataset contains for each measurement the average of each variable(MEAN, SD) for each activity and each subject.
