#' Custom Shiny Inputs module

#' Custom Shiny Inputs module UI
#'
#' Defines the UI for the Custom Shiny Inputs module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_customInputs_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Custom Shiny Inputs",
       class = "tab-title"),

    nice_box(
      title = "The importance of bindings",

      p("If you haven't looked under the hood of shiny, you're probably used to your apps
        'just working'. If you create a simple app with, for example, a sliderInput and a
        textOutput which just displays the value of the sliderInput, you will see that as you adjust
        the slider, the text changes - see the app below."),
      code_snippet(c("library(shiny)",
                     "",
                     "ui <- fluidPage(",
                     "  sliderInput('slider',",
                     "              label = 'Number:',",
                     "              min = 1,",
                     "              max = 20,",
                     "              value = 5),",
                     "  textOutput('display')",
                     ")",
                     "",
                     "server <- function(input, output, session) {",
                     "  output$display <- renderText(paste0('The number is ', input$slider))",
                     "}",
                     "",
                     "shinyApp(ui, server)")),
      p("If you run this app you will see the behaviour described above. If, however, you open your
        browser's HTML inspect and run Shiny.unbindAll(), then try changing the sliderInput you will
        see that nothing happens. Unbinding all the inputs has essentially severed the connection between
        the R-generated HTML (which creates the inputs) and the javascript (which drives reactivity across
        the app - see sections 1.2-1.4 for more info)."),
      p("Similiarly, if we run Shiny.bindAll() then the slider will work again as expected."),
      br(),
      p("So we can see that bindings are crucial for shiny inputs to work - this applies for all inputs
        including the base shiny ones like textInput, numericInput and selectInput as well as those from
        extension packages like shinyWidgets::colorSelectorInput or even inputs you create yourself."),
      br(),
      p("An", tags$b("input binding"), "allows Shiny to identify each", tags$b("instance"), "of a given
        input and establish what you are allowed do with this input."),
      p("In the example above, the input binding for sliderInput tells shiny that the value associated with
        that input must be updated everytime the range of the slider changes or the left or right arrow keys
        are pressed.")

    )
  )

}

#' Custom Shiny Inputs module server
#'
#' Defines the server logic for the Custom Shiny Inputs module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_customInputs_server <- function(id,
                                    appData) {

  moduleServer(
    id,
    function(input,
             output,
             session,
             appData = appData) {

      # Alias the namespace function for ease of use
      ns <- session$ns

    }
  )

}
