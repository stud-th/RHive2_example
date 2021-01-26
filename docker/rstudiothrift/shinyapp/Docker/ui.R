################################################################################
# A file including user interface (UI) code
################################################################################
library(shinydashboard)
library(shiny)
library(DT)

shinyUI(
  dashboardPage(
    dashboardHeader(title = "RHiveS2"),
    dashboardSidebar(
      sidebarMenu(
          menuItem("select()", tabName = "select", icon = icon("code")),
          menuItem("mutate()", tabName = "mutate", icon = icon("code")),
          menuItem("filter()", tabName = "filter", icon = icon("code")),
          menuItem("arrange()", tabName = "arrange", icon = icon("code")),
          menuItem("group_by()", tabName = "groupby", icon = icon("code")),
          menuItem("head()", tabName = "head", icon = icon("code")),
          menuItem("join()", tabName = "join", icon = icon("code")),
          menuItem("summarise()", tabName = "summarise", icon = icon("code")),
          menuItem("nested query", tabName = "nested", icon = icon("code")),
          menuItem("custom query", tabName = "custom", icon = icon("code"))
        )
    ),
    dashboardBody(
      tabItems(
        
      tabItem(tabName = "select",
              h2("dplyr::select()"),
              fluidRow(
              box(
                selectInput("irisColName","Select columns to view", 
                            tolower(colnames(iris)),
                            selected = tolower(colnames(iris))[1], 
                            multiple = TRUE)
              ),
              box("SQL Query", textOutput("selectIris_sql")),
              box("R code", textOutput("selectIris_code"))

            ),
            
              box(title = "Data", DTOutput("selectIris"), width = 16 )
            
            ),
      tabItem(tabName = "mutate",
              h2("dplyr::mutate()"),
              fluidRow(
              box( "Speed calculated with formula:\nspeed = distance / air_time * 60")),
              fluidRow(
                box("SQL Query", textOutput("mutateFlights_sql")),
                box("R code", textOutput("mutateFlights_code"))
              ),
              
                box(title = "Data", DTOutput("mutateFlights"), width = 16 )
              
      ),
      tabItem(tabName = "filter",
              h2("dplyr::filter()"),fluidRow(
                box(title = "Data", DTOutput("filterFlights")),
                box(title = "Filters: ",
                  sliderInput("filterHourFlightRange","Select hour range:",
                                0,23,c(0,10),
                                step = 1),
                  sliderInput("filterDelayFlightRange","Select delay range:",
                              0,100,c(0,10),
                              step = 5))),
              fluidRow( 
                box("SQL Query", textOutput("filterFlights_sql")),
                box("R code", textOutput("filterFlights_code"))
              )
      ),
      tabItem(tabName = "arrange",
              h2("dplyr::arrange()"),
              fluidRow(
                box(
                  selectInput("irisColNameArrange","Select columns to arrange data", 
                              tolower(colnames(iris)),
                              selected = tolower(colnames(iris))[1], 
                              multiple = TRUE)
                ),
                box("SQL Query", textOutput("arrangeIris_sql")),
                box("R code", textOutput("arrangeIris_code"))
              ),
             
                box(title = "Data", DTOutput("arrangeIris"), width = 16 )
              
      ),
      tabItem(tabName = "groupby",
              h2("dplyr::group_by()"),
              fluidRow(
                box(
                  selectInput("groupbyCol","Select columns to arrange data", 
                              tolower(colnames(flights)),
                              selected = tolower(colnames(flights))[17], 
                              multiple = FALSE)
                ),
                box("SQL Query", textOutput("groupbyFlights_sql")),
                box("R code", textOutput("groupbyFlights_code"))
              ),

                box(title = "Data", DTOutput("groupbyFlights"), width = 16 )

      ),
      tabItem(tabName = "head",
              h2("dplyr::head()"),
              fluidRow(
              box(numericInput("flightsHead","Number of records to display:", 10))),
              fluidRow(
              box("SQL Query", textOutput("headFlights_sql")),
              box("R code", textOutput("headFlights_code"))
              ),
              
                box(title = "Data", DTOutput("headFlights"), width = 16 )
              
      ),
      tabItem(tabName = "join",
              h2("dplyr::join()"),
              fluidRow(
                box(title = "Data: flights", DTOutput("beforejoinFlights")),
                box(title = "Data: airlines", DTOutput("beforejoinAirlines")),
                ),
              fluidRow(
                box("SQL Query", textOutput("joinFlights_sql")),
                box("R code", textOutput("joinFlights_code"))
              ),
              box(title = "Data: airlines with flights joined on carrier", DTOutput("joinFlights"), width = 16 ),
      ),
      tabItem(tabName = "summarise",
              h2("dplyr::summarise()"),
              fluidRow(
                box(
                  selectInput("summariseCarrier","Select carrier to summary", 
                              carrierID,
                              selected = carrierID[1], 
                              multiple = FALSE)
                ),
                box(title = "Data", DTOutput("summariseCarrier"))
              
              ),
              
              
              fluidRow(box("SQL Query", textOutput("summariseCarrier_sql")),
                       box("R code", textOutput("summariseCarrier_code")))
              
      ),
      tabItem(tabName = "nested",
              fluidRow(
                box(title = "Data", DTOutput("table1")),
                box(
                  selectInput("carrierName","Select carrier", 
                              local(chosenCarrier$name),
                              selected = local(chosenCarrier$name)[1], 
                              multiple = TRUE
                  ),
                  numericInput("dictnce_val","Flight distance from:", 500),
                  sliderInput("delayFlightRange","Choose mintutes range of delyed flights:",
                              0,100,c(0,100),
                              step = 5))),
              fluidRow( 
                box("SQL Query", textOutput("table2")),
                box("R code", textOutput("table3"))
              )
      )
      ,
      tabItem(tabName = "custom",
              fluidRow(
                box(title = "Write R code: ", width = 12,
                    column(width = 8, textInput(inputId = "custom",label = NULL, value = "iris_hive%>%select(sepal.length)")),
                    column(width = 4,
                      div(class="header", checked=NA,
                          p("    "),
                          p("%>%collect()")
                      )
                    )
                    
                )),
              fluidRow(
                box("SQL Query", textOutput("custom_sql")),
              ),
              
              fluidRow(
                  box(title = "Data", DTOutput("custom"))
                )

                

              
      # ,
      # fluidRow(
      #   box("SQL Query", textOutput("custom_sql")),
      #   box("R code", textOutput("table3"))
      # )
       )
      
    )
  )
  
)
)
