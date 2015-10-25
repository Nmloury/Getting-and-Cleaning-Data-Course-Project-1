# Getting and Cleaning Data Course Project 1

The run_analysis.R file included in the repo does the following:

1. Downloads the wearable computing data for the Course Project.
2. Unzips the data and read the relevant information into R.
3. Merges the training and test data sets together into one dataset, *alldata*, complete with variable names (taken from the features.txt file) along with the subject and activity ids.
    - I used the rbind function to merge the two sets together, as they have the exact same column names
4. Extracts the mean and standard deviation variables for each measurement and puts them into the *meandata* dataset.
    - I used select, along with the contains function from the dplyr package, to search for the "mean()" and "std()" strings in the variable names.
5. Renames the variables to make them more human readable
    - I removed the dashes and parenthesis and replaced a few of the words in the variable names to make them a bit easier to comprehend.
5. Labels the activity variable with descriptive activity names taken from the activity_labels.txt file.
6. Creates a tidy dataset, *tidydata*, which contains the average of each variable for each activity and each subject.
    - I used the group_by and summarize functions from dplyr in order to create the tidy dataset.
7. Writes the tidy data to a text file, *tidydata.txt* for uploading.

