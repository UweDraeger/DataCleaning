=========================================
Peer-graded Assignment: Getting and Cleaning Data Course Project (course 3 of 5 
in the Data Science: Foundations using R Specialization by Johns Hopkins University
Amended from the original authors' version below by
Uwe Draeger
=========================================




Descriptions of activities performed during the experiments and measures taken (features)

The original description files activity_labels.txt, features.txt are loaded to tibbles "activity_labels" and "feature_labels". Column names are assigned as activity_id, activity and feature_id, feature respectively.
There are six distinct activities and 561 distinct features (variables measured in the original study).


Subjects performing the activities in the experiment

The subject assignment files subject_train.txt and subject_test.txt are loaded from the train and test directories to "sub_train" and "subj_test" tibbles. Column names are set to subject_id in both cases. The train set contains the subject identifiers for 7352 observations while the test set has the subject identifiers for 2947 observations, i.e. roughly a 70/30 split as mentioned in the original study description.


Activities performed in each experiment

The training and test data description files y_train.txt and y_test.txt are loaded from the train and test directories to y_train and y_test tibbles. 
Two additional steps are performed after each load step, first a column labeled run_id is created from the row numbers, the activity_id and activity columns from "activity_labels" are appended, matched by activity_id.  In a last step the subject_id is appended from "subj_test" / "sub_train".
The final result are two tibbles containing information who performed which activity in each experiment.


Variable values measured in the experiments 

This four-step process is executed on both data sets for training and test data sequentially.
The data (files X_train.txt and X_test.txt) are loaded to tibbles "X_train" and "X_test". The variable labels (features)  from "feature_lables" are assigned as column names. 
The number of variables is reduced by selecting only those that refer to  mean or standard deviation of the measurement. This step reduces the number of variables from 561 to 79. All other variables from the original study are dropped.
Subject and activity information is added to the dataset.
For future reference both datasets are amended with a flag (train_test) indicating their use in the training or test datasets.
The final result are tibbles "X_train" and "X_test" containing all the means and standard deviation values measured in the original experiments and who performed that activity.


Joining training and test data

Training and test datasets ("X_train" and "X-test") are merged into "X_combined".


Creating the final dataset

In a final step a new tidy dataset "subj_activity_avg" is created with the average for each activity by each subject for each of the 79 variables.
Variables are labeled by prefixing the feature labels with "avg_". Hyphens ("-") are replaced by underscores ("_") and opening and closing brackets are removed from the variable names.
The dataset is saved to the file subj_activity_avg.txt.


The data can be read back into R by executing
df <- read.delim("subj_activity_avg.txt", header = TRUE, sep = " ")


Additonal information

The results were created with
platform       x86_64-w64-mingw32          
arch           x86_64                      
os             mingw32                     
system         x86_64, mingw32             
status                                     
major          4                           
minor          0.2                         
year           2020                        
month          06                          
day            22                          
svn rev        78730                       
language       R                           
version.string R version 4.0.2 (2020-06-22)


As the project relies on unchanged original data the original README.txt is given below to provide explanation of raw data, variables, and units.

The dataset was retrieved from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


==================================================================
Begin of original study README.txt 

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.