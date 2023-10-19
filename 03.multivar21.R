library(vegan)
#ordination methods are basically multivariate analysis
#there are different datasets:

data(dune)
head(dune) #the head function shows you only the first few rows (generally 6)
tail(dune) #you can see the final part of the dataset

ord <- decorana(dune) #detrended correspondence analysis

ldc1 <- 3.7004
ldc2 <- 3.2266
ldc3 <- 1.30055
ldc4 <- 1.47888

total = ldc1 + ldc2 + ldc3 +lcd4

plc1 = ldc1/total * 100
plc2 = ldc2/total * 100
plc3 = ldc3/total * 100
plc4 = ldc4/total * 100
#??? mi sono persa boia!!!



#from the table it is almost impossible to understand the corrispondence between the species, therefort I use a plot with only 2 axis
