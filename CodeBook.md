CodeBook for "Human Activity Recognition Using Smartphones Dataset"
=========================================
Getting and Cleaning Data Course Project
_________________________________________
#### CodeBook purpose: This file indicates all the variables and summaries calculated, along with units, and any other relevant information. This includes transformations and modifications to the data. The contents of the "features_info.txt" has been included at the end of the file because it contains relevant information about the variables measured. 

Data can be accessed at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


The run_analysis.R script modfies the data in the following ways:  

1. It combines y_train.txt with y_test.txt to yeild a data frame (called Y_df) that has the dimensions 10299 x 1 listing the number of instances and the activity IDs, respectively. Activity IDs have values from 1 to 6. 

2. It combines X_train.txt with X_test.txt to yeild a data frame (called X_df) that has the diminsions 10299 x 561 which respresent the number of instances and the number of feature variables, respectively. Feature variables are normalized and bounded to values from -1 to 1.    

3. It combines subject_train.txt with subject_test.txt to yeild a data frame (called subject) that has the dimensions 10299 x 1 listing the number of instances and subject IDs, respectively. Subject IDs have values from 1 to 30. The label subjectID is added to the subject data frame.     

4. From the file features.txt, it extracts only feature variable names containing the mean and standard deviation (in the following format: -mean() or -std() ).   

5. It subsets the X_df data frame with only feature names containing the mean and standard deviation into a new X_df data frame with the dimensions 10299 x 66 with values. Labels in this data frame are formatted to lower case letters and the parentheses removed.     

6. Activity labels found in activity_labels.txt are formatted to lower case letters and underscores are removed. These tidier activity labels (walking, walkingupstairs, walkingdownstairs, sitting, standing and laying) are applied to the Y_df. The label activity is added to Y_df.    

7. The properly labeled subject, Y_df and X_df data frames are combined using the cbind function to yeild a data frame with the dimensions 10299 x 68 called combined. This table begins with the subject IDs in the first column, activity names listed in part 6 in the second column and 66 columns of feature names in the general format: feature-mean-x, feature-std-y, etc.     

8. The combined data frame is passed to a function that melts and recasts the data. During the recasting, the average of each feature value is calculated for each subject and each activity. A new data frame called tidy is created with the results of this function that has dimensions of 180 x 68. The first column is labeled subjectID, the second is labeled activity followed by the average for each feature variable in the last 66 columns.     

9. After passing the data through this function, the activity factors are in a different order. Hence, they are reordered to the original order found in activity_labels.txt and then the data frame is ordered first by subject and then by the factor order.     

10. Lastly, a file called tidy_data_with_averages.txt is written that contains the data frame named tidy.



Feature Selection 
=================

#### From feature_info.txt

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
