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
 7. "timeGravityAccelerationMeanXAxis"      - time domain  Gravity Acceleration Mean value for X Axis.                               
 8. "timeGravityAccelerationMeanYAxis"    - time domain  Gravity Acceleration Mean value for Y Axis.                     
 9. "timeGravityAccelerationMeanZAxis"  - time domain  Gravity Acceleration Mean value for Z Axis.                   
 10. "timeGravityAccelerationStandardDeviationXAxis"  - time domain Gravity Acceleration Standard Deviation value for X Axis.          
 11. "timeGravityAccelerationStandardDeviationYAxis"  - time domain Gravity Acceleration Standard Deviation value for Y Axis.         
 12. "timeGravityAccelerationStandardDeviationZAxis" - time domain Gravity Acceleration Standard Deviation value for Z Axis.          
 13. "timeBodyAccelerationJerkMeanXAxis"   - time domain Body Acceleration Jerk Mean value for X Axis.                   
14. "timeBodyAccelerationJerkMeanYAxis"  - time domain Body Acceleration Jerk Mean value for Y Axis.                     
15. "timeBodyAccelerationJerkMeanZAxis"  - time domain Body Acceleration Jerk Mean value for Z Axis.                     
16. "timeBodyAccelerationJerkStandardDeviationXAxis" - time domain Body Acceleration Jerk Standard Deviation value for X Axis.         
17. "timeBodyAccelerationJerkStandardDeviationYAxis" - time domain Body Acceleration Jerk Standard Deviation value for X Axis.         
18. "timeBodyAccelerationJerkStandardDeviationZAxis" - time domain Body Acceleration Jerk Standard Deviation value for X Axis.         
19. "timeBodyGyroscopeMeanXAxis"  - time domain Body Gyroscope  Mean value for X Axis.                            
20. "timeBodyGyroscopeMeanYAxis" - time domain Body Gyroscope  Mean value for Y Axis.                               
21. "timeBodyGyroscopeMeanZAxis"    - time domain Body Gyroscope  Mean value for Z Axis.                            
22. "timeBodyGyroscopeStandardDeviationXAxis"  - time domain Body Gyroscope  Standard Deviation value for X Axis.                 
23. "timeBodyGyroscopeStandardDeviationYAxis"     - time domain Body Gyroscope  Standard Deviation value for Y Axis.            
24. "timeBodyGyroscopeStandardDeviationZAxis"  - time domain Body Gyroscope  Standard Deviation value for Z Axis.               
25. "timeBodyGyroscopeJerkMeanXAxis"   - time domain Body Gyroscope  Jerk Mean value for X Axis.                       
26. "timeBodyGyroscopeJerkMeanYAxis" - time domain Body Gyroscope  Jerk Mean value for Y Axis.                          
27. "timeBodyGyroscopeJerkMeanZAxis"  - time domain Body Gyroscope  Jerk Mean value for Z Axis.                         
28. "timeBodyGyroscopeJerkStandardDeviationXAxis" - time domain Body Gyroscope  Jerk Standard Deviation value for X Axis.             
29. "timeBodyGyroscopeJerkStandardDeviationYAxis"   - time domain Body Gyroscope  Jerk Standard Deviation value for Y Axis.         
30. "timeBodyGyroscopeJerkStandardDeviationZAxis" - time domain Body Gyroscope  Jerk Standard Deviation value for Z Axis.           
31. "timeBodyAccelerationMagnitudeMean" - time domain Body  Acceleation Magnitude Mean value.                     
32. "timeBodyAccelerationMagnitudeStandardDeviation"- time domain Body  Acceleation Magnitude Standard Deviation value.          
33. "timeGravityAccelerationMagnitudeMean"   - time domain Gravity Acceleation Magnitude Mean value.                
34. "timeGravityAccelerationMagnitudeStandardDeviation"  - time domain Gravity Acceleation Magnitude Standard Deviation value.      
35. "timeBodyAccelerationJerkMagnitudeMean"   - time domain Body Acceleation Jerk Magnitude Mean value.                 
36. "timeBodyAccelerationJerkMagnitudeStandardDeviation"      - time domain Body Acceleation Jerk Magnitude Standard Deviation value. 
37. "timeBodyGyroscopeMagnitudeMean"   - time domain Body Gyroscope  Magnitude Mean value.                        
38. "timeBodyGyroscopeMagnitudeStandardDeviation"  - time domain Body Gyroscope  Magnitude Standard Deviation value.                
39. "timeBodyGyroscopeJerkMagnitudeMean"  - time domain Body Gyroscope Jerk  Magnitude Mean value.                         
40. "timeBodyGyroscopeJerkMagnitudeStandardDeviation" - time domain Body Gyroscope Jerk Magnitude Standard Deviation value.          
41. "frequencyBodyAccelerationMeanXAxis"  - frequency domain Body Acceleration Mean value for X Axis.                         
42. "frequencyBodyAccelerationMeanYAxis"  - frequency domain Body Acceleration Mean value for Y Axis.                   
43. "frequencyBodyAccelerationMeanZAxis"   - frequency domain Body Acceleration Mean value for Z Axis.                  
44. "frequencyBodyAccelerationStandardDeviationXAxis" - frequency domain Body Acceleration Standard Deviation value for X Axis.       
45. "frequencyBodyAccelerationStandardDeviationYAxis"  - frequency domain Body Acceleration Standard Deviation value for Y Axis.      
46. "frequencyBodyAccelerationStandardDeviationZAxis"- frequency domain Body Acceleration Standard Deviation value for Z Axis.        
47. "frequencyBodyAccelerationJerkMeanXAxis"  - frequency domain Body Acceleration Jerk Mean value for X Axis.               
48. "frequencyBodyAccelerationJerkMeanYAxis" - frequency domain Body Acceleration Jerk Mean value for Y Axis.                 
49. "frequencyBodyAccelerationJerkMeanZAxis" - frequency domain Body Acceleration Jerk Mean value for Z Axis.                 
50. "frequencyBodyAccelerationJerkStandardDeviationXAxis" - frequency domain Body Acceleration Jerk Standard Deviaton value for X Axis.    
51. "frequencyBodyAccelerationJerkStandardDeviationYAxis" - frequency domain Body Acceleration Jerk Standard Deviaton value for Y Axis.    
52. "frequencyBodyAccelerationJerkStandardDeviationZAxis"- frequency domain Body Acceleration Jerk Standard Deviaton value for Z Axis.     
53. "frequencyBodyGyroscopeMeanXAxis"   - frequency domain Body Gyroscope Mean value for X Axis.                      
54. "frequencyBodyGyroscopeMeanYAxis"   - frequency domain Body Gyroscope Mean value for Y Axis.                         
55. "frequencyBodyGyroscopeMeanZAxis"   - frequency domain Body Gyroscope Mean value for Z Axis.                         
56. "frequencyBodyGyroscopeStandardDeviationXAxis" - frequency domain Body Gyroscope Standard deviation value for X Axis.              
57. "frequencyBodyGyroscopeStandardDeviationYAxis"   - frequency domain Body Gyroscope Standard deviation value for Y Axis.        
58. "frequencyBodyGyroscopeStandardDeviationZAxis" - frequency domain Body Gyroscope Standard deviation value for Z Axis.          
59. "frequencyBodyAccelerationMagnitudeMean"   - frequency domain Body Acceleraton Magnitude Mean value.              
60. "frequencyBodyAccelerationMagnitudeStandardDeviation"     - frequency domain Body Acceleraton Magnitude Standard Deviation value. 
61. "frequencyBodyAccelerationJerkMagnitudeMean"  - frequency domain Body Acceleraton Jerk Magnitude Mean value.             
62. "frequencyBodyAccelerationJerkMagnitudeStandardDeviation" - frequency domain Body Acceleraton Jerk Magnitude Standard Deviation value. 
63. "frequencyBodyGyroscopeMagnitudeMean"    - frequency domain Body Gyroscope Magnitude Mean value.                  
64. "frequencyBodyGyroscopeMagnitudeStandardDeviation"  - frequency domain Body Gyroscope Magnitude Standard Deviation value.       
65. "frequencyBodyGyroscopeJerkMagnitudeMean"  - frequency domain Body Gyroscope Jerk Magnitude Mean value.                
66. "frequencyBodyGyroscopeJerkMagnitudeStandardDeviation"  - frequency domain Body Gyroscope Magnitude Standard Deviation value.   
67. "subject" - subject id for the person for which this data belongs to.                                               
68. "activity"  - activity name.         



