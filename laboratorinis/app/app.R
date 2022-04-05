library(shiny)
library(shinythemes)
library(tidyverse)
library(lubridate)
library(shinyWidgets)
library(shinydashboard)

ui <- dashboardPage(skin="green", 
                    dashboardHeader(title = "460000",
                                    titleWidth = 250),
                    dashboardSidebar(width = 250,
                                     sidebarMenu(selectizeInput(
                                       inputId = "kodas", label = "Iveskite imones koda", choices = NULL, selected = NULL))),
                    dashboardBody(box(title="Atlyginimu dinamika"),
                                  tabItem("kodas", plotOutput("plot"))))

server <- function(input, output, session) {
  data <- read_csv("data/lab_sodra.csv")
  
  data1<-data %>% 
    filter(ecoActCode == 460000) %>%
    arrange(code)
  
  updateSelectizeInput(session, "kodas", choices = data1$code, server = TRUE)
  
  output$plot <- renderPlot(
    data1 %>%
      filter(code == input$kodas) %>%
      mutate(month = ym(month)) %>%
      ggplot(aes(x = month, y = avgWage, color=name)) +
      geom_line(color="forestgreen"))
}
shinyApp(ui, server)
