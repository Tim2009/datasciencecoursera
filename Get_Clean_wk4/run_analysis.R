

#Process_UCI_file <- function(){
  #download and unzip raw data files
  setwd("/Users/kylieandtim/Data_Science_Coursera/Clean_Data_1")
  ######  turn off download for testing
  #download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "temp.dat")
  dateDownloaded <- date()
  unzip("temp.dat", exdir = "./UCI_data") #change back to for final
  
  #load and clean Feature and Activity name UCI data files
  setwd("/Users/kylieandtim/Data_Science_Coursera/Clean_Data_1/UCI_data/UCI HAR Dataset")
  Feature_names <- read.table("features.txt", sep = " ")
  Variable_names <- paste(Feature_names$V2, Feature_names$V1, sep = "_")
#  Variable_names <- as.character(Feature_names2$V2)
  Variable_names <- gsub("\\(", "", Variable_names) #for both shapes brackets
  Variable_names <- gsub("\\)", "", Variable_names)
  Variable_names <- gsub("-", "_", Variable_names)
#  colnames(UCI_Combo2)<- c("Subject", "Activity", Variable_names)
    #colnames(X_test_df) <- c("Subject", "Activity", Feature_names) #for combined df headings
  Activity_names <- read.table("activity_labels.txt", sep = " ")
  colnames(Activity_names) <- c("Activity", "Activity_Name")
  
  #load and clean test data
  setwd("/Users/kylieandtim/Data_Science_Coursera/Clean_Data_1/UCI_data/UCI HAR Dataset/test")
  X_Test_raw <- readLines("X_test.txt") #adjust path for diff data - repeat as req'd
  X_Test <- gsub("  ", " ", X_Test_raw)
  Subject_Test <- readLines("subject_test.txt")
  Activity_Test <- readLines("y_test.txt")
  UCI_Test_df <- data.frame("Subject" = Subject_Test, "Activity" = Activity_Test) #strings as factors?
  
  X_test_split <- strsplit(X_Test, split = " ")
  X_Test_df <- data.frame(do.call(rbind, X_test_split)) #checkSAF for train
  X_Test_df[,1] <- NULL #remove 1st (blank) line
  UCI_Test_combo <- cbind(UCI_Test_df, X_Test_df)
  
  #load training data
  setwd("/Users/kylieandtim/Data_Science_Coursera/Clean_Data_1/UCI_data/UCI HAR Dataset/train")
  #getwd()
  X_Train_raw <- readLines("X_train.txt") #adjust path for diff data - repeat as req'd 
  X_Train <- gsub("  ", " ", X_Train_raw)
  Subject_Train <- readLines("subject_train.txt")
  Activity_Train <- readLines("y_train.txt")
  UCI_Train_df <- data.frame("Subject" = Subject_Train, "Activity" = Activity_Train) #strings as factors?
  
  X_train_split <- strsplit(X_Train, split = " ")
  X_Train_df <- data.frame(do.call(rbind, X_train_split))
  X_Train_df[,1] <- NULL #remove 1st (blank) line
  UCI_Train_combo <- cbind(UCI_Train_df, X_Train_df)
  
  #Combine Test and Train
  UCI_Combo <- rbind(UCI_Test_combo, UCI_Train_combo)
  
  #Add column headings
  colnames(UCI_Combo) <- c("Subject", "Activity", Variable_names) #for combined df headings
  
  #convert data variables to numeric
  indx <- sapply(UCI_Combo, is.factor)
  indx[1:2] <- FALSE #correct for Subject and Activity columns
  UCI_Combo[indx] <- lapply(UCI_Combo[indx], function(x) as.numeric(as.character(x)))
  
  #Rename Activity with meaningful names (this is clumsy but functional) 
  UCI_Combo <- merge(UCI_Combo, Activity_names) #rename as combo in final
  Activity_list <- UCI_Combo$Activity_Name
  UCI_Combo$Activity_Name <- NULL
  UCI_Combo$Activity <- Activity_list
  
  #Select out mean and Std Dev columns into new dataframe
  library(dplyr) #ensure dplyr package installed
  UCI_sdmean <- select(UCI_Combo, Subject, Activity, contains("mean"), contains("std")) #so don't need grep
  
  #Calculate means for each variable in UCI_sdmean, by Subject and Activity
  tail(names(UCI_sdmean),1) #determine last column name for summarise
  UCI_grouped <- group_by(UCI_sdmean, Subject, Activity)
  UCI_Averages <- summarise_each(UCI_grouped,funs(mean, "mean", mean(., na.rm = TRUE)), tBodyAcc_mean_X_1:fBodyBodyGyroJerkMag_std_543)
  
  setwd("/Users/kylieandtim/Data_Science_Coursera/Clean_Data_1")
  write.table(UCI_Averages, file = "UCI_summary.txt", row.name = FALSE)
  
  
#}