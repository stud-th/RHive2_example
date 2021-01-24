options(java.parameters = "-Xmx8g")
library(shiny)
library(dplyr)
library(RHiveS2)
library(rJava)
library(nycflights13)

cp=c("/Users/zukow/spark-2.2.1-bin-hadoop2.7/jars/hive-jdbc-1.2.1.spark2-standalone.jar","/Users/zukow/spark-2.2.1-bin-hadoop2.7/jars/hadoop-common-2.7.3.jar")
.jinit(classpath=cp)
conn <- dbConnect(HiveS2("org.apache.hive.jdbc.HiveDriver","/Users/zukow/spark-2.2.1-bin-hadoop2.7/jars/hive-jdbc-1.2.1.spark2.jar",identifier.quote='`'),
                  host ="jdbc:hive2://localhost:",
                  port = "10000",
                  schema = "default"
)


dbWriteTable(conn, "iris",iris, overwrite=TRUE)
