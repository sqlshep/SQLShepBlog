# Multiple plot function
#
# http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}
##########################################################################
#  Explore the data 
##########################################################################
library(ggplot2)

# lets look at some other data cars 
data(mtcars)
head(mtcars)
View(mtcars)

summary(mtcars)
str(mtcars)


# If you absolutely must convert, here you go
mtcars$lp100k <- (100 * 3.785) / (1.609 * mtcars$mpg)

#rename the columns to something slightly more meaningful
names(mtcars)[2]<-paste("Cylinders")
names(mtcars)[3]<-paste("Displacement")
names(mtcars)[4]<-paste("Horsepower")
names(mtcars)[5]<-paste("RearAxleRatio")
names(mtcars)[6]<-paste("Weight")
names(mtcars)[7]<-paste("QuarterMile")
names(mtcars)[8]<-paste("VSengine")
names(mtcars)[9]<-paste("TransmissionAM")
names(mtcars)[10]<-paste("Gears")
names(mtcars)[11]<-paste("Carburetors")

#fix the row names, i want them to be a column  
mtcars$Model <- row.names(mtcars)
row.names(mtcars) <- NULL
names(mtcars)


##Explore

p1 <- ggplot(mtcars,aes(x = Horsepower, y = mpg)) + 
  geom_point() +
  geom_smooth(method='lm', se= F) 

p2 <- ggplot(mtcars,aes(x = Displacement, y = mpg)) + 
  geom_point() +
  geom_smooth(method='lm', se= F) 

p3 <- ggplot(mtcars,aes(x = , y = mpg)) + 
  geom_point() +
  geom_smooth(method='lm', se= F) 

p4 <- ggplot(mtcars,aes(x = QuarterMile, y = mpg)) + 
  geom_point() +
  geom_smooth(method='lm', se= F) 

#ggplot(mtcars,aes(x = Weight, y = mpg)) + 
#  geom_point() +
#  geom_smooth(method='lm', se= F) 

multiplot(p1, p2, p3, p4, cols=2)
## normally distributed 
p1 <- ggplot(mtcars,aes(x = Horsepower)) + 
  geom_histogram(bins=10)  

p2 <- ggplot(mtcars,aes(x = Displacement)) + 
  geom_histogram(bins=10)  

p3 <- ggplot(mtcars,aes(x = RearAxleRatio)) + 
  geom_histogram(bins=10)  

p4 <- ggplot(mtcars,aes(x = QuarterMile)) + 
  geom_histogram(bins=10)  

#ggplot(mtcars,aes(x = Weight)) + 
#   geom_histogram(bins=15)  

multiplot(p1, p2, p3, p4, cols=2)


# More scatter plot
pairs(mtcars[3:7])
?pairs

# more more scatter plot 
#install.packages("GGally")
library(GGally)
ggpairs(mtcars[c(1,3:7)], aes(alpha = 0.5))


mtcars.1 <- lm(mpg ~ Horsepower + Displacement + RearAxleRatio + QuarterMile + Weight, data=mtcars)
summary(mtcars.1)

par(mfrow=c(2,2))
plot(mtcars.1)

mtcars.2 <- lm(mpg ~ Horsepower + RearAxleRatio + QuarterMile + Weight, data=mtcars)
summary(mtcars.2)

mtcars.3 <- lm(mpg ~ Horsepower + RearAxleRatio + Weight, data=mtcars)
summary(mtcars.3)

mtcars.4 <- lm(mpg ~ Horsepower + Weight, data=mtcars)
summary(mtcars.4)

Horsepower <- c(100,150,200,395)
Weight <- c(2.5,3.5,5.2,5.6)
newcars = data.frame(Horsepower,Weight)

predict(mtcars.4,newdata=newcars,interval="confidence")


#########################################################################
#  Adding Indicator variables
#########################################################################

#create factors
ColNames <- c("Cylinders","VSengine","TransmissionAM","Gears","Carburetors")
mtcars[ColNames] <- lapply(mtcars[ColNames], factor)

summary(mtcars)
str(mtcars)

par(mfrow=c(3,2))
plot(mtcars$Cylinders,main="Cylinders")
plot(mtcars$VSengine,main="VSengine")
plot(mtcars$TransmissionAM,main="TransmissionAM")
plot(mtcars$Gears,main="Gears")
plot(mtcars$Carburetors,main="Carburetors")

par(mfrow=c(3,2))
plot(mtcars$mpg ~ mtcars$Cylinders, main="Cylinders")
plot(mtcars$mpg ~ mtcars$VSengine,main="VSengine")
plot(mtcars$mpg ~ mtcars$TransmissionAM,main="TransmissionAM")
plot(mtcars$mpg ~ mtcars$Gears,main="Gears")
plot(mtcars$mpg ~ mtcars$Carburetors,main="Carburetors")


##################################################################
# Dealing with Factors
##################################################################
mtcars.5 <- lm(mpg ~ Horsepower + Weight + Cylinders, data=mtcars)
summary(mtcars.5)

mtcars.6 <- lm(mpg ~ Horsepower + Weight + Cylinders + VSengine + TransmissionAM + Gears + Carburetors, data=mtcars)
summary(mtcars.6)

mtcars.7 <- lm(mpg ~ Horsepower + Weight + Cylinders + TransmissionAM, data=mtcars)
summary(mtcars.7)


##################################################################
# Prediction
##################################################################

Horsepower <- c(100,150,200,395)
Weight <- c(2.5,3.5,5.2,5.6)
Cylinders <- as.factor(c(4,6,8,8))
TransmissionAM <- as.factor(c(0,1,1,1))

newcars = data.frame(Horsepower,Weight,Cylinders,TransmissionAM)

predict(mtcars.7,newdata=newcars,interval="confidence")

##################################################################
# All Variables
##################################################################
  library(ggplot2)
  library(GGally)
  ggpairs(mtcars[1:12], aes(alpha = 0.5))
  

mtcars.8 <- lm(mpg ~ ., data=mtcars[1:11])
summary(mtcars.8)

#Or

mtcars.8 <- lm(mpg ~ Cylinders+ Displacement+ Horsepower+ RearAxleRatio+ Weight+ QuarterMile+ VSengine+ TransmissionAM+ Gears+ Carburetors, data=mtcars)
summary(mtcars.8) 


##################################################################
# Forward Stepwise Regression
##################################################################

##stepwise regression forward
cars.fwd1 <- step(lm(mpg~1,data=mtcars), direction = "forward", 
                  scope=(~Cylinders+ Displacement+ Horsepower+ RearAxleRatio+ Weight+ QuarterMile+ VSengine+ TransmissionAM+ Gears+ Carburetors))
summary(cars.fwd1)

##################################################################
# Backward Stepwise Regression
##################################################################


cars.back1 <- step(lm(mpg ~ Cylinders+ Displacement+ Horsepower+ RearAxleRatio+ Weight+ QuarterMile+ VSengine+ TransmissionAM+ Gears+ Carburetors,data=mtcars), direction = "backward")
summary(cars.back1)
