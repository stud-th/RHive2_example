aggDelayFlights_code <- "modFlights %>% filter(name %in% local(input$carrierName)) %>%
               group_by(name, hour) %>% 
               filter(distance > local(input$dictnce_val)) %>%
               filter(dep_delay > local(input$delayFlightRange[1])) %>%
               filter(dep_delay < local(input$delayFlightRange[2])) %>%
               summarise(delayed_flight_cnt = n())"  

 
selectIris_code <-"iris_hive %>% select(input$irisColName)"
 
arrangeIris_code <-"iris_hive %>% arrange(base::as.name(local(input$irisColNameArrange)))"
mutateFlights_code <- "flights_hive %>% select(carrier, year, distance, air_time, speed) %>% 
  mutate(speed = distance / air_time * 60)"
headFlights_code <- "lol"
filterFlights_code <- "lol2"