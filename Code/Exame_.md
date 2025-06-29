# The 1980 Eruption of Mount St. Helens and the Evolution of Vegetation in a Volcanic Landscape
The project shows a detailed analysis of the vegetation evolution of a volcanic environment after a great eruption. The satellite images, obtained via google earth, concern Mount St. Helens strato volcano, located in the state of Washington, USA, and document the consequences of its most violent eruption, which occurred on May 18, 1980. Mount St. Helens is the youngest and most frequently active of all of the volcanoes in the Cascade Range of the northwestern United States.
It is one of the most destructive eruptions in the modern history, characterized by the structural collapse of the volcano's northern flank, which created a crater about 400 metres wide. The collapse triggered a massive landslide and the formation of an ash cloud that spread with at a speed of about 100 km/h. The most significant event, was the so-called lateral blast, a horizontal explosion that devastated the surrounding area, completely spreading all vegetation and uprooting thousands of trees along the path over 230 square miles (600 square kilometers). Since the major eruption, Mount St. Helens has had more than 10 documented eruptive episodes. However, considering the damage caused by each eruption, the one we are going to investigate is the main event that caused the most destruction.
The primary objective is to monitor and quantify the ecological recovery — specifically vegetation — through remote sensing techniques over a 40+ year period.

Below, on the left is the satellite image from 1979 before the eruption (the older images are false-color because earlier Landsat satellites could not “see” blue light), where vegetation is red, bare rock and volcanic debris are gray, and clear water is dark blue. The 1979 view (top) shows the snow-covered summit of the perfectly shaped stratovolcano, and the mixture of forest types surrounding the mountain. To the right the satellite from 1984 after the eruption of 1980. 
<img src="https://github.com/user-attachments/assets/06f8b92a-525b-4827-99df-b6dee6b4a62a" width=100%> 

## Data collection

