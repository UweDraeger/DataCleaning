library(tidyverse)

# read activity labels
activity_labels <- read_delim("activity_labels.txt",
                delim = " ",
                col_names = c("activity_id", "activity"))

# read feature labels
feature_labels <- read_delim("features.txt",
                delim = " ",
                col_names = c("feature_id", "feature"))


# read subject_train, subject_test
subj_train <- read_delim(paste0(file.path(getwd(), "train", "subject_train.txt")),
                delim = " ",
                col_names = "subject_id")

subj_test <- read_delim(paste0(file.path(getwd(), "test", "subject_test.txt")),
                delim = " ",
                col_names = "subject_id")

# read y_train, y_test
# create surrogate keys, then add subject_id, activity id and label

y_train <-  read_delim(paste0(file.path(getwd(), "train", "y_train.txt")),
                delim = " ",
                col_names = FALSE)

y_train <- rowid_to_column(y_train, var = "run_id") %>%
        mutate(activity = activity_labels$activity[match(X1, activity_labels$activity_id)]) %>%
        rename(activity_id = X1)

y_train <- y_train %>% 
        add_column(subject_id = subj_train$subject_id, .after = y_train$run_id)


y_test <- read_delim(paste0(file.path(getwd(), "test", "y_test.txt")),
                delim = " ",
                col_names = FALSE)

y_test <- rowid_to_column(y_test, var = "run_id") %>%
        mutate(activity = activity_labels$activity[match(X1, activity_labels$activity_id)]) %>%
        rename(activity_id = X1)

y_test <- y_test %>%
        add_column(subject_id = subj_test$subject_id, .after = y_test$run_id)


# read X_train, X_test with feature labels as column names
# join with activity labels
# add variable to flag origin as train or

X_train <- read_table2(paste0(file.path(getwd(), "train", "X_train.txt")),
                col_names = t(feature_labels[2]))

X_train <- select(X_train, any_of(grep("-mean()|-std()", colnames(X_train))))

X_train <- bind_cols(y_train, X_train)

X_train <- mutate(X_train, train_test = "train")


X_test <- read_table2(paste0(file.path(getwd(), "test", "X_test.txt")),
                col_names = t(feature_labels[2]))

X_test <- select(X_test, any_of(grep("-mean()|-std()", colnames((X_test)))))

X_test <- bind_cols(y_test, X_test)

X_test <- mutate(X_test, train_test = "test")

X_combined <- bind_rows(X_train, X_test)

