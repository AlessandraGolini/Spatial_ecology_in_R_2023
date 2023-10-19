library(vegan)
#ordination methods are basically multivariate analysis
#there are different datasets:

data(dune)
head(dune) #the head function shows you only the first few rows (generally 6)
tail(dune) #you can see the final part of the dataset

ord <- decorana(dune) #detrended correspondence analysis


ldc1 =  3.7004 
ldc2 =  3.1166 
ldc3 = 1.30055
ldc4 = 1.47888

total = ldc1 + ldc2 + ldc3 + ldc4

pldc1 = ldc1 * 100 / total
pldc2 = ldc2 * 100 / total
pldc3 = ldc3 * 100 / total
pldc4 = ldc4 * 100 / total

pldc1
pldc2

pldc1 + pldc2

plot(ord) 

#from the table it is almost impossible to understand the corrispondence between the species, therefort I use a plot with only 2 axis
