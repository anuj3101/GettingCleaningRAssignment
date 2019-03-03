# GettingCleaningRAssignment
Final course assignment for Coursera's - Getting and Cleaning Data

The R script, `run_analysis.R`, does the following:
1. Downloads the dataset and unzips the data into the directory
2. Loads the activity and feature files along with both the training and test datasets, keeping only those columns which
   reflect a mean or standard deviation
3. Loads the activity and subject data for each dataset, and merges those  
   columns with the dataset
4. Merges the datasets created in step 2 and step 3
5. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.

The end result is shown in the file `tidydata.txt`.

