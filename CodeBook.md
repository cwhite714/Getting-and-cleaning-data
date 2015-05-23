Codebook

A full description of data:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The "run_analysis.R" script performs the following:

1.	Merge the training and the test sets to create one data set.
	-	Read and merge "X_train.txt" and "X_test.txt" files to create "merged_data" dataset.
	-	Read and merge "y_train.txt" and "y_test.txt" files to create "merged_label" dataset.
	-	Read and merge "subject_train.txt" and "subject_test.txt" files to create "merged_subject" dataset.
2.	Extract only the measurements on the mean and standard deviation for each measurement.
	-	Read "features.txt" file and extract from "merged_data" dataset only those measurements containing "mean" or "std".
3.	Use descriptive activity names to name the activities in the data set.
	-	Read "activity_labels.txt", convert the labels to lower case and update "merged_label" dataset.
4.	Label the data set with appropriate descriptive variable names.
	-	Label columns in "merged_label" and "merged_subject" datasets.
	-	Merge "merged_data", "merged_label" and "merged_subject" files to create "final_data" dataset.
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	-	Calculate the average of each variable for each activity and each subject to create "tidy_data" dataset.
	-	Output this smaller dataset to "tidy_data.txt" file.


