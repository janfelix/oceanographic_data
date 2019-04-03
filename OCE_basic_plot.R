#load OCE package
library(oce)


#get R to ask to change between graphs
par(ask=T) 


#load Seabird Data into vector d
d<-read.oce("/Users/.../Cast4.cnv")
  
#plot data to see what it looks like -plot 1
plot(d)

plot(d, which=1)
  
#scan each recorded data point to determine downcast and upcast phases -plot2
plotScan(d)
  
  
##Enter start and stop of scan
  cat("\n","Enter Start of Scan","\n") # prompt
  ScanStart<-scan(n=1)
  
  cat("\n","Enter End of Scan","\n") # prompt
  ScanEnd<-scan(n=1)
  
  # make scan more specific for this Saanich Inlet site -plot3
  plotScan(ctdTrim(d, "range", parameters=list(item="scan", from=ScanStart, to=ScanEnd)))
  
  
  
  #Put the trimmed data into a new vector to make the new plots 
  ctd.trimmed <- ctdTrim(d, "range", parameters=list(item="scan", from=ScanStart, to=ScanEnd))
  
  #Check out the trimmed plot -plot4
  plot(ctd.trimmed)
  
  #Choose Depth
  
  Depth<- 30
  
  ##Plot 4 variables against pressure
  par(mar=c(5,5,11,5)+2)
  
  #First variable-in black.
  Lat <-round(ctd.trimmed@metadata$latitude, digits=3)
  Lon <-round(ctd.trimmed@metadata$longitude, digits=3)
  plot(ctd.trimmed@data$salinity, ctd.trimmed@data$pressure,
       xlim= (c(0, 33)),
       ylim= rev(c(0, Depth)),
       type= "l",
       ylab= "Pressure (db)",
       xlab="")
  title(main=ctd.trimmed@metadata$station, line=10,cex.main=3 )
  title(main=paste("Lat: ", Lat,
                   "Lon: ", Lon),   line=8)
  title(main=paste("Date and Time", ctd.trimmed@metadata$startTime, 
                   sep = " : "), line=7)
  
  #To move label to a more suitable spot. 
  mtext("Salinity (psu)", 
        side = 1, line = 2, outer = FALSE, at = NA,
        col = 'black')
  
  
  #Second variable-in blue.
  par(new=T)
  plot(ctd.trimmed@data$temperature, ctd.trimmed@data$pressure, 
       xlim= (c(8, 20)),
       ylim= rev(c(0, Depth)), 
       type= "l",
       xaxt="n", ylab= "",
       axes=FALSE, col='blue', xlab="")
  axis(3,pretty(c(8,20)), 
       #pretty(ctd.trimmed@data$temperature),
       col.axis='blue', col='blue')
  mtext(expression(paste("Temperature", degree, "C")), 
        side = 3, line = 2, outer = FALSE, at = NA,
        col = 'blue')
  
  
  #Third variable-in green
  par(new=T)
  plot(ctd.trimmed@data$fluorescence, 
       ctd.trimmed@data$pressure, 
       xlim= (c(0, 65)),
       ylim= rev(c(0, Depth)), 
       type= "l",
       ylab= "",axes=FALSE,
       col='green', xlab="")
  axis(3, pretty(c(0,65)),
       #   pretty(ctd.trimmed@data$fluorescence),
       col.axis='green', col='green', line=3)
  mtext("Fluorescence", side = 3, line = 5, 
        outer = FALSE, at = NA,
        col = 'green')
  
  #Fourth variable-in red
  par(new=T)
  plot(ctd.trimmed@data$oxygen, 
       ctd.trimmed@data$pressure, 
       xlim= (c(0, 10)),
       ylim= rev(c(0, Depth)),
       type= "l", 
       ylab= "",axes=FALSE,
       col='red', xlab="")
  axis(1, pretty(c(0,10)),
       #   pretty(ctd.trimmed@data$oxygen),
       col.axis='red', col='red', line=3.5)
  mtext("Oxygen mL/L", side = 1, line = 5.5, 
        outer = FALSE, at = NA,
        col = 'red')