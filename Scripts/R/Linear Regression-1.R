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
mtcars.1 <- lm(mpg ~ wt,data=mtcars)

summary(mtcars.1)

# If we pass in the interept and slope coordinates a "regression line will be drawn through the data"
plot(mtcars$mpg~mtcars$wt,
     cex=1, 
     pch=16);
abline(37.2851, -5.3445,
       lwd=3, 
       col="red")


predict(mtcars.1,list(wt=c(2.0)))

predict(mtcars.1,list(wt=c(2.0,3.0,4.0,9.0)), interval="confidence")
predict(mtcars.1,list(wt=c(2.0)), interval="prediction")



##########################################################
# Intercept and slope 
##########################################################
## check out the x and y intercept 

par(bg = 'lightblue')
plot(mpg~wt,data=mtcars,
     ylim=c(-15,40),
     xlim=(c(0,10))
)
abline(lm(mtcars$mpg ~ mtcars$wt), col="red",lwd=3)
abline(v=2.0, col="orange",lwd=3)
abline(v=3.0, col="yellow",lwd=3)
abline(v=4.0, col="green",lwd=3)
abline(v=9.0, col="blue",lwd=3)
#reset
par(bg = 'white')


ggplot(mtcars, aes(x=wt, y=mpg)) + 
  geom_point() + 
  geom_smooth(method=lm)

