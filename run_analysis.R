features <- read.table("features.txt", header=FALSE)
train <- read.table("./train/X_train.txt", header=FALSE, colClasses = "numeric", col.names=features[,2])
test <- read.table("./test/X_test.txt", header=FALSE, colClasses = "numeric", col.names=features[,2])
subject_test <- read.table("./test/subject_test.txt", header=FALSE, col.names=c("subject"))
subject_train <- read.table("./train/subject_train.txt", header=FALSE, col.names=c("subject"))
y_test <- read.table("./test/y_test.txt", header=FALSE, col.names=c("activity"))
y_train <- read.table("./train/y_train.txt", header=FALSE, col.names=c("activity"))
tmp_test <- cbind(test,subject_test)
tmp_train <- cbind(train,subject_train)
final_test <- cbind(tmp_test,y_test)
final_train <- cbind(tmp_train,y_train)
final <- rbind(final_train, final_test)
subsetFinal <- final[,grepl("subject|activity|mean|std", names(final))]
subsetFinal$activity[subsetFinal$activity == 1] <- "Walking"
subsetFinal$activity[subsetFinal$activity == 2] <- "WalkingUp"
subsetFinal$activity[subsetFinal$activity == 3] <- "WalkingDown"
subsetFinal$activity[subsetFinal$activity == 4] <- "Sitting"
subsetFinal$activity[subsetFinal$activity == 5] <- "Standing"
subsetFinal$activity[subsetFinal$activity == 6] <- "Laying"
subsetFinal$activity <- as.factor(subsetFinal$activity)
names(subsetFinal) <- sub("BodyBody", "Body", names(subsetFinal))
names(subsetFinal) <- sub("^t", "time", names(subsetFinal))
names(subsetFinal) <- sub("^f", "freq", names(subsetFinal))
names(subsetFinal) <- sub("...X", ".X", names(subsetFinal))
names(subsetFinal) <- sub("...Y", ".Y", names(subsetFinal))
names(subsetFinal) <- sub("...Z", ".Z", names(subsetFinal))
subsetFinal$subject[subsetFinal$subject == 1] <- "User01"
subsetFinal$subject[subsetFinal$subject == 2] <- "User02"
subsetFinal$subject[subsetFinal$subject == 3] <- "User03"
subsetFinal$subject[subsetFinal$subject == 4] <- "User04"
subsetFinal$subject[subsetFinal$subject == 5] <- "User05"
subsetFinal$subject[subsetFinal$subject == 6] <- "User06"
subsetFinal$subject[subsetFinal$subject == 7] <- "User07"
subsetFinal$subject[subsetFinal$subject == 8] <- "User08"
subsetFinal$subject[subsetFinal$subject == 9] <- "User09"
subsetFinal$subject[subsetFinal$subject == 10] <- "User10"
subsetFinal$subject[subsetFinal$subject == 11] <- "User11"
subsetFinal$subject[subsetFinal$subject == 12] <- "User12"
subsetFinal$subject[subsetFinal$subject == 13] <- "User13"
subsetFinal$subject[subsetFinal$subject == 14] <- "User14"
subsetFinal$subject[subsetFinal$subject == 15] <- "User15"
subsetFinal$subject[subsetFinal$subject == 16] <- "User16"
subsetFinal$subject[subsetFinal$subject == 17] <- "User17"
subsetFinal$subject[subsetFinal$subject == 18] <- "User18"
subsetFinal$subject[subsetFinal$subject == 19] <- "User19"
subsetFinal$subject[subsetFinal$subject == 20] <- "User20"
subsetFinal$subject[subsetFinal$subject == 21] <- "User21"
subsetFinal$subject[subsetFinal$subject == 22] <- "User22"
subsetFinal$subject[subsetFinal$subject == 23] <- "User23"
subsetFinal$subject[subsetFinal$subject == 24] <- "User24"
subsetFinal$subject[subsetFinal$subject == 25] <- "User25"
subsetFinal$subject[subsetFinal$subject == 26] <- "User26"
subsetFinal$subject[subsetFinal$subject == 27] <- "User27"
subsetFinal$subject[subsetFinal$subject == 28] <- "User28"
subsetFinal$subject[subsetFinal$subject == 29] <- "User29"
subsetFinal$subject[subsetFinal$subject == 30] <- "User30" 
subsetFinal$subject <- as.factor(subsetFinal$subject)
temp <- data.table(subsetFinal)
tidyFinal <- temp[, lapply(.SD, mean), by = 'subject,activity']
write.table(tidyFinal, file = "tidy.txt", row.name = FALSE)
