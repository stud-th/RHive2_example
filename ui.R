################################################################################
# A file including user interface (UI) code
################################################################################
library(shiny)
library(DT)

shinyUI(
fluidPage(
  titlePanel("RHiveS2"),
  
  sidebarLayout(
    sidebarPanel(selectInput("carrierName","Select carrier", 
                             local(chosenCarrier$name),
                             selected = local(chosenCarrier$name)[1], 
                             multiple = TRUE,
                 ),
                 numericInput("dictnce_val","Flight distance from:", 500),
                 sliderInput("delayFlightRange","Choose mintutes range of delyed flights:",
                             0,100,c(0,100),
                             step = 5)
                 
    ),
    mainPanel(tabsetPanel(
                tabPanel("Data",
                         DTOutput("table1")),
                tabPanel("SQL Query",
                         textOutput("table2"))
              )
              )
  )
)
)
