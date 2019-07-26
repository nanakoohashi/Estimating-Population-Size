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
