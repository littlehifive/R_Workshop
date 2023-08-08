# Load the required libraries
library(shiny)
library(ggplot2)

# Assuming you have a data frame named df
df <- data.frame(
  var1 = rnorm(100),
  var2 = rnorm(100),
  var3 = rnorm(100)
)

# User Interface
ui <- fluidPage(
  titlePanel("Interactive ggplot2 plot")
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "variable1",
                  label = "Select the first variable:",
                  choices = colnames(df),
                  selected = "var1"),
      
      selectInput(inputId = "variable2",
                  label = "Select the second variable:",
                  choices = colnames(df),
                  selected = "var2")
    ),
    
    mainPanel(
      plotOutput("scatterPlot")
    )
  )
)

# Server logic
server <- function(input, output) {
  output$scatterPlot <- renderPlot({
    ggplot(df, aes_string(x = input$variable1, y = input$variable2)) +
      geom_point() +
      labs(x = input$variable1, y = input$variable2)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
