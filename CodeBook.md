=========================================
Peer-graded Assignment: Getting and Cleaning Data Course Project (course 3 of 5 
in the Data Science: Foundations using R Specialization by Johns Hopkins University
Amended from the original authors' version below by
Uwe Draeger
=========================================

Code book

Descriptions of activities performed during the experiements and measures taken (features)

The original description files activity_labels.txt, features.txt are loaded to tibbles "activity_labels" and "feature_labels". Column names are assigned as activity_id, activity and feature_id, feature respectively.
There are six distinct activities and 561 distinct features (variables meaasured in the original study).


Subjects performing the activities in the experiment

The subject assignment files subject_train.txt and subject_test.txt are loaded from the train and test directories to "sub_train" and "subj_test" tibbles. Column names are set to subject_id in both tibbles. The train set contains the subject identifiers for 7352 observations while the test set has the subject identifiers for 2947 observations, i.e. roughly a 70/30 split as mentioned in the original study.


Activities performed in each experiement

The training and test data description files y_train.txt and y_test.txt are loaded from the train and test directories to y_train and y_test tibbles. 
Two additional steps are performed after each load step, first a column labelled run_id is created from the row numbers, the activity_id and activity columns from "activity_labels" is appended, matched by activity_id.  In a last step the subject_id is appended from "subj_test" / "sub_train".
The final result are tibbles containing information who performed which activity in each experiment.


Variable values measured in the experiements 

This four-step process is executed on both data sets for training and test data sequentially.
The data (files X_train.txt and X_test.txt) are loaded to tibbles "X_train" and "X_test". The variable labels (features)  from "feature_lables" are assigned as column names. 
The number of variables is reduced by extracting the mean and standard deviation for each measurement. This step reduces the number of variables from 561 in the original dataset to 79. All other variables from the original study are dropped.
Subject and activity information is added to the the dataset.
For future reference both datasets are amended with a train_test flag indicating their use in the original study in the training or test data sets.
The final result are tibbles "X_train" and "X_test" containing all the means and standard deviation values measured in the original experiemtns and who performed which activity.


Joining training and test data

Training and test datasets ("X_train" and "X-test") are merged into "X_combined".


Creating the final dataset

In a final step a new tidy dataset "subj_activity_avg" is created with the average for each activity and each subject for each of the 79 variables.
Variables are labed by prefixing the feature labels with "avg_". Hyphens ("-") are replaced by underscores ("_") and opening and closing brackets are removed from the variable names.
The dataset is saved to the file subj_activity_avg.txt.


