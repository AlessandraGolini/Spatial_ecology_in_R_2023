##### R project for Monitoring Ecosystem Changes and Functioning Exam #####
# Golini Alessandra
# The aim of this project is to investigate the Amazon forest reduction of last two decades and understand the importance of Indigenous populations for its protection.
# To do so, 

##### Install the following packages #####
install.packages("spatstat") #provides a comprehensive toolbox for analyzing spatial point pattern data. It includes functions for exploratory data analysis, 
#model-fitting, simulation, and visualization of spatial point patterns.
install.packages("terra")  #provides a framework for handling raster data (gridded spatial data) and conducting various spatial analysis tasks efficiently.
#It is designed to handle large datasets that may not fit into memory, making it suitable for working with big spatial data.
install.packages("sdm") #species distribution modeling
install.packages("rgdal") #to read and write raster and vector spatial data formats
install.packages("overlap") #to calculate and visualize spatial overlap between different geographic features, such as polygons or points
install.packages("devtools") #to streamline the process of developing, documenting, testing, and sharing R packages, other than installing packages from GitHub repositories.
devtools::install_github("ducciorocchini/imageRy") # install imagery
install.packages("raster")
install.packages("maps")

#### Recall the packages used ####
library(maps)
library(terra)
library(raster)
library(overlap)
library(devtools)
library(sf)
library(dplyr) #useful to gropu raws of a data frame
library(imageRy)

# First, set the working directory
setwd("C:/Users/aless/OneDrive - Alma Mater Studiorum Università di Bologna/Global Change Ecology and SDGs/Spatial Ecology in R/project")

##### Import data from RAISG #####
ind <- rast("Tis/Tis_territoriosIndigenas.jpg")
plot(ind)

# Total deforestation points
def <- rast("Def/deforestacion2001-2020.tif")
cl <- colorRampPalette(c("black", "red", "yellow")) (100)
cl1 <- colorRampPalette(c("black","blue", "pink", "magenta")) (100)
plot(def, col = cl, cex = 1.5)

# Amazon basin limits (lim, limr) and indigenous territories (tir)
lim <- st_read("Limites/Lim_Biogeografico.shp")
limr <- st_read("Limites/Lim_Raisg.shp")
tir <- st_read("Tis/Tis_territoriosIndigenas.shp")

# Natural Protected Areas (Áreas Naturales Protegidas, ANP in Spanish)
prot <- st_read("Anps/ANP_departamental.shp")
prot_nat <- st_read("Anps/ANP_nacional.shp")
prot_forest <- st_read("Anps/ANP_ReservaFlorestal.shp")


##### Plots ####

## Plot Natural Protected Areas (NPAs)
# Setting the map limits
xlim <- c(-82.12228, -41.60457)
ylim <- c(-21.21057, 12.55144)
# Creating the graphics window with defined limits and adding world boundaries
plot(NA, xlim = xlim, ylim = ylim, xlab = "longitude", ylab = "latitude", main = "Natural Protected Areas", asp = 1)
map("world", boundary = TRUE, interior = TRUE, add = TRUE)
# Plotting area boundaries
plot(limr, add = TRUE, col = "transparent", border = "red", lwd = 3)
plot(prot, add = TRUE, col = "green")
plot(prot_nat, add = TRUE, col = "darkgreen")
plot(prot_forest, add = TRUE, col = "lightgreen")
# Add a legend
legend("topleft", legend = c("Amazon limits", "Provincial NPAs", "National NPAs", "Forest reserve"), col = c("red", "green", "dark green", "light green"), pch = 15, cex=0.7)

## Plot Indigenous territories
# Creating the graphics window with defined limits and adding world boundaries
plot(NA, xlim = xlim, ylim = ylim, xlab = "longitude", ylab = "latitude", main = "Indigenous territories", asp = 1)
map("world", boundary = TRUE, interior = TRUE, add = TRUE)
# Plotting area boundaries
plot(limr["shape_Area"], add=TRUE, col = "transparent", border = "red", lwd = 3)
plot(tir["shape_Area"], add=TRUE, col ="yellow")
# Add a legend
legend("topleft", legend = c("Amazon limits", "Indigenous territories"), col = c("red", "yellow"), pch = 15, cex = 0.7)

