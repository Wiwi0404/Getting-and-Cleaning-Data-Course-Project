# 1. Merges the training and the test sets to create one data set.

# Read training data into data frame "train"
train_id <- read.table("./train/subject_train.txt", sep = "" , header = F, col.names = c("id"))
train_activity <- read.table("./train/y_train.txt", sep = "" , header = F, col.names = c("activity_id"))
train_data <- read.table("./train/X_train.txt", sep = "" , header = F)
train <- cbind(train_id, train_activity, train_data)

# Read test data into data frame "test"
test_id <- read.table("./test/subject_test.txt", sep = "" , header = F, col.names = c("id"))
test_activity <- read.table("./test/y_test.txt", sep = "" , header = F, col.names = c("activity_id"))
test_data <- read.table("./test/X_test.txt", sep = "" , header = F)
test <- cbind(test_id, test_activity, test_data)

# Merge training and test data into a new data frame "dat"
dat <- rbind(train, test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# Read column names from "features.txt" file
labels <- read.table("./features.txt", sep = "" , header = F)$V2

# Get the indies of the column names which contains "mean()" or "std()"
ind_mean <- grep("*mean\\(\\)*", labels)
ind_std <- grep("*std\\(\\)*", labels)
ind <- sort(c(ind_mean, ind_std))

# Extract data including only mean and std of each measurement
dat_extract <- dat[, c(1, 2, ind+2)]

# 3. Uses descriptive activity names to name the activities in the data set.

# Read the mapping table to map the activity code to activity name
activity_mapping <- read.table("./activity_labels.txt", sep = "" , header = F, col.names = c("activity_id", "activity"))

# Join the mapping table into "dat_extract" and remove the "activity_id" column
library(plyr)
dat_extract <- join(dat_extract, activity_mapping, type="left")
dat_extract <- dat_extract[, -2]

# 4. Appropriately labels the data set with descriptive variable names.
labels_extract <- labels[ind]
colnames(dat_extract) = c("id", labels_extract, "activity")

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
tidy_dat <- dat_extract %>%
            group_by(id, activity) %>%
            summarise_all(list(mean))

# Write the "tidy_dat" to a csv file "tidy_dat.txt"
write.table(tidy_dat, "tidy_dat.txt", row.name=FALSE)