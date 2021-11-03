#' Shiny Modules module

#' Shiny Modules module UI
#'
#' Defines the UI for the Shiny Modules module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_shinyModules_ui <- function(id) {
  ns <- NS(id)

  tagList(
    h3("Shiny Modules",
      class = "tab-title"
    ),
    fluidRow(
      column(
        width = 4,
        box(
          title = "Why...so...modular?",
          solidHeader = TRUE,
          width = NULL,
          closable = FALSE,
          collapsible = TRUE,
          icon = icon("boxes"),
          status = "maroon",
          p(
            "This tab will introduce Shiny modules and discuss how and why you might use them. If you
          are developing a shiny app which you think could potentially grow in future or be
          anything more than a very simple app, you should", tags$b("absolutely, definitely use modules."),
            "There are two key benefits to using Shiny modules and they are outlined below:"
          ),
          tags$ul(
            tags$li("If you've ever built a complex shiny app you'll know it can easily reach thousands of lines
                  of code if you aren't careful. This quickly becomes a nightmare to maintain and debug, as you
                  can end up scrawling through lines of your server to find where that one reactive object is defined.
                  Modules give you an easy way to split your app code into separate, manageable scripts."),
            tags$li(
              "The '1000 button problem': usually if you find yourself repeating code, you should be writing a
                    function and calling that instead. This isn't so straightforward with reactive Shiny code because of",
              tags$i("namespacing."), "Every instance of an object needs a unique ID to match the UI to the server and this can
                    quickly cause major headaches when developing your app. Modules provide a neat way to resolve this."
            )
          ),
          p("From personal experience, the first of these is the more useful aspect of Shiny modules and the reason why I would
            recommend always using them unless you have a reason not to."),
          p("The box on the right shows an example of how modules can be used, so feel free to use this as a starting point for
            developing your own modules."),
          tags$i("On a side note: be careful when researching/googling shiny modules and be sure not to confuse them with", tags$b("wahani"), "modules,
            which are an unrelated topic in R.")
        ),
        
        box(
          title = "Housekeeping",
          solidHeader = TRUE,
          width = NULL,
          closable = FALSE,
          collapsible = TRUE,
          icon = icon("broom"),
          status = "maroon",
          
          p("As mentioned above, one of the key benefits of using shiny modules is keeping different elements of your app
            separate and in short, manageable scripts. The workflow proposed here (in this tab and the previous tab) is
            inspired by various other frameworks and is opinionated. As always, feel free to pick and choose which of the
            below you use, but when it comes to using modules, the following points are recommended:"),
          tags$ul(
            tags$li("Each page of your app should be a separate module. This is straightforward for dashboard-style apps
                    where you can simply have a separate module for each tab, for other apps you may have to
                    make judgement calls about the separate parts of your app."),
            tags$li("Each module (UI and server function) should be in its own script, named according to the conventions
                    outlined on the previous tab (e.g. 'mod_01_homepage.R')."),
            tags$li("Every page's module server function should have a mandatory data argument, to which can be passed your
                    app_data reactiveValues (see the 'Sharing is caring' box on the previous tab)."),
            tags$li("Each module function should be documented in the same way as a normal function with roxygen comments.")
          ),
          p("Following these steps, as well as following the advice to structure your app as a package, will also mean that
            you can reuse modules in different apps. You could even develop a package with a module in and then just use
            that package when you are developing other apps in future. For example, if you have a particular section of reactive
            UI that is used in multiple apps.")
        ),
        
        box(
          title = "Summary",
          status = "maroon",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          p("So in summary:"),
          tags$ul(
            tags$li("Always use modules!"),
            tags$li("Separate your app into sections and have each section in a separate"),
            tags$li("Use modules as an alternative to functions which have reactive inputs and outputs"),
            tags$li("Shiny modules are an implementation of the software development method of", tags$i("namespacing"))
          )
        )
      ), # endColumn

      column(
        width = 8,
        box(
          title = "1000 Button Problem",
          solidHeader = TRUE,
          width = NULL,
          closable = FALSE,
          collapsible = TRUE,
          icon = icon("braille"),
          status = "maroon",
          p("Imagine you are building an app with several independent counter buttons. This can be achieved using functions for UI
            and server logic, but for a very large app you would run into problems due to the fact that input and output
            IDs share a", tags$i("global namespace"), "in shiny. This means that all inputs and outputs must have unique IDs."),
          p("This issue is resolved in computer science by using", tags$i("namespacing"), "whereby objects must only have unique
            IDs within their namespace and namespaces can be nested. In practice you can simply think of a namespace as a prefix to
            an ID. For example, if you have two outputs called 'my_button', you can put them into separate namespaces called 'first'
            and 'second'. This would be equivalent to (but far more elegant than) renaming the outputs 'first-my_button' and
            'second-my_button'."),
          p("Shiny modules were introduced to allow developers to take advantage of namespacing. See below for how to use them, in
            the context of an app with multiple counters."),
          code_snippet(c(
            "library(shiny)",
            "",
            "counterButton <- function(id, label = 'Counter') {",
            "  ns <- NS(id)",
            "  tagList(",
            "    actionButton(ns('button'), label = label),",
            "    verbatimTextOutput(ns('out'))",
            "  )",
            "}",
            "",
            "counterServer <- function(id) {",
            "  moduleServer(",
            "    id,",
            "    function(input, output, session) {",
            "      count <- reactiveVal(0)",
            "      observeEvent(input$button, {",
            "        count(count() + 1)",
            "      })",
            "      output$out <- renderText({",
            "        count()",
            "      })",
            "      count",
            "    }",
            "  )",
            "}",
            "",
            "ui <- fluidPage(",
            "  counterButton('counter1', 'Counter #1'),",
            "  counterButton('counter2', 'Counter #2'),",
            "  counterButton('counter3', 'Counter #3')",
            ")",
            "",
            "server <- function(input, output, session) {",
            "  counterServer('counter1')",
            "  counterServer('counter2')",
            "  counterServer('counter3')",
            "}",
            "",
            "shinyApp(ui, server)"
          )),
          br(),
          p("There are 5 important points to note about the code above:"),
          tags$ul(
            tags$li("The module is defined in two parts just like a shiny app, with a UI and a server function"),
            tags$li("Both elements of a module take in an id argument. This is crucial as it allows shiny to match
                    the module UI to module server for each instance of the module."),
            tags$li(
              "The UI function uses a function from shiny to access the current namespace.", code_block("NS(id)"),
              "will return a function that adds the current (unique) namespace to whatever is supplied to it. So
                    by applying the resulting ns() function to each output in the module, the outputs will be unique to
                    that particular 'id'."
            ),
            tags$li("Note the moduleServer call in the counterServer function. This allows you to write code as you would
                    for a shiny server, using the input, output and session objects as required."),
            tags$li(
              "Outputs in the server function do not need to be wrapped in a namespacing function because this is handled
                    by moduleServer(),",
              tags$b("but if you use renderUI(), any outputs or inputs must be namespaced in the same way as in the UI
                           function."),
              "This is done by adding the following line of code to the top of your moduleServer function call: ",
              code_block("ns <- session$ns")
            )
          )
        ) # end box
      ) # end column
    ) # end fluidRow
  ) # end tagList
}

#' Shiny Modules module server
#'
#' Defines the server logic for the Shiny Modules module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_shinyModules_server <- function(id,
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
