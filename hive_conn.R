#testing hive connection
options(java.parameters = "-Xmx8g")
library(shiny)
library(rJava)
library(RJDBC)
library(dplyr)
library(rJava)
library(RHiveS2)
library(nycflights13)
#devtools::load_all("/Users/zukow/Documents/GitHub/RHiveS2")

#options(java.parameters = "-Xmx8g")


cp=c("/Users/zukow/spark-2.2.1-bin-hadoop2.7/jars/hive-jdbc-1.2.1.spark2-standalone.jar","/Users/zukow/spark-2.2.1-bin-hadoop2.7/jars/hadoop-common-2.7.3.jar")
.jinit(classpath=cp)
conn <- dbConnect(HiveS2("org.apache.hive.jdbc.HiveDriver","/Users/zukow/spark-2.2.1-bin-hadoop2.7/jars/hive-jdbc-1.2.1.spark2.jar",identifier.quote='`'),
                  host ="jdbc:hive2://localhost:",
                  port = "10000",
                  schema = "default"
)

options(scipen = 999)



airlines_hive <- copy_to(conn, airlines,"airlines", overwrite=TRUE)
flights_hive <- copy_to(conn, flights,"flights", overwrite=TRUE)


# Join two data.frames
modFlights <- flights_hive %>% 
  inner_join(airlines_hive, by = 'carrier')

# Choose only sever airlines
chosenCarrier <- 
  modFlights %>% 
  count(name) %>% 
  arrange(desc(n)) %>% 
  head(7)%>%collect()



# Filter data
modFlights <- modFlights %>% 
  filter(!is.na(dep_delay),name %in% !!chosenCarrier$name)

