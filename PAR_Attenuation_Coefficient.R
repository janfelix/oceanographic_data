library(oce)

#setwd("/Users/.../Data_Files")
#s=read.csv("/Users/.../new_data.csv")
#or
setwd("/Users/...")

##SELECT THE month and year AND LOAD THE APPROPRIATE CTD FILE###########################################################################
time = "2011_22"
file = "SOG112202.cnv"
d = read.oce(file)
plot(d)
#downcast only
d = ctdTrim(d, "downcast")

#get depths as a list
#depth = s$DEPTH[s$STATION == station & s$Cruise == cruise]
#or define manual depths
#depth = c(2, 3, 4, 5, 6, 7, 9, 10)
depth = d@data$pressure

#Calculate the MLD
density = d@data$sigmaTheta
MLD_index = which((density[1:length(density)]-density[1])>0.125) # all index where density is 0.125 higher than at the surface; MLD_index[1] #just to show the index, optional
mld = d@data$pressure[MLD_index[1]] # first depth where desnity is higher, aka end of MLD or MLD

#loop through depths, extract PAR, for defined attunation range
depth2 = 2:13
PAR = vector(mode="numeric", length=0)
for (i in 1:length(depth2)){
  b = mean(d@data$par[d@data$pressure > (depth2[i]-0.05) & d@data$pressure < (depth2[i]+0.05)]); 
  PAR = rbind(PAR, b)}
#calculate attenuation K (Beer-Lambert)
k = log(PAR[1]/PAR[length(PAR)]) / (depth2[length(depth2)] - depth2[1])



#convert to vectors
depth = c(as.vector(depth2), mld)
PAR = c(as.vector(PAR), k)

#make the data frame of depth and PAR with MLD and K as the last values
out = data.frame(depth=depth,PAR=PAR)

#save data in a file
write.csv(out, paste0("PAR", time, ".csv"))






