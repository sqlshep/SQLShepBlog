
#install.packages("Rcpp")  # Rcpp_0.12.11 
#install.packages("devtools") # devtools_1.13.2

#devtools::install_github("rstats-db/odbc") # dbplyr_1.0.0.9000
#devtools::install_github("tidyverse/ggplot2") # ggplot2_2.2.1.9000
#install.packages("lubridate")
#install.packages("scales")

library(odbc)
library(ggplot2)
library(dplyr)
library(lubridate)
library(scales)

Sys.setenv(TZ='GMT')

MSDB <- dbConnect(odbc::odbc(),
                  Driver    = "SQL Server", 
                  Server    = "localhost",
                  Database  = "msdb",
                  Trusted_Connection = 'Yes')

SQLStmt <- sprintf("exec usp_GetBackupHist")

SQLStmt


rs <- dbSendQuery(MSDB, SQLStmt)

msdbBackupHist <- dbFetch(rs)

# house keeping 
dbClearResult(rs)
dbDisconnect(MSDB)


### Save an object to a file
#saveRDS(msdbBackupHist, file = "C:/Users/adminshep/Documents/msdbBackupHist.rds")

### Read from file 
# msdbHist <- readRDS(file = "/Users/Shep/Azure Share/DSVM1/msdb/msdbHist.rds")

keep <- msdbBackupHist

msdbBackupHist <- filter(msdbBackupHist, backup_start_date >= (max(msdbBackupHist$backup_start_date) - days(7)))

msdbBackupHist$backup_size[msdbBackupHist$backup_size_unit == 'MB'] = msdbBackupHist[msdbBackupHist$backup_size_unit == 'MB',12]/1000
msdbBackupHist$backup_size[msdbBackupHist$backup_size_unit == 'KB'] = msdbBackupHist[msdbBackupHist$backup_size_unit == 'KB',12]/1000000

msdbBackupHist$backup_size_unit[msdbBackupHist$backup_size_unit == 'KB'] = "GB"
msdbBackupHist$backup_size_unit[msdbBackupHist$backup_size_unit == 'MB'] = "GB"

options(scipen=999)





ggplot(msdbBackupHist, aes(x=backup_start_date, y=backup_size)) +
  geom_point() + 
  facet_wrap(type ~ name) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


# Create a dataframe for just the backups
DbBackups <- keep[keep$type == 'D',]


ggplot(DbBackups, aes(x=backup_start_date, y=backup_size)) +
  geom_point() + 
  facet_wrap(~name) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

##Show just nyse with selection in ggplot
ggplot(DbBackups[DbBackups$name == "NYSE",], aes(x=backup_start_date, y=backup_size)) +
  geom_point() + 
  facet_wrap(~name) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Create a dataframe jsut for log file backups
LogBackups <- msdbBackupHist[msdbBackupHist$type == 'L',]

ggplot(LogBackups, aes(x=backup_start_date, y=backup_size)) +
  geom_point() + 
  facet_wrap(~ name) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


