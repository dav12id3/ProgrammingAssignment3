library(dplyr)
library(reshape2)
test <- read.table("../ProgrammingAssignment3/UCI HAR Dataset/test/X_test.txt")
testid <- read.table("../ProgrammingAssignment3/UCI HAR Dataset/test/subject_test.txt")
testlabel <- read.table("../ProgrammingAssignment3/UCI HAR Dataset/test/y_test.txt")

train <- read.table("../ProgrammingAssignment3/UCI HAR Dataset/train/X_train.txt")
trainid <- read.table("../ProgrammingAssignment3/UCI HAR Dataset/train/subject_train.txt")
trainlabel <- read.table("../ProgrammingAssignment3/UCI HAR Dataset/train/y_train.txt")

variablenames <- read.table("../ProgrammingAssignment3/UCI HAR Dataset/features.txt")
myvariable <- grep("mean[/()]|std[/()]", variablenames$V2)

activity <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
testactivity <- factor(testlabel$V1, levels = 1:6, labels = activity)
trainactivity <- factor(trainlabel$V1, levels = 1:6, labels = activity)

colnames(test) <- variablenames$V2
colnames(train) <- variablenames$V2

test <- cbind(id = testid$V1, activity = testactivity, test)
train <- cbind(id = trainid$V1, activity = trainactivity, train)

merged <- rbind(test, train)
mymerged <- select(merged, id, activity, myvariable+2)

melted <- melt(mymerged, id = c("id", "activity"), measure.vars = names(mymerged)[-c(1,2)])
mytidydata <- dcast(melted, id + activity ~ variable, mean)
mytidydata


