
The script in run_analysis.R merges the training and the test sets to create one data set named "all_train_test".
Out of this dataset we extract only the measurements on the mean and standard deviation for each measurement.
The resulting variable is "select_train_test". 
The activities in the data set are named with descriptive activity names in "withnames_train_test"
Finally, scripts creat a tidy data set and writes it in the txt file.
