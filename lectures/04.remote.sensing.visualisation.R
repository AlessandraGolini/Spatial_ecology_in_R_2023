# Remote sensing for ecosystems monitoring

install.package("devtools") # it is a package that allows to install packages directly from GitHub instead of CRAN
library(devtools) # use devtools

install.packages("terra")
library(terra)

devtools::install_github("ducciorocchini/imageRy") # install imagery
library(imageRy) # to make a check

im.list()
# band number 2 on the list:
b2 <- im.import("sentinel.dolomites.b2.tif") 
b2

#let's change the color
clb <- colorRampPalette(c("dark grey", "grey", "light grey")) (100)
plot(b2, col=clb)

# import the green band from Sentinel-2 (band 3)
b3 <- im.import("sentinel.dolomites.b3.tif")
b3

clr <- colorRampPalette(c("red","pink","light pink")) (100)
plot(b3, col=clr)
#everithing that is light in the picture is reflecting the (green) light, while everything that is dark in the picture is absorbing it.
