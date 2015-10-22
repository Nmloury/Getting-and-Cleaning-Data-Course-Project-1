# Getting and Cleaning Data Course Project 1

The run_analysis.R file included in the repo does the following:

1. Downloads the wearable computing data for the Course Project.
2. Unzips the data and read the relevant information into R.
3. Merges the training and test data sets together into one dataset, *alldata*, complete with variable names (taken from the features.txt file) along with the subject and activity ids.
4. Extracts the the mean and standard deviation variables for each measurement and puts them into the *meandata* dataset.
5. Labels the activity variable with descriptive activity names.
6. Creates a tidy dataset, *tidydata*, which contains the average of each variable for each activity and each subject.
7. Writes the tidy data to a text file for uploading.

