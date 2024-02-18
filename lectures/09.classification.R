#07/12/2023

####CLASSIFICATION OF PIXELS for remote sensing data####
#grouping pixels can be used to represent the final class on a graph with red, infrared and so on on the axes.
#amount of pixels and the amount of proportion related to that.
#vegetation area are reflective a lot in the infrared area (not in the red since they are doing photosynthesis)
#water absorbs all the infrared light and may reflect red
#these pixels are called TRAINING SITES, something that can explain to the software which clusters (or classes) are present.
#if we want to classify a pixel, without knowing its class, we must use the reflectance of the pixel
#and use the SMALLEST DISTANCE FROM THE NEAREST CLASS, to estimate to which class the pixel is most probable to be part of.
#this way we can classify every pixel in the image by class.

#with the function im.classify()

#classifying satellite images 
library(imageRy)
library(terra)
library(ggplot2)
library(gridExtra)

im.list() #we are going to list all the files we have from ImageRy
          #the image of the sun comes from the ESA

#among the files, there is one related to the sun
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
#gases on the sun, more or less three levels of energy

        #we estimate the level of colors that are present in the image, 
        #then we are going to explain to the software the number of the clusters in the image

#im.classify(name of the image(sun in this case), number of clusters (num_clusters =) we want)
sunc <- im.classify(sun, num_clusters = 3)
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
#grid.arrange(p1, p2, ncol=2)
install.packages("patchwork")
library(patchwork)
p1+p2

        #one plot (p1) related to the 1992 and the other related to the 2006 image. 
        #Then to merge them together we have to use the function patchwork()

        #the problem now we have the problem of having two different scales in the two different images.
        #to have the same scale in each image graph we have to use add the specification to each line --> +ylim(c(0,100))
        #in this way the range in the y axis will be the same.

# final output, RESCALED
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1+p2                                                                          
#in this way you can actually appreciate the amount of forest loss

