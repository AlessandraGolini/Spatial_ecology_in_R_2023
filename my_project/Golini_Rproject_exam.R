##### R project for Monitoring Ecosystem Changes and Functioning Exam #####
# Golini Alessandra
# The aim of this project is to investigate the Amazon forest reduction of last two decades and understand the importance of Indigenous populations for its protection.
# To do so, 

#### Install the following packages
install.packages("spatstat") #provides a comprehensive toolbox for analyzing spatial point pattern data. It includes functions for exploratory data analysis, 
#model-fitting, simulation, and visualization of spatial point patterns.
install.packages("terra")  #provides a framework for handling raster data (gridded spatial data) and conducting various spatial analysis tasks efficiently.
#It is designed to handle large datasets that may not fit into memory, making it suitable for working with big spatial data.
install.packages("sdm") #species distribution modeling
install.packages("rgdal") #to read and write raster and vector spatial data formats
install.packages("overlap") #to calculate and visualize spatial overlap between different geographic features, such as polygons or points
install.packages("devtools") #to streamline the process of developing, documenting, testing, and sharing R packages, other than installing packages from GitHub repositories.
devtools::install_github("ducciorocchini/imageRy") # install imagery

#### Recall the packages used

library(raster)
library(overlap)
library(devtools)
library(sf)
library(dplyr) #useful to group raws of a data frame

# First, set the working directory
setwd("C:/Users/aless/OneDrive - Alma Mater Studiorum Università di Bologna/Global Change Ecology and SDGs/Spatial Ecology in R/project")

# Import data from RAISG
ind <- rast("Tis/Tis_territoriosIndigenas.jpg")
plot(ind)

# Total deforestation points
def <- rast("Def/deforestacion2001-2020.tif")
cl <- colorRampPalette(c("black", "red", "yellow")) (100)
plot(def, col = cl, cex = 1.5)

# Amazon basin limits (lim, limr) and indigenous territories (tir)
lim <- st_read("Limites/Lim_Biogeografico.shp")
limr <- st_read("Limites/Lim_Raisg.shp")
tir <- st_read("Tis/Tis_territoriosIndigenas.shp")

# Natural Protected Areas (Áreas Naturales Protegidas, ANP in Spanish)
prot <- st_read("Anps/ANP_departamental.shp")
prot_nat <- st_read("Anps/ANP_nacional.shp")
prot_forest <- st_read("Anps/ANP_ReservaFlorestal.shp")

# Plot Natural Protected Areas
plot(NA, xlim = c(-82.12228, -41.60457), ylim = c(-21.21057, 12.55144), xlab = "latitude", ylab = "longitude", main = "Ntural Protected Areas", asp = 1)
plot(limr["shape_Area"], add = TRUE, col = "transparent", border = "red", lwd = 2, asp = 1)
plot(prot["shape_Area"], add=TRUE, col = "green", asp=1)
plot(prot_nat["shape_Area"], add = TRUE, col = "dark green", asp=1)
plot(prot_forest["shape_Area"], add = TRUE, col = "light green", asp=1)
# Add a legend
legend("topleft", legend = c("Amazon limits", "Provincial NPAs", "National NPAs", "Forest reserve"), col = c("red", "green", "dark green", "light green"), pch = 15)

# Plot Indigenous territories
plot(NA, xlim = c(-82.12228, -41.60457), ylim = c(-21.21057, 12.55144), xlab = "latitude", ylab = "longitude", main = "Indigenous territories", asp = 1)
plot(limr["shape_Area"], add=TRUE, col = "transparent", border = "red", lwd = 2, xlim = c(-82.12228, -41.60457), ylim = c(-21.21057, 12.55144))
plot(tir["shape_Area"], add=TRUE, col ="yellow", asp=1)
# Add a legend
legend("topleft", legend = c("Amazon limits", "Indigenous territories"), col = c("red", "yellow"), pch = 15)

# Plot deforestation
plot(NA, xlim = c(-82.12228, -41.60457), ylim = c(-21.21057, 12.55144), xlab = "latitude", ylab = "longitude", main = "Amazon deforestation 2000-2020", asp = 1)
plot(limr["shape_Area"], add = TRUE, col = "transparent", border = "red", lwd = 2, asp = 1)
plot(def, add = TRUE, col = cl, cex = 2, asp = 1)
# Add a legend
legend("topleft", legend = c("Amazon limits", "Deforestation"), col = c("red", cl), pch = 15)

# One plot
plot(NA, xlim = c(-82.12228, -41.60457), ylim = c(-21.21057, 12.55144), xlab = "latitude", ylab = "longitude", main = "Amazon deforestation 2000-2020", asp = 1)
plot(limr["shape_Area"], add = TRUE, col = "transparent", border = "red", lwd = 2, asp = 1)
plot(prot["shape_Area"], add=TRUE, col = "green", asp=1)
plot(prot_nat["shape_Area"], add = TRUE, col = "dark green", asp=1)
plot(prot_forest["shape_Area"], add = TRUE, col = "light green", asp=1)
plot(tir["shape_Area"], add=TRUE, col ="yellow", asp=1)
#plot(def, add = TRUE, col = cl, cex = 2, asp = 1)
# Add a legend
legend("topleft", legend = c("Amazon limits", "Provincial NPAs", "National NPAs", "Forest reserve", "Indigenous territories", "Deforestation"), col = c("red","green", "dark green", "light green", "yellow", cl), pch = 15, cex = 0.5)

#### Some statistical analysis on the RAGIS data

## Percentage of NPAs over the total area of the RAGIS domain
# I use as reference variable the one descriing the area that's common to either 
# NPAs dataset and RAGIS limits dataset, which is "area_sig_h", measured in hectars (ha).
totNPA <- sum(c(prot$area_sig_h, prot_nat$area_sig_h, prot_forest$area_sig_h))
totRAGIS <- limr$area_sig_h
NPA_perc <- (totNPA/totRAGIS)*100
round(NPA_perc, 1) #32.1% of the Amazon forest is somehow a natural protected area

## Percentage of indigenous territories
tot_ind <- sum(tir$area_sig_h)
ind_perc <- (tot_ind/totRAGIS)*100
round(ind_perc,1) #28.9% of the total Amazon forest is classified as indigenous territory


## Compute which countries have more PNAs and indigenous territories, using a frequency table.
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
numeric_columns <- freq_RAISG[, -1]
numeric_columns <- apply(numeric_columns, 2, as.numeric)
freq_RAISG[ ,-1]<- numeric_columns
totals <- colSums(numeric_columns)
Total <- c("Total", totals)
freq_RAISG <- rbind(freq_RAISG, Total)


# Reordering the columns
freq_RAISG <- freq_RAISG %>%
  select(country,NPA_provincial, NPA_national, NPA_forestal, NPAs, ind_territories, area_ind, area_NPAs, area_p, area_n, area_f)
freq_RAISG

summary_RAISG <- freq_RAISG[c("country", "NPAs","area_NPAs", "ind_territories", "area_ind")]
