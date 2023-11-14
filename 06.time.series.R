# TIME SERIES ANALYSIS
# 14/11/2023

library(imageRy)
library(terra)

im.list()

## import the data about european nitrogen during Covid lockdown
EN01 <- im.import("EN_01.png")
EN13 <- im.import("EN_13.png") #situation in march
#plot them together
par(mfrow=c(2,1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

#i make the difference between the two images (january - march), using the first element (band)
diff = EN01[[1]] - EN13[[1]]
plot(diff)
cldiff <- colorRampPalette(c('blue', 'white', 'red')) (100)
plot(diff, col=cldiff)

## new example: temperature in Greenland
g2000 <- im.import("greenland.2000.tif")
plot(g2000, col=cldiff)
#in the middle of greenland you have a huge area with very low temperatures

g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")
plot(g2015, col=clg) #the central part in black is decreasing year by year

#plot them together 
par(mfrow=c(2,1))
plot(g2000, col=clg)
plot(g2015, col=clg)

#stacking the data, with all bands together
####instead of importing and plotting them differently
stackg <- c(g2000, g2005, g2010, g2015)
plot(stackg, col=clg)
#the 2003 period was one of the worst moment for the temperature and ice sheet state.


# EXERCISE: make the difference between the first and the final elements of the stack
#difg = g2000[[1]] - g2015[[1]]
difg = stackg[[1]] - stackg[[4]]
plot(difg)
plot(difg, col=clg)
#you're loosing low temperature in the middle, meaning that that part is particularly sensitive to temperature changings
#this is due to climate change
#YOU MIGHT THINK FOR THE EXAM TO DO THE SAME THING WITH 2023


# EXERCISE: make a RGB plot using different years
im.plotRGB(stackg, r=1, g=2, b=3)
# in the western part you have the high temperature of the inland of the American continent, but also on the Greenland western coasts

##the im.plotRGB function gives you a plot in the RGB color with different layers:
## in this case we specify that the red color is associated to the first layer, the green to the second one and the blue to the third one. You can only work with 3 layers.
## Therefore, you represent the three layers (in this case, they are the same images from three diffrent years) and, depending on the color you have, you understand which layer (picture of which year)
##has the main influnece in that point.
## we took the first three images (1,2,3 = g2000, g2005, g2010)

#a seconda di che colore vedi di più, capisci com'è variata la temperatura perché lo stack comprende già tutte e 4 

