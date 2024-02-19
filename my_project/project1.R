## R project for Monitoring Ecosystem Changes and Functioning Exam ##
# Golini Alessandra


# The aim of this project is to investigate the Amazon forest reduction of last decades and understand the importance of Indigenous populations for its protection.
# To do so, 

# Install the following packages
install.packages("spatstat") #provides a comprehensive toolbox for analyzing spatial point pattern data. It includes functions for exploratory data analysis, model-fitting, simulation, and visualization of spatial point patterns.
install.packages("terra") #package for spatial data manipulation and analysis. It provides methods for handling raster data, including reading, writing, processing, and analyzing large raster datasets
install.packages("sdm") #species distribution modeling
install.packages("rgdal") #to read and write raster and vector spatial data formats
install.packages("overlap") #to calculate and visualize spatial overlap between different geographic features, such as polygons or points
install.packages("devtools") #to streamline the process of developing, documenting, testing, and sharing R packages, other than installing packages from GitHub repositories
devtools::install_github("ducciorocchini/imageRy") # install imagery

# Recall the packages
library(spatstat)
library(terra) #provides a framework for handling raster data (gridded spatial data) and conducting various spatial analysis tasks efficiently.
#It is designed to handle large datasets that may not fit into memory, making it suitable for working with big spatial data.
library(sdm)
library(rgdal)
library(vegan)
library(overlap)
library(devtools)
library(ncdf4) 
library(imageRy)


# First, set the working directory
setwd("C:/Users/aless/OneDrive - Alma Mater Studiorum Università di Bologna/Global Change Ecology and SDGs/Spatial Ecology in R/project")

# Let's now import the data with a new function from terra: rast(name of the image)
forest10 <- rast("globaltreecover10pct_etm_2000_2009_lrg.jpg")
plotRGB(forest10, r=1, g=2, b=3)
