# GACDCP

<br />Getting and Cleaning Data Course Project - Week 4
<br />Original source file: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
<br />
<br />This project contains three main files: 
<ol type="1">
  <li>run_analysis.R - code in R.</li>
  <li>tidydata.txt - result of run_analysis.R script.</li>
  <li>codebook.md - codebook.</li>
</ol>
<br /> General information:
<ol type="1">
  <li>R script downloads source data to separate data frames (test and training).</li>
  <li>Script merges data from training and test data fames.</li>
  <li>Script clean data and leave only subject_id, label (of activity) and all measures with mean and standard deviation column.</li>
  <li>Script calculates mean of each measure column by subject_id and label.</li>
  <li>Results are saved in tidydata.txt file.</li>
</ol>
