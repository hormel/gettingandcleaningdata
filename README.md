##
## This repository contains a script to produce a tidy data set summarizing
## the data in the UCI Human Activity Recognition (HAR) dataset by subject
## by activity.  Four files are included:
## 
##     README.md          This file
##     CodeBook.md        A codebook describing the data in the tidy data set
##     run_analysis.R     The R script which generates the tidy data set and
##                        saves to file
##     tidydataset.txt    A file containing the tidy data set.  The file
##                        includes row headers and contains
##                        one line for each subject and activity pair.  This
##                        can be read back into R with the command:
##                            read.table ("tidydataset.txt")
## 
## The script groups the UCI HAR data by subject by activity (30 subjects x
## 6 activties each), then provides the average of the mean and standard
## deviation of each data sample collected:
##     1) Body Acceleration and Jerk signals along each axis
##     2) Body Gyro (angular momentum) and Jerk signals along each axis
##     3) Gravity Acceleration along each axis
##     4) Magnitudes of each of the above signals
##     5) Both time and frequency domain signals are provided
## 
## For the standard deviation of each sample provided, the average across
## samples provided is the simple average, not the sum of squares average.
## 