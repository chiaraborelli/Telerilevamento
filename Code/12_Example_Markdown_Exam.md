# Exam project title: title

## Data gathering

Data were gathered from the [Earth observatory site](https://earthobservatory.nasa.gov/)

Libraries used:

```r
library(terra)
library(imageRy)
library(viridis) 
```
```r
setwd("C:/Users/chiar/Desktop/UNIBO/Magistrale/Telerilevamento")
fires =rast("Fire.jpg")
plot(fires)
fires = flip(fires)
plot(fires)
```

## Data analysis

Based on the data gathered from the site we can calculate an index, using the first two bands:
```r
fireindex = fires[[1]] - fires[[2]]
plot(fireindex)
```
In order to export the index we can use the png() function like:

```r
png("fireindex.png")
plot(fireindex)
dev.off()
```

The index looks like:
 metti link

 ## Index visualisation by viridis

 In order to visualize the index with another viridis palette we made use if the following code:
  ```r
library(viridis)
plot(fireindex, col=inferno(100))
png("inferno.png")
plot(fireindex, col=inferno(100))
dev.off()
```

The output will look like:
