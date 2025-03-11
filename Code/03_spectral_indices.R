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

#ora facciamo con il satellite ast
mato06=im.import("matogrosso_ast_2006209_lrg.jpg")
mato06=flip(mato06)
plot(mato06)

im.multiframe(1,2)
im.plotRGB(mato1992, r=2, g=3, b=1)
im.plotRGB(mato06, r=2, g=3, b=1)

#possiamo anche fare il plot di una singola banda per vedere il range di riflettanza
#radiometric resolution
plot(mato1992[[1]], col=inferno(100))
plot(mato06[[1]], col=inferno(100))


#DVI (difference vegetation index)
# Tree: NIR=255, red=0, DVI=NIR-red=255
#Stressed tree: NIR=100, red=20, DVI=NIR-red=80
#la morale è che questo indice, una volta fatta la differenza ci dà una diretta informazione dello stato di saalute della vegetazione


