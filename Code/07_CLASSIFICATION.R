#R code for classifying images

library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)
im.list()

mato1992 = im.import("matogrosso_l5_1992219_lrg.jpg")
mato1992 = flip(mato1992)
plot(mato1992)

mato2006 = im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006 = flip(mato2006)
plot(mato2006)


mato1992c =im.classify(mato1992, num_clusters=2)
#class 1 = human
#class 2 = forest

mato2006c = im.classify(mato2006,num_clusters=2)
#class 1 = forest
#class 2 = human

#calcoliamo la frequenza ovvero quante volte abbiamo lo stesso valore

f1992 = freq(mato1992c)
tot1992 = ncell(mato1992c)
prop1992 = f1992 / tot1992
perc1992 = prop1992 * 100
#human = 17%, forest = 83%

tot2006 = ncell(mato2006c)
perc2006= freq(mato2006c) * 100 / tot2006
#human = 54%, forest = 45%

#ggplot2 consiglio per trovare i grafici
library(ggplot2)

#creaiamo un data.frame (ovvero una tabella)
#definiamo le colonne
class = c("forest", "human") #uso il c perché sono due elementi dello stesso vettore
y1992 = c(83, 17) #y sta per year
y2006 = c(45, 54) 
tabout = data.frame(class, y1992, y2006)

# ggplot(finalt, aes(x=class, y=y1992, color=class)) questa funzuione crea la struttura del grafico, ora dobbiamo definire come lo vogliamo fare

p1 = ggplot(tabout, aes(x=class, y = y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100)) #così sono sicura che avrò due assi uguali
p2 = ggplot(tabout, aes(x=class, y = y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))


p1 + p2

p0=im.ggplot(mato1992)
p00=im.ggplot(mato2006)

p0 + p00 + p1 + p2
