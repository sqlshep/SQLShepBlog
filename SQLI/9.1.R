#install.packages("ggplot2")
#install.packages("GGally")
#install.packages("coefplot")
library(ggplot2)
#library(GGally)
library(coefplot)
##########################################################################
##########################################################################
#
#  Mtcars 
#
##########################################################################
# Demo 1 Explore the data 
##########################################################################

# lets look at some other data cars 
data(mtcars)
head(mtcars)
View(mtcars)

#? will tell about the dataset
#names will display the column/variable names
?mtcars
names(mtcars)

#fix the row names, i want them to be a column  
mtcars$Model <- row.names(mtcars)
row.names(mtcars) <- NULL
names(mtcars)


#rename the columns, to something slightly more meaningful
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


summary(mtcars)
str(mtcars)

#Some of the columns are better as factors (categorical)
# this is one way of converting data types

ColNames <- c("Cylinders","VSengine","TransmissionAM","Gears","Carburetors")
mtcars[ColNames] <- lapply(mtcars[ColNames], factor)

str(mtcars)

##########################################################################
# Demo 2 -  Plot Some stuff, is it linear
##########################################################################
# Run this, save for later 
# The R Book page 405, with additions
mcheck <- function(obj,...) { 
  rs <- obj$resid
  fv <- obj$fitted
  par(mfrow=c(1,2))
  plot(fv,rs,xlab="Fitted values",ylab="Residuals",pch=16,col="red")
  abline(h=0,lty=2)
  
  abline(2*sd(rs), 0, col="black",lty=5, lwd=3) 
  abline(-2*sd(rs), 0, col="black",lty=5,lwd=3) 
  
  qqnorm(rs,xlab="Normal scores",ylab="Ordered residuals",main="",pch=16)
  qqline(rs,lty=2,col="green")
  par(mfrow=c(1,1))
  invisible(NULL)
}

plot(mtcars$mpg~mtcars$Weight,
     cex=2, 
     pch=16,
     main = "MTCars LM");
abline(lm(mtcars$mpg ~ mtcars$Weight),
       lwd=3, 
       col="red")

#this is the linear regression function that will provide intercept and slope   
lm(mtcars$mpg ~ mtcars$Weight)

# allow for side by side plotsm 1 row 2 columns
par(mfrow=c(1,2))

# If we pass in the interept and slope coordinates a "regression line will be drawn through the data"
plot(mtcars$mpg~mtcars$Weight,
     cex=1, 
     pch=16);
abline(37.285, -5.344,
       lwd=3, 
       col="red")
  
plot(mtcars$mpg~mtcars$Weight,
     cex=1, 
     pch=16)
abline(lm(mtcars$mpg ~ mtcars$Weight),
       lwd=3, 
       col="red")

#lets plot some other stuff, is it linear? 

plot(mtcars$mpg~mtcars$Horsepower)
abline(lm(mtcars$mpg ~ mtcars$Horsepower), col="red",lwd=3)

#Notoce waht happens when you plot a factor? 
plot(mtcars$mpg~mtcars$Cylinders)

plot(mtcars$mpg~mtcars$Displacement)
abline(lm(mtcars$mpg ~ mtcars$Displacement))

plot(mtcars$mpg~mtcars$RearAxleRatio)
abline(lm(mtcars$mpg~ mtcars$RearAxleRatio))

# This doesn't look right ???
plot(mtcars$mpg~mtcars$Carburetors)
abline(lm(mtcars$mpg~ mtcars$Carburetors))

#IS there a faster way to do this, probably not this way
pairs(mtcars[1:11]) #?

pairs(~mpg+Horsepower+Displacement,data=mtcars, 
      main="Simple Scatterplot Matrix")

#Look diiferently
# is there a trend bewtween engine size, horsepower and mpg?
ggplot(mtcars,aes(x = Horsepower, y = mpg)) + 
  geom_point() +
  #facet_wrap(~ Gears, nrow = 3) +
  facet_wrap(~ Carburetors, nrow = 3,scales = "free") +
  ggtitle("HP by MPG and Factored by ***??") +
  geom_smooth(method='lm', se= F) #+
