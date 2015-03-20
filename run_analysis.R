## Check that required packages are installed and install any that are missing
required_packages <- "dplyr"
missing_packages <- required_packages[!(required_packages %in% 
                                            installed.packages()[,"Package"])]
if(length(missing_packages)) {
    install.packages(missing_packages)
}

## Load required packages
library(dplyr)

# Define file paths
data_dir <- "UCI HAR Dataset"
activity_labels_file <- file.path(data_dir, "activity_labels.txt")
data_features_file <- file.path(data_dir, "features.txt")

test_data_file <- file.path(data_dir, "test/X_test.txt")
test_labels_file <- file.path(data_dir, "test/y_test.txt")
test_subject_file <- file.path(data_dir, "test/subject_test.txt")

train_data_file <- file.path(data_dir, "train/X_train.txt")
train_labels_file <- file.path(data_dir, "/train/y_train.txt")
train_subject_file <- file.path(data_dir, "/train/subject_train.txt")

features_file <- file.path(data_dir, "features.txt")

# Read in column names variables from file
features <- read.table(features_file, 
                       comment.char="", 
                       stringsAsFactors=FALSE)[, 2]

# Generate logical vector to select variables representing means and 
# standard deviations
keep_features <- grepl("-mean|-std", features)

# Select only variables representing means and standard deviations
features <- features[keep_features]

# Modify column names to remove () characters and replace '-' with '.'
features <- gsub("[(]|[)]", "", features)
features <- gsub("-", ".", features)

## Read in activity definitions
activity_definitions <- read.table(activity_labels_file,
                                   comment.char="", stringsAsFactors=FALSE)

### Read data
test_data <- read.table(test_data_file, comment.char="", colClasses="numeric")
train_data <- read.table(train_data_file,
                         comment.char="", colClasses="numeric")
## Combine all data and remove all columns that are not averages or 
## standard deviations
all_data <- rbind(test_data, train_data)[,keep_features]

## Read files that specify activity labels
test_labels <- read.table(test_labels_file, 
                          comment.char="", 
                          colClasses="numeric")
train_labels <- read.table(train_labels_file,
                           comment.char="", 
                           colClasses="numeric")

## Read files that specify test subject
test_subject <- read.table(test_subject_file, 
                           comment.char="", 
                           colClasses="numeric")
train_subject <- read.table(train_subject_file,
                           comment.char="",
                           colClasses="numeric")

### Merge all data with activity labels and test subjects
all_data <- cbind(all_data, 
                  rbind(test_labels, train_labels), 
                  rbind(test_subject, train_subject))

## Define column names to something meaningful
col_names <- c(features, "ActivityLabel", "SubjectNumber")

# Assign column names
colnames(all_data) <- col_names

## Convert activity numbers to factors with meaningful labels
all_data[,"ActivityLabel"] <- factor(all_data[,"ActivityLabel"], 
                                      levels=activity_definitions[,1],
                                      labels=activity_definitions[,2])

## Convert subject numbers to factor
all_data <- mutate(all_data, SubjectNumber = as.factor(SubjectNumber))

## Take mean of every variable by activity and subject
summarized_data <- all_data %>% 
    group_by(ActivityLabel, SubjectNumber) %>%
    summarise_each(funs(mean))

write.table(summarized_data, "tidy_summary.txt", row.name=FALSE)