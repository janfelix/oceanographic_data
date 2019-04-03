#load OCE package
library(oce)
setwd("/Users/.../meta_data/CTD")

#load Seabird Data into vector d
d = read.oce("/Users/.../SOG112201.cnv")
#plotScan(d)
#downcast only
d = ctdTrim(d, "downcast")
d = d@data #CRUCIAL!!!
df = as.data.frame(d)
colnames(df)[2] = "depth" #if pressure is used!!!

#plots
library(ggplot2)
temp = ggplot(df, aes(x=temperature, y=depth))+geom_path(size=1)+scale_y_reverse()+xlab("Temp (C)")+ylab("Depth (m)")+theme_classic()
sal = ggplot(df, aes(x=salinity, y=depth))+geom_path(size=1)+scale_y_reverse()+xlab("PSU")+ylab("Depth (m)")+theme_classic()
ts = ggplot(df, aes(x=salinity, y=temperature))+geom_point(size=1)+scale_y_reverse()+xlab("PSU")+ylab("Temp (C)")+theme_classic()
oxy = ggplot(df, aes(x=oxygen, y=depth))+geom_path(size=1)+scale_y_reverse()+xlab("Oxygen (mg/l)")+ylab("Depth (m)")+theme_classic()
par = ggplot(df, aes(x=par, y=depth))+geom_path(size=1)+scale_y_reverse()+xlab("PAR (umol/m2/s1)")+ylab("Depth (m)")+theme_classic()
flu = ggplot(df, aes(x=fluorescence, y=depth))+geom_path(size=1)+scale_y_reverse()+xlab("Chl (mg/m3)")+ylab("Depth (m)")+theme_classic()
multiplot(temp, ts, oxy, sal, par, flu,  cols=2)

#surface layer plots
dfs = df[df$depth<=20,]
temp = ggplot(dfs, aes(x=temperature, y=depth))+geom_path(size=1)+scale_y_reverse()+xlab("Temp (C)")+ylab("Depth (m)")+theme_classic()
sal = ggplot(dfs, aes(x=salinity, y=depth))+geom_path(size=1)+scale_y_reverse()+xlab("PSU")+ylab("Depth (m)")+theme_classic()
ts = ggplot(dfs, aes(x=salinity, y=temperature))+geom_point(size=1)+scale_y_reverse()+xlab("PSU")+ylab("Temp (C)")+theme_classic()
oxy = ggplot(dfs, aes(x=oxygen, y=depth))+geom_path(size=1)+scale_y_reverse()+xlab("Oxygen (mg/l)")+ylab("Depth (m)")+theme_classic()
par = ggplot(dfs, aes(x=par, y=depth))+geom_path(size=1)+scale_y_reverse()+xlab("PAR (umol/m2/s1)")+ylab("Depth (m)")+theme_classic()
flu = ggplot(dfs, aes(x=fluorescence, y=depth))+geom_path(size=1)+scale_y_reverse()+xlab("Chl (mg/m3)")+ylab("Depth (m)")+theme_classic()
multiplot(temp, ts, oxy, sal, par, flu,  cols=2)