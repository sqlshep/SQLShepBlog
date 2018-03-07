library(dplyr)
library(ggplot2)
library(GGally)

#Load the data 
#https://www.epa.gov/compliance-and-fuel-economy-data/data-cars-used-testing-fuel-economy

# If you do not want to download the file, you can read it directly from the source into a dataframe.
# epa <- read.csv("https://www.epa.gov/sites/production/files/2017-10/18tstcar.csv")



# Set working dir if you download this locally
# getwd()
setwd("/Users/Shep/git/SQLShepBlog/data")
epa <- read.csv("18tstcar.csv",stringsAsFactors=FALSE)


# there are several ways to rename columns, here are three ways to do it, 
# choose your fav and stick with it

names(epa)[12] <-paste("Cylinders")
names(epa)[46] <-paste("FuelEcon")

colnames(epa)[colnames(epa)=="X..of.Gears"] <- "Gears"
colnames(epa)[colnames(epa)=="Axle.Ratio"] <- "AxleRatio"

epa <- dplyr::rename(epa, HorsePower = "Rated.Horsepower")
epa <- dplyr::rename(epa, Weight = "Equivalent.Test.Weight..lbs..")
epa <- dplyr::rename(epa, Model = "Represented.Test.Veh.Model")

# now that we have a much larger dataset we can do a few visualizations to confirm some prior hypothesis. 
ggplot(epa,aes(FuelEcon,Weight))+
  geom_point()

# in case you are wondering, this is where the shit show begins
# We have weight and mpg and a car that claims to get 10,000 mpg
# In a real Data Science job this is where you will spend 80% of your life
# My best advice is to treat it like a game.
# Now you ahve to determine what vehicle gets 10,000mpg and is it cool enough for you to buy?
# No, i mean should you remove the row, fix the value or leave it?
# All are valid possible actions and one will be the answer.
# according to https://www.fueleconomy.gov/feg/noframes/39181.shtml the mpg shoud be 
# 30 combined, so we will fix by script.  But, much like SQL be careful.. 
# the following will produce three rows for the Chevy Sonic, we will delete the one with 10,000 mpg

filter(epa,   FuelEcon > 9000)

epa[epa$Test.Vehicle.ID == "184HV863DA" ,]
epa[epa$Test.Vehicle.ID == "184HV863DA" ,c("Represented.Test.Veh.Make","Model","Test.Vehicle.ID","FuelEcon")]


# We will remove anything in the dataframe that is not the specific vehicle id,and which has a mpg of less than 9999.  
# For some reason on my machine FuelEcon == 10000.0 is not working, i am not sure why at this moment. 
# Lets look at what we have with summary, my daframe has 3509 observations or rows
summary(epa$FuelEcon)
NROW(epa)

#  > summary(epa$FuelEcon)
#  Min.  1st Qu.   Median     Mean  3rd Qu.     Max.     NA's 
#  0.00    24.40    30.90    35.86    40.30 10000.00       12 

epa <- (filter(epa, FuelEcon < 9999))

# The summary() shows that the max of 10000 is gone and there are no more NAs.  Which for me is good since i had decided ot get rid of them.  
# In a real date scenario you must decide what is the best way to handle missing data, throw them out, 
# average them based on other similar data, or go find the data.  There are entire schools of thought on how to deal with missing data, 
# simply deleeing the data may not always be the best thing to do. 

summary(epa$FuelEcon)
NROW(epa)

#  > summary(epa$FuelEcon)
#  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#  0.00   24.40   30.85   33.01   40.28  395.40 

#  Okay, back to visuals.

ggplot(epa,aes(FuelEcon,Weight))+
  geom_point()

#  Well, its better but now i have what are clear outliers and one in the 400 mpg range. 
#  Now, i once had a 3000 pund diesel car and it got no where near 400mpg, so i am going to assume this is 
#  either bad data or a Tesla.


ggplot(epa, aes(FuelEcon,Weight)) +
  geom_point() +
  geom_text(data=subset(epa, FuelEcon > 90),aes(FuelEcon,Weight,label=Model), vjust=-.5, hjust=.10)


filter(epa, FuelEcon > 100)
epa[epa$FuelEcon > 100 ,c("Represented.Test.Veh.Make","Model","Test.Vehicle.ID","FuelEcon")]

mean(epa$FuelEcon) + mean(epa$FuelEcon)*2
mean(epa$FuelEcon) - mean(epa$FuelEcon)*2

################################################################################################

View(filter(epa,   Test.Procedure.Description == "Charge Depleting Highway" | Test.Procedure.Description == "Charge Depleting UDDS"))

epa <- filter(epa,   Test.Procedure.Description != "Charge Depleting Highway" & Test.Procedure.Description != "Charge Depleting UDDS")



ggplot(epa,aes(FuelEcon,Weight))+
  geom_point()
summary(as.factor(epa$Weight))


View(filter(epa,   Represented.Test.Veh.Make == "BENTLEY" & Model == "Continental GT" ))

table(epa$Test.Procedure.Description)

## If you wnated to keep just one test, this code will do it
#epa <- filter(epa,   Test.Procedure.Description == "HWFE" )
#epa <- filter(epa,   Test.Procedure.Description == "US06" )


k<-table(epa$Test.Vehicle.ID)
head(sort(k,decreasing = TRUE))

View(filter(epa, epa$Test.Vehicle.ID == "53XECSE012"))

k1<-filter(epa, epa$Test.Vehicle.ID == "53XECSE012")
table(k1$Model,k1$Test.Fuel.Type.Description)
table(k1$Test.Fuel.Type.Description,round(k1$FuelEcon))

