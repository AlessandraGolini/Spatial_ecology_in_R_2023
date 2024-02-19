## R project for Monitoring Ecosystem Changes and Functioning Exam ##
# Golini Alessandra


# The aim of this project is to investigate the Amazon forest reduction of last decades and understand the importance of Indigenous populations for its protection.
# To do so, 

# Install the following packages
install.packages("spatstat") #provides a comprehensive toolbox for analyzing spatial point pattern data. It includes functions for exploratory data analysis, 
#model-fitting, simulation, and visualization of spatial point patterns.
install.packages("terra")  #provides a framework for handling raster data (gridded spatial data) and conducting various spatial analysis tasks efficiently.
#It is designed to handle large datasets that may not fit into memory, making it suitable for working with big spatial data.
install.packages("sdm") #species distribution modeling
install.packages("rgdal") #to read and write raster and vector spatial data formats
install.packages("overlap") #to calculate and visualize spatial overlap between different geographic features, such as polygons or points
install.packages("devtools") #to streamline the process of developing, documenting, testing, and sharing R packages, other than installing packages from GitHub repositories.
devtools::install_github("ducciorocchini/imageRy") # install imagery

# Recall the packages
library(spatstat)
library(terra)
library(sdm)
library(rgdal)
library(vegan)
library(overlap)
library(devtools)
library(ncdf4) 
library(imageRy)
library(xml2)

# First, set the working directory
setwd("C:/Users/aless/OneDrive - Alma Mater Studiorum Università di Bologna/Global Change Ecology and SDGs/Spatial Ecology in R/project")

# Let's now import the data with a new function from terra: rast("name of the image")
forest10 <- read_xml("c_gls_NDVI_PROD-DESC_201909210000_GLOBE_PROBAV_V2.2.1.xml")
plotRGB(forest10, r=1, g=2, b=3)

