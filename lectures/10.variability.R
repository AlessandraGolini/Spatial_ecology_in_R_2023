#measurements of RS based on variability
install.packages("viridis")

library(imageRy)
library(terra)
library(viridis)

im.list()

sent <- im.import("sentinel.png")

# band 1 = NIR
# band 2 = red 
# band 3 = green

im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent, r=2, g=1, b=3) #vegetation in green and the bare soil (rocks) in violet

#we're going to calculate the variability. 
#the STD can be calculate only on one variable.
#but in this case we have 3 variables: the reflectance of the red, of the green and of the NIR

#let's select only the NIR:
nir <- sent[[1]] 
plot(nir)

# moving window
# focal
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3) #it is the standard deviation
#change the legend:
viridisc <- colorRampPalette(viridis(7))(255)
plot(sd3, col=viridisc)
