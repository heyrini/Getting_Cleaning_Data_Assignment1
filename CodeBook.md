
##CodeBook describes all the variables used in run_Analysis.R and the pre-processing steps
-------------------------------------------------------------------------------------------

###Data Collection and Description 
Raw data was downloaded from this website: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The description of  experiments as mentioned in this website http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
####Data Set Information:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

###Attribute Information:
For each record in the dataset it is provided: 
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

###Data Transformation and Variables used
The subject annotation and activity ids were merged with train and test datasets to create two intermediate datasets:
* Annotated.train
* Annotated.test

Then the two sets were merged to form the full data sets as 
* full.data

Then data was subsetted using only "mean" and "std" containing feature variables into 
* data.mean.std

Data was averaged by each feature based on subject and activity groups into
* data.mean.bygroups

This was written into a text file which is uploaded as
* Data.mean.by.sub.activity.txt
