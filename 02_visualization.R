#R code for visualizing satellite data

#l'installazione dei pacchetti va sempre fatto all'inizio e bisogna anche conoscere le funzioni del pacchetto che si sta usando
install.packages("viridis")
#install.packages("devtools")
library(devtools)
install_github("ducciorocchini/imageRy")

library(terra)
library(imageRy)
library(viridis)
im.list()
# For the whole course we are going to make use of = onstead of <-
b2 = im.import("sentinel.dolomites.b2.tif") #associo ad im.import la banda 2, l'immagine che ottengo mostra che tutto ciò che è giallo riflette tantissimo il blu
cl=colorRampPalette(c("black", "dark grey","light grey"))(100) #questi colori sono tre elementi di un'array (vettore), per metterli insieme devo usare la c di concatenait.100 sta per tutti i colori che ci sono
plot(b2, col=cl)
# r colors su internet, it give you all the colors you are interest in
# Sempre sui colori: https://custom-scripts.sentinel-hub.com/custom-scripts/sentinel-2/bands/
#band 3
b3 = im.import("sentinel.dolomites.b3.tif")
#Ora possiamo importare le altre bande
# b4 è la banda del rosso
# b3 è la banda verde (guarda anche quanti nanometri sono)
b4 = im.import("sentinel.dolomites.b4.tif")
# proviamo la banda 8 siamo nella near infrared, immediatamente dopo il visibile, oltre 700 nm
b8 = im.import("sentinel.dolomites.b8.tif")
#plottiamo le quattro bande insieme: usando "par" come funzione (funzione grafica per aprire delle finestre vuote)
par(mfrow=c(1,4))
plot(b2)
plot(b3)
plot(b4)
plot(b8)

dev.off() # serve per cancellare il grafico

im.multiframe(1,4)

#exercice: plot the bands using im.multiframe() one on top of the other
par(mfrow=c(4,1))
cl = colorRampPalette(c("black","light grey")) (100)
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)
# Così abbiamo creato un multiframe a due righe e due colonne e abbiamo deciso i colori
#STACK, è un pacchetto di dati 

sent = c(b2, b3, b4, b8) # se nella riga successiva scrivo "sent" poi mi mostra tutti i dati dell'immagine che ha creato

plot(sent, col=cl)

names(sent) = c("b2blue", "b3green", "b4red", "b8NIR")
sent # così posso vedere i vari nomi

#Se voglio plottare solo una delle 4 bande?
plot(sent$b8NIR)

plot(sent[[4]])
# importing several bands altogether, I have to write down the common name of the 4 bands 

sentdol = im.import("sentinel.dolomites")

#how to import several sets
pairs(sentdol)

#viridis, https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
plot(sentdol, col=viridis(100))
plot(sentdol, col=mako(100))

# 11/03
sentdol= im.import("sentinel.dolomite")
# oppure scrivi
print(sentdol)
nlyr(sentdol)
ncell(sentdol) # numero finale di pixel a nostra disposizione
ncell(sentdol)*nlyr(sentdol)
plot(sentdol[(1)])

#layer, usiamo più bande per fare un grafico
# 1 = blue (b2)
# 2 = green (b3)
# 3 = red (b4)
# 4 = NIR (b8)

# RGB, "red green and blue" sono colori da cui si possono prendere tutti i colori che vogliamo. Sono filtri usati per fare sovrapposizione di colori e creare tutti i colori possibili.
# r è il valore di rgb, attribuisco a ogni lettera rgb una banda di colore, queste verranno poi sovrapposte
im.plotRGB(sentdol, r=3, g=2, b=1) #immagine a colori naturali 

#adesso proviamo ad usare quella dell'infrarosso vicino (immagine a falsi colori)

im.plotRGB(sentdol, r=4, g=3, b=2)

#excersice: plot the image using the NIR ontop of the green component of the RGB scheme

im.plotRGB(sentdol, r=3, g=4, b=2)

im.multiframe(1,2)
im.plotRGB(sentdol, r=4,g=3,b=2)
im.plotRGB(sentdol, r=3, g=4, b=2)
dev.off

# usiamo i colori effettivi di riflettanza delle varie bande

