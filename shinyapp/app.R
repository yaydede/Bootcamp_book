library(shiny)
library(ggplot2)
library(dplyr)
library(RBootcamp)


ui <- fluidPage(    
  
  # Give the page a title
  titlePanel("Housing in Ames"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("neighborhood", "Neighborhood:", 
                  choices=unique(ames$Neighborhood)),
      hr(),
      helpText("Data from Ames Iowa Housing")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("HousingStylePlot")  
    )
    
  )
)

## Server

# Define a server for the Shiny app
server <- function(input, output) {
  
  # Fill in the spot we created for a plot
  output$HousingStylePlot <- renderPlot({
    
    ames %>% 
      filter(Neighborhood == input$neighborhood) %>% 
      ggplot(aes(x = Gr_Liv_Area, 
                 y = Sale_Price,
                 color = Central_Air)) +
      geom_point() +
      geom_smooth()
  })
}

shinyApp(ui, server)