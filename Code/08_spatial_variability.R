# Code for calculating spatial variability
library(patchwork)
library(terra)
library(imageRy)
install.packages("RStoolbox")
# Standard deviation, in questo caso calcoliamo una formula per trovare la "population" dal grafico a campana della deviazione standard
23, 22, 23, 49 #(età di quattro persone nell'aula)

m = (23 + 22 + 23 + 49) / 4
#m = 29.25

num = (23 - 29.25)^2 + (22 - 29.25)^2 + (23 - 29.25)^2 + (49 - 29.25)^2
den = 4 #scarto quadratico medio
variance = num / den #scarto quadratico medio ottenuto facendo un'altro tipo di operazione
variance = num / 4
stedv = sqrt(variance)
#stdev = 11.41271

sd(c(23, 22, 23)) #calcolo deviazione standard

#--- Come calcolare la deviazione standard: METODO MOVIE WINDOW

im.list()
sent = im.import("sentinel.png")
#band 1 = NIR
#band 2 = red
#band 3 = green

#Excercise plot the image in RGB with the NIR ontop of the red component
im.plotRGB(sent, r = 1, g = 2, b = 3)

#Excercise: make three plots with NIR ontop of each component: r, g, b
im.multiframe(1,3)
im.plotRGB(sent, r = 2, g = 1, b = 3)
im.plotRGB(sent, r = 3, g = 2, b = 1)
im.plotRGB(sent, r = 1, g = 2, b = 3)

nir = sent[[1]] #utilizziamo un singolo infrarosso (questo per il calcolo della deviazione standard)

#Excercise: plot the nir band with the inferno color ramp palette
plot(nir, col = inferno (100))
sd3 = focal(nir, w=3, fun=sd) # sd è la deviazione standard
plot(sd3)

im.multiframe(1,2)
im.plotRGB(sent, r=1, g=2, b=3)

#Excercise: calculate standard deviation of the nir band with a moving window of 5x5 pixels
sd5 = focal(nir, w=c(5,5), fun=sd)

#Excercise: use ggplot to plot the standard deviation
im.ggplot(sd3)

#Excercise: plot ddthe two sd maps (3 and 5) one beside the pther with ggplot
library(ggplot)
library(patchwork)
library(RStoolbox)
im.multiframe(1,2)
p1 = im.ggplot(sd3)
p2 = im.ggplot(sd5)
p1 + p2

#Excercise: with ggplot, plot the original set in RGB (ggRGB) together with
p0 = ggRGB(sent, r=1, g=2, b=3)
p0 + p1 + p2


#10/04/2025, what to do in case of huge image

sent = im.import("sentinel.png")
sent = flip(sent)
plot(sent)
sent

ncell(sent) # numero di pixel totali
ncell(sent)*nlyr(sent)
senta = aggregate(sent, fact=2) #mettendo il fattore uguale a 2 dimezzo il numero di pixel che avevo prima
senta

senta5 = aggregate(sent, fact=5) #mettendo il fattore uguale a 5 ho diminuito ancora di più la risoluzione dell'immagine
senta5

ncell(senta5)*nlyr(sent5) #nlyr è il numero di livelli
#101760


#Excercise: make a multiframe and plot in RGB the three images (or,...
im.multiframe(1,3)
im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(senta, r=1, g=2, b=3)
im.plotRGB(senta5, r=1, g=2, b=3)

#Calculating standard deviation
nira = senta[[1]]
sda3a = focal(nira, w=c(3,3), fun="sd")


#Excercise: calculate the standard deviation for the factor 5 image
nira5 = senta5[[1]]
sda5a = focal(nira5, w=c(3,3), fun="sd")
sda5a5 =focal(nira5, w=c(3,3), fun="sd")
plot(sda5a)

im.multiframe(2,2)
plot(sd3, col=turbo(100))
plot(sda3a, col=turbo(100))
plot(sda5a, col=turbo(100))
plot(sda5a5, col=turbo(100))

p1= im.ggplot(sd3)
p2= im.ggplot(sda3a)
p3= im.ggplot(sda5a)
p4= im.ggplot(sda5a5)

#Calcolo della varianza, sommatoria degli scarti quadratici diviso il numero di scarti
#nir
var3 = sd3^2
dev.off()
plot(var3)

sd5= focal(nir, w=c(5,5), fun="sd")
var5 = sd5^2
plot(var5)

#Thursday: stratch, variance, resampling
