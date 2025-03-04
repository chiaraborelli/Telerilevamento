#R code for visualizing satellite data

#install.packages("devtools")
library(devtools)
install_github("ducciorocchini/imageRy")

library(terra)
library(imageRy)

im.list()
# For the whole course we are going to make use of = onstead of <-
b2 = im.import("sentinel.dolomites.b2.tif") #associo ad im.import la banda 2, l'immagine che ottengo mostra che tutto ciò che è giallo riflette tantissimo il blu
cl=colorRampPalette(c("black", "dark grey","light grey"))(100) #questi colori sono tre elementi di un'array (vettore), per metterli insieme devo usare la c di concatenait.100 sta per tutti i colori che ci sono
plot(b2, col=cl)
# r colors su internet, it give you all the colors you are interest in
