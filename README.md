
README.md
========================================================

This repository (Tidy-UCI-HARUS) contains R-scripts and codebook for creating a tidy data set from a subset of the UCI Human Activity Recognition Using Smartphones Data Set.

The data used in this experiment represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data subset used in Tidy-UCI-HARUS consist of only the measurements on the mean and standard deviation for each measurement in the original data set. 

### The dataset includes the following files:

1. /test folder: test data 
  + subject_test.txt: Test set. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
  + X_test.txt: Test set.
  + y_test.txt: Test lables.
2. /train folder: training data
  + subject_train.txt: Training set wheere each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
  + X_train.txt: Training set
  + y_train.txt: Training labels
3. activity_labels.txt:  Links the class labels with their activity name.
4. CodeBook.md: modification of the original codebooks with the data to indicate all the variables and summaries calculated, along with units, and notes  relevant for processing the data.
5. README.md: this file
6. run_analysis.R : R-Script to create Tidy-UCI-HARUS for this exercise



