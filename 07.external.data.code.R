# EXTERNAL DATA

library(terra) #always put the packages and libraries on top of the code

#we have to explain to R what is the folder in which we are going to work from now on: working directory
# notice that in windows you have C:\pathway\ecc. but you have to change it in C:/pathway/ecc.
setwd("C:/Users/aless/OneDrive - Alma Mater Studiorum Università di Bologna/Global Change Ecology and SDGs/Spatial Ecology in R/R")

# let's import the data with a new function from terra: rast(name of the image), like in im.import()
naja <- rast("najafiraq_etm_2003140_lrg.jpg")
plotRGB(naja, r=1, g=2, b=3)

# Exercise: download the second image from the same site and import it into R
najaaug <- rast("najafiraq_oli_2023219_lrg.jpg")
plotRGB(najaaug, r=1, g=2, b=3)

#plot the two images together
par(mfrow=c(2,1))
plotRGB(naja, r=1, g=2, b=3)
plotRGB(najaaug, r=1, g=2, b=3)

# multitemporal change detection
## we're making the difference between the naja[[1]] - najaaug[[1]]
najadif = naja[[1]] - najaaug[[1]]
cl <- colorRampPalette(c('brown', 'grey', 'orange')) (100)
plot(najadif, col = cl)

# download your own image
flood <- rast("italyflooding_oil_2023307_lrg.jpg")
plotRGB(flood, r=1, g=2, b=3)

#I can also switch the bands in different compositions:
plotRGB(flood, r=2, g=1, b=3)
plotRGB(flood, r=3, g=2, b=1)

#example of mato grosso from earth observatory (NASA):
mato <- rast("matogrosso_l5_1992219_lrg.jpg")
plotRGB(mato, r=1, g=2, b=3) #the near infrared is on top of the red layer


## COPERNICUS
#ncdf4: Interface to Unidata netCDF (Version 4 or Earlier) Format Data Files
install.packages("ncdf4")
library(ncdf4)
