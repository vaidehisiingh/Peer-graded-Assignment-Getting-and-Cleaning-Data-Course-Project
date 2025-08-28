# Peer-graded Assignment: Getting and Cleaning Data Course Project

This repository is a submission for the *Getting and Cleaning Data* course project. It contains the instructions, scripts, and documentation for preparing and cleaning the **Human Activity Recognition Using Smartphones** dataset.

---

## Dataset

**Human Activity Recognition Using Smartphones**  
Collected from the accelerometers and gyroscopes of Samsung Galaxy S smartphones, performed by 30 volunteers within an age bracket of 19–48 years while carrying out 6 different activities (walking, walking upstairs, walking downstairs, sitting, standing, and laying).

The dataset can be obtained at:  
[UCI Machine Learning Repository - HAR Dataset](https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones)

---

## Files in this repository

- **CodeBook.md**  
  Describes the variables, the data, and all transformations performed to clean up the dataset.

- **run_analysis.R**  
  An R script that performs the data preparation and executes the 5 steps required by the course project definition:
  1. Merges the training and the test sets to create one data set.  
  2. Extracts only the measurements on the mean and standard deviation for each measurement.  
  3. Uses descriptive activity names to name the activities in the data set.  
  4. Appropriately labels the data set with descriptive variable names.  
  5. From the data set in step 4, creates a second, independent tidy dataset with the average of each variable for each activity and each subject.  

- **FinalData.txt**  
  The exported tidy dataset containing the average of each variable for each activity and subject, as produced by step 5 above.

---

## How to run the script

1. Download and unzip the dataset into your R working directory.  
2. Place the `run_analysis.R` script in the same working directory.  
3. Run the script in R/RStudio:

   ```r
   source("run_analysis.R")