#geom_text(aes(label=Model),hjust=-.2, vjust=-.1)

# is there a trend bewtween engine cylinders, weight and mpg?
ggplot(data = mtcars,mapping = aes(x = Weight, y = mpg)) + 
  geom_point() + 
  facet_wrap(~ Cylinders, nrow = 3) +
  ggtitle("Weight by MPG and Factored by Cylinders") +
  #geom_text(aes(label=Model),hjust=-.2, vjust=-.1) +
  geom_smooth(method='lm', se= F)

# is there a trend bewtween engine cylinders, Carburetors and mpg?
#Notice ggplot will not run a line for a factor?
ggplot(data = mtcars, mapping = aes(x = Carburetors, y = mpg)) + 
  geom_point() + 
  facet_wrap(~ Cylinders, nrow = 3) +
  ggtitle("Carburetors by MPG and Factored by Cylinders") +
  geom_smooth(method='lm')

# is there a trend bewtween engine cylinders, RearAxleRatio and mpg?
ggplot(data = mtcars,mapping = aes(x = RearAxleRatio, y = mpg)) + 
  geom_point() + 
  facet_wrap(~ Cylinders, nrow = 3) +
  ggtitle("RearAxleRatio by MPG and Factored by Cylinders") +
  geom_smooth(method='lm', se= F)

#Is there a trend between cylinders, displacement and mpg

ggplot(data = mtcars, aes(x = QuarterMile, y = mpg)) +
  geom_point(aes(colour=factor(Cylinders)))

#ggplot(data = mtcars, aes(x = Weight, y = mpg)) +
#  geom_text(aes(label=Model),hjust=-.2, vjust=-.1) +
#  geom_point(aes(colour=factor(Cylinders),size=Displacement))

ggplot(data = mtcars, aes(x = Weight, y = mpg)) +
  geom_point(aes(colour=factor(Cylinders),size=Displacement))


#Is there a trend between cylinders, quarter mile time and mpg
ggplot(data = mtcars, aes(x = Weight, y = mpg)) +
  geom_point(aes(colour=factor(Cylinders),size=QuarterMile))

#There is a car with a low QM time that gets 16mpg, what is it? 
ggplot(data = mtcars, aes(x = Weight, y = mpg)) +
  geom_point(aes(colour=factor(Cylinders),size=QuarterMile)) +
  geom_text(aes(label=Model),hjust=-.01, vjust=-.1) 

##########################################################################
# Demo 3 - Can we use this data to create a model to predict mpg?
##########################################################################

options(scipen=999)

# Start small
# Review each coefficient
cars.lm1 <- lm(mpg ~  Horsepower, data=mtcars)
summary(cars.lm1)

##########################################################################
# Demo 3.1 - Exam the residuals
##########################################################################

#Review the X Y plot
# the differnece in the prediction (the line) 
# and the actual values is the residuals
# Y-hat vs Y

plot(mtcars$mpg~mtcars$Horsepower,
     cex=2, 
     pch=16,
     xlab="Horsepower",  #X axis label
     ylab="Miles per gallon",
     main = "Residual Error") #Y axis label)
abline(lm(mtcars$mpg ~ mtcars$Horsepower),
       lwd=3, 
       col="red")

#Add some lines between the line and the actual to demonstrate the error
yhat <- predict(cars.lm1 , tfr = mtcars$Horsepower)
join <- function(i) 
  lines(c(mtcars$Horsepower[i],mtcars$Horsepower[i]),c(mtcars$mpg[i],yhat[i]),col="green",lwd=2)
sapply(1:32,join)


plot(mtcars$Horsepower, cars.lm1$residuals, ylim = c(-10,10)) 
abline(0, 0)                
abline(2*sd(cars.lm1$residuals), 0, col="red",lty=5) 
abline(-2*sd(cars.lm1$residuals), 0, col="red",lty=5) 

