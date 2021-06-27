#' Using Reactivity module

#' Using Reactivity module UI
#'
#' Defines the UI for the Using Reactivity module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_usingReactivity_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Using Reactivity",
       class = "tab-title"),

    fluidRow(
      column(
        width = 12,
        box(
          title = "Values, Expressions & Observers",
          status = "navy",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("shapes"),
          width = NULL,
          solidHeader = TRUE,
          p("So far, in 'Understanding Reactivity' we had a high-level overview of how reactivity works and the reactive graph. We
            spoke about reactive values and observers but did not go into any real detail about what these objects are and how they
            differ from each other. This will be addressed here, along with a discussion of two of the most powerful functions at the
            core of the shiny package: reactive() and observe()."),
          br(),
          p("There is some overlap and potential confusion with terminology being used, so the two points below will hopefully clarify what
            exactly these reactive objects are."),
          tags$ul(
            tags$li("All objects involved in reactivity are either reactive values, expressions or observers",
                    tags$ul(
                      tags$li("Reactive values are producers, created in response to e.g. user inputs"),
                      tags$li("Observers are consumers, which take in reactive values and provide some side effect (e.g. producing plots)"),
                      tags$li("The render*() functions are a special type of observer."),
                      tags$li("Reactive expressions are both consumers and producers (or alternatively, they are 'conductors'). They take in reactive values,
                              transform them in some way and then pass a reactive value on to other consumers. This is usually via a call to
                              reactive().")
                    )
            ),
            tags$li("As with most of the important elements of shiny, these are all implementations of R6 classes, which means they have",
                    tags$i("reference semantics", .noWS = "after"), ".",
                    tags$ul(
                      tags$li("Most objects in R have", tags$i("copy-on-modify"), "semantics, which means that as soon as you modify a
                              copy of a value, a new value is created in memory. We saw this in the previous tab (box 'Push or Pull?').
                              Consider the following example"),
                      code_snippet(c("a <- 2 # point 'a' at a value (2)",
                                     "b <- a # point 'b' to the same place as 'a' (the value of 2)",
                                     "b <- 4 # on modification a new value (4) is created and 'b' now points to that, so 'a' is not affected",
                                     "print(a) # 2")),
                      tags$li("R6 classes use reference semantics, which means that the example above would now be (if R objects used
                              reference semantics):"),
                      code_snippet(c("a <- 2 # point 'a' at a value (2)",
                                     "b <- a # point 'b' to the same place as 'a' (2)",
                                     "b <- 4 # with reference semantics, b just updates the value it is pointing at (that 'a' is also pointing at)",
                                     "print(a) # 4")),
                      tags$li("This type of semantic is common in object-oriented programming and can be extremely useful for maintaining a global
                              state of certain objects. It gives a useful (but risky if you aren't careful) method of getting around R's lexical scoping.")
                    ))
          )
        ) #end box
      ) #end column
    ), #end fluidRow
    
    fluidRow(
      column(
        width = 4,
        box(
          title = "Reactive Values",
          status = "navy",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("pallet"),
          width = NULL,
          solidHeader = TRUE
        ),
        
        box(
          title = "Reactive Expressions",
          status = "navy",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("share-alt-square"),
          width = NULL,
          solidHeader = TRUE
        ),
        
        box(
          title = "Observers",
          status = "navy",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("sitemap"),
          width = NULL,
          solidHeader = TRUE
        )
      ), #end column
      
      column(
        width = 8,
        
        box(
          title = "reactive() vs observe()",
          status = "navy",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("angle-double-up"),
          width = NULL,
          solidHeader = TRUE
        )
        
      )
    ) # end fluidRow
  ) # end tagList

}

#' Using Reactivity module server
#'
#' Defines the server logic for the Using Reactivity module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_usingReactivity_server <- function(id,
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
