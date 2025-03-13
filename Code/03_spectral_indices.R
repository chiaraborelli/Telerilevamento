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

#Calculating DVI
im.multiframe(1,2)
plot(mato1992)
plot(mato06)

#1 = NIR
#2 = red

dvi1992=mato1992[[1]] - mato1992[[2]] #NIR-red
plot(dvi1992)

# range DVI
# maximum: NIR -red = 255 - 0 = 255
#minimum: NIR - red = 0 - 255 = -255

plot(dvi1992, col=inferno(100))

#calculate dvi for 2006
dvi06 = mato06[[1]] - mato06[[2]]
plot(dvi06, col = inferno(100))

im.multiframe(1,2)
plot(dvi1992, col=inferno(100))
plot(dvi06, col = inferno(100))

#Different radiometric resolutions

#DVI 8 bit: range
# maximum: 255
# minimum: -255

#DVI 4 bit: range 
# maximum: NIR - red = 15 - 0 = 15
# minimum: NIR - red = 0 - 15 = -15

#NDVI 8 bit: range (0-255)
# maximum: (NIR - red) / (NIR + red) = (255 - 0) / (255 + 0) = 1
# minimum: (NIR - red) / (NIR + red) = (0 - 255) / (0 + 255) = -1

#NDVI 8 bit: range (0-15)
# maximum: (NIR - red) / (NIR + red) = (15 - 0) / (15 + 0) = 1
# minimum: (NIR - red) / (NIR + red) = (0 - 15) / (0 + 15) = -1

ndvi1992 = (mato1992[[1]] - mato1992[[2]])/(mato1992[[1]] + mato1992[[2]])
plot(ndvi1992)

ndvi06 = (mato06[[1]] - mato06[[2]])/(mato06[[1]] + mato06[[2]])
plot(ndvi06)

# function from imageRy, si ottiene la stessa immagine che abbiamo generato prima, però il calcolo ce lo risparmiamo 
dvi1992auto = im.dvi(mato1992, 1,2)
dev.off()
plot(dvi1992auto)

#function from imageRy, possiamo fare la stessa cosa con ndvi:
ndvi1992auto = im.ndvi(mato1992, 1,2)
ndvi06auto = im.ndvi(mato06, 1,2)
plot(ndvi1992)
plot(ndvi06)


