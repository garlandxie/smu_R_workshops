# SMU R Coding workshop for the Biology Department
# Purpose: teaching the basebone basics of R for students and professors
# Note: this is a really rough draft (but it does have cat names...)
# Code developed by Garland Xie (garlandxie@smu.ca)

# Data types in R --------------------------------------------------------------

# integers (think of ratings ==> how cute is your cat (from 1 to 5)?)

1 # really ugly 
2
3
4
5 # the cutest

# numeric (think of  height ==> how tall is your cat?)

14.5
15.5
10.1
11.0
12.4

# logical - TRUE or FALSE (think of: is your cat cute or not?)
TRUE
FALSE
TRUE
TRUE
FALSE

# strings - text characters (think of cat names!)
"Simba"
"Tigger"
"Max"
"Felix"
"Garfield"

# Data types - missing values (think: did the person bail out on the survey?)
NA
NA
NA
NA
NA

# Operators --------------------------------------------------------------------

# Arithmetic operators
1 + 1
2 - 2
3 * 3
4 / 4

# Logical operators - think of TRUE and FALSE again!
"Simba" == "Simba" # equals
"Simba" != "Tigger" # does not equals
3 > 4 # greater than
4 < 3 # less than
1 >= 2 # greater or equals to
2 <= 2 # less or equals to

# Vectors - aka a group of values -----------------------------------------------

# we can group values together using "vectors" 
# in some cases, you can think of vectors as group of recorded observations
# we have to give R a specific instruction to do so using the "c()" function

# vectors with the same data types 
c(1, 2, 3, 4, 5) 
c(TRUE, FALSE, TRUE)
c("Simba", "Tigger", "Max")

# remember: R can force vectors into a single data type!!
c(1, 2, "Max")     # turns it into a vector of string characters
c(1, TRUE, "Max")  # again, another vector of string characters

# exception: R usually won't change missing data types
c(NA, 1, "Max")

# Objects - aka trying to remember our data.. ----------------------------------

# so we can tell R to intepret some data for us
# but how do we remember our data if we need to recall it later on?
# well, we can assign any type of information to a given name (called objects)
# we have to explicitly assign names by using "-->"
# shortcut for this is "ALt + -" in R studio

# (Not so great) examples of naming objects
foo <- c("Simba", "Tigger", "Max", "Felix", "Garfield") # generic name
c <-  c("Simba", "Tigger", "Max") # avoid having same name as other functions
TRUE <-  c("Simba", "Tigger", "Max") # avoid using names that exist in base R
cat.names <-  c("Simba", "Tigger", "Max") # avoid function name conventions (S3)

# (Better) examples of naming objects
cat_id         <- c(1, 2, 3, 4, 5, 6)
cat_rating     <- c(1, 2, 3, 4, 5, NA)
cat_names      <- c("Simba", "Tigger", "Max", "Felix", "Garfield", NA)
cat_height_mm  <- c(14.5, 15.5, 10.1, 11.0, 12.4, NA)
is_cute_or_not <- c(TRUE, FALSE, FALSE, TRUE, TRUE, NA)

# Note: naming objects is harder than it looks - has to be memorable and short!

# You'll also notice the objects names pop up in the right-hand window 
# Here, you're storing the objects in a "local workspace" - global environment
# But it's only temporary - once you close R, (ideally) they should be gone

# if you want to remove an object
rm(foo)

# if you want to remove all objects - clear entire workspace 
# rm(list=ls())

# Vector indexing aka finding specific values in a vector ----------------------
# Sometimes we just want to access certain parts of our vector
# We can do this through indexing
# Think of place-holder numbers (like waiting line numbers) for each item 

# Recall: 
cat_names <- c("Simba", "Tigger", "Max", "Felix", "Garfield", NA)

# Getting specific cat names by their position in the vector
# Remember: first position is 1
cat_names[1]
cat_names[2]
cat_names[5]

# Getting creative: does the vector of cat names contain "Simba"?
cat_names %in% "Simba" # result: first place is Simba which is correct!

# Data frames - aka creating rows and columns ---------------------------------

# What if you want to recreate an table with rows and columns by hand?
# We can use another tool (data.frame) using two good methods: 

# 1) using assigned vectors with object names as columns
cat_df1 <- data.frame(cat_id,
                      cat_names,
                      cat_rating,
                      cat_height_mm,
                      is_cute_or_not)

# 2) manually typing in the vectors 
# notice how I've formatted my column names (col_name)
cat_df2 <- data.frame(
  id       = c(1, 2, 3, 4, 5, 6),
  names    = c("Simba", "Tigger", "Max", "Felix", "Garfield", NA),
  ratings  = c(1, 2, 3, 4, 5, NA),
  height   = c(14.5, 15.5, 10.1, 11.0, 12.4, NA),
  cute_ugly = c(TRUE, FALSE, FALSE, TRUE, TRUE, NA)
)

# Data frame indexing ----------------------------------------------------------

# just like vectors, we can also recall certain rows or columns
# [ , ] : left side is rows, right side is columns

# let's try just grabbing some columns first
cat_df1[, "cat_height_mm"] # calls out a vector 
cat_df1[, c("cat_height_mm", "cat_id")] # calls out a data-frame

# now, let's just grab some rows
cat_df1[1, ]     # first row
cat_df1[1:2, ]   # first two rows 
cat_df1[c(1,5), ] # first row and fifth row 
cat_df1[-1, ]    # grab everything but the first row 

# now let's combine both rows and columns
cat_df1[1:2, "cat_height_mm"]

# why do we have to know this?
# reason: we want to quickly find certain parts of data for specific purposes
# indexing helps us achieve this goal by subsetting our data 
# e.g., finding extreme values that don't make sense (subsetting rows)
# e.g., only analyzing only two factors in an experiment (subsetting columns)

# we can get a quick look at what's inside a data-frame which tells us: 
  # number of observations
  # number of columns
  # name of columns
  # data types for each column
  # a quick look at the first X rows of data
str(cat_df1)

# we can also grab columns by: 
cat_df1$cat_id

# Learning about functions -----------------------------------------------------

# You've noticed you've used a couple of functions("tools") in R 

c()
data.frame()

# These tools are formally called functions: 
# all of them have a required input and additional arguments to form an output
# think of using a microwave: you have to give some instructions for it to work
# required input - opening the door, how long to cook (eg 2 minutes)
# additional arguments - medium heat
# output - a cooked meal 

# a decent example that everyone has to use: calculating averages
avg_height1 <- mean(cat_height_mm) # required input: a group of numeric values

# Notice the weird output: NA_real_

# there is a default setting for this function: na.rm (removng missing values)
avg_height2 <- mean(cat_height_mm, na.rm = FALSE)

# in theory, these two vectors should be the same 
# we know this is true because the outputs are exactly the same for both

# let's try changing our default setting
avg_height3 <- mean(cat_height_mm, na.rm = TRUE) # from FALSE to TRUE

# in reality: there are lot more settings we can play around with

# every tool is open-sourced - you can peek under the hood to see how it works 
# also, a lot of our workflow in R revolves heavily around using functions
# some functions are already installed in R (like the ones we've used)
# for other functions, we install them separately as toolkits (libraries)

# if you want help for a certain function, use ?function_name
# here, you can see more details about the function:
  # what toolkit the function derives from
  # what the function does
  # what are the required inputs and additional arguments for each function
  # more details to clarify some concepts
  # some examples to help you with coding
?data.frame











