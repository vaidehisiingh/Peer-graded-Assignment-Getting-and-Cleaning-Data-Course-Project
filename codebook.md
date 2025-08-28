# Code Book

The `run_analysis.R` script performs the data preparation and follows the 5 steps required in the course project’s definition.

---

## 1. Download the dataset

- Dataset downloaded and extracted into the folder called **UCI HAR Dataset**.  
- **Source:** [Human Activity Recognition Using Smartphones Dataset](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

---

## 2. Assign each data file to variables

- **features.txt**: 561 rows, 2 columns  
  - List of all features (sensor measurements).  
  - Features come from accelerometer and gyroscope 3-axial raw signals (`tAcc-XYZ`, `tGyro-XYZ`).  

- **activity_labels.txt**: 6 rows, 2 columns  
  - Activity ID and corresponding descriptive activity name.  

- **test/subject_test.txt**: 2947 rows, 1 column  
  - IDs of 9/30 test subjects.  

- **test/X_test.txt**: 2947 rows, 561 columns  
  - Test set sensor measurements.  

- **test/y_test.txt**: 2947 rows, 1 column  
  - Activity IDs for test data.  

- **train/subject_train.txt**: 7352 rows, 1 column  
  - IDs of 21/30 training subjects.  

- **train/X_train.txt**: 7352 rows, 561 columns  
  - Training set sensor measurements.  

- **train/y_train.txt**: 7352 rows, 1 column  
  - Activity IDs for training data.  

---

## 3. Merge the training and test sets to create one dataset

- **X** (10299 rows, 561 columns): merged `x_train` and `x_test` using `rbind()`.  
- **Y** (10299 rows, 1 column): merged `y_train` and `y_test`.  
- **Subject** (10299 rows, 1 column): merged `subject_train` and `subject_test`.  
- **Merged_Data** (10299 rows, 563 columns): combined **Subject**, **Y**, and **X** using `cbind()`.  

---

## 4. Extract only the measurements on the mean and standard deviation

- **TidyData** (10299 rows, 88 columns): subset of **Merged_Data** containing only:  
  - `subject`  
  - `code` (activity label)  
  - Mean and standard deviation measurements (features with `mean()` or `std()`).  

---

## 5. Use descriptive activity names

- Numbers in the `code` column replaced with activity names from **activity_labels.txt**.  
- Example:  
  - `1 → WALKING`  
  - `2 → WALKING_UPSTAIRS`  
  - `3 → WALKING_DOWNSTAIRS`  
  - `4 → SITTING`  
  - `5 → STANDING`  
  - `6 → LAYING`  

---

## 6. Appropriately label the dataset with descriptive variable names

Renaming transformations applied:

- `code` → `activity`  
- `Acc` → `Accelerometer`  
- `Gyro` →
