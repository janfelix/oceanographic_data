#load OCE package
library(oce)

#define the file to read, with path
File = "/Users/.../SOG100901R.cnv"

#load Seabird Data into vector d
d<-read.oce(File)
  
#plot data to see what it looks like -plot 1
plot(d)

#scan each recorded data point to determine downcast and upcast phases -plot2
plotScan(d)
  

d = ctdTrim(d, "downcast") #good but cuts off a lot of data...

ScanStop = which.max(d@data$pressure) #find max depth
scan.trimmed <- ctdTrim(d, "range", parameters=list(item="scan", from=1, to=ScanStop))
scan.trimmed@data$pressure
#ScanStart = which.min(scan.trimmed@data$pressure >= 1)
#ScanStart = pressure(scan.trimmed@data$pressure(pressure == 0)) #optional to always start at 1m depth
#ScanStart = which.min(scan.trimmed@data$pressure)
##Enter start and stop of scan
  cat("\n","Enter Start of Scan","\n") # prompt
  ScanStart<-scan(n=1)

ctd.trimmed <- ctdTrim(d, "range", parameters=list(item="scan", from=ScanStart, to=ScanStop))

plotScan(ctd.trimmed)

#Check out the trimmed plot -plot3
plot(ctd.trimmed)

#Calculate the MLD
MLD_index = which((ctd.trimmed@data$sigmatheta[1:length(ctd.trimmed@data$sigmatheta)]-ctd.trimmed@data$sigmatheta[1])>0.05) # all index where density is 0.05 higher than at the surface; MLD_index[1] #just to show the index, optional
MLD = ctd.trimmed@data$pressure[MLD_index[1]] # first depth where desnity is higher, aka end of MLD or MLD

File
MLD

#write.csv(MLDs, file = "MLDs.csv")



  