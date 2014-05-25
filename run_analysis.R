## Created By Jawad Rashid For "Getting and Cleaning Data"

# Download the Data Folder from Internet. This will only re-download the data if there
# is no data folder.
if(!file.exists("data")) {
        dir.create("data");
        dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(dataUrl, destfile="data/UCI HAR Dataset.zip", method="curl")
        dateDownloaded <- date()
        file.create("data/dateDownloaded.txt")
        save(dateDownloaded, file="data/dateDownloaded.txt")
        unzip("data/UCI HAR Dataset.zip", exdir="data/")
}

# Prerequistes
# The dataset needs to be in the same folder as this script under the name "UCI HAR Dataset"

# Going to Load the Labels for the activities and the features variable names from the root
# folder for dataset first.
dataFolder <- "data/UCI HAR Dataset/"

#Read Actiity Names. Make it easier to understand by changing the col names.
#Renaming the activity to make it lowercase and more descriptive
activityFileName <- "activity_labels.txt"
activityFilePath <- paste0(dataFolder, activityFileName)
activityNames <- read.table(activityFilePath, sep = " ", stringsAsFactors = FALSE)
colnames(activityNames) <- c("classlabel", "activitynames")
activityNames$activitynames <- tolower(activityNames$activitynames)
activityNames$activitynames <- gsub("_"," ", activityNames$activitynames)

#Read Features List
featuresListFileName <- "features.txt"
featuresFilePath <- paste0(dataFolder, featuresListFileName)
featuresList <- read.table(featuresFilePath, sep=" ", stringsAsFactors = FALSE)
colnames(featuresList) <- c("featureindex", "featurelabel")

###### STEP 2 STARTS HERE ######
# Finding all variables with std() or mean() as per the requirements in the name
requiredIndexes <- grep(".*(mean\\(\\)|std\\(\\))", featuresList$featurelabel)
requiredFeatures <- featuresList$featurelabel[requiredIndexes]
###### STEP 2 STOPS HERE ######

# IMPORTANT: Not Making the variables lowercase as making text lowercase
# reduces the readability of the variables
# Renaming the name to change -x, -y, -z to xaxis, yaxis, zaxis.
# mean() and std() renamed into mean and standarddeviation
# f or t in the start renamed into frequency or time
# Acc renamed into acceleration, Gryo to gyroscope, mag to magnitude
# Removed duplicate bodybody to body.
###### STEP 3 STARTS HERE ######
requiredFeatures <- gsub("^f", "frequency\\2",  requiredFeatures)
requiredFeatures <- gsub("^t", "time\\2",  requiredFeatures)
requiredFeatures <- gsub("Gyro", "Gyroscope", requiredFeatures)
requiredFeatures <- gsub("(Body)\\1", "\\1", requiredFeatures)
requiredFeatures <- gsub("Mag", "Magnitude", requiredFeatures)
requiredFeatures <- gsub("-(X|Y|Z)$", "-\\1Axis", requiredFeatures)
requiredFeatures <- gsub("Acc", "Acceleration", requiredFeatures)
requiredFeatures <- gsub("std\\(\\)", "StandardDeviation", requiredFeatures)
requiredFeatures <- gsub("(mean)\\(\\)", "\\1", requiredFeatures)
requiredFeatures <- gsub("mean", "Mean", requiredFeatures)
requiredFeatures <- gsub("-", "", requiredFeatures)
###### STEP 3 STOPS HERE ######

###### STEP 1 STARTS HERE ######
# Read in testing and train data to merge them into one dataset
trainFolder <- paste0(dataFolder, "train/")
subjectTrainUrl <- paste0(trainFolder, "subject_train.txt")
subjectTrain <- read.table(subjectTrainUrl, stringsAsFactors=FALSE)

xTrainUrl <- paste0(trainFolder, "X_train.txt")
xTrain <- read.table(xTrainUrl, stringsAsFactors=FALSE)

yTrainUrl <- paste0(trainFolder, "y_train.txt")
yTrain <- read.table(yTrainUrl, stringsAsFactors=FALSE)

#Remove features not needed PART OF STEP 2
training <- xTrain[, requiredIndexes]
colnames(training) <- requiredFeatures
colnames(subjectTrain) <- c("subject")
colnames(yTrain) <- c("activity")
training <- cbind(training, subjectTrain, yTrain)

# Do the same for testing data
testFolder <- paste0(dataFolder, "test/")
subjectTestUrl <- paste0(testFolder, "subject_test.txt")
subjectTest <- read.table(subjectTestUrl, stringsAsFactors=FALSE)

xTestUrl <- paste0(testFolder, "X_test.txt")
xTest <- read.table(xTestUrl, stringsAsFactors=FALSE)

yTestUrl <- paste0(testFolder, "y_test.txt")
yTest <- read.table(yTestUrl, stringsAsFactors=FALSE)

#Remove features not needed PART OF STEP 2
test <- xTest[, requiredIndexes]
colnames(test) <- requiredFeatures
colnames(subjectTest) <- c("subject")
colnames(yTest) <- c("activity")
test <- cbind(test, subjectTest, yTest)

#Create the dataset just upto step 4 i.e. without taking mean
mergedDataset <- rbind(training, test)

###### STEP 1 ENDS HERE ######

###### STEP 4 STARTS HERE ######
for(i in seq_along(activityNames[,1])) {
       activityClassLabel <- activityNames[i, 1]
       activityLabel <- activityNames[i, 2]
       mergedDataset$activity[mergedDataset$activity == activityClassLabel] <- activityLabel
}
###### STEP 4 STOPS HERE ######

###### STEP 5 STARTS HERE ######
#Split the dataset by subject and activity and generate colMeans for them
subjectFactor <- as.factor(mergedDataset$subject)
activityFactor <- as.factor(mergedDataset$activity)
splitDataset <- split(mergedDataset, list(activityFactor, subjectFactor))

totalColumns <- dim(mergedDataset)[2]
resultDataFrame <- data.frame(matrix(0, nrow=length(splitDataset), ncol=totalColumns - 1), matrix("", nrow=length(splitDataset), ncol=1))
colnames(resultDataFrame) <- colnames(mergedDataset)
resultDataFrame$activity <- as.character(resultDataFrame$activity)

#Found loop easy to understand so didn't use any apply function
for(i in seq_along(splitDataset)) {
        #get Values for this subject and activity
        values <- splitDataset[[i]]
        if(ncol(values) > 0) {
                activity = values[1,]$activity
                subject = values[1, ]$subject
                resultDataFrame[i, ]$activity <- activity
                resultDataFrame[i, ]$subject <- subject
                resultDataFrame[i, 1:(totalColumns - 2)] <- colMeans(values[, 1:66])
        }
}
#Sorting the result so first result is sorted by activity and then subject
resultDataFrame <- resultDataFrame[order(resultDataFrame$activity,resultDataFrame$subject ),]
save(resultDataFrame, file=paste0("data/", "tidyDataset.RData"))
#Writing the Result Back
write.csv(resultDataFrame, file=paste0("data/", "tidyDataset.csv"), quote = FALSE, row.names=FALSE)
write.table(resultDataFrame, file=paste0("data/", "tidyDataset.txt"), sep= ",", quote=FALSE, , row.names=FALSE)
###### STEP 5 STARTS HERE ######
