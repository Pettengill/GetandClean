setwd("/Users/emily.pettengill/Desktop/Getting-and-Cleaning-Data/UCIHARDataset/")
# Part 1: Merges the training and the test sets to create one data set 

# Read in and merge "y" data tables
tr_y <- read.table("train/y_train.txt")
te_y <- read.table("test/y_test.txt")
Y_df <- rbind(tr_y, te_y)

# Read in and merge "x" data tables
tr_x <- read.table("train/X_train.txt")
te_x <- read.table("test/X_test.txt")
X_df <- rbind(tr_x, te_x)

# Read in and merge subject lists, add label to data frame
sub_tr <- read.table("train/subject_train.txt")
sub_te <- read.table("test/subject_test.txt")
subject <- rbind(sub_tr, sub_te)
names(subject) <- "subjectID"

# Part 2: Extracts only the measurements on the mean and standard deviation for each measurement

# Identify feature names with "-mean" or "-std" and subset X_df by these features
allfeatures <- read.table("features.txt")
mean_std <- grep("-mean\\(\\)|-std\\(\\)", allfeatures[,2]) 
X_df <- X_df[, mean_std]

# Assign and change names of the features?
names(X_df) <- allfeatures[mean_std, 2]
names(X_df) <- tolower(names(X_df))
names(X_df) <- gsub("\\(|\\)", "", names(X_df))

# Part 3: Uses descriptive activity names to name the activities in the data set

# Read in table of activity labels, make activity labels lower case, remove "_" 
# and apply them to merged Y_df, add column label to the Y_df data frame
activities <- read.table("activity_labels.txt")
activities[,2] <- tolower(as.character(activities[,2]))
activities[,2] <- gsub("_", "", activities[,2])
Y_df[,1] <- activities[Y_df[,1], 2]

# Part 4: Appropriately labels the data set with descriptive variable names

# Label subject table, combine the 3 data frames and write a file of the combined data
names(Y_df) <- "activity"
combined <- cbind(subject, Y_df, X_df)
write.table(combined, "combined_relabeled_data.txt")

# Part 5: Creates a second, independent tidy data set with the average of each feature variable for each activity and each subject

# Reshape data using a function that melts and recasts the data with the average of each feature variable for each activity and subject
tidyfunc <- function(x) {
        library(reshape2)
        id.vars = c("subjectID", "activity")
        measurevars = setdiff(colnames(x), id.vars)
        melted <- melt(x, id=id.vars, measure.vars=measurevars)
        dcast(melted, subjectID + activity ~ variable, mean)        
}
# Run tidyfunc with the combined data frame
tidy <- tidyfunc(combined)

# Since melt reorders the activity factors, the factor levels are reordered then the data frame is ordered by subject then activity
tidy$activity <- factor(tidy$activity, levels=c("walking", "walkingupstairs", "walkingdownstairs" , "sitting" , "standing" , "laying"))
levels(tidy$activity)
tidy <- tidy[order(tidy$subjectID, tidy$activity),]
row.names(tidy) <-NULL

# Writes a file with the tidy data averages for each subject and each activity
write.table(tidy, "tidy_data_with_averages.txt")
