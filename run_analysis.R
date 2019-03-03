library(dplyr)

##Downloading and unziping file
download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',destfile = 'smartphone.zip',method = 'libcurl')
unzip(zipfile = 'smartphone.zip',overwrite = T)

##Reading files
activity = read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("cd_nm", "act_nm"))
features = read.table("UCI HAR Dataset/features.txt", col.names = c("number","Func"))
sub_test = read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test= read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$Func )
y_test= read.table("UCI HAR Dataset/test/y_test.txt", col.names = "cd_nm")
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train = read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$Func)
y_train = read.table("UCI HAR Dataset/train/y_train.txt", col.names = "cd_nm")

## Creating one dataset by merging training and testing set
df_X = rbind(x_train, x_test) ## merging both x train and x test
df_Y = rbind(y_train, y_test) ## merging both y train and y test
Subject = rbind(subject_train, sub_test) ## merging both subject files
df_merged <- cbind(Subject, df_Y, df_X) ## final merge

## Selecting only the measurements for mean and SD
df_tidy = df_merged %>% select(subject, cd_nm, contains("mean"), contains("std"))

##Switching activities in the data set with descriptive activity name 
df_tidy$cd_nm = activity[df_tidy$cd_nm, 2]

## Relabling the variable names
names(df_tidy)[2] = "Activity"
names(df_tidy)=gsub("Acc", "Accelerometer", names(df_tidy))
names(df_tidy)=gsub("Gyro", "Gyroscope", names(df_tidy))
names(df_tidy)=gsub("BodyBody", "Body", names(df_tidy))
names(df_tidy)=gsub("Mag", "Magnitude", names(df_tidy))
names(df_tidy)=gsub("^t", "Time", names(df_tidy))
names(df_tidy)=gsub("^f", "Frequency", names(df_tidy))
names(df_tidy)=gsub("tBody", "TimeBody", names(df_tidy))
names(df_tidy)=gsub("-mean()", "Mean", names(df_tidy), ignore.case = TRUE)
names(df_tidy)=gsub("-std()", "STD", names(df_tidy), ignore.case = TRUE)
names(df_tidy)=gsub("-freq()", "Frequency", names(df_tidy), ignore.case = TRUE)
names(df_tidy)=gsub("angle", "Angle", names(df_tidy))
names(df_tidy)=gsub("gravity", "Gravity", names(df_tidy))

## Calculating mean of the measurements grouped by Subject and activity

df_final = df_tidy %>%
  group_by(subject, Activity) %>%
  summarise_all(funs(mean))

##Writing to a txt file
write.table(df_final, "tidydata.txt", row.name=FALSE)

