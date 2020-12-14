library(tidyverse)

setwd("~/Coursera/ DataCleaning")

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


# read subject_train, subject_test
# rename X1 to subject_id
subj_train <-
        read_delim(paste0(file.path(getwd(), "train", "subject_train.txt")),
                   delim = " ",
                   col_names = "subject_id")

subj_test <-
        read_delim(paste0(file.path(getwd(), "test", "subject_test.txt")),
                   delim = " ",
                   col_names = "subject_id")

# read y_train, y_test
# create surrogate keys, then add subject_id, activity id and label

y_train <-
        read_delim(paste0(file.path(getwd(), "train", "y_train.txt")),
                   delim = " ",
                   col_names = FALSE)
y_train <- rowid_to_column(y_train, var = "run_id") %>%
        mutate(activity = activity_labels$activity[match(X1, activity_labels$activity_id)]) %>%
        rename(activity_id = X1)
y_train <-
        y_train %>% add_column(subject_id = subj_train$subject_id, .after = y_train$run_id)

y_test <-
        read_delim(paste0(file.path(getwd(), "test", "y_test.txt")),
                   delim = " ",
                   col_names = FALSE)
y_test <- rowid_to_column(y_test, var = "run_id") %>%
        mutate(activity = activity_labels$activity[match(X1, activity_labels$activity_id)]) %>%
        rename(activity_id = X1)
y_test <-
        y_test %>% add_column(subject_id = subj_test$subject_id, .after = y_test$run_id)


# read X_train, X_test with feature labels as column names
# join with activity labels
# add variable to flag origin as train or

X_train <-
        read_table2(paste0(file.path(getwd(), "train", "X_train.txt")),
                    col_names = t(feature_labels[2]))
X_train <-
        select(X_train, any_of(grep("-mean()|-std()", colnames(X_train))))
X_train <- bind_cols(y_train, X_train)
X_train <- mutate(X_train, train_test = "train")

X_test <-
        read_table2(paste0(file.path(getwd(), "test", "X_test.txt")),
                    col_names = t(feature_labels[2]))
X_test <-
        select(X_test, any_of(grep("-mean()|-std()", colnames((
                X_test
        )))))
X_test <- bind_cols(y_test, X_test)
X_test <- mutate(X_test, train_test = "test")

X_combined <- bind_rows(X_train, X_test)

# You should create one R script called run_analysis.R that does the following.

# 1. Merges the training and the test sets to create one data set.
# add test/train flags before merging

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# contains "mean()" and "std()"

# 3. Uses descriptive activity names to name the activities in the data set
# activity labels with ID

# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
