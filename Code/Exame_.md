# L'eruzione del Mount Saint Helen e l'evoluzione del paesaggio
Il progetto presenta un’analisi dettagliata dell’evoluzione di un ambiente vulcanico in seguito a un’eruzione. Le immagini satellitari, ottenute tramite Google Earth, riguardano il vulcano Mount St. Helens, situato nello stato di Washington, USA, e documentano le conseguenze della sua più violenta eruzione, avvenuta il 18 maggio 1980.
Si tratta di una delle eruzioni più distruttive della storia moderna, caratterizzata dal collasso strutturale del fianco nord del vulcano, che ha generato un cratere largo circa 400 metri. Il cedimento ha innescato una massiccia frana e la formazione di una nube di cenere che si è propagata a una velocità di circa 100 km/h. L’evento più significativo è stato il cosiddetto blast laterale, un'esplosione orizzontale che ha devastato l’area circostante, abbattendo interamente la vegetazione e sradicando migliaia di alberi lungo il suo percorso.
## Raccolta dati

I dati sono stati ricavati da google earth

Library utilizzati:
```r
library(imageRy) 
library(terra)
library(viridis)
library(devtools)
library(cblindplot)
library(ggplot2)
library(RStoolbox)
```
Sono sei le foto che sono state ricavate e che risalgono dal 1984 fino al giorno d'oggi. Il confronto tra le immagini permette di osservare, in meno di ciquant'anni, i progressivi cambiamenti della vegetazione circostante e il ripristino, quindi, dell'area. 
```r
setwd("C:/Users/chiar/Desktop/UNIBO/Magistrale/Telerilevamento/Esame foto") #Sono 6 le foto ricavate, che mostrano il reintegro
#del paesaggio a seguito dell'eruzione
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
Di tutte le immagini è stata fatta una composizione a falsi colori con  R=3, G=1 e B=2
```r

im.multiframe(3,2)
im.plotRGB(Helen84, r=3, g=1, b=2)
im.plotRGB(Helen16, r=3, g=1, b=2)
im.plotRGB(Helen00, r=3, g=1, b=2)
im.plotRGB(Helen07, r=3, g=1, b=2)
im.plotRGB(Helen20, r=3, g=1, b=2)
im.plotRGB(Helen25, r=3, g=1, b=2)
```
L’analisi consente di distinguere le aree maggiormente colpite dall’eruzione, evidenziate con colori freddi, da quelle in cui la vegetazione è presente. Si osserva che i tempi di ripristino variano in base alla tipologia di evento: nel quadrante nord-occidentale, l’area interessata dal collasso di settore ha mostrato un recupero più rapido rispetto al versante orientale, dove si è generato un lahar. La mancata rigenerazione del letto del lahar può essere spiegata dalla presenza di intense precipitazioni che, seguendo il percorso del flusso, hanno favorito il deflusso dell’acqua piovana, contribuendo alla formazione di un corso d’acqua temporaneo:
<img src="https://github.com/user-attachments/assets/a47a26ea-66e9-49e5-8e81-d1ab62fd3627" width=100%\>


## Analisi dati
# Dati iniziali

 im.multiframe(3,2) 
#classe 1 vegetazione
#classe 2 disastro
Helen84c =im.classify(Helen84, num_clusters=2)
Helen16c =im.classify(Helen16, num_clusters=2)
Helen00c =im.classify(Helen00, num_clusters=2)
Helen20c =im.classify(Helen20, num_clusters=2)
Helen07c =im.classify(Helen07, num_clusters=2)
Helen25c =im.classify(Helen25, num_clusters=2)
<img src="https://github.com/user-attachments/assets/0301c7f6-0d77-46de-9631-e263e85ce4ef" width=100%>


Immagine satellitare del 1984:
```r
# Numero totale dei pixel
ncell(Helen84)
#outout=1384395

