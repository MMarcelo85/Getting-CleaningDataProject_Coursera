# Loading all requiered packages
library('tidyverse')
library('data.table')
library('RCurl')

getwd()
################## Getting the Data and merging
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if(!file.exists("./data")){dir.create("./data")}
download.file(url, destfile = './data/data.zip')
unzip('./data/data.zip', exdir = './data')

### Loading 
#train
x_train <- fread('data/UCI HAR Dataset/train/X_train.txt')
y_train <- fread('data/UCI HAR Dataset/train/y_train.txt')
subject_train <- fread('data/UCI HAR Dataset/train/subject_train.txt')
#test
x_test <- fread('data/UCI HAR Dataset/test/X_test.txt')
y_test <- fread('data/UCI HAR Dataset/test/y_test.txt')
subject_test <- fread('data/UCI HAR Dataset/test/subject_test.txt')

#features 
features <- fread('data/UCI HAR Dataset/features.txt')
activityLabels <- fread('./data/UCI HAR Dataset/activity_labels.txt')

#labeling columns
colnames(y_train) <- 'activityID'
colnames(x_train) <- features$V2
colnames(subject_train) <- "subjectId"

colnames(y_test) <- 'activityID'
colnames(x_test) <- features$V2
colnames(subject_test) <- "subjectId"
colnames(activityLabels) <- c('activityId','activity_label')

# Merging to one df:
all_train <- cbind(y_train, subject_train, x_train)
all_test <- cbind(y_test, subject_test, x_test)
all <- rbind(all_train, all_test)

############## Extract the column indices that have either mean or std in them.
columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(all), ignore.case=TRUE)

# Add activity and subject columns to the list and look at the dimension of the all data
requiredColumns <- c(1,2,columnsWithMeanSTD)
dim(all)

# select all columns with mean and std
df_means_stds <- all[,..requiredColumns]
dim(df_means_stds)

#Quickly check
colnames(df_means_stds)

########### Setting descriptive names to activities:
#Setting the variable to the right class
df_means_stds$activityID <- as.character(df_means_stds$activityID) 
#check
class(df_means_stds$activityID)
# we have to extract the label from activityLabels$V2 and pass it for each i in df_means_stds$activityID
# We have to set the result of every iteration to character in order to the for loop to work properly 
for(i in 1:6){
    df_means_stds$activityID[df_means_stds$activityID == i] <- as.character(activityLabels[i, 2])
}
#cheking that went OK
table(df_means_stds$activityID, useNA = 'ifany')
#as factor 
df_means_stds$activityID <- as.factor(df_means_stds$activityID) 


#############  Appropriately labels the data set with descriptive variable names
#Check the names of the df_means_stds data frame
colnames(df_means_stds)
# inspecting features_info.txt we know that:
# 't' indicates time
# 'f' indicates frequency
# 'Mag' indicates magnitude
# 'Acc' indixates Accelerometer
# 'Gyro <- Gyroscope
# 'BodyBody' must be replaced with 'Body'

names(df_means_stds)<-gsub("Acc", "Accelerometer", names(df_means_stds))
names(df_means_stds)<-gsub("Gyro", "Gyroscope", names(df_means_stds))
names(df_means_stds)<-gsub("BodyBody", "Body", names(df_means_stds))
names(df_means_stds)<-gsub("Mag", "Magnitude", names(df_means_stds))
names(df_means_stds)<-gsub("^t", "Time", names(df_means_stds))
names(df_means_stds)<-gsub("^f", "Frequency", names(df_means_stds))
names(df_means_stds)<-gsub("tBody", "TimeBody", names(df_means_stds))
names(df_means_stds)<-gsub("-mean()", "Mean", names(df_means_stds), ignore.case = TRUE)
names(df_means_stds)<-gsub("-std()", "STD", names(df_means_stds), ignore.case = TRUE)
names(df_means_stds)<-gsub("-freq()", "Frequency", names(df_means_stds), ignore.case = TRUE)
names(df_means_stds)<-gsub("angle", "Angle", names(df_means_stds))
names(df_means_stds)<-gsub("gravity", "Gravity", names(df_means_stds))

### Check
colnames(df_means_stds)

############## independent tidy data set with the average of each variable for each activity and each subject.
### Set subject as factor, convert df to data.table for later aggregation
df_means_stds$subjectId <- as.factor(df_means_stds$subjectId)
table(df_means_stds$subjectId)
as.data.table(df_means_stds)
class(df_means_stds)

### aggregation by subject and activity and get mean
# order by Subject and activity
# write the data table
tidyDT <- aggregate(. ~subjectId + activityID, df_means_stds, mean)
tidyDT <- setorder(tidyDT, subjectId, activityID)
write.table(tidyDT, file = "TidyDT.txt", row.names = FALSE)

#check OK
#getwd()
#dt <- fread('TidyDT.txt'); head(dt)
