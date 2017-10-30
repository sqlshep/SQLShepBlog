
library(RColorBrewer)

disk <- read.csv("c:/tools/disk.csv")

disk$mb <- disk$DirectorySize/1000000
disk$gb <- disk$DirectorySize/1000000000

topGB <- disk[disk$gb > 1,]

topGB <- subset(topGB, Path!="c:\\")

topGB <- topGB[order(-topGB$gb),]

top15GB <- topGB[1:15,]
top30GB <- topGB[1:30,]

colors<- colorRampPalette(brewer.pal(9,"RdYlGn"))(15)

pie(top15GB$gb,  labels = top15GB$Path, col=colors)

pie(top30GB$gb,  labels = paste(round(top30GB$gb,1),"GB", top30GB$Path), col=colors)

paste(round(top30GB$gb,1),"GB", top30GB$Path)
      