## Plot deforestation
# Creating the graphics window with defined limits and adding world boudaries
plot(NA, xlim = xlim, ylim = ylim, xlab = "longitude", ylab = "latitude", main = "Deforestation 2000-2020", asp = 1)
map("world", boundary = TRUE, interior = TRUE, add = TRUE, fill = FALSE)
# Plotting area boundaries
plot(limr["shape_Area"], add=TRUE, col = "transparent", border = "red", lwd = 3)
plot(def, add = TRUE, col = cl1)
# Add a legend
legend("topleft", legend = c("Amazon limits", "Deforestation"), col = c("red", cl1), pch = 15, cex=0.7)

# One plot
plot(NA, xlim = xlim, ylim = ylim, xlab = "longitude", ylab = "latitude", main = "Deforestation, NPAs and Indigenous population distribition", asp = 1)
map("world", boundary = TRUE, interior = TRUE, add = TRUE, fill = FALSE)
# Plotting area boundaries
plot(limr, add = TRUE, col = "transparent", border = "red", lwd = 3)
plot(prot, add = TRUE, col = "green")
plot(prot_nat, add = TRUE, col = "darkgreen")
plot(prot_forest, add = TRUE, col = "lightgreen")
plot(tir["shape_Area"], add=TRUE, col =adjustcolor("yellow", alpha=0.5))
plot(def, add = TRUE, col = cl1)
# Add a legend
legend("topleft", legend = c("Amazon limits", "Provincial NPAs", "National NPAs", "Forest reserve", "Indigenous territories", "Deforestation"), col = c("red","green", "darkgreen", "lightgreen", "yellow", cl1), pch = 15, cex = 0.5)

##### Some statistical analysis on the RAGIS data #####

### Compute a frequency table for NPAs and indigenous territories 
### to better understand which countries have more of them.

# Frequencies for each country:
f_npa_p <- table(prot$pais)
f_npa_n <- table(prot_nat$pais)
f_npa_f <- table(prot_forest$pais)
f_ind <- table(tir$pais)

all_countries <- unique(c(names(f_ind), names(f_npa_f), names(f_npa_n), names(f_npa_p)))
print(all_countries)

# Areas in hectares for each country:
# provincial NPAs
prot_areas <- data.frame(pais = prot$pais, area_sig_h = prot$area_sig_h)
p_sum <- prot_areas %>%
  group_by(pais) %>%
  summarize(area_p = sum(area_sig_h))

# national NPAs
protn_areas <- data.frame(paisn = prot_nat$pais, area_sig_hn = prot_nat$area_sig_h)
n_sum <- protn_areas %>%
  group_by(paisn) %>%
  summarize(area_n = sum(area_sig_hn))

# forestal NPAs
protf_areas <- data.frame(paisf = prot_forest$pais, area_sig_hf = prot_forest$area_sig_h)
f_sum <- protf_areas %>%
  group_by(paisf) %>%
  summarize(area_f = sum(area_sig_hf))

# indigenous territories
ind_areas <- data.frame(paisi = tir$pais, area_sig_hi = tir$area_sig_h)
i_sum <- ind_areas %>%
  group_by(paisi) %>%
  summarize(area_ind = sum(area_sig_hi))

# Create an empty dataframe with all countries
freq_RAISG <- data.frame(
  country = all_countries,
  NPA_provincial = 0,
  NPA_national = 0,
  NPA_forestal = 0,
  ind_territories = 0
)

# Fill in frequency values for each column
freq_RAISG$NPA_provincial <- as.numeric(f_npa_p[match(all_countries, names(f_npa_p))])
freq_RAISG$NPA_national <- as.numeric(f_npa_n[match(all_countries, names(f_npa_p))])
freq_RAISG$NPA_forestal <- as.numeric(f_npa_f[match(all_countries, names(f_npa_p))])
freq_RAISG$ind_territories <- as.numeric(f_ind[match(all_countries, names(f_ind))])

# Fill in area values for each column
freq_RAISG <- freq_RAISG %>%
  left_join(p_sum, by = c("country" = "pais")) %>%
  left_join(n_sum, by = c("country" = "paisn")) %>%
  left_join(f_sum, by = c("country" = "paisf")) %>%
  left_join(i_sum, by = c("country" = "paisi"))

# Replace NA with 0
freq_RAISG[is.na(freq_RAISG)] <- 0

# Calculate the total Natural Protected Areas and the relative area values
freq_RAISG$NPAs <- freq_RAISG$NPA_provincial + freq_RAISG$NPA_national + freq_RAISG$NPA_forestal
freq_RAISG$area_NPAs <- freq_RAISG$area_f + freq_RAISG$area_n + freq_RAISG$area_p

