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
          menuItem("nested query", tabName = "nested", icon = icon("code")),
          menuItem("select()", tabName = "select", icon = icon("code")),
          menuItem("mutate()", tabName = "mutate", icon = icon("code")),
          menuItem("filter()", tabName = "filter", icon = icon("code")),
          menuItem("arrange()", tabName = "arrange", icon = icon("code")),
          menuItem("group_by()", tabName = "groupby", icon = icon("code")),
          menuItem("head()", tabName = "head", icon = icon("code")),
          menuItem("join()", tabName = "join", icon = icon("code")),
          menuItem("summarise()", tabName = "summarise", icon = icon("code"))
        )
    ),
    dashboardBody(
      tabItems(
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
      ),
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
            fluidRow(
              box(title = "Data", DTOutput("selectIris"), width = 16 )
            )
            ),
      tabItem(tabName = "mutate",
              h2("dplyr::mutate()"),
              fluidRow(
              box( "Speed calculated with formula:\nspeed = distance / air_time * 60")),
              fluidRow(
                box("SQL Query", textOutput("mutateFlights_sql")),
                box("R code", textOutput("mutateFlights_code"))
              ),
              fluidRow(
                box(title = "Data", DTOutput("mutateFlights"), width = 16 )
              )
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
              fluidRow(
                h2("dplyr::arrange()"),
                box(
                  selectInput("irisColNameArrange","Select columns to arrange data", 
                              tolower(colnames(iris)),
                              selected = tolower(colnames(iris))[1], 
                              multiple = TRUE)
                ),
                box("SQL Query", textOutput("arrangeIris_sql")),
                box("R code", textOutput("arrangeIris_code"))
              ),
              fluidRow(
                box(title = "Data", DTOutput("arrangeIris"), width = 16 )
              )
      ),
      tabItem(tabName = "groupby",
              h2("dplyr::group_by()"),
      ),
      tabItem(tabName = "head",
              h2("dplyr::head()"),
              fluidRow(
              box(numericInput("flightsHead","Number of records to display:", 10))),
              fluidRow(
              box("SQL Query", textOutput("headFlights_sql")),
              box("R code", textOutput("headFlights_code"))
              ),
              fluidRow(
                box(title = "Data", DTOutput("headFlights"), width = 16 )
              )
      ),
      tabItem(tabName = "join",
              h2("dplyr::join()"),
      ),
      tabItem(tabName = "summarise",
              h2("dplyr::summarise()"),
      )
    )
  )
  
)
)
