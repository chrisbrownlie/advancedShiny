#' Reactive Objects module

#' Reactive Objects module UI
#'
#' Defines the UI for the Reactive Objects module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_reactiveObjects_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Reactive Objects",
       class = "tab-title"),

    fluidRow(
      column(
        width = 6,

        box(
          title = "Values, Expressions & Observers",
          status = "aqua",
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
          p("There is some overlap and potential confusion with terminology being used, so the points below will hopefully clarify what
            these reactive objects are."),
          tags$ol(
            tags$li("All objects involved in reactivity are either reactive producers, conductors or consumers.",
                    tags$ul(
                      tags$li("Producers create reactive values, for example from user inputs"),
                      tags$li("Consumers take in reactive values and turn these into something which can be updated (e.g. plots)"),
                      tags$li("Producers and consumers are almost always prefixed by input$ and output$ respectively"),
                      tags$li("Reactive conductors (or expressions) are both consumers and producers. They take in reactive values,
                              transform them in some way and then pass them on to other consumers. This is usually via a call to
                              reactive() or observe().")
                    )
            ),
            tags$li("As with most of the important elements of shiny, these are all implementations of R6 classes.")
          )
        ),
      )
    ) # end fluidRow
  ) # end tagList

}

#' Reactive Objects module server
#'
#' Defines the server logic for the Reactive Objects module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_reactiveObjects_server <- function(id,
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
