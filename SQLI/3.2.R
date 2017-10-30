#######################################################################################
#######################################################################################

######    ######   ########  ##        #######  ########     #######       #######  
##    ##  ##    ##  ##     ## ##       ##     ##    ##       ##     ##     ##     ## 
##        ##        ##     ## ##       ##     ##    ##              ##            ## 
##   #### ##   #### ########  ##       ##     ##    ##        #######       #######  
##    ##  ##    ##  ##        ##       ##     ##    ##              ##     ##        
##    ##  ##    ##  ##        ##       ##     ##    ##       ##     ## ### ##        
 ######    ######   ##        ########  #######     ##        #######  ### #########

#######################################################################################


# Explore
################################################################

?mtcars
#data()
data(mtcars)

View(mtcars)

summary(mtcars)

str(mtcars)

# Engineer some data
# convert fields to factors
mtcars$cyl <- as.factor(mtcars$cyl)
mtcars$carb <- as.factor(mtcars$carb)
mtcars$vs <- as.factor(mtcars$vs)
mtcars$am <- as.factor(mtcars$am)
mtcars$gear <- as.factor(mtcars$gear)

################################################################
#
# Install the package, load it
################################################################

#install.packages("ggplot2")
#install.packages("ggthemes")
#install.packages("GGally")
library(ggplot2)
library(GGally)
library(ggthemes)

################################################################
#
# Histogram
################################################################

#qplot is a wrapper (so to speak) for ggplot if you like plot
#syntax claims to be similar, but not really... 
?qplot 
qplot(mtcars$mpg) 
quickplot(mtcars$hp,geom="histogram")


##
## The good stuff
## Start basic, the minimum
ggplot(data=mtcars, aes(mpg)) +
   geom_histogram()

# Add some labels for x and y 
ggplot(data=mtcars, aes(mpg)) +
    geom_histogram() +
    labs(x="MPG", y="Numver of Cars")

# put some space between the bars
ggplot(data=mtcars, aes(mpg)) + 
    geom_histogram(col="white") +
    labs(title="Miles Per Gallon Histogram") +
    labs(x="MPG",y="Numver of Cars")

# color code each bar with a factor, gear, carb, am,  etc.. 
ggplot(data=mtcars, aes(mpg, fill=carb)) + 
    geom_histogram(col="black",binwidth = 1) +
    labs(title="Miles Per Gallon Histogram") +
    labs(x="MPG", y="Numver of Cars")

# color code each bar with a factor, gear, carb, am,  etc.. 
ggplot(data=mtcars, aes(mpg, fill=carb)) + 
  geom_histogram(col="white",binwidth = 1) +
  labs(title="Miles Per Gallon Histogram") +
  labs(x="MPG", y="Number of Cars") +
  theme_economist()
  #theme_solarized_2(light = FALSE)
  #theme_tufte(ticks = TRUE)
  #theme_fivethirtyeight()
  #theme_void()
  #theme_grey()
  #theme_bw()
  #theme_dark()


## Pairs

ggpairs(mtcars[1:2])

p_ <- GGally::print_if_interactive

data(flea)
ggpairs(flea, columns = 2:4)
pm <- ggpairs(flea, columns = 2:4, ggplot2::aes(colour=species))
p_(pm)


################################################################
#
# Scatter Plot
################################################################

# The minimum
ggplot(data=mtcars) + 
  geom_point(aes(mpg,disp)) 

# add some lables 
ggplot(data=mtcars) + 
  geom_point(mapping=aes(mpg,disp)) +
  labs(title="Miles Per Gallon vs Engine Displacement") +
  labs(x="MPG", y="Engine Cubic Inches")

# Add  color to identify cylinders
ggplot(data=mtcars) + 
  geom_point(aes(x=mpg, y=disp, colour = factor(cyl))) +
  labs(title="Miles Per Gallon vs Engine Displacement") +
  labs(x="MPG", y="Engine Cubic Inches")   

# Add size to identify number of gears
ggplot(data=mtcars) + 
    geom_point(aes(x=mpg, y=disp, colour = factor(cyl), size = factor(gear))) +
    labs(title="Miles Per Gallon vs Engine Displacement") +
    labs(x="MPG", y="Engine Cubic Inches")   

# Add labels
ggplot(data=mtcars, aes(mpg,disp)) + 
  geom_point(aes(x=mpg, y=disp,colour = factor(cyl), size = factor(gear))) +
  labs(title="Miles Per Gallon vs Engine Displacement") +
  labs(x="MPG", y="Engine Cubic Inches") +
  geom_text(aes(label=row.names(mtcars)), size=4, nudge_x = 0, nudge_y = 9,check_overlap = FALSE) 

  
# repalce the points with just the car names
ggplot(data=mtcars, aes(mpg,disp)) + 
  labs(title="Miles Per Gallon vs Engine Displacement") +
  labs(x="MPG", y="Engine Cubic Inches") +
  geom_text(aes(colour = factor(cyl),label=row.names(mtcars)), size=5, nudge_x = 0, nudge_y = 0,check_overlap = FALSE) 

# Add size to identify number of gears
ggplot(data=mtcars, aes(mpg,disp)) + 
  geom_point(aes(colour = factor(cyl), size = factor(carb))) +
  labs(title="Miles Per Gallon vs Engine Displacement Grouped by Gears") +
  labs(x="MPG", y="Engine Cubic Inches")+
  facet_grid(. ~ gear)

# Add size to identify number of gears
ggplot(data=mtcars, aes(mpg,disp)) + 
  geom_point(aes(colour = factor(cyl), size = factor(carb))) +
  labs(title="Miles Per Gallon vs Engine Displacement Grouped by Gears") +
  labs(x="MPG", y="Engine Cubic Inches")+
  facet_wrap("gear")

