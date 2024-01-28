# Relations among species in time and not only space

# camera traps data
# data from Kerinci-Seblat National Park in Sumatra, Indonesia (Ridout and Linkie, 2009)
# Ridout MS, Linkie M (2009). Estimating overlap of daily activity patterns from camera trap data. 
# Journal of Agricultural, Biological, and Environmental Statistics, 14(3), 322–337.

install.packages("overlap")
library(overlap)
# https://cran.r-project.org/web/packages/overlap/vignettes/overlap.pdf

# data
data(kerinci)
head(kerinci)
summary(kerinci)

# selecting the tiger species:
# the column is sps
tiger <- kerinci[kerinci$Sps == "tiger", ]

# The unit of time is the day, so values range from 0 to 1. 
# The package overlap works entirely in radians: fitting density curves uses trigonometric functions (sin, cos, tan),
# so this speeds up simulations. The conversion is straightforward: kerinci$Time * 2 * pi
kerinci$timeRad <- kerinci$Time * 2 * pi 
#in this way we add a column to the dataset in which we do that calculation
head(kerinci) 

# plot of the time variable
plot(tiger$timeRad)
timetig <-tiger$timeRad
densityPlot(timetig, rug=TRUE) # this function plot the density of observations in radiants time (24h!)

# EXERCISE: select only the data on the monkeys
summary(kerinci)
# macaque:273
mac <- kerinci[kerinci$Sps == "macaque", ]
head(mac)

timemac <- mac$timeRad
densityPlot(timemac, rug=TRUE)
# the macaque is quite different from the tiger: the tiger has two peaks, whereas the macaque concentrates most of the data in the central part of the day

# is there a moment for the macaque to worry abaut the presence of the tiger
# we're going to overlap the two distributions:
overlapPlot(timetig, timemac)
# the coloured part of the graph represents the perfect overlapping between the two distributions.
