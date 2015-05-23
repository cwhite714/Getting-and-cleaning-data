setwd("C:\\cwhite\\projects\\run_analysis")

if(!file.exists("data")) {
	dir.create("data")
}

## 1. Merge the training and the test sets to create one data set
train_data <- read.table("./data/train/X_train.txt")
train_label <- read.table("./data/train/y_train.txt")
train_subject <- read.table("./data/train/subject_train.txt")
test_data <- read.table("./data/test/X_test.txt")
test_label <- read.table("./data/test/y_test.txt")
test_subject <- read.table("./data/test/subject_test.txt")
merged_data = rbind(train_data, test_data)
merged_label = rbind(train_label, test_label)
merged_subject = rbind(train_subject, test_subject)

## 2. Extract only the measurements on the mean and standard deviation for each measurement
features <- read.table("./data/features.txt")
mean_std_indices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
merged_data <- merged_data[, mean_std_indices]
names(merged_data) <- gsub("\\(\\)", "", features[mean_std_indices, 2])

## 3. Use descriptive activity names to name the activities in the data set
activity <- read.table("./data/activity_labels.txt")
activity[, 2] <- tolower(activity[, 2])
activity_label <- activity[merged_label[, 1], 2]
merged_label[, 1] <- activity_label

## 4. Appropriately label the data set with descriptive variable names
names(merged_label) <- "activity"
names(merged_subject) <- "subject"
final_data <- cbind(merged_subject, merged_label, merged_data)

## 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
subject_len <- length(table(merged_subject))
activity_len <- dim(activity)[1]
column_len <- dim(final_data)[2]
result <- matrix(NA, nrow=subject_len*activity_len, ncol=column_len) 
result <- as.data.frame(result)
colnames(result) <- colnames(final_data)
row <- 1
for(i in 1:subject_len) {
    for(j in 1:activity_len) {
        result[row, 1] <- sort(unique(merged_subject)[, 1])[i]
        result[row, 2] <- activity[j, 2]
        var1 <- i == final_data$subject
        var2 <- activity[j, 2] == final_data$activity
        result[row, 3:column_len] <- colMeans(final_data[var1&var2, 3:column_len])
        row <- row + 1
    }
}
write.table(result, "tidy_data.txt", row.names=FALSE)
