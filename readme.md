##Create a data frame of features
> features <- read.table("features.txt", header=FALSE)

##Create tables from the raw data: 
> train <- read.table("./train/X_train.txt", header=FALSE, colClasses = "numeric", col.names=features[,2])
> test <- read.table("./test/X_test.txt", header=FALSE, colClasses = "numeric", col.names=features[,2])

##Create tables from the subjects and add a meaningful name to the single column 
> subject_test <- read.table("./test/subject_test.txt", header=FALSE, col.names=c("subject"))
> subject_train <- read.table("./train/subject_train.txt", header=FALSE, col.names=c("subject"))

##Create tables from the activities and add a meaningful name to the single column fina
> y_test <- read.table("./test/y_test.txt", header=FALSE, col.names=c("activity"))
> y_train <- read.table("./train/y_train.txt", header=FALSE, col.names=c("activity"))

##Add the subjects id to train and test tables
> tmp_test <- cbind(test,subject_test)
> tmp_train <- cbind(train,subject_train)

##Add the activities id to train and test tables
> final_test <- cbind(tmp_test,y_test)
> final_train <- cbind(tmp_train,y_train)



##STEP 1: Merge the test and train containing subjects and activities
> final <- rbind(final_train, final_test)

##STEP2: Keep only the measurements related to mean and std (assuming that the variables that contain the string "mean"" or "std" are indeed measuring those metrics) 
> subsetFinal <- final[,grepl("subject|activity|mean|std", names(final))]

##STEP 3: Use descriptive activity names 
> subsetFinal$activity[subsetFinal$activity == 1] <- "Walking"
> subsetFinal$activity[subsetFinal$activity == 2] <- "WalkingUp"
> subsetFinal$activity[subsetFinal$activity == 3] <- "WalkingDown"
> subsetFinal$activity[subsetFinal$activity == 4] <- "Sitting"
> subsetFinal$activity[subsetFinal$activity == 5] <- "Standing"
> subsetFinal$activity[subsetFinal$activity == 6] <- "Laying"
> subsetFinal$activity <- as.factor(subsetFinal$activity)

##STEP 4: Use descriptive variables names. This step was partially achieved when I read the data and used the col.names with the features names as attribute (i.e. col.names=features[,2]). In my opinion the names in features.txt were descriptive except for few details described below (note that col.names makes sure the names are syntactically valid and gets ride of the unwanted parentehesis and dashes). 

##Eliminate the redundancy in "BodyBody" and keep only "Body"
> names(subsetFinal) <- sub("BodyBody", "Body", names(subsetFinal))

##Spell out the word "time" or the abbreviation "freq" for clarity (instead of using only the letters "t" or "f". 
> names(subsetFinal) <- sub("^t", "time", names(subsetFinal))
> names(subsetFinal) <- sub("^f", "freq", names(subsetFinal))

##Replace extra dots before X, Y and Z
> names(subsetFinal) <- sub("...X", ".X", names(subsetFinal))
> names(subsetFinal) <- sub("...Y", ".Y", names(subsetFinal))
> names(subsetFinal) <- sub("...Z", ".Z", names(subsetFinal))

##Add more descriptive names to the participants
> subsetFinal$subject[subsetFinal$subject == 1] <- "User01"
> subsetFinal$subject[subsetFinal$subject == 2] <- "User02"
> subsetFinal$subject[subsetFinal$subject == 3] <- "User03"
> subsetFinal$subject[subsetFinal$subject == 4] <- "User04"
> subsetFinal$subject[subsetFinal$subject == 5] <- "User05"
> subsetFinal$subject[subsetFinal$subject == 6] <- "User06"
> subsetFinal$subject[subsetFinal$subject == 7] <- "User07"
> subsetFinal$subject[subsetFinal$subject == 8] <- "User08"
> subsetFinal$subject[subsetFinal$subject == 9] <- "User09"
> subsetFinal$subject[subsetFinal$subject == 10] <- "User10"
> subsetFinal$subject[subsetFinal$subject == 11] <- "User11"
> subsetFinal$subject[subsetFinal$subject == 12] <- "User12"
> subsetFinal$subject[subsetFinal$subject == 13] <- "User13"
> subsetFinal$subject[subsetFinal$subject == 14] <- "User14"
> subsetFinal$subject[subsetFinal$subject == 15] <- "User15"
> subsetFinal$subject[subsetFinal$subject == 16] <- "User16"
> subsetFinal$subject[subsetFinal$subject == 17] <- "User17"
> subsetFinal$subject[subsetFinal$subject == 18] <- "User18"
> subsetFinal$subject[subsetFinal$subject == 19] <- "User19"
> subsetFinal$subject[subsetFinal$subject == 20] <- "User20"
> subsetFinal$subject[subsetFinal$subject == 21] <- "User21"
> subsetFinal$subject[subsetFinal$subject == 22] <- "User22"
> subsetFinal$subject[subsetFinal$subject == 23] <- "User23"
> subsetFinal$subject[subsetFinal$subject == 24] <- "User24"
> subsetFinal$subject[subsetFinal$subject == 25] <- "User25"
> subsetFinal$subject[subsetFinal$subject == 26] <- "User26"
> subsetFinal$subject[subsetFinal$subject == 27] <- "User27"
> subsetFinal$subject[subsetFinal$subject == 28] <- "User28"
> subsetFinal$subject[subsetFinal$subject == 29] <- "User29"
> subsetFinal$subject[subsetFinal$subject == 30] <- "User30" 
> subsetFinal$subject <- as.factor(subsetFinal$subject)

##STEP 5: Create a dataset with the average of each variable for each activity and each subject
> temp <- data.table(subsetFinal)
> tidyFinal <- temp[, lapply(.SD, mean), by = 'subject,activity']
> write.table(tidyFinal, file = "tidy.txt", row.name = FALSE)