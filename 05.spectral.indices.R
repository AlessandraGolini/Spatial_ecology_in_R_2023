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

#### (09/11/2023) ####
### exercise: build a multiframe with 1992 and 2006 images
par(mfrow=c(1,2)) #one row and two columns
im.plotRGB(m1992, r=2, g=3, b=1) 
im.plotRGB(m2006, r=2, g=3, b=1)

## let's create vegetation indices to visualize and measure the health of the vegetation situation.
dev.off()
#plot the first element of the image in 1992
plot(m1992[[1]])
#the range of reflectance is from 0 to 255: this is because reflectance is the ratio between the incident flux of energy and the reflected flux
#but this would lead to float numbers and we want to avoid them because they require space in our computer.
#therefore, we use bits: 1 bit = or 0 or 1: the BINARY CODE
#we can use binary code to build every information in the computer
#With 1 bit you have 2 information: 0 or 1.
#With 2 bits you have 4 information: 00, 01, 10, 11
#With 3 bits you have 8 info
#with 4 bits you have 16 info
#most of the images are storaged in 8 BIT: they are a lot of information but reducing the storaging space required.

#a tree is reflecting a lot in the NIR and absorbing a lot in the RED
#DVI = DIFFERENCE VEGETATIO INDEX ----> you make the difference between the total bits and the REDs (ex. 255-10 = 245 is the DVI of a living plant; 255-
#DVI = difference between NIR and RED

dvi1992 = m1992[[1]] - m1992[[2]] #i'm using the equal = and not the assign <- because it is an operation
plot(dvi1992)
#we have only one layer because it is a difference 

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi1992, col=cl)

#exercise: calculate the dvi of 2006
dvi2006 = m2006[[1]] - m2006[[2]]
plot(dvi2006, col=cl)
#we have a situation in which the healthy vegetation is really a small amount of the total 
