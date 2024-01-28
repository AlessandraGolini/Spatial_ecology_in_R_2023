# Code realted to population ecology

# A package is needed for point pattern analysis: spatstat (frm the network CRAN)
install.packages("spatstat") # this is the function used to install packages and the argument is between round parenthesis, with quotes because the package is still outside R
library(spatstat)

# the data are directly inside the packages
# let's use the bei data:
# data description 
#https://cran.r-project.org/web/packages/spatstat/index.html

bei #trees in the tropical forest 
plot(bei) 

#the points in the plot are huge with respect to the area, so I change them with "character exageration"
plot(bei, cex = 0.2)
#changing the symbol with pch
plot(bei, cex = 0.4, pch=19)

#inside the package there is another dataset: additional dataset
bei.extra

#to extract a single part of a dataset there are different ways
plot(bei.extra)
#a RASTER is an image made of pixels
#we need to use only one element of the dataset (only elevation)

#let's use only part of the dataset: elev
plot(bei.extra$elev) # the dollar symbol links the element to the dataset but we assign it to an object
elevation <- bei.extra$elev
plot(elevation)

#second method to select elements
elevation2 <- bei.extra[[1]] #double quadratic parenthesis because we're in two dimensions
plot(elevation2)

##########################################################

# passing from points to a coninuous surface: INTERPOLATION
densitymap <- density(bei)
plot(densitymap)
points(bei, cex=.5)

cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100) #merge all the colors together in one array
#100 is the gradient = number of different colors passing from one to another
plot(densitymap, col = cl)
# it is important to use the yellow color for high values because it is the first one you see in a map!!
# do never ever use a rainbow color palettes! because they are a mess for color-blind people
# https://r-graph-gallery.com/42-colors-names_files/figure-html/thecode-1.png COLORS IN R

cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(4)
plot(densitymap, col = cl) #there is no continuity because we use only 4 colors!

###
plot(bei.extra) #we want to select the first element of the dataset
elev <- bei.extra[[1]]     #elev <- bei.extra$elev
plot(elev)

###
par(mfrow = c(1,2)) #multiframe of 1row  and 2columns
plot(densitymap)
plot(elev)

par(mfrow = c(2,1))
plot(densitymap)
plot(elevation)

par(mfrow = c(1,3))
plot(bei)
plot(densitymap)
plot(elev)

#######################################
# install the packages
install.packages("sdm")
install.packages("terra")
install.packages("rgdal")

library(sdm)
library(terra)
library(rgdal)
########################################
