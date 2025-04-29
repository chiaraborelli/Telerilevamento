# Code to solve colorblindness problems

#Packages
library(terra)


#Installing cblindplot
library(devtools)
install_github("ducciorocchini/cblindplot")
library(cblindplot)

#Importing data
setwd("C:/Users/chiar/Desktop/UNIBO/Magistrale/Telerilevamento")
vinicunca=rast("vinicunca.jpg")

plot(vinicunca)
vinicunca = flip(vinicunca)
plot(vinicunca)

#simulating color blindness
im.multiframe(1,2)
im.plotRGB(vinicunca, r=1, g=2, b=3, title="Standard Vision")
im.plotRGB(vinicunca, r=1, g=2, b=3, title="Protanopia")

rainbow = rast("rainbow.jpg")
plot(rainbow)
rainbow = flip(rainbow)
plot(rainbow)
png("rainbow_out.png")
cblind.plot(rainbow, cvd="deuteranopia")
cblind.plot(rainbow, cvd="protanopia")
cblind.plot(rainbow, cvd="tritanopia")

