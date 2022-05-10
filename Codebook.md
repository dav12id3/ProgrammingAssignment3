---
author: "YCWang"
date: "5/10/2022"
output: html_document
---

### Codebook for run_analysis.R

#### Raw data:
The features of the signal `features.txt`  
Activity labels which link the labels to the activities `activity_labels.txt`  
Test subjects `subject_test.txt`  
Test labels `y_test.txt`  
Test signals `X_test.txt`  
Training subjects `subject_train.txt`  
Training labels `y_train.txt`  
Training signals `X_train.txt`  

#### Codebook:

**id**

The test and training subjects are assigned to id (1-30).

**activity**

The test and training labels are linked to activity labels and transformed         as factor.  
The factor has six levels, "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", and "LAYING".

**other variables**

The features of signals (mean and standard deviation for each measurement) are assigned as column names for variables. (Unit: t for time, f for frequency) 