#more than one way to show this....
qqnorm(mtcars$mpg)
qqline(mtcars$mpg,lwd=3)

par(mfrow=c(2,2))
plot(cars.lm1)

mcheck(cars.lm1)

hist(cars.lm1$residuals,breaks=10, col= "lightblue", xlim=c(-10,10))


##########################################################
# 3.2 
# Intercept and slope 
##########################################################
## check out the x and y intercept 
plot(mtcars$mpg~mtcars$Horsepower,
     ylim=c(0,40),
     xlim=(c(0,500))
     )
abline(lm(mtcars$mpg ~ mtcars$Horsepower), col="red",lwd=3)
abline(h=30.09886, col="black",lwd=3)
abline(v=0, col="black",lwd=3)


## check out the x and y intercept for 225 hp

plot(mtcars$mpg~mtcars$Horsepower,
     ylim=c(0,40),
     xlim=(c(0,500))
)
abline(lm(mtcars$mpg ~ mtcars$Horsepower), col="red",lwd=3)
abline(h=14.74711, col="black",lwd=3)
abline(v=225, col="black",lwd=3)

##Make a prediction 
predict(cars.lm1,list(Horsepower=c(225)))

##########################################################
# 3.3 Check out each explanatory variable 
##########################################################

cars.lm1 <- lm(mpg ~  Horsepower, data=mtcars)
summary(cars.lm1)

cars.lm2 <- lm(mpg ~  Displacement, data=mtcars)
summary(cars.lm2)

cars.lm3 <- lm(mpg ~  RearAxleRatio, data=mtcars)
summary(cars.lm3)

cars.lm4 <- lm(mpg ~  Weight, data=mtcars)
summary(cars.lm4)

cars.lm5 <- lm(mpg ~  QuarterMile, data=mtcars)
summary(cars.lm5)

multiplot(cars.lm1,cars.lm2,cars.lm3,cars.lm4,cars.lm5)
anova(cars.lm1,cars.lm2,cars.lm3,cars.lm4,cars.lm5)
AIC(cars.lm1,cars.lm2,cars.lm3,cars.lm4,cars.lm5)
BIC(cars.lm1,cars.lm2,cars.lm3,cars.lm4,cars.lm5)

##########################################################
# 3.4 Multiple Regression
##########################################################

cars.lm6 <- lm(mpg ~ Displacement + Horsepower + RearAxleRatio + Weight + QuarterMile, data=mtcars)
summary(cars.lm6)


#16.53357 + (0.00872 * 350) - (0.02060 * 330) + (2.01578*3.07) - (4.38546*6.150) + (0.64015 * 14.8)


newCar <- data.frame(Displacement=225.0,Horsepower=125,RearAxleRatio=3.9,Weight=3.0,QuarterMile=18.0)

predict(cars.lm6,newCar)
predict(cars.lm6,newCar,interval="predict")
predict(cars.lm6,newCar,interval="confidence")

newCar <- data.frame(Displacement=350,Horsepower=330,RearAxleRatio=3.07,Weight=6.150,QuarterMile=14.8)

#Check the residuals, looks like a Parabola, may need to square one of the terms

ggplot(aes(x=.fitted, y=.resid), data=cars.lm6) + 
  geom_point() +
  geom_hline(yintercept = 0) +
  geom_smooth(se= FALSE) + 
  labs(x="Fitted", y="Residuals")



##########################################################
# 3.5 Add the Factors
##########################################################

cars.lm7 <- lm(mpg ~ Cylinders + Displacement + Horsepower + RearAxleRatio + Weight + QuarterMile + 
                 VSengine + TransmissionAM + Gears + Carburetors, data=mtcars)

summary(cars.lm7)
## What happened? Only one variable is significant...


coefplot(cars.lm7)

# to run a prediction create the dataframe with teh new data
newCar <- data.frame(Cylinders = 8,
              Displacement =	225,
              Horsepower =		125,
              RearAxleRatio =	3.9,
              Weight =		3.0,
              QuarterMile =		18.0,
              VSengine =		1,
              TransmissionAM = 1,
              Gears =	5,
              Carburetors = 4)

#make sure the columns taht were passed into the lm are factors
ColNames <- c("Cylinders","VSengine","TransmissionAM","Gears","Carburetors")
newCar[ColNames] <- lapply(newCar[ColNames], factor)


# run the prediction  
predict(cars.lm7,newCar)

# If our math holds truem we shoiud get the same result with the following math 
23.87913 + 225  * 0.03555 + 125  *  (- 0.07051) + 3.9  * 1.18283 + 3.0  * (-4.52978) + 
  18.0 * (0.36784) + 1  * 1.93085 + 1  * 1.21212 + 1  * 2.52840 + 1  * 1.09142 + 1  * (-0.33616 ) 



## Check the residuals, looks like a Parabola, may need to square one of the terms...
ggplot(aes(x=.fitted, y=.resid), data=cars.lm7) + 
  geom_point() +
  geom_hline(yintercept = 0) +
  geom_smooth(se= FALSE) + 
  labs(x="Fitted", y="Residuals")

##########################################################
# 3.6 Stewise 
##########################################################


##stepwise regression forward
cars.fwd1 <- step(lm(mpg~1,data=mtcars), direction = "forward", 
                  scope=(~Displacement + Horsepower + RearAxleRatio + Weight + QuarterMile))
summary(cars.fwd1)
coefplot(cars.fwd1)


cars.fwd2 <- step(lm(mpg~1,data=mtcars), direction = "forward", 
                  scope=(~Displacement + Horsepower + RearAxleRatio + Weight + QuarterMile + 
                           VSengine + TransmissionAM + Gears + Carburetors + Cylinders))
summary(cars.fwd2)
coefplot(cars.fwd2)

multiplot(cars.fwd1,cars.fwd2)

##stepwise regression backward
cars.back1 <- step(lm(mpg ~ Displacement + Horsepower + RearAxleRatio + Weight + QuarterMile, data=mtcars),
                   direction = "backward")
summary(cars.back1)
coefplot(cars.back1)

cars.back2 <- step(lm(mpg ~ Displacement + Horsepower + RearAxleRatio + Weight + QuarterMile + 
                        VSengine + TransmissionAM + Gears + Carburetors + Cylinders,data=mtcars), direction = "backward")
summary(cars.back2)
coefplot(cars.back2)

multiplot(cars.back1,cars.back2)
multiplot(cars.fwd1,cars.back1)
multiplot(cars.fwd1,cars.fwd2,cars.back1,cars.back2)

AIC(cars.fwd1,cars.fwd2,cars.back1,cars.back2)
BIC(cars.fwd1,cars.fwd2,cars.back1,cars.back2)

multiplot(cars.fwd2,cars.back2)

# Interaction, just do them all 
cars.lm3 <- lm(mpg ~Displacement * Horsepower * RearAxleRatio * Weight * QuarterMile + Cylinders +
                 VSengine + TransmissionAM + Gears + Carburetors, data=mtcars)

summary(cars.lm3)
coefplot(cars.lm3)

cars.lm3 <- lm(mpg ~Displacement * Horsepower * RearAxleRatio * Weight * QuarterMile +
                 + Cylinders + VSengine + TransmissionAM + Gears + Carburetors  , data=mtcars)

summary(cars.lm3)
coefplot.lm(cars.lm3)

multiplot(cars.lm1,cars.lm2,cars.lm3,cars.fwd2)

AIC(cars.lm1,cars.lm2,cars.lm3,cars.fwd2)
BIC(cars.lm1,cars.lm2,cars.lm3,cars.fwd2)

##the winner 
summary(cars.fwd2)