# data set with  average of each variable for each activity and each subject
subj_activity_avg <- X_combined %>% 
        group_by(activity, subject_id) %>% 
        summarise(avg_tBodyAcc_mean_X = mean(`tBodyAcc-mean()-X`),
                avg_tBodyAcc_mean_Y = mean(`tBodyAcc-mean()-Y`),
                avg_tBodyAcc_mean_Z = mean(`tBodyAcc-mean()-Z`),
                avg_tBodyAcc_std_X = mean(`tBodyAcc-std()-X`),
                avg_tBodyAcc_std_Y = mean(`tBodyAcc-std()-Y`),
                avg_tBodyAcc_std_Z = mean(`tBodyAcc-std()-Z`),
                avg_tGravityAcc_mean_X = mean(`tGravityAcc-mean()-X`),
                avg_tGravityAcc_mean_Y = mean(`tGravityAcc-mean()-Y`),
                avg_tGravityAcc_mean_Z = mean(`tGravityAcc-mean()-Z`),
                avg_tGravityAcc_std_X = mean(`tGravityAcc-std()-X`),
                avg_tGravityAcc_std_Y = mean(`tGravityAcc-std()-Y`),
                avg_tGravityAcc_std_Z = mean(`tGravityAcc-std()-Z`),
                avg_tBodyAccJerk_mean_X = mean(`tBodyAccJerk-mean()-X`),
                avg_tBodyAccJerk_mean_Y = mean(`tBodyAccJerk-mean()-Y`),
                avg_tBodyAccJerk_mean_Z = mean(`tBodyAccJerk-mean()-Z`),
                avg_tBodyAccJerk_std_X = mean(`tBodyAccJerk-std()-X`),
                avg_tBodyAccJerk_std_Y = mean(`tBodyAccJerk-std()-Y`),
                avg_tBodyAccJerk_std_Z = mean(`tBodyAccJerk-std()-Z`),
                avg_tBodyGyro_mean_X = mean(`tBodyGyro-mean()-X`),
                avg_tBodyGyro_mean_Y = mean(`tBodyGyro-mean()-Y`),
                avg_tBodyGyro_mean_Z = mean(`tBodyGyro-mean()-Z`),
                avg_tBodyGyro_std_X = mean(`tBodyGyro-std()-X`),
                avg_tBodyGyro_std_Y = mean(`tBodyGyro-std()-Y`),
                avg_tBodyGyro_std_Z = mean(`tBodyGyro-std()-Z`),
                avg_tBodyGyroJerk_mean_X = mean(`tBodyGyroJerk-mean()-X`),
                avg_tBodyGyroJerk_mean_Y = mean(`tBodyGyroJerk-mean()-Y`),
                avg_tBodyGyroJerk_mean_Z = mean(`tBodyGyroJerk-mean()-Z`),
                avg_tBodyGyroJerk_std_X = mean(`tBodyGyroJerk-std()-X`),
                avg_tBodyGyroJerk_std_Y = mean(`tBodyGyroJerk-std()-Y`),
                avg_tBodyGyroJerk_std_Z = mean(`tBodyGyroJerk-std()-Z`),
                avg_tBodyAccMag_mean = mean(`tBodyAccMag-mean()`),
                avg_tBodyAccMag_std = mean(`tBodyAccMag-std()`),
                avg_tGravityAccMag_mean = mean(`tGravityAccMag-mean()`),
                avg_tGravityAccMag_std = mean(`tGravityAccMag-std()`),
                avg_tBodyAccJerkMag_mean = mean(`tBodyAccJerkMag-mean()`),
                avg_tBodyAccJerkMag_std = mean(`tBodyAccJerkMag-std()`),
                avg_tBodyGyroMag_mean = mean(`tBodyGyroMag-mean()`),
                avg_tBodyGyroMag_std = mean(`tBodyGyroMag-std()`),
                avg_tBodyGyroJerkMag_mean = mean(`tBodyGyroJerkMag-mean()`),
                avg_tBodyGyroJerkMag_std = mean(`tBodyGyroJerkMag-std()`),
                avg_fBodyAcc_mean_X = mean(`fBodyAcc-mean()-X`),
                avg_fBodyAcc_mean_Y = mean(`fBodyAcc-mean()-Y`),
                avg_fBodyAcc_mean_Z = mean(`fBodyAcc-mean()-Z`),
                avg_fBodyAcc_std_X = mean(`fBodyAcc-std()-X`),
                avg_fBodyAcc_std_Y = mean(`fBodyAcc-std()-Y`),
                avg_fBodyAcc_std_Z = mean(`fBodyAcc-std()-Z`),
                avg_fBodyAcc_meanFreq_X = mean(`fBodyAcc-meanFreq()-X`),
                avg_fBodyAcc_meanFreq_Y = mean(`fBodyAcc-meanFreq()-Y`),
                avg_fBodyAcc_meanFreq_Z = mean(`fBodyAcc-meanFreq()-Z`),
                avg_fBodyAccJerk_mean_X = mean(`fBodyAccJerk-mean()-X`),
                avg_fBodyAccJerk_mean_Y = mean(`fBodyAccJerk-mean()-Y`),
                avg_fBodyAccJerk_mean_Z = mean(`fBodyAccJerk-mean()-Z`),
                avg_fBodyAccJerk_std_X = mean(`fBodyAccJerk-std()-X`),
                avg_fBodyAccJerk_std_Y = mean(`fBodyAccJerk-std()-Y`),
                avg_fBodyAccJerk_std_Z = mean(`fBodyAccJerk-std()-Z`),
                avg_fBodyAccJerk_meanFreq_X = mean(`fBodyAccJerk-meanFreq()-X`),
                avg_fBodyAccJerk_meanFreq_Y = mean(`fBodyAccJerk-meanFreq()-Y`),
                avg_fBodyAccJerk_meanFreq_Z = mean(`fBodyAccJerk-meanFreq()-Z`),
                avg_fBodyGyro_mean_X = mean(`fBodyGyro-mean()-X`),
                avg_fBodyGyro_mean_Y = mean(`fBodyGyro-mean()-Y`),
                avg_fBodyGyro_mean_Z = mean(`fBodyGyro-mean()-Z`),
                avg_fBodyGyro_std_X = mean(`fBodyGyro-std()-X`),
                avg_fBodyGyro_std_Y = mean(`fBodyGyro-std()-Y`),
                avg_fBodyGyro_std_Z = mean(`fBodyGyro-std()-Z`),
                avg_fBodyGyro_meanFreq_X = mean(`fBodyGyro-meanFreq()-X`),
                avg_fBodyGyro_meanFreq_Y = mean(`fBodyGyro-meanFreq()-Y`),
                avg_fBodyGyro_meanFreq_Z = mean(`fBodyGyro-meanFreq()-Z`),
                avg_fBodyAccMag_mean = mean(`fBodyAccMag-mean()`),
                avg_fBodyAccMag_std = mean(`fBodyAccMag-std()`),
                avg_fBodyAccMag_meanFreq = mean(`fBodyAccMag-meanFreq()`),
                avg_fBodyBodyAccJerkMag_mean = mean(`fBodyBodyAccJerkMag-mean()`),
                avg_fBodyBodyAccJerkMag_std = mean(`fBodyBodyAccJerkMag-std()`),
                avg_fBodyBodyAccJerkMag_meanFreq = mean(`fBodyBodyAccJerkMag-meanFreq()`),
                avg_fBodyBodyGyroMag_mean = mean(`fBodyBodyGyroMag-mean()`),
                avg_fBodyBodyGyroMag_std = mean(`fBodyBodyGyroMag-std()`),
                avg_fBodyBodyGyroMag_meanFreq = mean(`fBodyBodyGyroMag-meanFreq()`),
                avg_fBodyBodyGyroJerkMag_mean = mean(`fBodyBodyGyroJerkMag-mean()`),
                avg_fBodyBodyGyroJerkMag_std = mean(`fBodyBodyGyroJerkMag-std()`),
                avg_fBodyBodyGyroJerkMag_meanFreq = mean(`fBodyBodyGyroJerkMag-meanFreq()`))

# save result
write_delim(subj_activity_avg, "subj_activity_avg.txt")

