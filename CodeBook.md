# Code Book

The `run_analysis.R`script does the following actions:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The data for which this script is usefull are found in this link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Variables & Functions

###Step1.
* All the raw data were downloaded by `read.table()` function.
* `xtrain``ytrain``subjtrain``xtest``ytest``subjtest` store the raw data, and were merged in `train` and `test` with `cbind()`.
* Complet raw data was merged in `alldata` with `rbind()`. 

###Step 2. & Step 4
* This two steps were done together to simplifly the code.
* `features` stores the names of the variables, and they were passed to data with `names()`, including also the names of the first and second columns ("subject" and "activity").
* With `grep()` and the regular exptression `.*mean.*|.*std.*`, only the mean and standart deviation were chosed. this data was stored in `datawanted`.

###Step3.
* `actlabels` stores the names of the levels of the "activity" variable.
* First and second columns wer setted as factors with `as.factor()` and `factor()`.

###Step 5. 
* With `aggregate()` the mean of the data grouped by "activity" and "subject" variables were done, and stored in `tidydata`. 
* `write.table()` function was used to get the `Tidy data set.txt` file.
