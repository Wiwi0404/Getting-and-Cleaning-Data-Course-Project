# Getting-and-Cleaning-Data-Course-Project

Before running the code, please set the working directory to the folder "UCI HAR Dataset" where you extract the zip file to.

The code will first read the data, subject ID, activity ID from both train and test folder. Then they will be combined into a single data frame.
After that it will extract the mean and standard deviation of each measurement out together with the id and activity id.
Then using the "activity_labels.txt" as the mapping table, it will map the activity_id to the activity names.
Also based on "features.txt" file, it will replace the headers in the combined data frame from measurement code to meansurement names.
Finally it calculates the average for each variable in data frame grouped by subject id and activity.
