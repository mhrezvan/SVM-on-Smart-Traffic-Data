file <- read.csv(file.choose(),header = TRUE,sep = ",")

avgSpeed <- file$avgSpeed
vehicleCount <- file$vehicleCount
timeStamp <- file$TIMESTAMP

timeStampTable <- file["TIMESTAMP"]

counter <- 1
#avgSpeed <- avgSpeed[7:length(avgSpeed)]


totalAvgSpeed <- mean(avgSpeed)

interval <- c(1)

#busyTime <- double(floor(length(avgSpeed)/interval))
#UnBusyTime <- double(floor(length(avgSpeed)/interval))
# labels <- double(floor(length(avgSpeed)/interval))

hour <- substr(timeStamp,12,19)

j <- 1

# for (i in 1:floor(length(avgSpeed)/interval) )
# {
#   #tempMean <- mean(avgSpeed[j:(j+interval-1)])
#   tempMean <- avgSpeed[j]
#   if(tempMean <= totalAvgSpeed)
#   {
#     #UnBusyTime[counter] <- 11 +counter
#     labels[counter] <- -1
#   } else {
#     #busyTime[counter] <- 11 +counter
#     labels[counter] <- 1
#   }
#   counter <- floor(j/interval) 
#   j <- j+interval
# }

dimention <- 1
#npos <- round(length(avgSpeed)/2)

# Generate the positive and negative examples
xSpeed <- matrix(avgSpeed,length(avgSpeed),dimention)
xCount <- matrix(vehicleCount,length(vehicleCount),dimention)
#x <- cbind(xSpeed,xCount)
x <- xSpeed
#Normalizing
x <- (x-min(x))/(max(x)-min(x))

x <- x[1:1000,]
# labels <- labels[1:1000]
hour <- hour[1:1000]

#plot(x,col=ifelse(labels>0,1,2))
#legend("topleft",c('Positive','Negative'),col=seq(2),pch=1,text.col=seq(2))

nTrain <- (0.8)*nrow(x)
tIndex <- sample(nrow(x),nTrain)

xtrain <- x[tIndex,]
xtest <- x[-tIndex,]

# ytrain <- labels[tIndex]
# ytest <- labels[-tIndex]

ytrain <- hour[tIndex]
ytest <- hour[-tIndex]

# isTrain = rep(0,nrow(x))
# isTrain[tIndex] = 1

# load the kernlab package
library(kernlab)
# train the SVM
svp <- ksvm(xtrain,ytrain,type="C-svc",kernel='vanilladot',C=100,scaled=c())
# General summary
svp
# Attributes that you can access
attributes(svp)
# For example, the support vectors
alpha(svp)
alphaindex(svp)
b(svp)
# Use the built-in function to pretty-plot the classifier
plot(svp,data=xtrain)