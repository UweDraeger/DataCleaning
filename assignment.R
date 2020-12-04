

library(tidyverse)

setwd(
        "~/Coursera/Scripts and Data/Getting and Cleaning Data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset"
)

# read activity labels
activity_labels <-
        read_delim(
                "activity_labels.txt",
                delim = " ",
                col_names = c("activity_id", "activity")
        )

# read feature labels
feature_labels <-
        read_delim("features.txt",
                   delim = " ",
                   col_names = c("feature_id", "feature"))


# read subject_train, subject_test - Do I need those as analysis focused on mean and std?
subj_train <-
        read_delim(
                paste0(file.path(getwd(), "train", "subject_train.txt")),
                delim = " ",
                col_names = FALSE
        )
subj_test <-
        read_delim(
                paste0(file.path(getwd(), "test", "subject_test.txt")),
                delim = " ",
                col_names = FALSE
        )

# read y_train, y_test
# create surrogate keys, then join the activity labels
y_train <-
        read_delim(
                paste0(file.path(getwd(), "train", "y_train.txt")),
                delim = " ",
                col_names = FALSE
        )
y_train <- rowid_to_column(y_train, var = "y_id") %>% 
        mutate(activity = activity_labels$activity[match(X1, activity_labels$activity_id)])
y_test <-
        read_delim(
                paste0(file.path(getwd(), "test", "y_test.txt")),
                delim = " ",
                col_names = FALSE
        )
y_test <- rowid_to_column(y_test, var = "y_id") %>% 
        mutate(activity = activity_labels$activity[match(X1, activity_labels$activity_id)])

# read X_train, X_test - Do I need to care for NA's - problems(X-test)?
# assumes same order when extracting column names of feature, which seems 
# logical 
X_train <-
        read_delim(
                paste0(file.path(getwd(), "train", "X_train.txt")),
                delim = " ",
                col_names = t(feature_labels[2])
        )
X_test <-
        read_delim(
                paste0(file.path(getwd(), "test", "X_test.txt")),
                delim = " ",
                col_names = t(feature_labels[2])
        )

body_acc_x_train <- 
        read_delim(
                paste0(file.path(getwd(), "train", "Inertial Signals", "body_acc_x_train.txt")),
                delim = " ",
                col_names = FALSE
        )
body_acc_x_test <- 
        read_delim(
                paste0(file.path(getwd(), "test", "Inertial Signals", "body_acc_x_test.txt")),
                delim = " ",
                col_names = FALSE
        )

# You should create one R script called run_analysis.R that does the following.

# 1. Merges the training and the test sets to create one data set.
# add test/train flags before merging

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# contains "mean()" and "std()"

# 3. Uses descriptive activity names to name the activities in the data set
# activity labels with ID

# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
