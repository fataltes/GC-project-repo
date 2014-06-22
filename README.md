Collect, Clean, and Work with Data
============================================
In this repository you will find files for Course Project of Getting and Cleaning Data.

To use these files you must attend some notes

1. Set your working directory in R to the path you clone this repository

2. You must be connected to internet while running "run_analysis.R".
It's going to download the dataset zip file.

3. Running file run_analysis.R you can see all the results.

4. You can read comments in run_analysis.R or CodeBook.md to
understand the steps of code.

5. For CodeBook you can use CodeBook.Rmd but library knitr is required.
or you can just open CodeBook.md or CodeBook.html
This codebook contains information about the code and some results 
as samples.

6. If you are using CodeBook.Rmd, after the first successful download you must 
put the expression "cache=TRUE" in the first chunk of r like this : {r cache=TRUE}
so it doesn't try to download the data set every time you run CodeBook.Rmd

7. Tidy data is a matrix with row names and column names.
downloading the file from coursera you must open it with read.table
