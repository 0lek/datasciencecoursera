library(reshape2)

# Load activities and features
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

# Convert 2nd column to characters
activities[,2] <- as.character(activities[,2])
features[,2] <- as.character(features[,2])

# Get only the data we really want (no need to load 70 MB of data)
features_subset <- grep(".*mean.*|.*std.*", features[,2])
features_subset.names <- features[features_subset,2]

# Make it look pretty
features_subset.names = gsub('-mean', 'Mean', features_subset.names)
features_subset.names = gsub('-std', 'Std', features_subset.names)
features_subset.names <- gsub('[-()]', '', features_subset.names)

# Load the training and testing datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[features_subset]
test <- read.table("UCI HAR Dataset/test/X_test.txt")[features_subset]

# Load the training and testing activities
activities_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
activities_test <- read.table("UCI HAR Dataset/test/Y_test.txt")

# Load the training and testing subjects
subjects_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjects_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Merge the 3 files - put all columns side-by-side
train <- cbind(subjects_train, activities_train, train)
test <- cbind(subjects_test, activities_test, test)

# And now merge the two sets - put rows of one "under" the other
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", features_subset)

# Factorize variables
allData$activity <- factor(allData$activity, levels = activities[,1], labels = activities[,2])
allData$subject <- as.factor(allData$subject)

# "Transpose" it using the reshape2 package. "Melt" in R-speak
allData.melted <- melt(allData, id = c("subject", "activity"))

# Get the means in there
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

# Export it
write.table(allData.mean, "tidy_dataset.txt", row.names = FALSE, quote = FALSE)