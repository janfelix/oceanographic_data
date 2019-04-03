setwd("/Users/...")
abundance = read.csv("data.csv")
d = abundance$DEPTH #load data from column
s = abundance$SAL
t = abundance$TEMP

abundance$SIGMA = swRho(s, t, d) #claculate density

write.csv(abundance, file = "abundance_data_density.csv") #write to file

#setwd("/Users/...")
#abundance = read.csv("data_density.csv")

library(oce)

station = abundance[abundance$STATION == 'S1C1', ] #extract data of one particular station

abundance$MLD_index[abundance$STATION == 'S1C1'] = station$SIGMA[1:length(station$SIGMA)] - station$SIGMA[1] #calculate density difference to surface in one set of station and save in a new column in the original matrix


s = unique(abundance$STATION) #list all stations as a vector for the for loop

for (s in 5:6) {station = abundance[abundance$STATION == s, ]
                abundance$MLD_index[abundance$STATION == s] = station$SIGMA[1:length(station$SIGMA)] - station$SIGMA[1]}