k1<-filter(epa, epa$Test.Vehicle.ID == "EGAA1M")
table(k1$Model,k1$Test.Fuel.Type.Description)
table(k1$Test.Fuel.Type.Description,round(k1$FuelEcon))


################################################################
# Trim 

# Remove Police Vehicles
View(filter(epa, epa$Police...Emergency.Vehicle. == "Y"))
table(epa$Police...Emergency.Vehicle.)

epa <- filter(epa,epa$Police...Emergency.Vehicle. != "Y" )

View(distinct(epa,Vehicle.Manufacturer.Name
              ,Veh.Mfr.Code
              ,Represented.Test.Veh.Make
              ,Model
              ,Test.Vehicle.ID
              ,Test.Veh.Displacement..L.
              ,Drive.System.Description
              ,AxelRatio
              ,Weight
              ,Test.Fuel.Type.Cd
              , .keep_all = TRUE))

epa <- (distinct(epa,Vehicle.Manufacturer.Name
              ,Veh.Mfr.Code
              ,Represented.Test.Veh.Make
              ,Model
              ,Test.Vehicle.ID
              ,Test.Veh.Displacement..L.
              ,Drive.System.Description
              ,AxelRatio
              ,Weight
              ,Test.Fuel.Type.Cd
              , .keep_all = TRUE) )



# trim down the columns for the mdel training set 
View(epa[c(4,5,10,11,12,14,15,16,18,22,23,34,35,36,37,46)])

epaMpg <- epa[c(4,5,10,11,12,14,15,16,18,22,23,34,35,36,37,46)]

names(epaMpg)

epaMpg$Cylinders <- as.factor(epaMpg$Cylinders)
epaMpg$Tested.Transmission.Type.Code <- as.factor(epaMpg$Tested.Transmission.Type.Code)
epaMpg$Gears <- as.factor(epaMpg$Gears)
epaMpg$Test.Procedure.Cd <- as.factor(epaMpg$Test.Procedure.Cd)
epaMpg$Drive.System.Code <- as.factor(epaMpg$Drive.System.Code)
epaMpg$Test.Fuel.Type.Cd <- as.factor(epaMpg$Test.Fuel.Type.Cd)


epaMpg <- epaMpg[!is.na(epaMpg$Cylinders),]


ggpairs(epaMpg[c(3:6,14)])
ggpairs(epaMpg[c(8:12,14)])

options(scipen = 999)
epaMpg.1 <- lm(FuelEcon ~ HorsePower + Cylinders + Tested.Transmission.Type.Code + Gears + Drive.System.Code + Weight + AxleRatio + Test.Procedure.Cd + Test.Fuel.Type.Cd,data=epaMpg)
summary(epaMpg.1)




#write.csv(epaMpg, file = "epaMpg.csv")


HorsePower <- c(395,1500,70)
Cylinders <- as.factor(c(8,16,4))
Tested.Transmission.Type.Code <- as.factor(c("A","SA","CVT"))
Gears <-as.factor(c(8,8,1))
Drive.System.Code <- as.factor(c(4,"A","F"))
Weight <- c(5500,4750,2800)
AxleRatio <-c(3.21,3.64,3.2)
Test.Procedure.Cd <- as.factor(c(90,90,90))
Test.Fuel.Type.Cd <- as.factor(c(61,61,61))

newcars = data.frame(HorsePower,Cylinders,Tested.Transmission.Type.Code,Gears,Drive.System.Code,Weight,AxleRatio,Test.Procedure.Cd,Test.Fuel.Type.Cd)

predict(epaMpg.1,newdata=newcars,interval="confidence")


####################################################################################################################################
# Forward Stepwise Regression
####################################################################################################################################

##stepwise regression forward
epaMpg.fwd1 <- step(lm(FuelEcon~1,data=epaMpg), direction = "forward", 
                  scope=(~HorsePower + Cylinders + Tested.Transmission.Type.Code + Gears + Drive.System.Code + Weight + AxleRatio + Test.Procedure.Cd + Test.Fuel.Type.Cd))
summary(epaMpg.fwd1)

epaMpg.back1 <- step(lm(FuelEcon ~ HorsePower + Cylinders + Tested.Transmission.Type.Code + Gears + Drive.System.Code + Weight + AxleRatio + Test.Procedure.Cd + Test.Fuel.Type.Cd,data=epaMpg), direction = "backward")
summary(epaMpg.back1)


ggplot(epa,aes(FuelEcon))+
  geom_histogram()

summary(epa$FuelEcon)

ggplot(epa,aes(Weight))+
  geom_histogram()

summary(epa$Weight)

ggplot(epa,aes(HorsePower))+
  geom_histogram()

ggplot(epa,aes(FuelEcon,HorsePower))+
  geom_point()

summary(epa$HorsePower)

epa[epa$HorsePower > 1000 ,c("Represented.Test.Veh.Make","Model","Test.Vehicle.ID","FuelEcon")]
View(epa[epa$HorsePower > 1000 ,])
View(epa[epa$Test.Procedure.Description =="HWFE" ,])

ggplot(epa,aes(FuelEcon,AxleRatio))+
  geom_point()

ggplot(epa,aes(AxleRatio))+
  geom_histogram()

summary(epa$AxleRatio)

ggplot(epa,aes(FuelEcon,AxleRatio))+
  geom_point()


table(as.factor(epa$Cylinders))
table(as.factor(epa$Weight))
table(as.factor(epa$AxleRatio))
table(as.factor(epa$Gears))
