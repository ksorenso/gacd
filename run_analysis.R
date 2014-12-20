
# set the path for the working directory where the folder "UCI HAR Dataset" is found
datadir <- "C:/Users/ksorenso.CISCO/Documents/Coursera/g_and_c_data/"
setwd(datadir)

# ... step 1. Merge the training and the test sets to create one data set
# ... First read in the 'x' training and test files and combine them
x_train = read.table("UCI HAR Dataset/train/X_train.txt", header=F,sep="")
x_test = read.table("UCI HAR Dataset/test/X_test.txt", header=F,sep="")
x_combined = rbind(x_test,x_train)
# ... Then read in the 'y' training and test files and combine them
y_train = read.table("UCI HAR Dataset/train/y_train.txt", header=F,sep="")
y_test = read.table("UCI HAR Dataset/test/y_test.txt", header=F,sep="")
y_combined = rbind(y_test,y_train)
# ... Then read in the subject information training and test files and combining them
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt", header=F,sep="")
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt", header=F,sep="")
subject_combined = rbind(subject_test,subject_train)
# ... Label the column 'subject'
names(subject_combined) <- "subject"
# ... prior to combining subject, activity (y), and measurements (x), I chose to complete step 2 and 3

# ... step 2. Extract only the measurements on the mean and standard deviation for each measurement.
# ... here, I choose to loosely interpret this as any measurement containing the string 'mean' or 'std'
# ... I could have more strictly interpreted it as those measurements containing the strings 'mean()' or 'std()'
features = read.table("UCI HAR Dataset/features.txt", header=F)
contains_mean = sapply(features$V2, function(x) length(grep("mean",x,ignore.case=T)) > 0)
contains_std = sapply(features$V2, function(x) length(grep("std",x,ignore.case=T)) > 0 )
names(x_combined) <- features$V2
x_filtered <- x_combined[,features[contains_std | contains_mean,]$V1]

# ... step 3.  Name the activities in the data set with descriptive activity names
# ... ( I contemplated reading in the activity information and and developing code to
# ...   associate descriptive names with the activities programmatically, but decided
# ...   to use subsetting and write a line of code for each activity since there were only 6.)
# ...   >> read.table("UCI HAR Dataset/activity_labels.txt", header=F)
# ... )
y_combined$activity <- "placeholder"
y_combined$activity[y_combined$V1 == 1] <- "WALKING"
y_combined$activity[y_combined$V1 == 2] <- "WALKING_UPSTAIRS"
y_combined$activity[y_combined$V1 == 3] <- "WALKING_DOWNSTAIRS"
y_combined$activity[y_combined$V1 == 4] <- "SITTING"
y_combined$activity[y_combined$V1 == 5] <- "STANDING"
y_combined$activity[y_combined$V1 == 6] <- "LAYING"

# ... now, having completed steps 2 and 3, complete step 1 by
# ... creating a single data frame with subject, activity, and included data (means and std dev's)
one_dataset <- cbind( subject_combined["subject"], y_combined["activity"], x_filtered)

# ... step 5. From the data set in step 4, 
# ... create a second, independent tidy data set with the average of each variable for each activity and each subject.
# head(aggregate(one_dataset[,3:NCOL(one_dataset)], list(subject = one_dataset$subject, activity = one_dataset$activity), mean ))
tidy_dataset <- aggregate(one_dataset[,3:NCOL(one_dataset)], list(subject = one_dataset$subject, activity = one_dataset$activity), mean )
# summary(tidy_dataset)
# dim(tidy_dataset)

# ... prepare a txt file to upload for the coursera project submission
# ... create it with write.table() using row.name=FALSE
# ... I also set quote=FALSE for a cleaner submission
write.table(tidy_dataset, "tidydata.txt", row.names=FALSE, quote=FALSE)

# ... as a final check, read the text file back into R 
tidy_dataset2 = read.table("tidydata.txt", header=T,sep="")