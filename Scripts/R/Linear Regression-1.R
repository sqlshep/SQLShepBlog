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

