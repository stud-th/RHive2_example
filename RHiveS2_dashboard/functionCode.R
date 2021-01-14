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
headFlights_code <- "flights_hive%>%head(input$flightsHead)"
filterFlights_code <- "flights_hive %>% select(carrier, hour, distance, air_time, dep_delay) %>%filter(hour > (local(input$filterHourFlightRange[1]))-1) %>%filter(hour < (local(input$filterHourFlightRange[2]))+1) %>% filter(dep_delay > local(input$filterDelayFlightRange[1])) %>%filter(dep_delay < local(input$filterDelayFlightRange[2]))"
groupbyFlights_code <- "flights_hive %>% group_by(base::as.name(local(input$groupbyCol))) %>% count()"
joinFlights_code<-"flights_hive %>% inner_join(airlines_hive, by = 'carrier')%>%select(carrier,name, dest, time_hour)"

summariseCarrier_code<-"flights_hive%>%group_by(carrier)%>%filter(carrier %in% local(input$summariseCarrier)) %>%   summarise(total_flights = n()
    )"