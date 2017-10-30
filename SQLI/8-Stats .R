###############################################
## 8.1
## Qualitative - Categorical, or a Category
## Quantitative 
###############################################

## Load and view the dataset
library(ggplot2)
library(dplyr)
data(mtcars)
View(mtcars)


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



## Can we do this without looking and guessing?
## Is this a godd way7 to figure out Quantitative vs Qualitative? 

unique(mtcars$Cylinders)
unique(mtcars$Displacement)
unique(mtcars$Horsepower)
unique(mtcars$RearAxleRatio)
unique(mtcars$Weight)
unique(mtcars$QuarterMile)
unique(mtcars$VSengine)
unique(mtcars$TransmissionAM)
unique(mtcars$Gears)
unique(mtcars$Carburetors)

## Review the data

summary(mtcars)

str(mtcars)

# Change to factors 

mtcars$Cylinders <- as.factor(mtcars$Cylinders)
mtcars$VSengine <- as.factor(mtcars$VSengine)
mtcars$TransmissionAM <- as.factor(mtcars$TransmissionAM)
mtcars$Gears <- as.factor(mtcars$Gears)
mtcars$Carburetors <- as.factor(mtcars$Carburetors)

summary(mtcars)

str(mtcars)


###############################################
## 8.2
## Mean, Median, Mode, Central Tendency
###############################################
library(mosaic)

USData <- read.csv("https://raw.githubusercontent.com/sqlshep/SQLShepBlog/master/data/USA.dataAll.csv")

options(scipen=999)

summary(USData$PovertyPercent)
mosaic::favstats(USData$PovertyPercent)

hist(USData$PovertyPercent)

hist(USData$EDU_LessHSDiploma, breaks=20)
hist(USData$EDU_HSDiploma)
hist(USData$EDU_SomeCollegeorAS, xlim=c(5,50))
hist(USData$EDU_BSorHigher)

hist(USData$UnemploymentRate)

hist(USData$Married)
hist(USData$Divorced)

hist(USData$HHMedianIncome)

hist(USData$Obesity)

plot(USData$Obesity, USData$OpiodRx)

plot(USData$Obesity, USData$UnemploymentRate)

plot(USData$Obesity, USData$Married)

plot(USData$Obesity, USData$EDU_LessHSDiploma)

plot(USData$OpiodRx, USData$Obesity)

plot(USData$UnemploymentRate,USData$HHMedianIncome)
abline(lm(USData$HHMedianIncome ~ USData$UnemploymentRate))

ggplot(USData, aes(UnemploymentRate, HHMedianIncome, color=EDU_LessHSDiploma))+
  geom_point() +
  facet_wrap(~RuralUrbanCode)


ggplot(USData, aes(Obesity))+
  geom_histogram(col="white",
                 fill="blue")


#######################################################################
# 8.3 
# Hypo One Sample T-Test, test for mean 
#######################################################################

# Build a new dataframe 
UE <-data.frame(Winner = as.character(USData$Winner), UnemploymentRate = USData$UnemploymentRate)

# Change two varialbes to Catagorical 
UE$Winner <- ifelse(UE$Winner == 0, "Clinton",
          ifelse(UE$Winner == 1, "Trump", NA))

hist(UE$UnemploymentRate)

UE.test <- t.test(UE$UnemploymentRate, alternative = "two.sided", mu=5)

UE.test

#ggplot(data.frame(x=UE$UnemploymentRate))+
#  geom_density(aes(x=x))+
#  geom_vline(xintercept=UE.test$statistic) 


#######################################################################
# 8.4
# Two sample T-Test compare Means
#######################################################################

hist(UE$UnemploymentRate)

hist(UE$UnemploymentRate[UE$Winner == "Trump"])

hist(UE$UnemploymentRate[UE$Winner == "Clinton"])

## Shapiro.test tests for normality in the distribution, 
## to pass the Shapirio test P must be > .05
## p value are the chances that this data came from a normal distribution

shapiro.test(UE$UnemploymentRate)

shapiro.test(UE$UnemploymentRate[UE$Winner == "Clinton"])

shapiro.test(UE$UnemploymentRate[UE$Winner == "Trump"])

## Three Shapiro tests indicate the data is not normally ditributed.
## So, run Ansari, but we fail that too.
## In stats as in life, move forward anyway! 

ansari.test(UnemploymentRate ~ Winner, UE)

# The two sample T-Test
t.test(UnemploymentRate ~ Winner, data = UE, var.equal = TRUE)



#  While we are here lets look at some other values

#Change the 0/1 to trump/clinton for ease of reading
USData$Winner <- as.character(USData$Winner)
USData$Winner <- ifelse(USData$Winner == 0, "Clinton",
                    ifelse(USData$Winner == 1, "Trump", NA))

t.test(PovertyPercent ~ Winner, data = USData, var.equal = TRUE)

t.test(Obesity ~ Winner, data = USData, var.equal = TRUE)

t.test(EDU_LessHSDiploma ~ Winner, data = USData, var.equal = TRUE)
t.test(EDU_HSDiploma ~ Winner, data = USData, var.equal = TRUE)
t.test(EDU_SomeCollegeorAS ~ Winner, data = USData, var.equal = TRUE)
t.test(EDU_BSorHigher ~ Winner, data = USData, var.equal = TRUE)


mean(subset(UE, Winner == "Clinton")$UnemploymentRate, na.rm= TRUE)
mean(subset(UE, Winner == "Trump")$UnemploymentRate, na.rm= TRUE)


UE$RateLarge <- ifelse(UE$UnemploymentRate >= 7, "HighRate",
                      ifelse(UE$UnemploymentRate < 7, "LowRate", NA))
  
# # Contingency Table 
# # Create a class of table
# UETable <- table(UE$RateLarge,UE$Winner)
# 
# UETable
# # Proportion table
# prop.table(UETable)
# margin.table(UETable,1)
# margin.table(UETable,2)
# 
# # Contingency table 
# #install.packages("gmodels")
# library(gmodels)
# 
# with(UE, CrossTable(RateLarge, Winner))
# xtabs(~ RateLarge + Winner,UE)
# 
# 
# # Summary with Chi Square 
# summary(UETable)
# 
