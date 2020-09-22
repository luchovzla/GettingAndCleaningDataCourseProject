Getting and Cleaning Data Course Project

This project consists in gathering and tidying a dataset to obtain the averages of 
accelerometer and gyroscope signals of test subjects while performing diverse physical
activities. This data is divided in two datasets, one pertaining to test subjects 
(labeled 'test') and one pertaining to training subjects (labeled 'train'). 

The script works by reading the provided .txt files using the readr::read_table command
in R for both the test and training subject data, then merging these two datasets together.
After this, the variables related to average and standard deviation are extracted and 
observations are labeled according to their activity ID. 

Finally, the data is summarized, grouped by subject ID and activity label, and the 
variables are averaged to create a second, tidy data set, which is displayed on screen.