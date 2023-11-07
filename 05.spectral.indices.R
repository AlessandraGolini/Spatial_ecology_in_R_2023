# VEGETATION INDICES

library(imageRy)
library(terra)

im.list() #to see which files we're going to use: "matogrosso_l5_1992219_lrg.jpg" 
#if yuou want to have information about the description of the files, there is it on the GitHub account of the prof. at the depository "imageRy"

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
#it will make directly the plot of the image, with a 30m pixel resolution
#this image has been processed

# bands: 1=NIR, 2=RED, 3=GREEN

im.plotRGB(m1992, r=1, g=2, b=3) #all the vegetation will become red
#im.plotRGB(m1992, 1, 2, 3)
# area in 1992: the red one is the tropical forest and they started destroying it

#we put the nir on top of the green component
im.plotRGB(m1992, r=2, g=1, b=3) #you see the dense forestm in green and in violet you see the bare soil.
im.plotRGB(m1992, r=2, g=3, b=1) 
# water should become red since it absorbe all the radiation

#lat's see the same image in 1006
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, r=2, g=3, b=1) #you can see how much yellow color there is now: that's how humans succeeded in destroying everything.

#THE YELLOW COLOR CATCHES THE ATTENTION!!!


