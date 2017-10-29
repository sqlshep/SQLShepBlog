################################################################################
################################################################################
##  Packages
################################################################################
################################################################################


#install.packages('RXKCD')
library(RXKCD)
getXKCD(552)
getXKCD("random")

################################################################################
##  Mine Sweeper, Rgui only
################################################################################

#install.packages("fortunes")
library(fortunes)
fortune("sudoku")

################################################################################
##  Mine Sweeper, Rgui only
################################################################################
#install.packages("fun")
library(fun)
mine_sweeper()

################################################################################
##  Animation Stats Demo
################################################################################
#install.packages("animation")
library(animation)

?flip.coin
flip.coin(faces = 2, prob = NULL, border = "white", grid = "grey", col = 1:2,
          type = "p", pch = 21, bg = "transparent", digits = 2)

##K-menas clustering Demo
kmeans.ani(x = cbind(X1 = runif(75), X2 = runif(75)), centers = 3,
           hints = c("Move centers!", "Find cluster?"), pch = 1:3, col = 1:3)


################################################################################
## Other packages choroplethr
################################################################################

#install.packages("choroplethr")
library("choroplethr")

data(package="choroplethr")
data("df_pop_county")

View(df_pop_county)

str(df_pop_county)
summary(df_pop_county)

?county_choropleth
?df_pop_county

county_choropleth(df_pop_county,
                  title = "Population Density",
                  legend="Population")

county_choropleth(df_pop_county,
                  title = "Population Density of California",
                  legend="Population",
                  num_colors=9,
                  state_zoom="california")


################################################################################
## More choroplethr
################################################################################

## You can find this in the help docs as well
library(dplyr)
library(choroplethrMaps)
data(county.regions)

# show the population of the 5 counties in FL
fl_county_names = c("monroe", "miami-dade", "collier", "broward", "palm beach", "hendry", "lee")
fl_county_fips = county.regions %>%
  filter(state.name == "florida" & county.name %in% fl_county_names) %>%
  select(region)
county_choropleth(df_pop_county, 
                  title        = "Population of Counties in Southern Florida",
                  legend       = "Population",
                  num_colors   = 7,
                  county_zoom = fl_county_fips$region)

################################################################################
################################################################################
##Since i am referecneincg Jareds Work, buy Jareds Book! ! ! ! 
################################################################################
library(ggplot2)
housing <- read.table("http://www.jaredlander.com/data/housing1.csv",
                      sep=',', 
                      header=TRUE, 
                      stringsAsFactors = FALSE)

names(housing)
head(housing)

hist(housing$ValuePerSqFt,bin=10)

ggplot(housing, aes(x=ValuePerSqFt))+ geom_histogram(binwidth = 10)
ggplot(housing, aes(x=ValuePerSqFt,color=Boro, fill=Boro))+ geom_histogram(binwidth = 10)

################################################################################
## Dazzle me more! 
################################################################################

#devtools::install_github("bwlewis/rthreejs")

library("threejs")
earth <- "http://eoimages.gsfc.nasa.gov/images/imagerecords/73000/73909/world.topo.bathy.200412.3x5400x2700.jpg"
globejs(img=earth, bg="lightblue")


################################################################################
## Dazzle me more! 
################################################################################
################################################################################


library("maptools")

#library("threejs")

data(wrld_simpl)                             # Basic country shapes
load(url("http://illposed.net/bono.rdata"))  # Awareness index data

bgcolor <- "#000025"
earth <- tempfile(fileext=".jpg")
jpeg(earth, width=2048, height=1024, quality=100, bg=bgcolor, antialias="default")
par(mar = c(0,0,0,0),    pin = c(4,2),    pty = "m",    xaxs = "i",
    xaxt = "n",          xpd = FALSE,    yaxs = "i",    yaxt = "n")

map_palette <- apply(col2rgb(heat.colors(5)[5:1])/768,2,function(x)rgb(x[1],x[2],x[3]))
# Restrict bono data to countries from the maptools package
bono <- bono[rownames(bono) %in% wrld_simpl$NAME, ,drop=FALSE]
# Set a default color for each country and the colors from the bono data
clrs <- rep(map_palette[1], length(wrld_simpl$NAME))
names(clrs) <- wrld_simpl$NAME
clrs[rownames(bono)] <- map_palette[bono$index]

plot(wrld_simpl,  col=clrs,   bg=bgcolor,        border="cyan",  ann=FALSE,
     axes=FALSE,  xpd=FALSE,  xlim=c(-180,180), ylim=c(-90,90),  setParUsrBB=TRUE)

graphics.off()

legendcol=heat.colors(5)[5:1]
globejs(earth,  bg="white")



################################################################################
# M O R E  D A Z Z L E
################################################################################
################################################################################
library(threejs)

# Plot flights to frequent destinations from
# Callum Prentice's global flight data set,
# http://callumprentice.github.io/apps/flight_stream/index.html
data(flights)

# Approximate locations as factors
dest   <- factor(sprintf("%.2f:%.2f",flights[,3], flights[,4]))

# A table of destination frequencies
freq <- sort(table(dest), decreasing=TRUE)

# The most frequent destinations in these data, possibly hub airports?
frequent_destinations <- names(freq)[1:10]

# Subset the flight data by destination frequency
idx <- dest %in% frequent_destinations
frequent_flights <- flights[idx, ]

# Lat/long of frequent destinations
latlong <- unique(frequent_flights[,3:4])

# Plot frequent destinations as bars, and the flights to and from
# them as arcs. Adjust arc width and color by frequency.
earth <- system.file("images/world.jpg",  package="threejs")
globejs(img=earth, lat=latlong[,1], long=latlong[,2], arcs=frequent_flights,
        arcsHeight=0.3, arcsLwd=2, arcsColor="#ffff00", arcsOpacity=0.15,
        atmosphere=TRUE)
