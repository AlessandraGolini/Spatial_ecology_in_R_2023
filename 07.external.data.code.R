# EXTERNAL DATA

library(terra) #always put the packages and libraries on top of the code

#we have to explain to R what is the folder in which we are going to work from now on: working directory
# notice that in windows you have C:\pathway\ecc. but you have to change it in C:/pathway/ecc.
setwd("C:/Users/aless/OneDrive - Alma Mater Studiorum Università di Bologna/Global Change Ecology and SDGs/Spatial Ecology in R/R")

# let's import the data with a new function from terra: rast(name of the image), like in im.import()
naja <- rast("najafiraq_etm_2003140_lrg.jpg")

plotRGB(naja, r=1, g=2, b=3)
