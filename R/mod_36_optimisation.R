#' Optimisation module

#' Optimisation module UI
#'
#' Defines the UI for the Optimisation module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_optimisation_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Optimisation",
       class = "tab-title"),
    
    fluidRow(
      column(
        width = 6,
        box(
          title = "Optimising using {profvis}",
          status = "success",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ), #end box
        
        box(
          title = "Caching in shiny apps and {memoise}",
          status = "success",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ) #end box
      ), #end column
      column(
        width = 6,
        box(
          title = "Asynchronous programming with {promises} and {future}",
          status = "success",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ), #end box
        
        box(
          title  = "Some common optimisations",
          status = "success",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          p("e.g. multiple tabs, paste>sprintf, data.frame>data.table, grepl^>startsWith, vectorisation/de-looping, use SQL databases, {Rcpp}, {minifyr}")
        ) #end box
      ) #end column
    ) #end fluidRow
  )

}

#' Optimisation module server
#'
#' Defines the server logic for the Optimisation module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_optimisation_server <- function(id,
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
