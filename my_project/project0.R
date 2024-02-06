## R project for Monitoring Ecosystem Changes and Functioning Exam ##
# Golini Alessandra

# the aim of this project is to investigate how the forest cover can change depending on the considered definition of forest.
# in fact, we may consider an area forested if 30 percent of the land is covered with trees;
# or if  there is 10 percent tree cover.

# Install the following packages

# Recall the packages
library(terra) 
#provides a framework for handling raster data (gridded spatial data) and conducting various spatial analysis tasks efficiently.
#It is designed to handle large datasets that may not fit into memory, making it suitable for working with big spatial data.
library(ncdf4) 


# First, set the working directory
setwd("C:/Users/aless/OneDrive - Alma Mater Studiorum Università di Bologna/Global Change Ecology and SDGs/Spatial Ecology in R/project")

# Let's now import the data with a new function from terra: rast(name of the image)
forest10 <- rast("globaltreecover10pct_etm_2000_2009_lrg.jpg")
plotRGB(forest10, r=1, g=2, b=3)



