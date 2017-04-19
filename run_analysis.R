# Clean up workspace
rm(list=ls())

# 1. Merge the training and the test sets to create one data set.

#set working directory to the location where the UCI HAR Dataset was unzipped
setwd('/Users/letsdodata/Documents/coursera/Clean/data/UCI HAR Dataset/');

# Reading trainings tables:
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

# Reading testing tables:
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

# Reading feature vector:
features <- read.table('./features.txt')

# Reading activity labels:
activityLabels = read.table('./activity_labels.txt')

# asssign colnames
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

# merging datasets
all_train <- cbind(y_train, subject_train, x_train)
all_test <- cbind(y_test, subject_test, x_test)
all_train_test <- rbind(all_train, all_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

colNames <- colnames(all_train_test)

logic_vector <- (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))

select_train_test <- all_train_test[ , logic_vector == TRUE]


# 3. Uses descriptive activity names to name the activities in the data set

withnames_train_test <- merge(select_train_test, activityLabels, by='activityId', all.x=TRUE)

# 4. Appropriately labels the data set with descriptive variable names
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

final_dataset <- aggregate(. ~ subjectId + activityId, withnames_train_test, mean)

write.table(final_dataset, "tidy_set.txt", row.name=FALSE)