The data were obtained from Google Earth, [earth observatory nasa](https://earthobservatory.nasa.gov/) and [Copernicus](https://browser.dataspace.copernicus.eu/?zoom=5&lat=50.16282&lng=20.78613&demSource3D=%22MAPZEN%22&cloudCoverage=30&dateMode=SINGLE)

Library utilizzati:
```r
library(imageRy) 
library(terra)
library(viridis)
library(devtools)
library(ggplot2)
library(RStoolbox)
```
There are six photos that were obtained, dating from 1984 up to the present day. The comparison between the images allows us to observe, in less than fifty years, the gradual changes in the surrounding vegetation and the restoration of the area.
```r
setwd("C:/Users/chiar/Desktop/UNIBO/Magistrale/Telerilevamento/Esame foto") 
Helen84 = rast("Mt. St. Helen 84.jpg")
plot(Helen84)
Helen84=flip(Helen84)
plot(Helen84)

Helen91 = rast("Mt. St. Helen 91.jpg")
plot(Helen91)
Helen91=flip(Helen91)
plot(Helen91)

Helen00=rast("Mt. St. Helen 2000.jpg")
plot(Helen00)
Helen00=flip(Helen00)
plot(Helen00)

Helen07=rast("Mt. St. Helen 2007.jpg")
plot(Helen07)
Helen07=flip(Helen07)
plot(Helen07)

Helen16=rast("Mt. St. Helen 2016.jpg")
plot(Helen16)
Helen16=flip(Helen16)
plot(Helen16)

Helen20=rast("Mt. St. Helen 2020.jpg")
plot(Helen20)
Helen20=flip(Helen20)
plot(Helen20)

Helen25=rast("Mt. St. Helen 2025.jpg")
plot(Helen25)
Helen25=flip(Helen25)
plot(Helen25)
```
A false-color composite was made for all the images using R=3, G=1, and B=2, in a way to identify the vegetation.
```r

im.multiframe(3,2)
im.plotRGB(Helen84, r=3, g=1, b=2)
im.plotRGB(Helen16, r=3, g=1, b=2)
im.plotRGB(Helen00, r=3, g=1, b=2)
im.plotRGB(Helen07, r=3, g=1, b=2)
im.plotRGB(Helen20, r=3, g=1, b=2)
im.plotRGB(Helen25, r=3, g=1, b=2)
```
The analysis allow us to distinguish the areas most affected by the eruption highlighted with cool colors, from those where vegetation is present. It is observed the recovery times vary depending of the type of event: 
- The northwest quadrant, which has undergone the extreme heat of the pyroclastic flows sterilized the Pumice Plain of the crater were nothing survived, showed a faster recovery;
- The eastern slope, where a lahar occured, had a really slow recovery. The lack of the regeneration of the lahar bed can be explained by the presence of the intense rainfalls which, following the flow path, favored the runoff of rainwater, contributing to the formation of a temporary watercourse.

Generally the rate of the vegetation development :
<img src="https://github.com/user-attachments/assets/a47a26ea-66e9-49e5-8e81-d1ab62fd3627" width=100%\>


## Data analysis
# Inizial data
To begin with, two classes are created — vegetation and soil — to observe the areas most and least affected by the eruption, more effectively than with the false color RGB image. No more than two classes per feature are classified, in order to have a simple yet still clear and understandable map.
```r
 im.multiframe(3,2) 
#classe 1 vegetazion
#classe 2 soil(eruption's disaster)
Helen84c =im.classify(Helen84, num_clusters=2)
Helen16c =im.classify(Helen16, num_clusters=2)
Helen00c =im.classify(Helen00, num_clusters=2)
Helen20c =im.classify(Helen20, num_clusters=2)
Helen07c =im.classify(Helen07, num_clusters=2)
Helen25c =im.classify(Helen25, num_clusters=2)
```
<img src="https://github.com/user-attachments/assets/0301c7f6-0d77-46de-9631-e263e85ce4ef" width=100%>


Satellite image of 1984:
```r
# Total pixels
ncell(Helen84)
#output=1384395

#Calculation of the total number of the raster stack's values
ncell(Helen84)*nlyr(Helen84)
#output=4153185
plot(Helen84)
```
<img src="https://github.com/user-attachments/assets/6c4cdcd3-779b-4d1c-b9d2-0428c34adb6d" width=100%\>

Satellite image of 2025:
```r
# Numero totale dei pixel
ncell(Helen25)
#output=1384395

#Calculation of the total number of the raster stack's values
ncell(Helen25)*nlyr(Helen25)
#output=4153185
Plot(Helen25)
```
<img src="https://github.com/user-attachments/assets/eec0017f-f0b7-476b-aaae-790e86eb3823" width=100%\>


# CALCULATION DVI (difference vegetation index)
Using the DVI it is possible to have the presence and the density of the vegetation, It's a basic comparison between vegetation and soil more effective than the two classes - vegetation and soil - created before. The difference lies in the type of output: the classification shows two distinct classes with clear boundaries, while the DVI provides a continuous gradient that highlights the gradual transition between vegetation and bare soil. To calculate the DVI index, it is necessary to use images that include the NIR band. The latest images were taken from Google Earth, which does not provide the NIR band. Therefore, from now on, we are going to use other images taken from the Copernicus website. 
```r
im.multiframe(2,2)
dvi79=Helen79[[1]] - Helen79[[2]] #NIR-red
plot(dvi79, col=(inferno(100)), main = "DVI 1979")
dvi84=Helen84[[1]] - Helen84[[2]] #NIR-red
plot(dvi84, col=(inferno(100)), main = "DVI 1984")
dvi17=Helen17[[1]] - Helen17[[2]] #NIR-red
plot(dvi17, col=(inferno(100)), main = "DVI 2017")
dvi25=Helen16[[1]] - Helen25[[2]] #NIR-red
plot(dvi25, col=(inferno(100)), main = "DVI 2025")
```
Output:
<img src="https://github.com/user-attachments/assets/32afa5a8-d289-49ed-99dd-f2bfc99d2ca6" width=100%\>


# CALCULATION NDVI, Normalized Difference Vegetation Index 
```r
ndvi79 = (Helen79[[1]] - Helen79[[2]]) / (Helen79[[1]] + Helen79[[2]])
ndvi79 = clamp(ndvi79)
ndvi84 = (Helen84[[1]] - Helen84[[2]]) / (Helen84[[1]] + Helen84[[2]])
ndvi84 = clamp(ndvi84)
ndvi17 = (Helen17[[1]] - Helen00[[2]]) / (Helen00[[1]] + Helen00[[2]])
ndvi17 = clamp(ndvi17)
ndvi25 = (Helen25[[1]] - Helen25[[2]]) / (Helen25[[1]] + Helen25[[2]])
ndvi25 = clamp(ndvi25)

 im.multiframe(2,2) 
plot(ndvi79, col = (inferno(100)), main = "NDVI 1979", type = "continuous")
plot(ndvi84, col = (inferno(100)), main = "NDVI 1984", type = "continuous")
plot(ndvi17, col = (inferno(100)), main = "NDVI 2017", type = "continuous")
plot(ndvi25, col = (inferno(100)), main = "NDVI 2025", type = "continuous")
```
It is a useful calculation to monitoring the vegetation health and changes over time. The images below allow us to identify several polygons around the volcano - also visible in the DVI image - which correspond to areas characterized by poor vegetation. During the eruption, the force of the explotions generated a shock wave so intense that uprooted trees, which then fell in the wind's direction. The dead plants and insects, the windblown organic matter, and the droppings of herbivores slowly create pockets of soil on the volcanic deposits.
<img src ="https://github.com/user-attachments/assets/d0271203-24f3-4646-b835-44680e157ff8" width=100%> 

# CALCULATION DVIdif
Difference between the DVI values of the 1984 and 2025 images. This new image shows the intensity of where and how much the vegetation has changed over time. Positive values indicate areas where vegetation has increased over time, while negative values indicate areas where vegetation has not increased which match the pockets of soil we mentioned earlier. 
```r
 dvidif = dvi25 - dvi84
plot(dvidif, col = inferno (100))
```
<img src="https://github.com/user-attachments/assets/13a07dcb-a16f-435d-a446-10ec09d5f39b" width=100%>

Based on the previous image, it is possible to generate a graph showing the distribution of differential values between the two images. 
```r
im.ridgeline(dvidif, scale=5, palette="magma")
```
<img src="https://github.com/user-attachments/assets/11eeb988-53db-444b-a78b-04399665bf06" width=100%>

## CONCLUSION 

```r
Helen79c =im.classify(Helen79, num_clusters=2)
fHelen79 = freq(Helen79c)
totHelen79 = ncell(Helen79c)
propHelen79 = fHelen79 / totHelen79
percHelen79 = propHelen79 * 100
#1 = forest 86 %
#2 = disastro 14 %

fHelen84 = freq(Helen84c)
totHelen84 = ncell(Helen84c)
propHelen84 = fHelen84 / totHelen84
percHelen84 = propHelen84 * 100
#1 = forest 69 %
#2 = disastro 31 %

fHelen25 = freq(Helen25c)
totHelen25 = ncell(Helen25c)
propHelen25 = fHelen25 / totHelen25
percHelen25 = propHelen25 * 100
#1 = forest 84 %
#2 = disastro 16 %
```
From the satellite images, it is possible to determine the percentage of vegetation present and the area affected by the eruption. Thanks to  classification techniques, and vegetation indices such as DVI and NDVI, we were able to quantify and visualize the ecological response of the landscape surrounding Mount St. Helens following the 1980 eruption. Based on the calculation shown below, an initial post-eruption vegetation coverage of 69% was identified, which increased by 15% over the course of forty-one years — indicating a significant recovery of the surrounding ecosystem. Prairie Lupine is the name of the plant to reappear afte the eruption, the one that helped to increased the vegetation coverage, his nutrient is nitrogen that can be catch from the air rather than from the soil. Any type of eruption leads to the partial or total destruction of life surrounding the volcanic edifice. What surprises researchers is the ability of certain plants to survive in harsh environmental conditions, and thus contribute to the gradual reintegration of the ecosystem over time. The role of Lupinus lepidus (Prairie Lupine) is an example, a nitrogen-fixing pioneer species that facilitated soil development and the re-establishment of other plant communities. 

```r
class = c("forest", "human")  #using c because are twe elements of the same vector 
y79 = c(86, 14)
y84 = c(69, 31) #y means year
y25 = c(84, 16) 
tabout = data.frame(class, y79, y84, y25)
d1 = ggplot(tabout, aes(x=class, y = y84, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100)) #ensuring we have the same axis
d2 = ggplot(tabout, aes(x=class, y = y25, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
d3 = ggplot(tabout, aes(x=class, y = y79, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
d=im.ggplot(Helen79)
d0=im.ggplot(Helen84) #The actual image 
d00=im.ggplot(Helen25)
```
<img src="https://github.com/user-attachments/assets/bbcdddcf-c381-4894-80d2-c8a6e186706c" width=100%>
<img src="https://github.com/user-attachments/assets/ee15cfa1-ab53-4303-acda-77ed7c2275bd" width=100%>
<img src="https://github.com/user-attachments/assets/0241df70-7e9b-42d6-8d23-db9d06e9bc2f" width=100%>
