#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Iris Data Viz"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("varx",
                        "X Variable:",
                        choices = c('Sepal.Length', 'Sepal.Width', 
                                    'Petal.Length', 'Petal.Width'),
                        selected = 'Sepal.Length'),
            selectInput("vary",
                        "Y Variable:",
                        choices = c('Sepal.Length', 'Sepal.Width', 
                                    'Petal.Length', 'Petal.Width'),
                        selected = 'Sepal.Width'),
            selectInput("varspecies",
                        "Select Species to plot:",
                        choices = c('setosa', 'virginica', 'versicolor'),
                        selected = c('setosa', 'virginica', 'versicolor'),
                        multiple = T),
            textInput('gtitle',
                      'Choose a title:',
                      value = "Iris Data")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("irisplot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$irisplot <- renderPlot({
        # generate bins based on input$bins from ui.R
        
        filtro = iris[iris$Species %in% input$varspecies , ]
        
        ggplot(NULL, aes(x = filtro[[input$varx]], 
                         y = filtro[[input$vary]],
                         color = filtro[['Species']]
                        )) +
            geom_point(alpha=.8, size=4) +
            theme_minimal() +
            labs(title = input$gtitle,
                 x = input$varx,
                 y = input$vary,
                 color = 'Species')
            
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
