# README - Human Activity Recognition Using Smartphones 
### Created By Jawad Rashid

## How To Run
There is no special package/library needed for this project. Just run the run_analysis.R and you are done. This project was created using RStudio 0.98.507 with R 3.1.0 under MAC OS X 10.8.5 Mountain Lion OS.

## About the Input Dataset
There is no need to place the input dataset in the same folder as this script will first see if there is any data directory. 

* If there is a data directory that means that there should be data already. 
* If there is no data directory then this script goes over the internet to download the zip for the dataset and places it in the data folder. 
* Once the dataset zip is downloaded this script uses the unzip command to unzip the dataset into data folder and the unzip automatically creates a folder by the name "UCI HAR Dataset".
* This downloading only takes place if there is no data folder. Once this process has been complete the first time  the script will not re-download the dataset. 

## Reading in Activity Names
The script reads in activity_labels.txt which is used later on to replace the numeric activity labels with the actual activity name. As already discussed in the CodeBook.md file the activity names are converted to lowercase characters with _ replaced with space characters.

## Features List
* Next this script read the names of the features from features.txt. From these columns using regular expressions only those columns indexes and names are left which have mean() or std() in the name to denote that these are mean() or standard deviation values.
* Next transformations are made on the names of features as dicussed in CodeBook. This is step 2 of requirements.

## Merge Dataset
* Now the x_train, y_train, subject_train for training dataset and x_test, y_test, and subject_Test for test dataset are read in R and a single dataset is created with only the features needed into a single dataset by appending the training and test dataset together into a single dataset. This step is the step # 1 in requirements.

## Replace Activity Name
* The step 3 & 4 to replace actiity number to activity names is done next.

## Step 5 - Generate Tidy Dataset
* This is the last step. In this the dataset is first broken down using subject and activity factors so there one element in the list for each unique subject and activity. A empty dataframe for tidy dataset is generated. Then each combination is looped through and the mean for each measurement is recorded for each subject/activity combination to generate only one record.
* Once the resultant data frame for tidy dataset is generated three files are created one is saving the dataframe into an R object to file, a csv file and text file with csv data which is the file which is submitted.  



