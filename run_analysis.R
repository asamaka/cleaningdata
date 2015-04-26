#read the feature names (col names for Data)
f <- read.table("features.txt", head=FALSE)

#Read the train files and merge with the activity 
X_train <- read.table("train/X_train.txt", header = FALSE)
Y_train <- read.table("train/Y_train.txt", header = FALSE)
names(X_train) <- f$V2
names(Y_train) <- c("Activity")
Train <- cbind(X_train,Y_train)
S_train <- read.table("train/subject_train.txt", header = FALSE)
names(S_train) <- c("Subject")
Train <- cbind(Train,S_train)

#Read the test files and merge with the activity
X_test <- read.table("test/X_test.txt", header = FALSE)
Y_test <- read.table("test/y_test.txt", header = FALSE)
names(X_test) <- f$V2
names(Y_test) <- c("Activity")
Test <- cbind(X_test,Y_test)
S_test <- read.table("test/subject_test.txt", header = FALSE)
names(S_test) <- c("Subject")
Test <- cbind(Test,S_test)

#combine Train & Test Data
Data <- rbind(Train, Test)

#filter only std and mean cols
avgData <- Data[,grep("std|mean|Mean|Activity|Subject",names(Data))]

MeltAvgData <- melt(avgData,id=c("Subject","Activity"))
Summary <- dcast(MeltAvgData, Activity + Subject ~ variable, mean)

#Replace Activity with i's actual name
aLabels <- read.table("activity_labels.txt", head=FALSE)
Tidy <- mutate(Summary, Activity = aLabels[Activity,2])