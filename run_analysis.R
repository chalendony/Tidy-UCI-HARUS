require(stringr)
require(dplyr)
require(utils)
require(hashmap)


## read train, test, labels and activity data from files
train  <- tbl_df(read.table("./train/X_train.txt"))
subject_train <- tbl_df(read.table("./train/subject_train.txt"))
label_train <- tbl_df(read.table("./train/y_train.txt"))

test  <- tbl_df(read.table("./test/X_test.txt"))
subject_test <- tbl_df(read.table("./test/subject_test.txt"))
label_test <- tbl_df(read.table("./test/y_test.txt"))


## 1. Merge the taining and the test sets to create one data set.
x  <- bind_rows(train, test)
y  <- bind_rows(label_train, label_test)


## create and apply headers; NOTE some headers are duplicated
features  <- tbl_df(read.table("./features.txt", stringsAsFactors = FALSE))
headers <- make.unique(gsub(pattern = "\\-|\\,|\\(|\\)", "", stringr::str_to_lower(features$V2)))
names(x) <- headers


## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
df <- select(x, matches("mean|std"))


## 3. Uses descriptive activity names, to name the activities in the data set
activity <- read.table("./activity_labels.txt")
lablesNumToNames <- hashmap(as.vector(activity$V1), as.vector(activity$V2))

## function to map activity level to descriptive name
describeActivity <- function(labelNum){
  lablesNumToNames[[labelNum]]
}
descr_train <- sapply(label_train$V1, describeActivity)
descr_test <- sapply(label_test$V1, describeActivity)
descr_labels  <- bind_rows(tbl_df(descr_train), tbl_df(descr_test))
names(descr_labels) = "activity"

## 4. Appropriately labels the data set with descriptive variable names.
subject  <- bind_rows(subject_train, subject_test)
names(subject) = "subject"

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyDataSet <- df %>% bind_cols(descr_labels, subject) %>% group_by(subject,activity) %>% summarise_each(funs(mean))
