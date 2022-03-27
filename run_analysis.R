library("dplyr")

getwd()
##nomes das colunas

feat <- read.table("D:/OneDrive/Documentos/GitHub/Getting-and-Cleaning-Data/UCI HAR Dataset/features.txt", col.names = c("n","functions"))

trainx <- read.table("D:/OneDrive/Documentos/GitHub/Getting-and-Cleaning-Data/UCI HAR Dataset/train/X_train.txt", col.names = feat$functions)
testx <- read.table("D:/OneDrive/Documentos/GitHub/Getting-and-Cleaning-Data/UCI HAR Dataset/test/X_test.txt", col.names = feat$functions)

xjunto <- rbind(trainx, testx)

trainy <- read.table("D:/OneDrive/Documentos/GitHub/Getting-and-Cleaning-Data/UCI HAR Dataset/train/y_train.txt", col.names = "code")
testy <- read.table("D:/OneDrive/Documentos/GitHub/Getting-and-Cleaning-Data/UCI HAR Dataset/test/Y_test.txt", col.names = "code")

yjunto <- rbind(trainy, testy)

trainsub <- read.table("D:/OneDrive/Documentos/GitHub/Getting-and-Cleaning-Data/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
'testsub' <- read.table("D:/OneDrive/Documentos/GitHub/Getting-and-Cleaning-Data/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

subjunto <- rbind(trainsub, testsub)

alldata <- cbind(xjunto, yjunto, subjunto)

DataFinal <- alldata %>% 
  select(subject, code, contains("mean"), contains("std"))

act <- read.table("D:/OneDrive/Documentos/GitHub/Getting-and-Cleaning-Data/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

DataFinal$code <- act[DataFinal$code, 2]

View(DataFinal)

names(DataFinal)[2] = "atividade"
names(DataFinal)<-gsub("Acc", "Accelerometer ", names(DataFinal),ignore.case = TRUE)
names(DataFinal)<-gsub("Gyro", "Gyroscope ", names(DataFinal),ignore.case = TRUE)
names(DataFinal)<-gsub("BodyBody", "Body ", names(DataFinal),ignore.case = TRUE)
names(DataFinal)<-gsub("Mag", "Magnitude ", names(DataFinal),ignore.case = TRUE)
names(DataFinal)<-gsub("^t", "Time ", names(DataFinal),ignore.case = TRUE)
names(DataFinal)<-gsub("^f", "Frequency ", names(DataFinal),ignore.case = TRUE)
names(DataFinal)<-gsub("tBody", "TimeBody ", names(DataFinal),ignore.case = TRUE)
names(DataFinal)<-gsub(".mean", "Mean ", names(DataFinal), ignore.case = TRUE)
names(DataFinal)<-gsub("-std()", "STD ", names(DataFinal), ignore.case = TRUE)
names(DataFinal)<-gsub("-freq()", "Frequency ", names(DataFinal), ignore.case = TRUE)
names(DataFinal)<-gsub("angle", "Angle ", names(DataFinal), ignore.case = TRUE)
names(DataFinal)<-gsub("gravity", "Gravity ", names(DataFinal), ignore.case = TRUE)

View(DataFinal)


Resposta <- DataFinal %>%
  group_by(subject, atividade) %>%
  summarise_all(funs(mean))

View(Resposta)

write.table(Resposta, "Resposta.txt", row.name=FALSE)
