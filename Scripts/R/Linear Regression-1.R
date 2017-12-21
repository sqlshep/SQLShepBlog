#install.packages("ggplot2")
library(ggplot2)
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

summary(mtcars)
str(mtcars)

summary(mtcars$wt)
summary(mtcars$mpg)

# If you absolutely must convert, here you go
mtcars$lp100k <- (100 * 3.785) / (1.609 * mtcars$mpg)

#? will display help about thedataset
#names will display the column/variable names
?mtcars
names(mtcars)


plot(mtcars$mpg ~ mtcars$wt,
     main = "MTCars Weight");
abline(lm(mtcars$mpg ~ mtcars$wt),
       lwd=3, 
       col="red")

# Use a side by side chart and add text lables to the dots
par(mfrow=c(1,2))

plot(mtcars$mpg ~ mtcars$wt,
     main = "MTCars Weight");
abline(lm(mtcars$mpg ~ mtcars$wt),
       lwd=3, 
       col="red")
text(mtcars$wt, mtcars$mpg, row.names(mtcars), cex=0.9, pos=4, col="red")


plot(mtcars$lp100k ~ mtcars$wt,
     main = "MTCars Weight");
abline(lm(mtcars$lp100k ~ mtcars$wt),
       lwd=3, 
       col="red")
text(mtcars$wt, mtcars$lp100k, row.names(mtcars), cex=0.9, pos=4, col="red")

#fix the row names, i want them to be a column  
mtcars$Model <- row.names(mtcars)
row.names(mtcars) <- NULL
names(mtcars)


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

#this is the linear regression function that will provide intercept and slope   
mtcars.1 <- lm(mtcars$mpg ~ mtcars$wt)

summary(mtcars.1)

# If we pass in the interept and slope coordinates a "regression line will be drawn through the data"
plot(mtcars$mpg~mtcars$wt,
     cex=1, 
     pch=16);
abline(37.2851, -5.3445,
       lwd=3, 
       col="red")