# Calculate the totals and add a row to the data frame
totals <- colSums(freq_RAISG[, -1])
total_row <- c("Total", totals)
freq_RAISG <- rbind(freq_RAISG, total_row)
# Convert the num columns again in numeric data
num_columns <- c("NPA_provincial", "NPA_national", "NPA_forestal", "ind_territories", "area_p", "area_n", "area_f", "area_ind", "NPAs", "area_NPAs")
freq_RAISG[num_columns] <- lapply(freq_RAISG[num_columns], as.numeric)

str(freq_RAISG)

# Reordering the columns
freq_RAISG <- freq_RAISG %>%
  select(country,NPA_provincial, NPA_national, NPA_forestal, NPAs, ind_territories, area_ind, area_NPAs, area_p, area_n, area_f)
freq_RAISG

summary_RAISG <- freq_RAISG[c("country", "NPAs","area_NPAs", "ind_territories", "area_ind")]
str(summary_RAISG)

## Relative frequencies of NPAs, indigenous territories and their areas, per country:
summary_RAISG$rel_NPAs <- summary_RAISG$NPAs / summary_RAISG$NPAs[10]
summary_RAISG$rel_ind <- summary_RAISG$ind_territories / summary_RAISG$ind_territories[10]
summary_RAISG$rel_areaNPA <- summary_RAISG$area_NPAs / summary_RAISG$area_NPAs[10]
summary_RAISG$rel_areaind<- summary_RAISG$area_ind / summary_RAISG$area_ind[10]

summary_RAISG <- summary_RAISG[c("country", "NPAs","rel_NPAs","area_NPAs", "rel_areaNPA","ind_territories", "rel_ind", "area_ind","rel_areaind")]
round(summary_RAISG[ ,-1], 2)
str(summary_RAISG)

## Percentage of NPAs over the total area of the RAGIS domain
# I use as reference variable the one descriing the area that's common to either 
# NPAs dataset and RAGIS limits dataset, which is "area_sig_h", measured in hectars (ha).
totNPA <- sum(c(prot$area_sig_h, prot_nat$area_sig_h, prot_forest$area_sig_h))
totRAISG <- limr$area_sig_h
NPA_perc <- (totNPA/totRAISG)*100
round(NPA_perc, 1) #32.1% of the Amazon forest is somehow a natural protected area

## Percentage of indigenous territories
tot_ind <- sum(tir$area_sig_h)
ind_perc <- (tot_ind/totRAISG)*100
round(ind_perc,1) #28.9% of the total Amazon forest is classified as indigenous territory

### Frequency table for deforestation, to better understand its spatial and temporal distribution.
str(def) #SpatRaster
summary(def)
# Remove missing values before creating the histogram
def_no_na <- na.omit(def)
# Create histogram
hist(def_no_na, col = "blue", main = "Distribution of deforestation values",
     xlab = "Year", ylab = "Frequency")

####################################################################################################
##### Rondonia deforestation #####
# Uploading the image from Earth Observatory
list.files() # from the directory
rond2001 <- rast("amazon_deforestation_20010811_lrg.jpg")
rond2012<- rast("amazon_deforestation_20120718_lrg.jpg")
plotRGB(rond2001, r=1, g=2, b=3)
plotRGB(rond2012, r=1, g=2, b=3)

# Plot the two images together in a multiframe
par(mfrow=c(2,1))
plotRGB(rond2001, r=1, g=2, b=3)
plotRGB(rond2012, r=1, g=2, b=3)

# Having 3 components RGB, there can be used only 3 bands per time:
# b2 = Blue; b3 = Green; b4 = Red. Since it is a real-color image, there is not the band b8 = NIR (near infrared).
# And each band can be associated to a specific component, which can be changed.
# For example, here the Red element is in the third band, the Blue in the first, and the Green in the second:
plotRGB(rond2001, r=3, g=2, b=1)
plotRGB(rond2012, r=3, g=2, b=1)

plotRGB(rond2001, r=2, g=3, b=1) #you see the dense forestm in green and in violet you see the bare soil.
plotRGB(rond2012, r=2, g=3, b=1)
dev.off()

# multitemporal change detection
## making the difference between the rond2001[[1]] - rond2012[[1]]
rond_dif = rond2001[[1]] - rond2012[[1]]
cl <- colorRampPalette(c('red','brown', 'grey', 'blue')) (100)
plot(rond_dif, col = cl,main = "Multitemporal change direction")

## classification in clusters:
rond2001c<- im.classify(rond2001, num_clusters=3)
rond2001c
plot(rond2001c[[1]], main = "Classes from 2001")
legenda() 


