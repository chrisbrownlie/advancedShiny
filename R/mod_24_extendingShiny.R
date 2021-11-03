#' Extending Shiny module

#' Extending Shiny module UI
#'
#' Defines the UI for the Extending Shiny module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_extendingShiny_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Extending Shiny",
       class = "tab-title"),
    
    fluidRow(
      column(
        width = 6,
        box(
          title = "Javascript is powerful",
          status = "purple",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ), #end box
        
        box(
          title = "shinyHelper, shinyFeedback, shinyEffects",
          status = "purple",
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
          title = "htmlwidgets",
          status = "purple",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ), #end box
        
        box(
          title = "Higher-order reactives",
          status = "purple",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ) #end box
      ) #end column
    ) #end fluidRow
    
  )

}

#' Extending Shiny module server
#'
#' Defines the server logic for the Extending Shiny module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_extendingShiny_server <- function(id,
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
