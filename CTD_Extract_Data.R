library(oce)

#setwd("/Users/.../Data_Files")
#s=read.csv("/Users/.../new_data.csv")


##SELECT THE month and year AND LOAD THE APPROPRIATE CTD FILE###########################################################################
time = "082012"
file = "Saan0812002.cnv"
d = read.oce(file)
#or
d = read.oce("/Users/.../SOG110301.cnv")

#downcast only
d = ctdTrim(d, "downcast")

#plot
plot(d) #four plots
plot(d, which=1)#temp sal
plot(d, which=2)#density buoyency
plot(d, which=3)#TS
plot(d, which=4)#info
plot(d, which=5)#coastline
plot(d, which=6)#density dp/dt
plot(d, which=13)#spice
plot(d, which=15)#Rp
plot(d, which=17)#conductivity
plot(d, which=c(1, 2, 3, 13)) #combination

#get depths as a list
#depth = s$DEPTH[s$STATION == station & s$Cruise == cruise]
#or define manual depths
depth =c(2, 3, 4, 5, 6, 7, 9, 10)

#loop through depths, extract eg temp and save
temps = vector(mode="numeric", length=0)
for (i in 1:length(depth)){
  b = mean(d@data$temperature[d@data$pressure > (depth[i]-0.05) & d@data$pressure < (depth[i]+0.05)]); 
  #print(d@data$temperature[d@data$pressure > (depth[i]-0.05) & d@data$pressure < (depth[i]+0.05)])
  temps = rbind(temps, b)}
temps = rbind(temps, mean(temps))

sal = vector(mode="numeric", length=0)
for (i in 1:length(depth)){
  b = mean(d@data$salinity[d@data$pressure > (depth[i]-0.05) & d@data$pressure < (depth[i]+0.05)]); 
  sal = rbind(sal, b)}
sal = rbind(sal, mean(sal))

chl = vector(mode="numeric", length=0)
for (i in 1:length(depth)){
  b = mean(d@data$fluorescence[d@data$pressure > (depth[i]-0.05) & d@data$pressure < (depth[i]+0.05)]); 
  chl = rbind(chl, b)}
chl = rbind(chl, mean(chl))

oxygen = vector(mode="numeric", length=0)
for (i in 1:length(depth)){
  b = mean(d@data$oxygen[d@data$pressure > (depth[i]-0.05) & d@data$pressure < (depth[i]+0.05)]); 
  oxygen = rbind(oxygen, b)}
oxygen = rbind(oxygen, mean(oxygen))

PAR = vector(mode="numeric", length=0)
for (i in 1:length(depth)){
  b = mean(d@data$par[d@data$pressure > (depth[i]-0.05) & d@data$pressure < (depth[i]+0.05)]); 
  PAR = rbind(PAR, b)}
PAR = rbind(PAR, mean(PAR))

#Calculate the MLD
density = d@data$sigmaTheta
MLD_index = which((density[1:length(density)]-density[1])>0.125) # all index where density is 0.125 higher than at the surface; MLD_index[1] #just to show the index, optional
mld = d@data$pressure[MLD_index[1]] # first depth where desnity is higher, aka end of MLD or MLD

#convert to vectors, again for some reason, fuck you R!
depth = c(as.vector(depth), mld)
temps = as.vector(temps)
sal = as.vector(sal)
chl = as.vector(chl)
oxygen = as.vector(oxygen)
PAR = as.vector(PAR)

#make the data frame
output = data.frame(depth=depth, temps=temps, sal=sal, chl=chl, ox=oxygen, PAR=PAR)

#save data in a file, build name from input variables
write.csv(output, paste0("saanich", time, ".csv"))






