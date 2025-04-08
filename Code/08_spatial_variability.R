# Code for calculating spatial variability

library(terra)
library(imageRy)

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
