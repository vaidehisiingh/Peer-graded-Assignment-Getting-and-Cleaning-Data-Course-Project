# Coursera: Getting and Cleaning Data – UCI HAR Project

run_analysis <- function() {
  # ---- 0. setup ----
  options(stringsAsFactors = FALSE)
  need <- c("dplyr", "reshape2")
  to_install <- need[!(need %in% installed.packages()[,"Package"])]
  if (length(to_install)) install.packages(to_install, repos = "https://cloud.r-project.org")
  suppressPackageStartupMessages({
    library(dplyr)
    library(reshape2)
  })
  
  # ---- 1. Download & unzip (if needed) ----
  zipUrl  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  zipFile <- "Dataset.zip"
  dataDir <- "UCI HAR Dataset"
  
  if (!file.exists(zipFile) && !dir.exists(dataDir)) {
    download.file(zipUrl, destfile = zipFile, mode = "wb")
  }
  if (!dir.exists(dataDir)) {
    unzip(zipFile)
  }
  
  # ---- 2. Read metadata ----
  features <- read.table(file.path(dataDir, "features.txt"),
                         col.names = c("index","feature"))
  act_lbls <- read.table(file.path(dataDir, "activity_labels.txt"),
                         col.names = c("id","activity"))
  
  # keep only mean() and std() features (per project instructions)
  keep_idx <- grep("mean\\(\\)|std\\(\\)", features$feature)
  keep_features <- features$feature[keep_idx]
  
  # ---- 3. Read train/test, subset to mean/std, then merge ----
  # TRAIN
  sub_train <- read.table(file.path(dataDir, "train", "subject_train.txt"),
                          col.names = "subject")
  y_train   <- read.table(file.path(dataDir, "train", "y_train.txt"),
                          col.names = "activity")
  X_train   <- read.table(file.path(dataDir, "train", "X_train.txt"))[, keep_idx]
  
  # TEST
  sub_test <- read.table(file.path(dataDir, "test", "subject_test.txt"),
                         col.names = "subject")
  y_test   <- read.table(file.path(dataDir, "test", "y_test.txt"),
                         col.names = "activity")
  X_test   <- read.table(file.path(dataDir, "test", "X_test.txt"))[, keep_idx]
  
  # merge
  train <- cbind(sub_train, y_train, X_train)
  test  <- cbind(sub_test,  y_test,  X_test)
  all   <- rbind(train, test)
  
  # ---- 4. Name activities + label variables descriptively ----
  # activity as factor with descriptive labels
  all$activity <- factor(all$activity, levels = act_lbls$id, labels = act_lbls$activity)
  
  # column names = subject, activity, <features>
  colnames(all) <- c("subject", "activity", keep_features)
  
  # clean/expand variable names to be descriptive
  names(all) <- gsub("\\()", "", names(all))
  names(all) <- gsub("-", "", names(all))
  names(all) <- gsub("^t", "Time", names(all))
  names(all) <- gsub("^f", "Frequency", names(all))
  names(all) <- gsub("Acc", "Accelerometer", names(all))
  names(all) <- gsub("Gyro", "Gyroscope", names(all))
  names(all) <- gsub("Mag", "Magnitude", names(all))
  names(all) <- gsub("BodyBody", "Body", names(all))
  names(all) <- gsub("mean", "Mean", names(all))
  names(all) <- gsub("std", "STD", names(all))
  
  # ---- 5. Create the second tidy dataset (average per subject+activity) ----
 
  molten <- melt(all, id.vars = c("subject","activity"))
  tidy   <- dcast(molten, subject + activity ~ variable, mean)
  
  # ---- 6. Write output ----
  write.table(tidy, "tidyDataSet.txt", row.names = FALSE)
  message("Done: wrote tidyDataSet.txt (rows: ", nrow(tidy), ", cols: ", ncol(tidy), ")")
  invisible(tidy)
}

run_analysis()
