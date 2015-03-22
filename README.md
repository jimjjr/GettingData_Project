# README

## Introduction
The R script "run_analysis.R" is a script to subset and summarize data from the  UC Irvine study of Samsung Galaxy S smartphone accelerometer data collected from a number of test subjects during different monitored motion activities. 

For more information on the original study and the data collected, please consult the document "codebook.txt" or the original article located at "http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/". Further information can be obtained from the original source of the data used by the R script at "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones". 

The script "run_analysis.R" assumes that the (unzipped) data folder from the UC Irvine study, downloaded from this source: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", is in the same working directory as the script.

## Description of script function
The UC Irvine Samsung Galaxy S accelerometer data as-downloaded containes data spread out across many separate files. The script "run_analysis.R" tidys up and summarizes the data in these data files and outputs a tidy data set of this summary. The functions performed by the script are as follows:

1. Determines which columns of data in the datasets represent "mean" or "standard deviation" from the variable names listed in the document "features.txt"
2. Slightly alters the variable names to make them more intelligible and easier to use.
3. Collates the test and training data from the files "X_test.txt" and "X_train.txt" into one dataset with one column for every variable and one row for every observation.
4. Filters collated dataset to only keep variables representing "mean" or "standard deviation" values.
5. Adds columns for appropriate activity labels and test subject numbers for each observation to dataset.
6. Summarizes data by taking the mean of every kept variable, subsetted by activity and subject.
7. Saves a .txt file containing the summarized data in the file "tidy_summary.txt" using the R function write.table(..., row.names = FALSE) into the working directory.

## Instructions
In order to successfully run the script, the following steps should be taken:

1. Download the UC Irvine study of the Samsung Galaxy S accelerometer data from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
2. Unzip the downloaded .zip file into the same directory as the R script "run_analysis.R"
3. Run the R script "run_analysis.R"
4. The collated and summarized data will be saved to the working directory (assumed to be the same directory as the script).