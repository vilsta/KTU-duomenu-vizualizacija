library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Paskaita 2"),
  dashboardSidebar(),
  dashboardBody()
)

server <- function(input, output) { }

shinyApp(ui, server)