file <- read.csv(file="trafficData158324.csv",header = TRUE,sep = ",")
summary(file)

avgfile <- file$avgSpeed
vehicleCount <- file$vehicleCount
vehicleCountTable <- file["vehicleCount"]
avgSpeedTable <- file["avgSpeed"]

lastSpeed <- avgfile[1]
counter <- 0
totalSpeed <- 0
currentSpeed <- 0
currentSpeed[1] <- lastSpeed
for (i in 2:length(avgfile))
{
  if (vehicleCount[i]!=0)
  {
    counter <- counter +1
    currentSpeed[i] <- (2*avgfile[i]) - (lastSpeed)
    totalSpeed <- totalSpeed + (currentSpeed[i])
    lastSpeed <- currentSpeed[i]
  }
}
avgTotalSpeed <-totalSpeed/counter
currentSpeed[1:500]
