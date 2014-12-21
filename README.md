gacd
====

Getting and Cleaning Data Course Project
========================================

Getting and Cleaning Data is the 3rd course in the John Hopkins University Data Science Track on www.coursera.org.

This file README.md, along with the R Script run_analysis.R, CodeBook.md, and tidydata.txt are fulfillment of the requirements for the course project.

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis. 

Requirements:
1) a tidy data set as described below, 
2) a link to a Github repository with your script for performing the analysis, and 
3) a code book that describes the variables, the data, and any transformations or work performed to clean up the data called CodeBook.md. 
Also include a README.md in the repo with the scripts. 
This repo explains how all of the scripts work and how they are connected.  


The data for the project
--------
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Abstract: Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) 
while carrying a waist-mounted smartphone with embedded inertial sensors.

see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data cleaning and Processing
----------------------------
Once the data for the project is un-zipped to a directory,
it will be necessary to indicate the path to the directory 
in the script file run_analysis.R which can then be run in
its entirety and will performs the following actions:

1. Merges the training and the test sets to create one data set.
2. Extracts the measurements on the mean and standard deviation for each measurement.
3. Names the activities in the data set
4. Labels the data set with descriptive variable names
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. (tidydata.txt)

