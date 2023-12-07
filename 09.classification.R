#07/12/2023

## CLASSIFICATION 
#if we consider the reflectance of every single pixels in each band, 
#let's take one random pixel in the forest and let's see where it is going to reflect.
#the pixel are called trained areas(?): 
#classes, or cluster are something that could 
#BOH RAGA IO NON SO PRENDERE APPUNTI CON LUI



#Classifing satellite images and estimate the amount of change of different classes
library(imageRy)
library(terra)
library(ggplot2)
library(gridExtra)

im.list() #list all the avaiable files in the imageRy library
#mong the files, there is one related to the sun

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
#gases on the sun, more or less three levels of energy

#we expect 3 clusters, let's classify them
sunc<- im.classify(sun, num_clusters=3)
sunc
plot(sunc[[1]])
#the third class is the class with the highest energy, but it could be the class 1 or 2 or 3
plot(sun) #you can tell that the top right part is the one with the highest energy
plot(sunc) # => the highest energy is the third class

#from the original we can see that the class number 3 is the class with the highest energy level
#we now apply this to the image of mato grosso to see if there is a change.

#classify satellite data
im.list()

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

plotRGB(m1992)

#we can do a classification of these images. we use just 2 clusters here.

m1992c <- im.classify(m1992, 2)
plot(m1992c)
plot(m1992c[[1]])

m2006c <- im.classify(m2006, 2)
plot(m2006c[[1]])

#classes: forest=1; human=2.
dev.off()
par(mfrow=c(1,2))
plot(m1992c[[1]])
plot(m2006c[[1]])

# what is the proportion of each class?
#there is a function that compute the frequency of the of pixels for each class

f1992 <- freq(m1992c[[1]])
f1992
#you see the amount of pixels in class n1 and the number of pixels in class n2
#the dominant class is the first one.

#let's extract the total number of pixel of each picture:
tot1992 <- ncell(m1992c[[1]])
#ncell() counts the total number of pixels in m1992 image
#to get the frequency you divide the frequency of a certain class for the total number, multiplying per 100
p1992 <- f1992*100/tot1992
p1992
#forest = 83%; human related areas = 17%

#now that we have the percentage we can do the same for 2006:
f2006 <- freq(m2006c[[1]])
f2006
tot2006 <- ncell(m2006[[1]])
tot2006
p2006 = f2006*100/tot2006
p2006
#the first class represents the forests that has a percentage of 45.3%
#forest = 45%; human = 55%

##now we want to make a graph of these results

#building the final table:
class <- c("forest", "human") #is the first column
y1992 <- c(83, 17) #second column
y2006 <- c(45, 55) #third column

tabout <- data.frame(class, y1992, y2006)
tabout
#you finally have a table in which you have the values of 1992 and the ones of 2006

#and now we use the package ggplot2 to make a graph
##aes = aestheitcs is the class; the color will be related to the class;
##the geometry
# final plot
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
p1
p2
dev.off()
# Arrange the plots in a grid
grid.arrange(p1, p2, ncol=2)
