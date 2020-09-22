## Getting and Cleaning Data Course Project
## By: Luis Gomez

library(tidyverse)

# Merge training and test sets to create one data set

## Read needed files, assign descriptive variable names to columns 

columnNames <- read_table("./UCI HAR Dataset/features.txt", col_names = FALSE) %>% 
    mutate(X1 = str_remove(X1, "[:digit:]{1,3} "))

testValues <- read_table("./UCI HAR Dataset/test/X_test.txt", col_names = columnNames$X1)
testValues$subject <- read_table("./UCI HAR Dataset/test/subject_test.txt", col_names = FALSE)
testValues$activity <- read_table("./UCI HAR Dataset/test/y_test.txt", col_names = FALSE)
trainValues <- read_table("./UCI HAR Dataset/train/X_train.txt", col_names = columnNames$X1)
trainValues$subject <- read_table("./UCI HAR Dataset/train/subject_train.txt", col_names = FALSE)
trainValues$activity <- read_table("./UCI HAR Dataset/train/y_train.txt", col_names = FALSE)

dataFrame <- bind_rows(testValues, trainValues) %>%
    select(subject, activity, everything()) 

# Extract mean and standard deviation for each measurement

dataFrame <- dataFrame %>% 
    select(1 | 2 | contains("std()") | contains("mean()"))

# Use descriptive activity names to name the activities in the dataset

dataFrame <- dataFrame %>%
    mutate(
        activity = case_when(
            activity == 1 ~ "Walking",
            activity == 2 ~ "Walking Upstairs",
            activity == 3 ~ "Walking Downstairs",
            activity == 4 ~ "Sitting",
            activity == 5 ~ "Standing",
            activity == 6 ~ "Lying Down"
        )
    )

## Arrange rows by subject

dataFrame <- dataFrame %>%
    arrange(subject)

# Create a second independent tidy dataset with averages of each variable grouped by activity and subject

averagesDataFrame <- dataFrame %>%
    group_by(subject, activity) %>%
    summarize(across(1:66, mean))

View(averagesDataFrame)