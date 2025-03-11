# code to calculate spectral indices from satellite images

library(imageRy) #beloved packages developed
library(terra)
library(viridis)

im.list()

mato1992 = im.import("matogrosso_l5_1992219_lrg.jpg") #l'immagine che mi dà è ruotata allora facciamo:

#1 = NIR
#2 = red
#3 = green
mato1992=flip(mato1992)

plot(mato1992)
mato1992 = im.import("matogrosso_l5_1992219_lrg.jpg")

im.plotRGB(mato1992, r=2, g=1, b=3)

#la banda n 1 che era nel nera infra red la metto sul blu

im.plotRGB(mato1992, r=2, g=3, b=1)

#import the 2006 image of the Mato Grosso area
