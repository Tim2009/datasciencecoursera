README: Coursera Data Science Specialization - Getting and Cleaning Data (Tim Dyke)
Week 4 Assignment
The purpose of this exercise is to access a data set derived from 30 individuals undertaking 6 different physical activities as measured through a wearable accelerometer and gyroscope device (Samsung 5 smartphone) and then convert that data into a smaller summary data set for subsequent exploratory analysis.
The final data set has one row for each unique combination of individual and activity. It has one column for each average value of the mean and standard deviation calcualted from the raw device measurements

Data source:
UCI data repository fround at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Further information : 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data files
Generic:  activity_labels.txt, names for activities (used); features.txt, names for variables once cleaned (used); features_info.txt, descritption of measurements (not used, but useful reference)

Training and Test each contain: an X (measurement data) (used); y (activity category numbers) (used); subject (individual person category numbers) (used) and a folder of Inertial Signals containing additional (derived) measurement data (not used)


Analysis steps
All data acquisition and analysis done from within a single R script which:
Downloads the data as a zipped file
Unzips the data to the local drive 
Loads the files into R lists or dataframes as appropriate, cleaning extra spaces, brackets, commas, etc
Combines the main data dataframes (X_train  and X_test) with the subject and activity listings and the cleaned variable names
Combines the training and test datasets into a single dataframe
Replaces the activity number IDs with actual categorical names (sitting, walking etc) in the dataframe
Creates a subset dataframe including only those variables which are calculations of the mean or standard deviation of a particular measurement (using grep on the variable names)
Calculates the average (mean) of each of the subset measurements for each unique pairing of individual and activity into a new dataframe
Writes the resulting summary data set to a text file on the local drive.




