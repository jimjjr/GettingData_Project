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

# Previously-determined data columns with "average" or "Standard deviation"
keep_features <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 
                   227:228, 240:241, 253:254, 266:271, 294:296, 345:350, 
                   373:375, 424:429, 452:454, 503:504, 513, 516:517, 526, 
                   529:530, 539, 542:543, 552)

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
col_names <- c("Mean of time-domain body linear acceleration for x-axis",
               "Mean of time-domain body linear acceleration for y-axis",
               "Mean of time-domain body linear acceleration for z-axis",
               "Standard deviation of time-domain body linear acceleration for x-axis",
               "Standard deviation of time-domain body linear acceleration for y-axis",
               "Standard deviation of time-domain body linear acceleration for z-axis",
               "Mean of time-domain gravity linear acceleration for x-axis",
               "Mean of time-domain gravity linear acceleration for y-axis",
               "Mean of time-domain gravity linear acceleration for z-axis",
               "Standard deviation of time-domain gravity linear acceleration for x-axis",
               "Standard deviation of time-domain gravity linear acceleration for y-axis",
               "Standard deviation of time-domain gravity linear acceleration for z-axis",
               "Mean of time derivative of body linear acceleration for x-axis",
               "Mean of time derivative of body linear acceleration for y-axis",
               "Mean of time derivative of body linear acceleration for z-axis",
               "Standard deviation of time derivative of body linear acceleration for x-axis",
               "Standard deviation of time derivative of body linear acceleration for y-axis",
               "Standard deviation of time derivative of body linear acceleration for z-axis",
               "Mean of time-domain body angular velocity for x-axis",
               "Mean of time-domain body angular velocity for y-axis",
               "Mean of time-domain body angular velocity for z-axis",
               "Standard deviation of time-domain body angular velocity for x-axis",
               "Standard deviation of time-domain body angular velocity for y-axis",
               "Standard deviation of time-domain body angular velocity for z-axis",
               "Mean of time derivative of body angular velocity for x-axis",
               "Mean of time derivative of body angular velocity for y-axis",
               "Mean of time derivative of body angular velocity for z-axis",
               "Standard deviation of time derivative of body angular velocity for x-axis",
               "Standard deviation of time derivative of body angular velocity for y-axis",
               "Standard deviation of time derivative of body angular velocity for z-axis",
               "Mean of Euclidean norm magnitude of time-domain body linear acceleration",
               "Standard deviation of Euclidean norm magnitude of time-domain body linear acceleration",
               "Mean of Euclidean norm magnitude of time-domain gravity linear acceleration",
               "Standard deviation of Euclidean norm magnitude of time-domain gravity linear acceleration",
               "Mean of Euclidean norm magnitude of time derivative of body linear acceleration",
               "Standard deviation of Euclidean norm magnitude of time derivative of body linear acceleration",
               "Mean of Euclidean norm magnitude of time-domain body angular velocity",
               "Standard deviation of Euclidean norm magnitude of time-domain body angular velocity",
               "Mean of Euclidean norm magnitude of time derivative of body angular velocity",
               "Standard deviation of Euclidean norm magnitude of time derivative of body angular velocity",
               "Mean of frequency-domain body linear acceleration for x-axis",
               "Mean of frequency-domain body linear acceleration for y-axis",
               "Mean of frequency-domain body linear acceleration for z-axis",
               "Standard deviation of frequency-domain body linear acceleration for x-axis",
               "Standard deviation of frequency-domain body linear acceleration for y-axis",
               "Standard deviation of frequency-domain body linear acceleration for z-axis",
               "Mean frequency of frequency-domain body linear acceleration for x-axis",
               "Mean frequency of frequency-domain body linear acceleration for y-axis",
               "Mean frequency of frequency-domain body linear acceleration for z-axis",
               "Mean of time derivative of x-axis body linear acceleration in the frequency domain",
               "Mean of time derivative of y-axis body linear acceleration in the frequency domain",
               "Mean of time derivative of z-axis body linear acceleration in the frequency domain",
               "Standard deviation of time derivative of x-axis body linear acceleration in the frequency domain",
               "Standard deviation of time derivative of y-axis body linear acceleration in the frequency domain",
               "Standard deviation of time derivative of z-axis body linear acceleration in the frequency domain",
               "Mean frequency of time derivative of x-axis body linear acceleration in the frequency domain",
               "Mean frequency of time derivative of y-axis body linear acceleration in the frequency domain",
               "Mean frequency of time derivative of z-axis body linear acceleration in the frequency domain",
               "Mean of frequency-domain body angular velocity for x-axis",
               "Mean of frequency-domain body angular velocity for y-axis",
               "Mean of frequency-domain body angular velocity for z-axis",
               "Standard deviation of frequency-domain body angular velocity for x-axis",
               "Standard deviation of frequency-domain body angular velocity for y-axis",
               "Standard deviation of frequency-domain body angular velocity for z-axis",
               "Mean frequency of frequency-domain body angular velocity for x-axis",
               "Mean frequency of frequency-domain body angular velocity for y-axis",
               "Mean frequency of frequency-domain body angular velocity for z-axis",
               "Mean of Euclidean norm magnitude of body linear acceleration in the frequency domain",
               "Standard deviation of Euclidean norm magnitude of body linear acceleration in the frequency domain",
               "Mean frequency of Euclidean norm magnitude of body linear acceleration in the frequency domain",
               "Mean of Euclidean norm magnitude of time derivative of body linear acceleration in the frequency domain",
               "Standard deviation of Euclidean norm magnitude of time derivative of body linear acceleration in the frequency domain",
               "Mean frequency of Euclidean norm magnitude of time derivative of body linear acceleration in the frequency domain",
               "Mean of Euclidean norm magnitude of body angular velocity in the frequency domain",
               "Standard deviation of Euclidean norm magnitude of body angular velocity in the frequency domain",
               "Mean frequency of Euclidean norm magnitude of body angular velocity in the frequency domain",
               "Mean of Euclidean norm magnitude of time derivative of body angular velocity in the frequency domain",
               "Standard deviation of Euclidean norm magnitude of time derivative of body angular velocity in the frequency domain",
               "Mean frequency of Euclidean norm magnitude of time derivative of body angular velocity in the frequency domain",
               "Activity_Label",
               "Subject_Number")

# Assign column names
colnames(all_data) <- col_names

## Convert activity numbers to factors with meaningful labels
all_data[,"Activity_Label"] <- factor(all_data[,"Activity_Label"], 
                                      levels=activity_definitions[,1],
                                      labels=activity_definitions[,2])

## Convert subject numbers to factor
all_data <- mutate(all_data, Subject_Number = as.factor(Subject_Number))

## Take mean of every variable by activity and subject
summarized_data <- all_data %>% 
    group_by(Activity_Label, Subject_Number) %>%
    summarise_each(funs(mean))

write.table(summarized_data, "tidy_summary.txt", row.name=FALSE)