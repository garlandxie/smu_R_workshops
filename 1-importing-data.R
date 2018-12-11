# SMU R Coding workshop - importing data 
# Purpose: teach students and professors how to import data
# as well as creating R scripts (so it's 2-in-1 thing here)
# Code developed by Garland Xie (garlandxie@smu.ca)

# Install libraries  ------------------------------------------------------
install.packages(c("readr", "readxl"))

# Import libraries --------------------------------------------------------
library(readr)   # for reading in csv files 
library(readxl)  # for reading in excel files 

# Some notes on libraries

# Installing libraries depend on the current version of R installed in
# your laptop. Remember that certain people update these libraries and 
# it varies on the version of R

# Bottom-right window of R studio shows the list of libraries 
# currently installed in R
# quick way to check what's installed or not (and their versions)

# All R libraries should contain documentation for each respective
# function. You can check these for more info about what they do

# Import data -------------------------------------------------------------

# Importing data comes in many shapes and sizes in R
# Relatively easy to import data if they have a defined structure: 
  # text files, excel files, or google spreadsheets (so think table formats)
# A little bit harder when it's more messy and unstructured: 
  # web pages (think scraping data from lots of lines of code)

# In my experience, a lot of people import their data either through:
  # Excel 
  # Comma-seprated delimited files(CSV)
# So we'll just use these two examples for today
  # Each of these two examples have their own advantages and disadvantages

# Importing csv files ------------------------------------------------------

  # The set-up fora comma-separated delimited files is simple:
  # 1,2,3 ==> each row has its values separated by just commas
  # the beauty of this file format is that it'll never degrade
  # excel file formats might get upgraded and any changes might affect import
  # plus, the simplicity of this format means a smaller file size 

# strings are factors by default
catdf1_csv <- read.csv("cat_stuff_by_commas.csv")

# automatically: strings are NOT factors (which is good)
catdf2_csv <- read_csv("cat_stuff_by_commas.csv")

# I like doing sanity checks so let's check if every cells is
# equal between both data-frames (remember: the results should be TRUE)
all(catdf1_csv == catdf2_csv)

# Hmm. looks like we have missing values (NA) in our data-sets
# We can just remove missing values for now
# Looks like both read_csv and read.csv interpret the remarks
# column differently (characters vs factors)
all(catdf1_csv == catdf2_csv, na.rm = TRUE) 

# a little fancier: telling R what data types for each column
# why: by default, read_csv tries to guess what the data types are
# in some cases, you might need to tell R to change into a factor 
# e.g., experimental treatments are masked as integers rather than factors
cat_df2_csv <- read_csv("cat_stuff_by_commas.csv", 
                    col_types = cols(cat_ID = col_double(),
                                     cat_names = col_character(),
                                     height_cm = col_double(),
                                     weight_lbs = col_double(),
                                     remarks = col_character()
                                    )
                    )

# Importing excel files ----------------------------------------------------

# Unlike csv files, excel files have multiple work-sheets
catdf1_xls <- read_excel("cat_stuff_in_excel.xlsx", sheet = 1) 

# More robust: call the sheet name instead of the number
# You might accidentally switch the worksheets around (happened to me)
# So this method is easier to reproduce if someone else looked at your code
catdf2_xls <- read_excel("cat_stuff_in_excel.xlsx", sheet = "cat_traits")

# Sanity check
all(catdf1_xls == catdf2_xls, na.rm = TRUE)

# Similarly, R will parse both CSV and XLS into similar data structures (df)
# Should hold true for the datasets we've brought in from readr and readxl
all(catdf2_csv == catdf2_xls, na.rm = TRUE)

# Inspecting data frames -------------------------------------------------------

# chances are you'll be using data frames a lot when you're using R
# that being said, it might be a good idea to show some functions 
# that let you know explore more about the data frames you'll be working with

# 1) Check the packaging: did you import the right data?
# One way to verify this is to check the number of rows and columns

dim(catdf2_csv)  # both rows and columns 
nrow(catdf2_csv) # number of rows
ncol(catdf2_csv) # number of columns

# 2) Check the head and tails
# in some cases, you might have an extra comment line on your worksheet
# you don't want to catch you by surprise so double-check this first

head(catdf2_csv, n = 10) # first ten rows (use the n argument for big datasets)
tail(catdf2_csv, n = 10) # first ten rows (last ten rows)


# 3) Check the structure of the data-frame
# Verify that your columns have the correct data types (up to the analyst)
str(catdf1_csv)

# 4) Check the summary of the dataset
# aka summary statistics
# Quick look at ranges, averages and medians to get a sense of your data
summary(catdf2_csv)

# 5) Check your n's per categorical variable 
# Like seeing if you have replicate ID numbers
# Not very useful for numeric values tbh
table(catdf2_csv$cat_ID) 

# 6) Plotting histograms
# What kind of shape does your sample form? 
# You might see a classic bell-curved shape (normal distribution)
hist_heigt <- hist(catdf2_csv$height_cm, main = "", xlab = "height (cm)")
