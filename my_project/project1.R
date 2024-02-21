## R project for Monitoring Ecosystem Changes and Functioning Exam ##
# Golini Alessandra

# The aim of this project is to investigate the Amazon forest reduction of last two decades and understand the importance of Indigenous populations for its protection.
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

# Recall the packages used
library(raster)
library(overlap)
library(devtools)
library(sf)

# First, set the working directory
setwd("C:/Users/aless/OneDrive - Alma Mater Studiorum Università di Bologna/Global Change Ecology and SDGs/Spatial Ecology in R/project")

# Import data from RAIGS
ind <- rast("Tis/Tis_territoriosIndigenas.jpg")
plot(ind)

# Total deforestation points
def <- rast("Def/deforestacion2001-2020.tif")
cl <- colorRampPalette(c("black", "red", "yellow")) (100)
plot(def, col = cl, cex = 1.5)

# Amazon basin limits (lim, limr) and indigenous territories (tir)
lim <- st_read("Limites/Lim_Biogeografico.shp")
limr <- st_read("Limites/Lim_Raisg.shp")
tir <- st_read("Tis/Tis_territoriosIndigenas.shp")

# Natural Protected Areas (Áreas Naturales Protegidas, ANP in Spanish)
prot <- st_read("Anps/ANP_departamental.shp")
prot_nat <- st_read("Anps/ANP_nacional.shp")
prot_forest <- st_read("Anps/ANP_ReservaFlorestal.shp")

# Plot Natural Protected Areas
plot(NA, xlim = c(-82.12228, -41.60457), ylim = c(-21.21057, 12.55144), xlab = "latitude", ylab = "longitude", main = "Ntural Protected Areas", asp = 1)
plot(limr["shape_Area"], add = TRUE, col = "transparent", border = "red", lwd = 2, asp = 1)
plot(prot["shape_Area"], add=TRUE, col = "green", asp=1)
plot(prot_nat["shape_Area"], add = TRUE, col = "dark green", asp=1)
plot(prot_forest["shape_Area"], add = TRUE, col = "light green", asp=1)
# Add a legend
legend("topleft", legend = c("Amazon limits", "Provincial NPAs", "National NPAs", "Forest reserve"), col = c("red", "green", "dark green", "light green"), pch = 15)

# Plot Indigenous territories
plot(NA, xlim = c(-82.12228, -41.60457), ylim = c(-21.21057, 12.55144), xlab = "latitude", ylab = "longitude", main = "Indigenous territories", asp = 1)
plot(limr["shape_Area"], add=TRUE, col = "transparent", border = "red", lwd = 2, xlim = c(-82.12228, -41.60457), ylim = c(-21.21057, 12.55144))
plot(tir["shape_Area"], add=TRUE, col ="yellow", asp=1)
# Add a legend
legend("topleft", legend = c("Amazon limits", "Indigenous territories"), col = c("red", "yellow"), pch = 15)

# Plot deforestation
plot(NA, xlim = c(-82.12228, -41.60457), ylim = c(-21.21057, 12.55144), xlab = "latitude", ylab = "longitude", main = "Amazon deforestation 2000-2020", asp = 1)
plot(limr["shape_Area"], add = TRUE, col = "transparent", border = "red", lwd = 2, asp = 1)
plot(def, add = TRUE, col = cl, cex = 2, asp = 1)
# Add a legend
legend("topleft", legend = c("Amazon limits", "Deforestation"), col = c("red", cl), pch = 15)

# One plot
plot(NA, xlim = c(-82.12228, -41.60457), ylim = c(-21.21057, 12.55144), xlab = "latitude", ylab = "longitude", main = "Amazon deforestation 2000-2020", asp = 1)
plot(limr["shape_Area"], add = TRUE, col = "transparent", border = "red", lwd = 2, asp = 1)
plot(prot["shape_Area"], add=TRUE, col = "green", asp=1)
plot(prot_nat["shape_Area"], add = TRUE, col = "dark green", asp=1)
plot(prot_forest["shape_Area"], add = TRUE, col = "light green", asp=1)
plot(tir["shape_Area"], add=TRUE, col ="yellow", asp=1)
plot(def, add = TRUE, col = cl, cex = 2, asp = 1)
# Add a legend
legend("topleft", legend = c("Amazon limits", "Provincial NPAs", "National NPAs", "Forest reserve", "Indigenous territories", "Deforestation"), col = c("red","green", "dark green", "light green", "yellow", cl), pch = 15)


# Percentage of indigenous territories
tir_area <- sum(tir$shape_Area)
tot_area <- limr$shape_Area
ind_perc <- (tir_area/tot_area)*100
round(ind_perc,1) #28.4% of the total Amazon forest is classified as indigenous territory


