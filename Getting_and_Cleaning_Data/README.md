Getting_and_Cleaning_Data README File
========

> The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.  The original data set can be found here:

> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

> Within this repository is an R script called "run_analysis.R" that does the following:
> 
> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement.
> 3. Uses descriptive activity names to name the activities in the data set.
> 4. Appropriately labels the data set with descriptive activity names.
> 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Using the run_analysis.R file
-----------------------------

1. In RStudio, call the file using the function `source("/run_analysis.R")`
2. The output file `Tidy_UCI_HAR_Dataset.txt` will be saved to your current working directory.
3. Refer to the file `Codebook.MD` for information on the tidy dataset, including variables, dimensions, structure, etc.
