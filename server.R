################################################################################
# A file including backend code (server) 
################################################################################
library(shiny)
library(ggplot2)
library(ggthemes)
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

output$table1 <- renderDT({
  datatable(aggDelayFlights(),colnames = c("Hour", "Flights.Total"), rownames = F)
})

output$table2 <- renderPrint({ 
  aggDelayFlights_sql()
})
})
