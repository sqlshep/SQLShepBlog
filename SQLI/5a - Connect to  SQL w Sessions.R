########  ######## ##     ##  #######          ##         ########  ######## ##     ##  #######  
##     ## ##       ###   ### ##     ##       ####         ##     ## ##       ##     ## ##     ## 
##     ## ##       #### #### ##     ##         ##         ##     ## ##       ##     ## ##     ## 
##     ## ######   ## ### ## ##     ##         ##         ########  ######   ##     ## ##     ## 
##     ## ##       ##     ## ##     ##         ##         ##   ##   ##        ##   ##  ##     ## 
##     ## ##       ##     ## ##     ##         ##         ##    ##  ##         ## ##   ##     ## 
########  ######## ##     ##  #######       +######       ##     ## ########    ###     #######  
################################################################################################################

#install.packages("RevoScaleR")
library("RevoScaleR")


Sys.setenv(TZ='GMT')


connStr <- "Driver=SQL Server; Server=DSVM1; Database=master;Trusted_Connection=Yes"
sqlShareDir <- paste("C:\\AllShare\\",Sys.getenv("USERNAME"),sep="")
sqlWait <- TRUE
sqlConsoleOutput <- TRUE

sqlcc <- RxInSqlServer(connectionString = connStr, 
                       shareDir = sqlShareDir, 
                       wait = sqlWait, 
                       consoleOutput = sqlConsoleOutput)

rxSetComputeContext(sqlcc)

# Load up a query 
sampleDataQuery <- "select * from sys.dm_exec_sessions"

inDataSource <- RxSqlServerData(
  sqlQuery = sampleDataQuery,
  connectionString = connStr,
  rowsPerRead=500
)

MyStuff<- rxImport(inData = inDataSource)


################################################################################################
########  ######## ##     ##  #######      #######      #######  ########  ########   ######  
##     ## ##       ###   ### ##     ##    ##     ##    ##     ## ##     ## ##     ## ##    ## 
##     ## ##       #### #### ##     ##           ##    ##     ## ##     ## ##     ## ##       
##     ## ######   ## ### ## ##     ##     #######     ##     ## ##     ## ########  ##       
##     ## ##       ##     ## ##     ##    ##           ##     ## ##     ## ##     ## ##       
##     ## ##       ##     ## ##     ##    ##           ##     ## ##     ## ##     ## ##    ## 
########  ######## ##     ##  #######     #########     #######  ########  ########   ######  
################################################################################################

#install.packages("odbc")
library(odbc)


Sys.setenv(TZ='GMT')


master <- dbConnect(odbc::odbc(),
                     Driver    = "SQL Server", 
                     Server    = "localhost",
                     Database  = "master",
                     Trusted_Connection = 'Yes')


SQLStmt <- sprintf("SELECT [session_id]
                        ,[login_time]
                       ,[host_name]
                       ,[program_name]
                       ,[host_process_id]
                       ,[client_version]
                       ,[client_interface_name]
                       --,[security_id]
                      ,[login_name]
                      ,[nt_domain]
                       ,[nt_user_name]
                       ,[status]
                       --,[context_info] 
                       ,[cpu_time]
                       ,[memory_usage]
                       ,[total_scheduled_time]
                       ,[total_elapsed_time]
                       ,[endpoint_id]
                       ,[last_request_start_time]
                       ,[last_request_end_time]
                       ,[reads]
                       ,[writes]
                       ,[logical_reads]
                       ,[is_user_process]
                       ,[text_size]
                       ,[language]
                       ,[date_format]
                       ,[date_first]
                       ,[quoted_identifier]
                       ,[arithabort]
                       ,[ansi_null_dflt_on]
                       ,[ansi_defaults]
                       ,[ansi_warnings]
                       ,[ansi_padding]
                       ,[ansi_nulls]
                       ,[concat_null_yields_null]
                       ,[transaction_isolation_level]
                       ,[lock_timeout]
                       ,[deadlock_priority]
                       ,[row_count]
                       ,[prev_error]
                       --,[original_security_id]
                       ,[original_login_name]
                       ,[last_successful_logon]
                       ,[last_unsuccessful_logon]
                       ,[unsuccessful_logons]
                       ,[group_id]
                       ,[database_id]
                       ,[authenticating_database_id]
                       ,[open_transaction_count]
                   FROM [master].[sys].[dm_exec_sessions]")

rs <- dbSendQuery(master, SQLStmt)

MyStuff <- dbFetch(rs)

# house keeping 
dbClearResult(rs)
dbDisconnect(master)

#88b           d88   ad88888ba   88888888ba,    88888888ba                           
#888b         d888  d8"     "8b  88      `"8b   88      "8b                          
#88`8b       d8'88  Y8,          88        `8b  88      ,8P                          
#88 `8b     d8' 88  `Y8aaaaa,    88         88  88aaaaaa8P'                          
#88  `8b   d8'  88    `"""""8b,  88         88  88""""""8b,                          
#88   `8b d8'   88          `8b  88         8P  88      `8b                          
#88    `888'    88  Y8a     a8P  88      .a8P   88      a8P                          
#88     `8'     88   "Y88888P"   88888888Y"'    88888888P"                           

#88888888ba                           88                                             
#88      "8b                          88                                             
#88      ,8P                          88                                             
#88aaaaaa8P'  ,adPPYYba,   ,adPPYba,  88   ,d8  88       88  8b,dPPYba,   ,adPPYba,  
#88""""""8b,  ""     `Y8  a8"     ""  88 ,a8"   88       88  88P'    "8a  I8[    ""  
#88      `8b  ,adPPPPP88  8b          8888[     88       88  88       d8   `"Y8ba,   
#88      a8P  88,    ,88  "8a,   ,aa  88`"Yba,  "8a,   ,a88  88b,   ,a8"  aa    ]8I  
#88888888P"   `"8bbdP"Y8   `"Ybbd8"'  88   `Y8a  `"YbbdP'Y8  88`YbbdP"'   `"YbbdP"'  
#                                                            88                      
#                                                            88       
#######################################################################################

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


keep <- msdbBackupHist
#msdbBackupHist <- keep


#msdbBackupHist <- filter(msdbBackupHist, backup_start_date >= (max(msdbBackupHist$backup_start_date) - days(7)))
#msdbBackupHist <- filter(msdbBackupHist, backup_start_date >= (max(msdbBackupHist$backup_start_date) - days(14)))
msdbBackupHist <- filter(msdbBackupHist, backup_start_date >= (max(msdbBackupHist$backup_start_date) - days(21)))

#Get all sizes to the same scale, GB
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
DbBackups <- msdbBackupHist[msdbBackupHist$type == 'D',]


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


