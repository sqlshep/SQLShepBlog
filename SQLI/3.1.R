##########################################################################

########     ###     ######  ########    ########      #######        ##   
##     ##   ## ##   ##    ## ##          ##     ##    ##     ##     ####   
##     ##  ##   ##  ##       ##          ##     ##           ##       ##   
########  ##     ##  ######  ######      ########      #######        ##   
##     ## #########       ## ##          ##   ##             ##       ##   
##     ## ##     ## ##    ## ##          ##    ##     ##     ## ###   ##   
########  ##     ##  ######  ########    ##     ##     #######  ### ###### 

##########################################################################
#
# Explore
################################################################


#install.packages("ggplot2")
library(ggplot2)

?mtcars

data(mtcars)

View(mtcars)

summary(mtcars)

str(mtcars)


hist(mtcars$hp)


################################################################
## Anatomy
################################################################
?par 
## Save the graphical parameters for environment
## if you mess everything up, restart R 
savePar = par() 

# set the back ground to grey
par(bg = "grey")



hist(mtcars$hp,
     main="1974 Motor Trend",  # Main title
     sub = "Histogram Horsepower",   # Sub title
     xlab="Horsepower",   # x axis label
     ylab = "Freq",  # y axis label
     xlim = c(25,375),   # x axis limits
     ylim = c(1,11),   #  y axis limits
     labels=TRUE,   # labels for each histogram 
     col="blue",   # histogram bars fill 
     border = "lightblue",   # border of each bar
     lwd = 1,   # line width
     cex.lab=1.25,   # label font size 125% 
     cex.main=2,   # main title font, 200%
     cex.sub=1.5,   #  sub title font, 150%
     col.main = "red",   # main title color
     col.sub = "red",   # sub title color 
     font.main = 3   # main titile font 
     
)

par(savePar)  ## reset to saved environment


################################################################
#
# Histogram
################################################################
#histogram
#hist()
#?hist
hist(mtcars$hp)

hist(mtcars$hp,
     breaks=15,
     main="Histogram of 1974 Motor Trend, Horsepower"
     )

hist(mtcars$hp,
     breaks=15,
     main="Histogram of 1974 Motor Trend, Horsepower",
     xlab="Horsepower",
     col="blue",
     border = "lightblue",
     labels=TRUE
     #ylim=c(0,8),
     #las = 2
    )
################################################################
#
# Scatter Plot
################################################################
#?plot

#plot everything 

data(mtcars)
plot(mtcars)

pairs(mtcars[1:4])

#plot horse power and miles per gallon
plot(mtcars$hp,mtcars$mpg)

#Plot with a few labels 

plot(mtcars$hp,mtcars$mpg,
  main = "Scatterplot of 1974 Motor Trend, Horsepower by MPG",
  xlab = "Horsepower",
  ylab = "Miles per Gallon")

#cahnge the color, point and width
plot(mtcars$hp,mtcars$mpg,
     main = "Scatterplot of 1974 Motor Trend, Horsepower by MPG",
     xlab = "Horsepower",
     ylab = "Miles per Gallon",
     col="darkblue",
     type = "p",
     lwd=3,
     pch=4)

# add a text label to each dot, 
# cex= font size, pos is offset from point
text(mtcars$hp, mtcars$mpg, row.names(mtcars), cex=1.5, pos=4, col="black")

################################################################
#
# Dot Plot
################################################################
#dot plot
data(mtcars)
dotchart(mtcars$mpg)

dotchart(mtcars$gear)

dotchart(mtcars$carb)


#Add labels to each data point
dotchart(mtcars$mpg,labels=row.names(mtcars))

#sort 
mtcars <- mtcars[order(mtcars$mpg),] 

dotchart(mtcars$mpg,
         labels=row.names(mtcars),
         cex=.7)

#convert to factors
mtcars$cyl <- as.factor(mtcars$cyl)

dotchart(mtcars$mpg,
         labels=row.names(mtcars),
         cex=1.1, 
         groups = mtcars$cyl, 
         color=as.numeric(mtcars$cyl),
         pch=20,
         main = "MPG by Cylinders",
         xlab = "Miles per Gallon",
         pt.cex = 3)

################################################################
#
# line graph 
################################################################
#line graph
data(Seatbelts)
class(Seatbelts)

x <- Seatbelts[,0:1]
plot.ts(x, 
        ylab = "Deaths", 
        xlab = "Year")

plot.ts(Seatbelts)

################################################################
#
# box plot
################################################################
#box plot
data(mtcars)

?boxplot
boxplot(mtcars$mpg)

summary((mtcars$mpg))

boxplot(mtcars$disp ~ mtcars$cyl, 
        ylab = "Engine Size in Cubic Inches",
        xlab = "Cykinders")

boxplot(mtcars$mpg ~ mtcars$cyl, 
        ylab = "Miles per Gallon",
        xlab = "Cylinders")

boxplot(mtcars$mpg ~ round(mtcars$qsec,0), 
        ylab = "Miles per Gallon",
        xlab = "Quarter Mile Time")

boxplot(mtcars$disp ~ round(mtcars$qsec,0), 
        ylab = "Engine Size in Cubic Inches",
        xlab = "Quarter Mile Time")



################################################################
#
# barplot
################################################################

#barchart 
?barplot
vs <- table(mtcars$vs)
carb <- table(mtcars$carb)
gears <- table(mtcars$gear)
cyl <- table(mtcars$cyl)

barplot(vs)
barplot(gears)
barplot(cyl,        xlab = "Cylinders",
        ylab = "Frequency")

barplot((carb),
        horiz = TRUE,
        density = 50,
        col = "blue",
        border = "black",
        ylab = "Cylinders",
        xlab = "Frequency"
        )




