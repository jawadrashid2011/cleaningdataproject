# CodeBook - Human Activity Recognition Using Smartphones 
### Created By Jawad Rashid


## About the data
The data used is from this site http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and i used the url https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip to download the data with all the needed files. 

You can read more details about the project in the links above but basically this data was originally recorded from 30 subjects using the gyroscope and the embedded accelerator on Samsung Galaxy S II. Six activities for each subject were recorded. More detail is in README.txt and features_info.txt in the data folder of the links above.

The original dataset contained 561 features of the readings. Each readings was derived using the original gyroscope and accelerator data by doing different transformations. More information about the type of data will be provided in **About the Variables** section. You can read more about the transformation to the original data and variable selection i did in the following **Study Design & Transoformations** section.

## Study Design & Transformations
Out of the 561 features i selected only the min() and std() values of the variables. Which resulted in total of 66 features. The features list names was read in from features.txt and i used regular expression to only select those values which had mean() and std() in the names to filter out all other values. 
Following is the list of **transformations** what was made to the names of the features to make them more readable.

* The features names were **NOT** transformed into all lowercase as i wanted to keep as much information from the original name in the final name and as the names of the features were very descriptive but very long with multiple words making characters lowercase made the features difficult to read so i made other transformations but decided to use camel case to make the names more readable.
* In the original variable names had prefix t or f for time or frequency measurements. I converted these t or f in the beginning to time or frequency to make it more visible what kind of reading it is.
* I removed mean() and std() to mean and standard deviation removing the brakets to make the variable more readable. Std was renamed to standarddeviation to make it more easier to understand what it means.
* Some readings had -x, -y or -z suffix to denote that they represent the x, y and z readings for a variable so i renamed them into xAxis, yAxis and zAxis to make it clear that these are the three positional reading along an axis.
* Acc, gyro and mag were used in the original dataset to denote accelerator, gyroscope and magnitude respectively so i renamed these terms into equivalent terms to make it clear what is the reading is about.
* There were very few readings which had bodybody twice so removed that duplication.
* Also made all words in the name camel case to make it clear what the variable measures.

One thing to note is that in the original dataset there were multiple readings for a single unique set of subject and activity but in the final dataset for each set of activity, subject pair the mean of each variable was taken to reduce the dataset. As there were 30 subjects and 6 activities there were a total of 180 rows in the final dataset. 

Also, the activities, subjects were present in different files as the measurements. So these all were loaded in R and a single dataset was created with 66 measuredments and 2 columsn for subject and activity.

In the original dataset the activities were resepresented by a number from 1-6. The actual activity names were saved in another file. So that file was read in R and those number were replaced by the activity names instead.

Also the activity names were converted to lowercase and underscore, dashes removed. 

The original dataset was broken into test and train with 30% and 70% partition. In the final dataset these two dataset were merged into a single dataset with all rows from test and train dataset.




## About the Variables
### Naming the variables
There has been already a detailed discussion about the variable names and the measurements in the previous section here i will start out with some terms which will come up in variable names so it is understood what each term means.

* If the variables started with time prefix it means this reading is taken using time domain signales at a constant rate of 50 HZ. Then filter were applied to remove noise.
* Some variables start with prefix frequency to denote that Fast Fourier Transform (FFT) was applied to these varaibles.
* Acceleration there were three types of accerometer readings body, gravity and total acceleration which made some calculation on the acceleration. (body, acceleration, total)
* Body linear acceleration and angular velocity were used   in time to obtain jerk signals. (timeBodyJerk…)
* The magnitude of these three-dimensional signals were calculated using the Euclidean norm (timeBodyJerkMagnitude…)
* Gyro is used to denote gyroscope readings.
* xAxis, yAxis, zAxis is used to denote 3-axial signals in the X, Y and Z directions. 
* Also mean and standarddeviation in the name denote that mean and std readings were taken for the signals.
* Finally in the final dataset the mean/average of all the measurements for each variable for a given subject and activity was taken to generate a single record.
### Variables List and details
Following is the list of the variables:
 1. "timeBodyAccelerationMeanXAxis" - time domain Body Acceleration Mean value for X Axis.                     
 2. "timeBodyAccelerationMeanYAxis"  - time domain Body Acceleration Mean value for Y Axis.                         
 3. "timeBodyAccelerationMeanZAxis"    - time domain Body Acceleration Mean value for Z Axis.                       
 4. "timeBodyAccelerationStandardDeviationXAxis"   - time domain Body Acceleration Standard Deviation value for X Axis.           
 5. "timeBodyAccelerationStandardDeviationYAxis"    - time domain Body Acceleration Standard Deviation value for y Axis.                       
 6. "timeBodyAccelerationStandardDeviationZAxis"     - time domain Body Acceleration Standard Deviation value for Z Axis.                      
 7. "timeGravityAccelerationMeanXAxis"      - time domain Body Gravity Acceleration Mean value for X Axis.                               
 8. "timeGravityAccelerationMeanYAxis"    - time domain Body Gravity Acceleration Mean value for Y Axis.                     
 [9] "timeGravityAccelerationMeanZAxis"  - time domain Body Gravity Acceleration Mean value for Z Axis.                       
