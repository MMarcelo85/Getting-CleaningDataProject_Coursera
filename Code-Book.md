

### Code Book.

#### *Introduction*
This document explains the operations carried out on some of the variables of the "
Human Activity Recognition Using Smartphones Data Set". [aquí](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
A full description of the Data Set can be found in [The UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#) and within the first link provided.


#### *Data Set Information:*

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


#### *About the script*
The 5 sections of run_analsis.R script performs 5 tasks as requested in the course Assignment:

1- Download the data:

- Unzip the files ad load the txt data files (x_train, x_test, y_train, y_test, subject_train, subject_test, features, activity_labels).

- Rename the varibles.

- and Merges the training and the test sets to create one data set (all).
    
2- Extracts only the measurements on the mean and standard deviation for each measurement.

- Extract the column indices that have either mean or std in them.

- Add activity and subject columns to the list and look at the dimension of the all data.

- Making nessesary subset from the one data set (all).
    
3- Uses descriptive activity names to name the activities in the data set. 

4- Appropriately labels the data set with descriptive variable names.

5- From the data set in step 4:

- Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

- Writes de data set on your HD.


#### Data sets descripction:
- x_train, x_test, y_train, y_test: Data variables 

- subject_train, subject_test: Subjects IDs 

- features: Data variables descriptive names

- activity_labels: Activities labels
