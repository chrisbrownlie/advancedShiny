library(shiny)

ui <- navbarPage("Navbar!",
                 tabPanel("Plot",
                          sidebarLayout(
                            sidebarPanel(
                              radioButtons("plotType", "Plot type",
                                           c("Scatter"="p", "Line"="l")
                              )
                            ),
                            mainPanel(
                              plotOutput("plot")
                            )
                          )
                 ),
                 tabPanel("Summary"),
                 navbarMenu("More")
)

server <- function(input, output, session) {
  
  output$plot <- renderPlot({
    plot(cars, type=input$plotType)
  })
  
}

shinyApp(ui, server)
