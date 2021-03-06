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
population <- gather(data = population, key = Year, value = Population, -State)

# Drop State column
population <- subset(population, select = -c(State))

# Change Year from character vector to a YYYY date vector
population$Year <- as.numeric(population$Year)

# Linear model
fit <- lm(Population ~ Year, population)

# Plot points and linear regression line
p <- ggplot(population, aes(x = Year, y = Population)) + 
  geom_point() + 
  labs(x = 'Year', y = 'Population', title = "Linear Regression for Population on Year for the State of Colorado") + 

# Start y-axis at 0
p <- p + expand_limits(y = 0)
p

# Display linear regression equation and r-squared value on graph
yintercept <- format(coef(fit)[1], scientific = FALSE)
slope <- format(coef(fit)[2], scientific = FALSE)
rsquared <- summary(fit)$r.squared
eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(r)^2~"="~r2, 
   list(a = format(unname(yintercept), digits = 4),
        b = format(unname(slope), digits = 4),
        r2 = rsquared))
text <- as.character(as.expression(eq));
xx <- 2012
yy <- 2000000
p + geom_text(data = population, aes(x = xx, y = yy), label = text, parse = TRUE)

#Tabulate linear model:
summary(fit)
