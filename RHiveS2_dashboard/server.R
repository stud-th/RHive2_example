################################################################################
# A file including backend code (server) 
################################################################################
library(shiny)
library(ggplot2)
library(ggthemes)
source("functionCode.R")
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

output$table1 <- renderDT({
  datatable(aggDelayFlights(),colnames = c("Hour", "Flights.Total"), rownames = F)
})
output$table2 <- renderPrint({ 
  aggDelayFlights_sql()
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

})
