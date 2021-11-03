#' Using Javascript module

#' Using Javascript module UI
#'
#' Defines the UI for the Using Javascript module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_usingJS_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Using Javascript",
       class = "tab-title"),
    
    fluidRow(
      column(
        width = 6,
        box(
          title = "What is Javascript?",
          status = "warning",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ), #end box
        
        box(
          title = "Some cool use cases for adding JS to your app",
          status = "warning",
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
          title = "How to add javascript to your app",
          status = "warning",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ), #end box
        
        box(
          title = "shinyjs",
          status = "warning",
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

#' Using Javascript module server
#'
#' Defines the server logic for the Using Javascript module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_usingJS_server <- function(id,
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
