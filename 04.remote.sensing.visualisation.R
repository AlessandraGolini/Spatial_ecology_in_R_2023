# Remote sensing for ecosystems monitoring

install.package("devtools") # it is a package that allows to install packages directly from GitHub instead of CRAN
library(devtools) # use devtools

install.packages("terra")
library(terra)

devtools::install_github("ducciorocchini/imageRy") # install imagery
library(imageRy) # to make a check

im.list()

im.import("sentinel.dolomites.b2.tif") 
#non mi viene:(
