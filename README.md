---
author: "YCWang"
date: "5/10/2022"
output: html_document
---


## Intrduction

This markdown file describes how the **run_analysis.R** works.

Besides the base R language, it takes functions from the two packages:

```
library(dplyr)
library(reshape2)
```

### Loading data

Test data sets (i.e. readings, subjects, activities) from the **UCI HAR Dataset** is loaded:

```
test <- read.table("../ProgrammingAssignment3/UCI HAR Dataset/test/X_test.txt")
testid <- read.table("../ProgrammingAssignment3/UCI HAR Dataset/test/subject_test.txt")
testlabel <- read.table("../ProgrammingAssignment3/UCI HAR Dataset/test/y_test.txt")
```

As well as the training data sets:

```
train <- read.table("../ProgrammingAssignment3/UCI HAR Dataset/train/X_train.txt")
trainid <- read.table("../ProgrammingAssignment3/UCI HAR Dataset/train/subject_train.txt")
trainlabel <- read.table("../ProgrammingAssignment3/UCI HAR Dataset/train/y_train.txt")
```

The variable names of each columns is loaded.  
Meanwhile the variables of interest (mean and standard deviation for each measurement) are selected, which returns a vector indicating the locations of the variables in `variablenames`.

```
variablenames <- read.table("../ProgrammingAssignment3/UCI HAR Dataset/features.txt")
myvariable <- grep("mean[/()]|std[/()]", variablenames$V2)
```
### Assigning variable names to each data set

The activity labels are first assigned to `activity`.  
The loaded labels (i.e. `testlabel` and `trainlabel`, which used to be sets of numbers) are transformed into factor with six levels according to theirs numbers, and labeled by `activity`. 

```
activity <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
testactivity <- factor(testlabel$V1, levels = 1:6, labels = activity)
trainactivity <- factor(trainlabel$V1, levels = 1:6, labels = activity)
```
The variable names are then assigned to both sets of data.

```
colnames(test) <- variablenames$V2
colnames(train) <- variablenames$V2
```
### Tagging and merging data

Two tags (i.e. id and activity) are introduced into the first and second columns of both data sets, which points to the **subject** and **activity** corresponding to each rows (observations). 

```
test <- cbind(id = testid$V1, activity = testactivity, test)
train <- cbind(id = trainid$V1, activity = trainactivity, train)
```
The two data sets are combined by row, leading by the test data set.  
Columns of our interest (which the column location is stored in `myvariable`) are selected. (Note: Since an additional two columns are added from the left, the column location should +2)

```
merged <- rbind(test, train)
mymerged <- select(merged, id, activity, myvariable+2)
```
### Create a tidy data set

The merged and selected data frame is melted, with "id" and "activity" assigning to the id  argument and the other variables to the measure argument.
The melted data is reformatted, which each id owns six activities, followed by the average of the measurements in each id-activity group.

```
melted <- melt(mymerged, id = c("id", "activity"), measure.vars = names(mymerged)[-c(1,2)])
mytidydata <- dcast(melted, id + activity ~ variable, mean)
```
`mytidydata` stores the tidy data created by the code.