p <- ggplot(data=mtcars, aes(mpg,disp)) + 
  geom_point(aes(colour = factor(cyl), size = factor(carb))) +
  labs(title="Miles Per Gallon vs Engine Displacement Grouped by Gears") +
  labs(x="MPG", y="Engine Cubic Inches")+
  facet_wrap("gear")

ggplotly(p)

################################################################
#
# Dot Plot
################################################################
# The absolute minimum
ggplot(mtcars, aes(x = mpg)) + 
  geom_dotplot()

# Meh, lets switch to point and add the names of the cars, at an angle
ggplot(mtcars, aes(x=row.names(mtcars), y=mpg)) + 
  geom_point() +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))
  
# Flip it so the vehicle names are on the left 
ggplot(mtcars, aes(x=row.names(mtcars), y=mpg)) + 
  geom_point() +
  coord_flip()


# Add some color based on a factor 
ggplot(mtcars, aes(x=row.names(mtcars), y=mpg)) + 
  geom_point(aes(size = factor(gear), color = factor(cyl)))+
  coord_flip()

# i prefer things in order 

mtcars <- mtcars[order(mtcars$mpg),] 

ggplot(mtcars, aes(x=row.names(mtcars), y=mpg)) + 
  geom_point(aes(size = factor(gear), color = factor(cyl)))+
  coord_flip()


## But the order is still vehicle name descending...???
## Add a reorder to the x axis
ggplot(mtcars, aes(x=reorder(row.names(mtcars),mpg), y=mpg)) + 
  geom_point(aes(size = factor(gear), color = factor(cyl)))+
  coord_flip()

################################################################
# Brace yourself, 
# Newly engineered daaset 
# Using tidyverse
################################################################

data(txhousing)
head(txhousing)
library(dplyr)

tx <- txhousing %>% 
  na.omit() %>%  
  tbl_df() %>% 
  select(city, year, median)


meanTexas <- tx %>%
  group_by(city) %>% 
  summarise(meanHouse = mean(median))

meanYearTexas <- tx %>%
  group_by(city,year) %>% 
  summarise(meanHouse = mean(median))

Abilene <- filter(meanYearTexas, city == "Abilene")

Abilene <- Abilene[,2:3]

plot(Abilene)
plot(Abilene, type="l")

#####
ggplot(Abilene, aes(x = meanHouse)) + 
  geom_dotplot()


ggplot(meanTexas, aes(x = meanHouse)) + 
  geom_dotplot(stackdir="center",binwidth=2500) 

ggplot(meanTexas, aes(x = meanHouse)) + 
  geom_dotplot(stackdir="center") +
  theme_tufte(ticks = FALSE) +
  labs(x="Mean House Price")+
  theme(axis.text=element_text(size=18))+
  theme(axis.title.x = element_text(size = rel(2))) +
  theme(axis.title.y = element_text(size = rel(2)))


################################################################
#
# line graph 
################################################################
# Add labels
ggplot(data=Abilene, aes(year,meanHouse)) + 
  geom_line() 


## Sometimes, its fun to stuff data in and see what happens
## since ggplot is pretty smart...
ggplot(data=meanYearTexas, aes(city,meanHouse)) + 
  geom_line() 


## Flip it 
ggplot(data=meanYearTexas, aes(city,meanHouse)) + 
  geom_line() +
  coord_flip()
  

## Reorder it... 
ggplot(data=meanYearTexas, aes(x=reorder(city,meanHouse),y=meanHouse)) + 
  geom_line() +
  coord_flip()


ggplot(data=meanYearTexas, aes(x=reorder(city,meanHouse),y=meanHouse, colour = year)) + 
  geom_line() +
  coord_flip()


################################################################
#
# box plot
################################################################

#Create a new Dataset with just one county
CollinCounty <- filter(txhousing, city == "Collin County")

#Box Plot it
ggplot(CollinCounty, aes(x = as.factor(year), y=median)) + 
  geom_boxplot()+
  theme(axis.text.x = element_text(angle = 60, hjust = 1))


# Cheat and perform the county filter in the plot function
ggplot((filter(txhousing, city == "Harlingen")), aes(x = as.factor(year), y=median)) + 
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))



ggplot(CollinCounty,aes(x = as.factor(year), y=median)) + 
  geom_boxplot() +
  #theme_tufte(ticks = TRUE) +
  labs(x="Mean House Price")+
  theme(axis.text=element_text(size=12))+
  theme(axis.title.x = element_text(size = rel(1.6))) +
  theme(axis.title.y = element_text(size = rel(1.6))) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))

# geom to build your owon plot 
ggplot(CollinCounty, aes(x = as.factor(year), y=median)) +
  stat_summary(
    mapping = aes(x = as.factor(year), y = median),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = mean) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))

################################################################
#
# barplot
################################################################

ggplot(mtcars,aes(gear)) +
  geom_bar()

ggplot(mtcars,aes(carb)) +
  geom_bar(aes(fill = gear))

ggplot(mtcars,aes(carb)) +
  geom_bar(aes(fill = gear)) +
  coord_flip() 
  
#barplot of inventory by year
ggplot(CollinCounty,aes(x=factor(year), y=inventory)) +
  geom_bar(stat="identity")

#barplot of inventory by year
ggplot((filter(txhousing, city == "Harlingen")),aes(x=factor(year), y=inventory)) +
  geom_bar(stat="identity")

#barplot of sales by year
ggplot((filter(txhousing, city == "Harlingen")),aes(x=factor(year), y=sales)) +
  geom_bar(stat="identity")

options(scipen=999)

#barplot of volume by year
ggplot((filter(txhousing, city == "Harlingen")),aes(x=factor(year), y=listings,fill = sales )) +
  geom_bar(stat="identity")


