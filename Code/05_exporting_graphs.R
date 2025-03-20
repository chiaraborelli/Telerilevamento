#This code helps exporting graphs to images 
#primo modo per esportare
png("greenland_output.png") #così creo il file
plot(gr) #qui plotto dentro i grafici
dev.off()

#secondo modo per esportare
pdf("greenland_output.pdf")
plot(gr)
dev.off()

pdf("difgreen.pdf")  #mi creo il pdf finale
plot(grdif)
dev.off()

#esportare in jpeg
jpeg("difgreen.jpeg")
plot(grdif)
dev.off()



