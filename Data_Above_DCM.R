setwd("/Users/...")
abundance = read.csv("abundance.csv", na.strings = c("#DIV/0!"))

sta = unique(abundance$STATION) #list all stations as a vector for the for loop

#station = abundance[(abundance$STATION == s),]
#depth = station$DEPTH[which.max(station$CHL)]
#dcm = station[(station$DEPTH <= depth),]

for (s in sta){station = abundance[abundance$STATION == s,]
                        print(s)
                        if(nrow(station) > 1){depth = station$DEPTH[which.max(station$CHL)]}else{depth = station$DEPTH}
                        print(depth)
                        abundance = abundance[!((abundance$STATION == s) & (abundance$DEPTH > depth)),]
                        str(abundance)}


#write.csv(abundance, file = "abundance_>DCM.csv")



