# Import packages
library("ggplot2", lib.loc="~/R/win-library/3.6")
library("dplyr", lib.loc="~/R/win-library/3.6")
library("tidyr", lib.loc="~/R/win-library/3.6")
library("reshape2", lib.loc="~/R/win-library/3.6")
library("tidyverse", lib.loc="~/R/win-library/3.6")
library("ggpmisc", lib.loc="~/R/win-library/3.6")
library("broom", lib.loc="~/R/win-library/3.6")

# Import .csv file
population.csv <- read.csv("C:/Users/Nanako/Desktop/R/nst-est2016-01.csv", header = TRUE)
str(population.csv)
View(population.csv)

# Assign the .csv file to a variable
population <- population.csv

# Create a dataframe
population <- tbl_df(population)
as.data.frame(population)

# Select Colorado row
population <- subset(population, (Geographic.Area == 'Colorado'))

# Drop Census.2010 and Estimate.Base.2010 columns
population <- subset(population, select = -c(Census.2010, Estimates.Base.2010))

# Remove first letter of each column name
names(population) <- substring(names(population),2,5)

# Rename first column
colnames(population)[1] <- "State"

# Wide to long conversion