[10] "timeGravityAccelerationStandardDeviationXAxis"  - time domain Body Gravity Acceleration Standard Deviation value for X Axis.          
[11] "timeGravityAccelerationStandardDeviationYAxis"  - time domain Body Gravity Acceleration Standard Deviation value for Y Axis.         
[12] "timeGravityAccelerationStandardDeviationZAxis" - time domain Body Gravity Acceleration Standard Deviation value for Z Axis.          
[13] "timeBodyAccelerationJerkMeanXAxis"                      
[14] "timeBodyAccelerationJerkMeanYAxis"                      
[15] "timeBodyAccelerationJerkMeanZAxis"                      
[16] "timeBodyAccelerationJerkStandardDeviationXAxis"         
[17] "timeBodyAccelerationJerkStandardDeviationYAxis"         
[18] "timeBodyAccelerationJerkStandardDeviationZAxis"         
[19] "timeBodyGyroscopeMeanXAxis"                             
[20] "timeBodyGyroscopeMeanYAxis"                             
[21] "timeBodyGyroscopeMeanZAxis"                             
[22] "timeBodyGyroscopeStandardDeviationXAxis"                
[23] "timeBodyGyroscopeStandardDeviationYAxis"                
[24] "timeBodyGyroscopeStandardDeviationZAxis"                
[25] "timeBodyGyroscopeJerkMeanXAxis"                         
[26] "timeBodyGyroscopeJerkMeanYAxis"                         
[27] "timeBodyGyroscopeJerkMeanZAxis"                         
[28] "timeBodyGyroscopeJerkStandardDeviationXAxis"            
[29] "timeBodyGyroscopeJerkStandardDeviationYAxis"            
[30] "timeBodyGyroscopeJerkStandardDeviationZAxis"            
[31] "timeBodyAccelerationMagnitudeMean"                      
[32] "timeBodyAccelerationMagnitudeStandardDeviation"         
[33] "timeGravityAccelerationMagnitudeMean"                   
[34] "timeGravityAccelerationMagnitudeStandardDeviation"      
[35] "timeBodyAccelerationJerkMagnitudeMean"                  
[36] "timeBodyAccelerationJerkMagnitudeStandardDeviation"     
[37] "timeBodyGyroscopeMagnitudeMean"                         
[38] "timeBodyGyroscopeMagnitudeStandardDeviation"            
[39] "timeBodyGyroscopeJerkMagnitudeMean"                     
[40] "timeBodyGyroscopeJerkMagnitudeStandardDeviation"        
[41] "frequencyBodyAccelerationMeanXAxis"                     
[42] "frequencyBodyAccelerationMeanYAxis"                     
[43] "frequencyBodyAccelerationMeanZAxis"                     
[44] "frequencyBodyAccelerationStandardDeviationXAxis"        
[45] "frequencyBodyAccelerationStandardDeviationYAxis"        
[46] "frequencyBodyAccelerationStandardDeviationZAxis"        
[47] "frequencyBodyAccelerationJerkMeanXAxis"                 
[48] "frequencyBodyAccelerationJerkMeanYAxis"                 
[49] "frequencyBodyAccelerationJerkMeanZAxis"                 
[50] "frequencyBodyAccelerationJerkStandardDeviationXAxis"    
[51] "frequencyBodyAccelerationJerkStandardDeviationYAxis"    
[52] "frequencyBodyAccelerationJerkStandardDeviationZAxis"    
[53] "frequencyBodyGyroscopeMeanXAxis"                        
[54] "frequencyBodyGyroscopeMeanYAxis"                        
[55] "frequencyBodyGyroscopeMeanZAxis"                        
[56] "frequencyBodyGyroscopeStandardDeviationXAxis"           
[57] "frequencyBodyGyroscopeStandardDeviationYAxis"           
[58] "frequencyBodyGyroscopeStandardDeviationZAxis"           
[59] "frequencyBodyAccelerationMagnitudeMean"                 
[60] "frequencyBodyAccelerationMagnitudeStandardDeviation"    
[61] "frequencyBodyAccelerationJerkMagnitudeMean"             
[62] "frequencyBodyAccelerationJerkMagnitudeStandardDeviation"
[63] "frequencyBodyGyroscopeMagnitudeMean"                    
[64] "frequencyBodyGyroscopeMagnitudeStandardDeviation"       
[65] "frequencyBodyGyroscopeJerkMagnitudeMean"                
[66] "frequencyBodyGyroscopeJerkMagnitudeStandardDeviation"   
[67] "subject"                                                
[68] "activity"           