#Calcolo del numero totale di valori nel raster stack
ncell(Helen84)*nlyr(Helen84)
#output=4153185
plot(Helen84)
```
<img src="https://github.com/user-attachments/assets/6c4cdcd3-779b-4d1c-b9d2-0428c34adb6d" width=100%\>

Immagine satellitare del 2025:
```r
# Numero totale dei pixel
ncell(Helen825)
#output=1384395

#Calcolo del numero totale di valori nel raster stack
ncell(Helen25)*nlyr(Helen25)
#output=4153185
Plot(Helen25)
```
<img src="https://github.com/user-attachments/assets/eec0017f-f0b7-476b-aaae-790e86eb3823" width=100%\>

# CALCOLO DVI (difference vegetation index)
Attraverso il DVI è possibile conoscere la presenza e la densità di vegetazione, si tratta di un confronto base tra vegetazione e suolo.
```r
dvi84=Helen84[[1]] - Helen84[[2]] #NIR-red
plot(dvi84, col=inferno(100))

dvi25=Helen25[[1]] - Helen25[[2]] #NIR-red
plot(dvi25, col=inferno(100))
```
Risultato:
<img src="https://github.com/user-attachments/assets/37180bfe-a59f-4c0c-ab74-a7faa0c1e72e" width=100%\>


# CALCOLO NDVI, Normalized Difference Vegetation Index 
```r
ndvi84 = (Helen84[[1]] - Helen84[[2]]) / (Helen84[[1]] + Helen84[[2]])
ndvi84 = clamp(ndvi84, -1, 1)
ndvi25 = (Helen25[[1]] - Helen25[[2]]) / (Helen25[[1]] + Helen25[[2]])
ndvi25 = clamp(ndvi25, -1, 1)
im.multiframe(2,1)
plot(ndvi84, col = rev(inferno(100)), main = "NDVI 1984", type = "continuous")
plot(ndvi25, col = rev(inferno(100)), main = "NDVI 2025", type = "continuous")
```
Si tratta di un calcolo utile per monitorare la salute della vegetazione e i cambiamenti nel tempo. Le immagini sottostanti permettono di individuare alcuni poligoni attorno al vulcano — visibili anche nell'immagine a DVI — che corrispondono ad aree caratterizzate da scarsa vegetazione. Durante l’eruzione, la forza delle esplosioni ha generato un’onda d’urto talmente intensa da sradicare gli alberi, che sono poi crollati seguendo la direzione del vento.
<img src ="https://github.com/user-attachments/assets/4a93aef2-f635-45f5-8d81-c1cc61ce3a38" width=100%> 
# CALCOLO DVIdif
differenza tra i valori dvi dell'immagine dell'84 e del 25. Questa nuova immagine mostra dove e quanto la vegetazione è cambiata nel tempo. I valori positivi indicano dove la vegetazione è aumentata nel tempo, mentre valori negativi indicano dove la vegetazione non è aumentata.
```r
 dvidif = dvi25 - dvi84
plot(dvidif, col = inferno (100))
```
<img src="https://github.com/user-attachments/assets/13a07dcb-a16f-435d-a446-10ec09d5f39b" width=100%>

In base all'immagine precedente è possibile ottenere un grafico che mostra la distribuzione dei valori differenziali tra le due immagini
```r
im.ridgeline(dvidif, scale=5, palette="magma")
```
<img src="https://github.com/user-attachments/assets/6c65686b-f95c-47da-b5fc-6c2e12b4d78d" width=100%>


#calcoliamo la frequenza ovvero quante volte abbiamo lo stesso valore
```r
 fHelen84 = freq(Helen84c)
totHelen84 = ncell(Helen84c)
propHelen84 = fHelen84 / totHelen84
percHelen84 = propHelen84 * 100
#1 = forest 69 %
#2 = disastro 31 %

fHelen25 = freq(Helen25c)
totHelen25 = ncell(Helen25c)
propHelen25 = fHelen25 / totHelen25
percHelen25 = propHelen25 * 100
#1 = forest 84 %
#2 = disastro 16 %
```
