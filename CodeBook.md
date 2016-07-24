# Codebook  

## Peer Graded Assignment: Getting and Cleaning Data Course Project
## Week 4: Human Activity Recognition Using Smartphones Data Set 
========================================================

The data subset used in Tidy-UCI-HARUS consist of only the measurements on the mean and standard deviation  for each measurement in the original data set. 

# Features
==========

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

 Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tbodyaccjerkxyz and tbodygyrojerkxyz). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tbodyaccmag, tgravityaccmag, tbodyaccjerkmag, tbodygyromag, tbodygyrojerkmag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fbodyAccxyz, fbodyaccjerkxyz, fbodygyroxyz, fbodyaccjerkmag, fbodygyromag, fbodygyrojerkmag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern: the string 'xyz' is used to denote 3-axial signals in the X, Y and Z directions.

* tbodyaccxyz
* tgravityaccxyz
* tbodyaccjerkxyz
* tbodygyroxyz
* tbodygyrojerkxyz
* tbodyaccmag
* tgravityaccmag
* tbodyaccjerkmag
* tbodygyromag
* tbodygyrojerkmag
* fbodyaccxyz
* fbodyaccjerkxyz
* fbodygyroxyz
* fbodyaccmag
* fbodyaccjerkmag
* fbodygyromag
* fbodygyrojerkmag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravitymean
* tbodycccmean
* tbodyaccjerkmean
* tbodygyromean
* tbodygyrojerkmean

The  subset  consists of the following 88 features:

1.	subject: identifier for the participanting subject 
2.	activity = {"WALKING", "WALKING UPSTAIRS", "WALKING DOWNSTAIRS"", "SITTING"", "STANDING"", "LAYING""}
3.	tbodyaccmeanx
4.	tbodyaccmeany
5.	tbodyaccmeanz
6.	tbodyaccstdx
7.	tbodyaccstdy
8.	tbodyaccstdz
9.	tgravityaccmeanx
10.	tgravityaccmeany
11.	tgravityaccmeanz
12.	tgravityaccstdx
13.	tgravityaccstdy
14.	tgravityaccstdz
15.	tbodyaccjerkmeanx
16.	tbodyaccjerkmeany
17.	tbodyaccjerkmeanz
18.	tbodyaccjerkstdx
19.	tbodyaccjerkstdy
20.	tbodyaccjerkstdz
21.	tbodygyromeanx
22.	tbodygyromeany
23.	tbodygyromeanz
24.	tbodygyrostdx
25.	tbodygyrostdy
26.	tbodygyrostdz
27.	tbodygyrojerkmeanx
28.	tbodygyrojerkmeany
29.	tbodygyrojerkmeanz
30.	tbodygyrojerkstdx
31.	tbodygyrojerkstdy
32.	tbodygyrojerkstdz
33.	tbodyaccmagmean
34.	tbodyaccmagstd
35.	tgravityaccmagmean
36.	tgravityaccmagstd
37.	tbodyaccjerkmagmean
38.	tbodyaccjerkmagstd
39.	tbodygyromagmean
40.	tbodygyromagstd
41.	tbodygyrojerkmagmean
42.	tbodygyrojerkmagstd
43.	fbodyaccmeanx
44.	fbodyaccmeany
45.	fbodyaccmeanz
46.	fbodyaccstdx
47.	fbodyaccstdy
48.	fbodyaccstdz
49.	fbodyaccmeanfreqx
50.	fbodyaccmeanfreqy
51.	fbodyaccmeanfreqz
52.	fbodyaccjerkmeanx
53.	fbodyaccjerkmeany
54.	fbodyaccjerkmeanz
55.	fbodyaccjerkstdx
56.	fbodyaccjerkstdy
57.	fbodyaccjerkstdz
58.	fbodyaccjerkmeanfreqx
59.	fbodyaccjerkmeanfreqy
60.	fbodyaccjerkmeanfreqz
61.	fbodygyromeanx
62.	fbodygyromeany
63.	fbodygyromeanz
64.	fbodygyrostdx
65.	fbodygyrostdy
66.	fbodygyrostdz
67.	fbodygyromeanfreqx
68.	fbodygyromeanfreqy
69.	fbodygyromeanfreqz
70.	fbodyaccmagmean
71.	fbodyaccmagstd
72.	fbodyaccmagmeanfreq
73.	fbodybodyaccjerkmagmean
74.	fbodybodyaccjerkmagstd
75.	fbodybodyaccjerkmagmeanfreq
76.	fbodybodygyromagmean
77.	fbodybodygyromagstd
78.	fbodybodygyromagmeanfreq
79.	fbodybodygyrojerkmagmean
80.	fbodybodygyrojerkmagstd
81.	fbodybodygyrojerkmagmeanfreq
82.	angletbodyaccmeangravity
83.	angletbodyaccjerkmeangravitymean
84.	angletbodygyromeangravitymean
85.	angletbodygyrojerkmeangravitymean
86.	anglexgravitymean
87.	angleygravitymean
88.	anglezgravitymean


# Data Processing

### The files were read into dplr table. The code snippet shows how the training and test files were  read into the intermediate variables:

```{r}
train  <- tbl_df(read.table("./train/X_train.txt"))
subject_train <- tbl_df(read.table("./train/subject_train.txt"))
label_train <- tbl_df(read.table("./train/y_train.txt"))
test  <- tbl_df(read.table("./test/X_test.txt"))
subject_test <- tbl_df(read.table("./test/subject_test.txt"))
label_test <- tbl_df(read.table("./test/y_test.txt"))
```

###  The taining and the test were merged to create one data set.
```{r}
x  <- bind_rows(train, test)
y  <- bind_rows(label_train, label_test)

```


### All feature names were converted to lower case; non-alphanumeric characters were replaced with empty string; and features names in the original data set  were de-duplicated using the make.unique() function.
```{r}
features  <- tbl_df(read.table("./features.txt", stringsAsFactors = FALSE))
headers <- make.unique(gsub(pattern = "\\-|\\,|\\(|\\)", "", stringr::str_to_lower(features$V2)))
names(x) <- headers

```

###  Only features derived using a   mean and standard deviation were extracted from the original data set, for each measurement.
```{r}
df <- select(x, matches("mean|std"))
```

###  Descriptive activity names, were used for each measurement; a function  used to map activity level to descriptive name
```{r}
activity <- read.table("./activity_labels.txt")
lablesNumToNames <- hashmap(as.vector(activity$V1), as.vector(activity$V2))

describeActivity <- function(labelNum){
  lablesNumToNames[[labelNum]]
}
descr_train <- sapply(label_train$V1, describeActivity)
descr_test <- sapply(label_test$V1, describeActivity)
descr_labels  <- bind_rows(tbl_df(descr_train), tbl_df(descr_test))
names(descr_labels) = "activity"
subject  <- bind_rows(subject_train, subject_test)
names(subject) = "subject"
```

### An independent tidy data set with the average of each variable for each activity and each subject is produced 
```{r}
tidyDataSet <- df %>% bind_cols(descr_labels, subject) %>% group_by(subject,activity) %>% summarise_each(funs(mean))

```


