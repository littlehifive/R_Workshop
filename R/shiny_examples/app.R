# Load the necessary libraries
library(shiny)
library(ggplot2)
library(plotly)

# User Interface
ui <- fluidPage(
  selectInput("xVariable", "X-axis variable:",
              choices = c("displ", "hwy", "cty", "cyl"), 
              selected = "displ"),
  selectInput("yVariable", "Y-axis variable:",
              choices = c("hwy", "cty", "cyl", "displ"), 
              selected = "hwy"),
  selectInput("colorVariable", "Color points by:",
              choices = c("class", "drv", "fl"), 
              selected = "class"),
  plotlyOutput("mpgPlot")
)

# Server logic
server <- function(input, output) {
  output$mpgPlot <- renderPlotly({
    p <- ggplot(mpg, 
                aes(x = .data[[input$xVariable]], 
                    y = .data[[input$yVariable]],
                    color = .data[[input$colorVariable]])) +
      geom_point() + 
      theme_minimal()
    
    ggplotly(p)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
