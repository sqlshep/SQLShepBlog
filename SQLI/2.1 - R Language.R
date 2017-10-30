# 88                                                   88888888ba       ad888888b,       88  
# 88                ,d                                 88      "8b     d8"     "88     ,d88  
# 88                88                                 88      ,8P             a8P   888888  
# 88  8b,dPPYba,  MM88MMM  8b,dPPYba,   ,adPPYba,      88aaaaaa8P'          ,d8P"        88  
# 88  88P'   `"8a   88     88P'   "Y8  a8"     "8a     88""""88'          a8P"           88  
# 88  88       88   88     88          8b       d8     88    `8b        a8P'             88  
# 88  88       88   88,    88          "8a,   ,a8"     88     `8b      d8"          888  88  
# 88  88       88   "Y888  88           `"YbbdP"'      88      `8b     88888888888  888  88
############################################################################################
##comment 

#addition
1 + 4

#subtraction
2 * 4

#division
5 / 4

#modulo (remainder only)
6 %% 4 

#base/float/integer division
6 %/% 4 

#exponent
6^2

#exponent
6**2

#square root
sqrt(36)

# is 3 less than 4
3 < 4

#is 3 greater than 4
3 > 4

# is 3 less than or equal to 4
3 <= 4

# is 3 greater than or equal to 4
3 >= 4

#is 3 equal to 4
3 == 4

#is 3 not equal to 4
3 != 4

# is 3 or 4
3 | 4

#is 3 and 4
3 & 4

#is the value being tested result in a boolean true
isTRUE(FALSE)

# assign the result of 6**2 to x
x <- 6**2

class(x) # class = waht is it?

y <- c(1,2,3,4,5,6) # create a numeric vector 
class(y) # waht is it? 

# list all the datasets currently loaded and available 
data() 

# View in R the crimtab dataset
View(crimtab)
?crimtab


data(mtcars) # load the mtcars dataset 
View(mtcars) # display the mtcars dataset in R

?mtcars
class(mtcars) # class = waht is it?

#show the mpg column of mtcars
mtcars$mpg

summary(mtcars)
str(mtcars)

#fix(mtcars)

x <- 1
repeat {
  print(x);
  x = x+1;
  if (x == 6){
    break;}
  else
    print("not yet")
  
}

#load up a vector with lower case a-z
x <-letters
x <- toupper(letters)

NROW(x)

#loop through them and print one at a time
for (i in x){
  print(i)
}
  

#Read in a csv localy or form github...
Edu_Fl <- read.csv("https://raw.githubusercontent.com/sqlshep/SQLShepBlog/master/FloridaData/Edu_CollegeDegree-FL.csv")
data.election <- read.csv("/Users/Shep/Harvard DS/Stat 150/Project/Data/2016_US_County_Level_Presidential_Results.csv",stringsAsFactors=FALSE)

write.csv(Edu_Fl, "Education_florida.csv")
getwd()

# or R Data File

saveRDS(Edu_Fl, file = "Edu_Fl.rds")
Edu_FL <- readRDS("Edu_Fl.rds")


########################################################
## For Fun
########################################################
## Load the harry Potter Books
devtools::install_github("bradleyboehmke/harrypotter")

##http://uc-r.github.io/sentiment_analysis
library(harrypotter) 
data(package="harrypotter")


data(chamber_of_secrets)
summary(chamber_of_secrets)
str(chamber_of_secrets)

typeof(chamber_of_secrets)
hp_ch1 <- chamber_of_secrets[1:1]

class(hp_ch1)
typeof(hp_ch1)
length(hp_ch1)

length(chamber_of_secrets)

hp_ch1_words = 0
for (i in hp_ch1) {
  hp_ch1_words = hp_ch1_words + 1 
}

print(hp_ch1_words)
#?? WHy so few words?


#print the top of the chapter
head(hp_ch1)

#split the words into seperate strings, the [[1]] prevents it from becoming a list 
hp_ch1_split <- tolower(strsplit(hp_ch1, " ")[[1]])

#now see that the words are indiviual strings 
head(hp_ch1_split)

#set a variable to count total words
hp_ch1_words = 0

#for loop to count with no pre-processing
for (i in hp_ch1_split) {
  hp_ch1_words = hp_ch1_words + 1
}


print(hp_ch1_words)


##  or

#install.packages("ngram")
library(ngram)

?ngram

string.summary(hp_ch1)

wordcount(hp_ch1_split)

#install.packages("wordcloud") 
#install.packages("tm")  # for text mining
#install.packages("RColorBrewer") # color palettes
library(wordcloud)
library(tm)
library(RColorBrewer)

?wordcloud

wordcloud(words = hp_ch1_split,  min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
