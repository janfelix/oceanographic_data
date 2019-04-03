#load OCE package
library(oce)

###CTD: Seabird
#load Seabird Data into vector d
DATA = read.oce("/Users/.../Cast9.cnv")
plotScan(DATA)
trim = ctdTrim(DATA, "range", parameters=list(item="scan", from=1, to=20000))
d = trim@data #CRUCIAL!!!
df = as.data.frame(d)
#colnames(df)[2] = "depth" #if pressure is used!!!

#plots
library(ggplot2)
temp = ggplot(df, aes(x=temperature, y=depth))+geom_path(size=1)+scale_y_reverse()+xlab("Temp (C)")+ylab("Depth (m)")+theme_classic()
sal = ggplot(df, aes(x=salinity, y=depth))+geom_path(size=1)+scale_y_reverse()+xlab("PSU")+ylab("Depth (m)")+theme_classic()
ts = ggplot(df, aes(x=salinity, y=temperature))+geom_point(size=1)+scale_y_reverse()+xlab("PSU")+ylab("Temp (C)")+theme_classic()
oxy = ggplot(df, aes(x=oxygen, y=depth))+geom_path(size=1)+scale_y_reverse()+xlab("Oxygen (mg/l)")+ylab("Depth (m)")+theme_classic()
par = ggplot(df, aes(x=par, y=depth))+geom_path(size=1)+scale_y_reverse()+xlab("PAR (umol/m2/s1)")+ylab("Depth (m)")+theme_classic()
flu = ggplot(df, aes(x=fluorescence, y=depth))+geom_path(size=1)+scale_y_reverse()+xlab("Chl (mg/m3)")+ylab("Depth (m)")+theme_classic()
multiplot(temp, oxy, sal, ts, cols=2)
multiplot(temp, ts, oxy, sal, par, flu,  cols=2)



### CTD: idronaut
#load idronaut data, !!! if applicable !!! manually remove strange noise data with *** attached (will automate in script later...)
d = read.table("/Users/.../SEED001.txt", skip=10)
#add the header, read the top two lines but only use the second line with the labels... 
head = readLines("/Users/.../SEED001.txt", n=2)[2]
labels = unlist(strsplit(head, " "))
names(d) = labels[c(1, 2, 3, 4, 6, 8, 9, 11, 13, 15, 17, 18, 19, 22)]
#plots
library(ggplot2)
temp = ggplot(d, aes(x=Temperature, y=Depth))+geom_path(size=1)+scale_y_reverse()+xlab("Temp (C)")+ylab("Depth (m)")+theme_classic()
sal = ggplot(d, aes(x=Salinity, y=Depth))+geom_path(size=1)+scale_y_reverse()+xlab("PSU")+ylab("Depth (m)")+theme_classic()
ts = ggplot(d, aes(x=Salinity, y=Temperature))+geom_point(size=3)+scale_y_reverse()+xlab("PSU")+ylab("Temp (C)")+theme_classic()
oxy = ggplot(d, aes(x=Oxygen, y=Depth))+geom_path(size=1)+scale_y_reverse()+xlab("Oxygen (mg/l)")+ylab("Depth (m)")+theme_classic()
multiplot(temp, oxy, sal, ts, cols=2)






