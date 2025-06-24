# Titolo: L'eruzione del Mount Saint Helen e l'evoluzione del paesaggio

## Raccolta dati

I dati sono stati ricavati da google earth

Library utilizzati:
```r
library(imageRy) #beloved packages developed
library(terra)
library(viridis)
library(devtools)
library(cblindplot)Comincia a scrivere
library(ggplot2)
library(RStoolbox)
```
```r
setwd("C:/Users/chiar/Desktop/UNIBO/Magistrale/Telerilevamento/Esame foto") #Sono 6 le foto ricavate, che mostrano il reintegro
del paesaggio a seguito dell'eruzione
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
Sono state messe a confronto le seguenti immagini:
<img src="C:\Users\chiar\Desktop\UNIBO\Magistrale\Telerilevamento\Esame foto\Confronto.312.jpeg" width=100%\>

## Analisi dati
# CALCOLO DVI (difference vegetation index)
```r
dvi84=Helen84[[1]] - Helen84[[2]] #NIR-red
plot(dvi84, col=inferno(100))

dvi25=Helen25[[1]] - Helen25[[2]] #NIR-red
plot(dvi25, col=inferno(100))
```

The index looks like:
