## Raw data files can be downloaded here:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Load the following required packages in your R environment.
packages <- c("data.table", "reshape2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

## Once the raw data is in your working directory, first step is reading the data into R, 
## starting with the "subject_train" and "subject_test" txt files.
tableSubjectTrain <- read.table("subject_train.txt")
datTableSubjectTrain <- data.table(tableSubjectTrain)
tableSubjectTest <- read.table("subject_test.txt")
datTableSubjectTest <- data.table(tableSubjectTest)

## Then the "X_train" and "X_test" txt files.
tableX_train <- read.table("X_train.txt")
datTableX_train <- data.table(tableX_train)
tableX_test <- read.table("X_test.txt")
datTableX_test <- data.table(tableX_test)

## Finally the "y_train" and "y_test" txt files.
tableY_train <- read.table("y_train.txt")
datTableY_train <- data.table(tableY_train)
tableY_test <- read.table("y_test.txt")
datTableY_test <- data.table(tableY_test)



## Merging the training and test sets, which will create one large data set:
## Start by concatenating rows of pairs of data sets, using the rbind function.
table_subject <- rbind(datTableSubjectTrain, datTableSubjectTest)
setnames(table_subject, "V1", "subject")
table_y <- rbind(datTableY_train, datTableY_test)
setnames(table_y, "V1", "act_Num")
data_table <- rbind(datTableX_train, datTableX_test)

## Then merge the remaining data sets by column.
table_subject <- cbind(table_subject, table_y)
data_table <- cbind(table_subject, data_table)

## Set a key.
setkey(data_table, subject, act_Num)



## Extracting only the mean and standard deviation measurements:
## Read the "features.txt" file into R, this file has info as to which measurements are
## mean and standard deviation, and which are not.
tablefeatures <- read.table("features.txt")
datTablefeatures <- data.table(tablefeatures)
setnames(datTablefeatures, names(datTablefeatures), c("featureNum", "featureName"))

## Isolate the measurements for both mean and standard deviation.
datTablefeatures <- datTablefeatures[grepl("mean\\(\\)|std\\(\\)", featureName)]

## Add a column of variable names that match up with columns in mean_std.
datTablefeatures$featureCode <- datTablefeatures[, paste0("V", featureNum)]
head(datTablefeatures)
datTablefeatures$featureCode

## Create a subset of the newly added variables.
sel <- c(key(data_table), datTablefeatures$featureCode)
data_table <- data_table[, sel, with=FALSE]



## Label the dataset with descriptive vaiable names:
## Read the "activity_labels.txt" file into R, this file contains names that will be
## applied to the activies in our data set.
tableActNames <- read.table("activity_labels.txt")
datTableActName <- data.table(tableActNames)
setnames(datTableActName, names(datTableActName), c("act_Num", "act_Name"))

## Merge the activity labels into data_table.
data_table <- merge(data_table, datTableActName, by="act_Num", all.x=TRUE)

## Add "act_Name" as a key.
setkey(data_table, subject, act_Num, act_Name)

## Use the "Melt" function to reformat the data, from wide to narrow.
data_table <- data.table(melt(data_table, key(data_table), variable.name="featureCode"))

## Merge the activity names into data_table.
data_table <- merge(data_table, datTablefeatures[, list(featureNum, featureCode, featureName)], by="featureCode", all.x=TRUE)

## Create new variables (activity and feature), this will aid in getting desciptive names
## to each activity.
data_table$activity <- factor(data_table$act_Name)
data_table$feature <- factor(data_table$featureName)

## Isolate each feature and apply a descriptive activity name to each.
dtf <- data_table$feature
## Features with 1 category
data_table$featJerk <- factor(grepl("Jerk", dtf), labels=c(NA, "Jerk"))
data_table$featMagnitude <- factor(grepl("Mag", dtf), labels=c(NA, "Magnitude"))
## Features with 2 categories
y <- matrix(seq(1, 2), nrow=2)
x <- matrix(c(grepl("^t", dtf), grepl("^f", dtf)), ncol=nrow(y))
data_table$featDomain <- factor(x %*% y, labels=c("Time", "Frequency"))
x <- matrix(c(grepl("Acc", dtf), grepl("Gyro", dtf)), ncol=nrow(y))
data_table$featInstrument <- factor(x %*% y, labels=c("Accelerometer", "Gyroscope"))
x <- matrix(c(grepl("BodyAcc", dtf), grepl("GravityAcc", dtf)), ncol=nrow(y))
data_table$featAcceleration <- factor(x %*% y, labels=c(NA, "Body", "Gravity"))
x <- matrix(c(grepl("mean()", dtf), grepl("std()", dtf)), ncol=nrow(y))
data_table$featVariable <- factor(x %*% y, labels=c("Mean", "StandDev"))
## Features with 3 categories
y <- matrix(seq(1, 3), nrow=3)
x <- matrix(c(grepl("-X", dtf), grepl("-Y", dtf), grepl("-Z", dtf)), ncol=nrow(y))
data_table$featAxis <- factor(x %*% y, labels=c(NA, "X", "Y", "Z"))



## Creation of an independent tidy data set with the average of each variable for each
## activity and each subject.
setkey(data_table, subject, activity, featDomain, featAcceleration, featInstrument, featJerk, featMagnitude, featVariable, featAxis)
data_table_Tidy <- data_table[, list(count = .N, average = mean(value)), by=key(data_table)]

## Save tidy dataset to a text file.
write.table(data_table_Tidy, "Tidy_UCI_HAR_Dataset.txt", quote = FALSE, sep = "\t", row.names = FALSE)