################################################################################
# A file containing objects (variables) which are available both in ui.R and server.R
# It may support the app in several fields, such as package installation, 
# data preprocessing, database connection etc.
################################################################################
#testing hive connection
options(java.parameters = "-Xmx8g")
library(shiny)
library(dplyr)
library(RHiveS2)
library(rJava)
library(nycflights13)

cp=c("/home/rstudio/jars/hive-jdbc-1.2.1.spark2-standalone.jar","/home/rstudio/jars/hadoop-common-2.7.3.jar")
.jinit(classpath=cp)
conn <- dbConnect(HiveS2("org.apache.hive.jdbc.HiveDriver","/home/rstudio/jars/hive-jdbc-1.2.1.spark2.jar",identifier.quote='`'),
                  host ="jdbc:hive2://spark-thift-server:",
                  port = "10000",
                  schema = "default"
)

options(scipen = 999)



airlines_hive <- copy_to(conn, airlines,"airlines", overwrite=TRUE)
flights_hive <- copy_to(conn, flights,"flights", overwrite=TRUE)
flights_hive <- flights_hive%>%head(1000)
iris_hive<- copy_to(conn, iris,"iris", overwrite=TRUE)

carrierID <- airlines%>%select(carrier)%>%collect()


# Join two data.frames
modFlights <- flights_hive %>% 
  inner_join(airlines_hive, by = 'carrier')

# Choose only sever airlines
chosenCarrier <- 
  modFlights %>% 
  count(name) %>% 
  arrange(desc(n)) %>% 
  head(7)%>%collect()


verbFilterFlights <- modFlights
# Filter data
modFlights <- modFlights %>% 
  filter(!is.na(dep_delay),name %in% !!chosenCarrier$name)

