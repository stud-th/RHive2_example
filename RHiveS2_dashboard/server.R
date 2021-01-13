################################################################################
# A file including backend code (server) 
################################################################################
library(shiny)
library(ggplot2)
library(ggthemes)
source("functionCode.R")
source("SQLQuery.R")
shinyServer(function(input, output, session) {
  

  # Reactive expression containing the data for both plot and the table
  aggDelayFlights <- reactive({
    sql_flights<-modFlights %>% 
      filter(name %in% local(input$carrierName)) %>%
      group_by(name, hour) %>% 
      filter(distance > local(input$dictnce_val))%>%
      filter(dep_delay > local(input$delayFlightRange[1]))%>%
      filter(dep_delay < local(input$delayFlightRange[2]))%>%
      summarise(
      delayed_flight_cnt = n()
      )
    sql_flights%>%collect()
  })
  aggDelayFlights_sql <- reactive({
      show_query(modFlights %>% 
      filter(name %in% local(input$carrierName)) %>%
      group_by(name, hour) %>% 
      filter(distance > local(input$dictnce_val))%>%
      filter(dep_delay > local(input$delayFlightRange[1]))%>%
      filter(dep_delay < local(input$delayFlightRange[2]))%>%
      summarise(
        delayed_flight_cnt = n()
      ))
  })  
  selectIris <- reactive({
    iris_hive%>%select(input$irisColName)%>%collect()
  }) 
  selectIris_sql <- reactive({
    show_query(iris_hive%>%select(input$irisColName))
  }) 
  arrangeIris <- reactive({
    iris_hive%>%arrange((base::as.name(local(input$irisColNameArrange))))%>%collect()
  }) 
  arrangeIris_sql <- reactive({
    show_query(iris_hive%>%arrange(base::as.name(local(input$irisColNameArrange))))
  })
  mutateFlights <- flights_hive %>% select(carrier, year, distance, air_time) %>% mutate(speed = distance / air_time * 60) %>% collect()
  headFlights <- reactive({
    flights_hive%>%head(input$flightsHead)%>%collect()
  }) 
  headFlights_sql <- reactive({
    show_query(flights_hive%>%head(input$flightsHead))
  }) 
  filterFlights <- reactive({
    flights_hive %>% select(carrier, hour, distance, air_time, dep_delay) %>%
      filter(hour > (local(input$filterHourFlightRange[1]))-1) %>%
      filter(hour < (local(input$filterHourFlightRange[2]))+1) %>%
      filter(dep_delay > local(input$filterDelayFlightRange[1])) %>%
      filter(dep_delay < local(input$filterDelayFlightRange[2])) %>%
      collect()
  }) 
  filterFlights_sql <- reactive({
      show_query(flights_hive %>% select(carrier, hour, distance, air_time, dep_delay) %>%
                   filter(hour > (local(input$filterHourFlightRange[1]))-1) %>%
                   filter(hour < (local(input$filterHourFlightRange[2]))+1) %>%
                   filter(dep_delay > local(input$filterDelayFlightRange[1])) %>%
                   filter(dep_delay < local(input$filterDelayFlightRange[2]))
                   )
  }) 
  
  
  
output$table1 <- renderDT({
  datatable(aggDelayFlights(),colnames = c("Hour", "Flights.Total"), rownames = F)
})
output$table2 <- renderPrint({ 
  aggDelayFlights_sql()
})
output$table3 <- renderPrint({ 
  print(aggDelayFlights_code)
})
output$mutateFlights <- renderDT({
  datatable(mutateFlights,colnames = c("carrier", "year", "distance", "air_time", "speed"), rownames = F)
})
output$mutateFlights_sql<- renderPrint({ 
  show_query(flights_hive %>% select(carrier, year, distance, air_time ) %>% 
               mutate(speed = distance / air_time * 60))
})
output$mutateFlights_code <- renderPrint({ 
  print(mutateFlights_code)
})
output$filterFlights <- renderDT({
  datatable(filterFlights(),colnames = c("carrier", "hour", "distance", "air_time","dep_delay"), rownames = F)
})
output$filterFlights_sql <- renderPrint({ 
  filterFlights_sql()
})
output$filterFlights_code <- renderPrint({ 
  print(filterFlights_code)
})
output$selectIris <- renderDT({
  datatable(selectIris(),colnames = c(input$irisColName), rownames = F)
})
output$selectIris_sql <- renderPrint({ 
  selectIris_sql()
})
output$selectIris_code <- renderPrint({ 
  print(selectIris_code)
})
output$arrangeIris <- renderDT({
  datatable(arrangeIris(),colnames = c(tolower(colnames(iris))), rownames = F)
})
output$arrangeIris_sql <- renderPrint({ 
  arrangeIris_sql()
})
output$arrangeIris_code <- renderPrint({ 
  print(arrangeIris_code)
})
output$headFlights <- renderDT({
  datatable(headFlights(),colnames = c(colnames(flights)), rownames = F)
})
output$headFlights_sql<- renderPrint({ 
  headFlights_sql()
})
output$headFlights_code <- renderPrint({ 
  print(headFlights_code)
})
})
