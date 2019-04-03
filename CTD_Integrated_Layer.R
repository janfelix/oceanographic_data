data = read.csv("/Users/.../data.csv")

#build list of the unique casts, eg based on a combination of year, station and month
data$cast = paste0(data$YEAR, data$STATION, data$MONTH)

#subset data by a criteria, eg cruise label
SOG = data[data$Cruise == 'SOG',]

#average the surface layer data for each cast
uniSOG = unique(SOG$cast)

depth = vector(mode="numeric", length=0)
for (s in uniSOG){b = mean(SOG$DEPTH[SOG$cast == s]);
                  depth = rbind(depth, b)}

temp = vector(mode="numeric", length=0)
for (s in uniSOG){b = mean(SOG$TEMP[SOG$cast == s]);
                  temp = rbind(temp, b)}

sal = vector(mode="numeric", length=0)
for (s in uniSOG){b = mean(SOG$SAL[SOG$cast == s]);
                  sal = rbind(sal, b)}

chl = vector(mode="numeric", length=0)
for (s in uniSOG){b = mean(SOG$CHL[SOG$cast == s]);
                  chl = rbind(chl, b)}

oxy = vector(mode="numeric", length=0)
for (s in uniSOG){b = mean(SOG$Oxygen[SOG$cast == s]);
                  oxy = rbind(oxy, b)}

NO3.2 = vector(mode="numeric", length=0)
for (s in uniSOG){b = mean(SOG$NO3.2[SOG$cast == s]);
                  NO3.2 = rbind(NO3.2, b)}

PO4 = vector(mode="numeric", length=0)
for (s in uniSOG){b = mean(SOG$PO4[SOG$cast == s]);
                  PO4 = rbind(PO4, b)}

Si = vector(mode="numeric", length=0)
for (s in uniSOG){b = mean(SOG$Si[SOG$cast == s]);
                  Si = rbind(Si, b)}
PAR = vector(mode="numeric", length=0)
for (s in uniSOG){b = mean(SOG$PAR[SOG$cast == s]);
                  PAR = rbind(PAR, b)}

BACTERIA = vector(mode="numeric", length=0)
for (s in uniSOG){b = mean(SOG$BACTERIA[SOG$cast == s]);
                  BACTERIA = rbind(BACTERIA, b)}

#build the new data vectors
cast = as.vector(uniSOG)
depth = as.vector(depth)
temp = as.vector(temp)
sal = as.vector(sal)
chl = as.vector(chl)
oxy = as.vector(oxy)
NO3.2 = as.vector(NO3.2)
PO4 = as.vector(PO4)
Si = as.vector(Si)
PAR = as.vector(PAR)
BACTERIA = as.vector(BACTERIA)

#build a data frame
SOGavg = data.frame(cast=cast, DEPTH=depth, TEMP=temp, SAL=sal, CHL=chl, Oxygen=oxy, NO3.2=NO3.2, PO4=PO4, Si=Si, PAR=PAR, BACTERIA=BACTERIA)
#save data in a file
write.csv(SOGavg, "SOGavg.csv"))

